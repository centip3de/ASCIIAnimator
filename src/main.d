import std.stdio;
import std.string;
import std.c.stdlib;
import std.file;
import core.sys.posix.unistd;
import std.regex;
import std.conv;
import frames;

void clear()
{
	/* This function simulates the bash command, 'clear'... really badly, in use for refreshing. */

	for(int i = 0; i < 50; i++)
	{
		writeln("");
	}
}

void render(Frame root) 
{
	/*  This function takes in a frame (node), writes out it's data, clears the screen if needed,
	    and waits the amount of time specified. */
	    
	if(root.getRefresh())
	{
		clear();
	}
	write(root.getData());

	usleep(root.getTime * 1000000);	//Converting seconds to microseconds (usleep takes in microseconds)
}

void tick(string text)
{
	/* This function takes in the file to parse (to pass to the constructList() call), calls constructList, and then
	   loops through each node in our constructedList and calls render() on that node. */

	Frame root;
	Frame node = new Frame();
	constructList(text, root);

	node = root;
	while(node !is null)
	{
		render(node);
		if(node.hasGoto)
		{
			gotoFrame(node.goingTo, root, node);
		}
		else
		{
			node = node.next;
		}
	}
}

void gotoFrame(string name, Frame root, ref Frame found)
{
	/* This function takes in the name of the frame to find, the root frame, and the frame to assign the found frame to (passed in
	   by reference). It finds the frame by a simple recursion loop and when found, assigns the 'found' frame, to the root, thus
	   allowing the frame you wanted to be found, to be assigned to a variable outside scope without doing awkward recursion hacks. */
	if(root.name == name)
	{
		found = root;
		return;
	}
	gotoFrame(name, root.next, found);
	return;
}

void constructList(string text, ref Frame root)
{
	/* This function takes in all the text in a given file and a reference to the root frame (also the beginning of our 
           linked list. It first splits up our animation file on certain tokens (currently just whitespace) and then loops 
	   through each token, adding information about each frame to a linked list (1 frame = 1 link). Each link contains 
	   information about whether to refresh (clear the screen) or not, the amount of time to display each frame (in seconds), 
	   and the actual scene to render */
	
	auto data = split(text, regex(`[\n]`));	//Split on newlines 

	/* Variables to help control flow by allowing us to assume what token is next. */
	bool isTime = false;
	bool inScene = false;
	bool isRefresh = false;
	bool hasGoto = false;
	bool refresh = false;

	/* Variables to hold our parsed values */
	string name;
	string goingTo;
	int time;
	string scene;

	Frame node; // The temporary node to construct our links

	int i = 0; // Index for whether this is the root node, or the node directly following it.	

	/* Looping thorugh each token */
	foreach(string line; data)
	{
		if(line.length >= 4)
		{
			/* Might be ending a scene */
			if(line[0..4] == "End:" && inScene)
			{
				/* Okay, we really are ending the scene */
				if(strip(line[5..$]) == name) 
				{
					/* If it's our first frame, send the data to our root node. */
					if(i == 0)
					{
						root = new Frame(name, scene, time, refresh, hasGoto, goingTo);
						i++;
					}
					/* If it's our second frame, send the data to our temprorary node, and attach our
					   temporary node to our root node. */
					else if(i == 1)
					{
						node = root.insert(node, name, scene, time, refresh, hasGoto, goingTo);
						i++;
					}
					/* For all other frames, insert this frame after the previous one, and assign our
					   temporary node to the next frame. */
					else
					{

						node.insert(node.next, name, scene, time, refresh, hasGoto, goingTo);
						node = node.next;
						i++;
					}

					/* Clear all variables used in assignment of node data, and set inScene to false. */
					time = 0;
					name = "";
					scene = "";
					inScene = false;
					hasGoto = false;
					goingTo = "";
					continue;
				}
			}
		}
		if(line.length >= 6)
		{
			/* Must be starting a scene */
			if(line[0..6] == "Begin:")
			{
				name = to!string(strip(line[7..$]));
				continue;
			}

			/* Found the time */
			else if(line[0..5] == "Time:")
			{
				/* Must be the amount time */
				time = to!int(strip(line[6..$]));
			}
			else if(line[0..5] == "Goto:")
			{
				hasGoto = true;
				goingTo = to!string(strip(line[6..$]));
			}
		}

		/* Looking for refreshes */
		if(line.length >= 9)
		{
			/* Found the refresh */
			if(line[0..8] == "Refresh:")
			{
				refresh = to!bool(strip(line[9..$]));
				inScene = true;
				continue;
			}
		}

		/* Must be in scene */
		if(inScene)
		{
			scene ~= line ~ "\n";
		}
	}
	writeln(root.getData);
}

int main(string args[])
{
	/* This function attempts to read in the file given in the first argument, then passes control over to our tick() function */
	string file = args[1];
	auto text = read(file);

	tick(cast(string)text);
	return 0;
}
	
	
