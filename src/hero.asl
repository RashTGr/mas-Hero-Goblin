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
	
	
// Plan for a coin
+coin(hero) : not .desire(carry_to(goblin)) & not hero(vase) & not hero(gem)
	<- !carry_to(goblin). 
	
+!carry_to(G)
	<- ?pos(hero,X,Y);
		-+pos(lastLocation,X,Y);
		
		!ensurePickUp(item);
		
		!takeTo(item,G);
		
		!backTo(lastLocation);

		!exploreForest.

		
		
+!ensurePickUp(item) : coin(hero)
	<- pick(coin);
	!ensurePickUp(item). // Recursive call

	+!take(item,G) : true
	<- !backTo(G);
		.print("Coin picked and delivered");
		drop(coin).
		
+!ensurePickUp(_).
