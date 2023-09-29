// Initial goals
!run.
!exploreForest.

/*
* In the event that the agent must achieve "started", under all circumstances, print the message.
*/
+!run
	:true
	<- .print("I've taken on the role of a forest-exploring hero!").
	

// Constantly exploring forest environment
+!exploreForest : true & not pos(X,7,7)
	<- next(slot); 
	!exploreForest.

// Stop and print message at the end of grid
+!exploreForest : pos(hero,7,7)
	<- .print("End of environment!").