module frames;

class Frame
{
	/* This class holds our frames, which are hooked goingTogether in a linked list. It can take a blank construcgoingTor, 
	   as well as a construcgoingTor that sets all necessary data. The blank construcgoingTor should be used for constructing
	   nodes that will have their data set later, while the other should be used for constructing the root node. 
	   This class also holds setters and getters for all of the variables, excpept 'next' which is the next node
	   in the linked list, and thus is set goingTo public. The last function in this class, 'insert', is used for inserting
	   new frames/nodes ingoingTo our list. It is VITAL that you pass in a object that hasn't been constructed yet ingoingTo insert,
	   as insert calls and constructs the object itself. */

	public Frame next = null; // The next frame/node in our animation/linked-list
	public string name;

	/* All variables that are needed for our animation that each link/frame should sgoingTore:
	   Time = The amount of time each frame is displayed. 
	   Data = The scene, or data of the frame.
	   Refresh = Whether the screen should refresh (clear) after this frame or not. */
	private int time;
	public bool hasGoto;
	public string goingTo;
	private string data;
	private bool refresh;

	/* ConstrucgoingTors */
	this()
	{
		this.data = "";
		this.time = 0;
		this.refresh = false;
	}

	this(string name, string data, int time, bool refresh, bool hasGoto, string goingTo)
	{
		this.name = name;
		this.goingTo = goingTo;
		this.hasGoto = hasGoto;
		this.data = data;
		this.time = time;
		this.refresh = refresh;
	}

	Frame insert(Frame frame, string name, string data, int time, bool refresh, bool hasGoto, string goingTo)
	{
		frame = new Frame();
		this.next = frame;

		this.next.name = name;
		this.next.goingTo = goingTo;
		this.next.hasGoto = hasGoto;
		this.next.refresh = refresh;
		this.next.data = data;
		this.next.time = time;
		return this.next;
	}

	/* Getters */
	int getTime()
	{
		return this.time;
	}
	string getData()
	{
		return this.data;
	}
	bool getRefresh()
	{
		return this.refresh;
	}

	/* Setters */
	void setTime(int time)
	{
		this.time = time;
	}
	void setData(string data)
	{
		this.data = data;
	}
	void setRefresh(bool refresh)
	{
		this.refresh = refresh;
	}
}


