**Commands:**

(Do note that because of laziness, all commands MUST be typed EXACTLY as I typed them, i.e., there MUST be a space after the colons and each line MUST begin with an uppercase character.)

* Begin: <FrameName> - Begin a new frame setting the frame's name as the given FrameName.

* End: <FrameName> - The end of FrameName's frame.

* Time: <TimeNumber> - The length of time (in seconds, though going to nanoseconds is possible using decimal points) to display the given frame.

* Refresh: <BooleanValue> - Whether to refresh (clear the screen) before the given frame is displayed or not.

* Goto: <FrameName> - Goto the specified frame after this frame has been shown.


**Basic animation walkthrough:**

Do note that this walkthrough uses comments, which ARE NOT supported in an actual animation file.

BasicAnimation.txt

Begin: 1 					#Begin a frame named 1		
Time: 1						#Display this frame for 1 second
Refresh: true 					#Refresh the screen after this frame is finished displaying
 _
|_|						#The scene to be displayed

End: 1						#End the frame named 1

Begin: 2					#Begin a frame named 2
Time: 1						#Display this frame for 1 second
Refresh: true					#Refresh the screen after this frame is finished displaying 

 __
|  |						#The scene to be displayed
|__|

End: 2						#End of the frame named 2

This animation will display a growing square (although it's growth is short). 
