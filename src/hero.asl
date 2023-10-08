//Hero is at the position of agent P (variable), if agent P's position is identical to Hero's position 
at(P) :- pos(P,X,Y) & pos(hero,X,Y).


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
@lg[atomic] // to ensure the entire plan executes atomically 
+!exploreForest : not pos(X,7,7) & not coin(hero) & not vase(hero) & not gem(hero)
	<- next(slot); 
	!exploreForest.
!exploreForest.
	
	
// Plan for a coin
+coin(hero) : not .desire(carry_to(goblin)) & not hero(vase) & not hero(gem)
	<- !carry_to(goblin). 
	
+vase(hero) : not .desire(carry_to(goblin)) & not hero(coin) & not hero(gem)
	<- !carry_to(goblin). 	

+gem(hero) : not .desire(carry_to(goblin)) & not hero(coin) & not hero(vase)
	<- !carry_to(goblin). 
	
+!carry_to(G)
	<- 
		?pos(hero,X,Y);
		-+pos(last,X,Y);
		
		!ensurePickUp(item);
		
		!takeTo(item,G);
		
		!backTo(last);

		!exploreForest.

		
+!ensurePickUp(item) : coin(hero) & not vase(hero) & not gem(hero)
	<- pick(coin);
	!ensurePickUp(item). // Recursive call

	
	+!takeTo(item,G) : true & hero(coin)
		<- !backTo(G);
		.print("Hey, Goblin. I've a COIN for you!");
		drop(coin). // Element-related action from the environment: drop coin


+!ensurePickUp(item) : vase(hero) & not coin(hero) & not gem(hero)
	<- pick(vase);
	!ensurePickUp(item). // Recursive call

	
	+!takeTo(item,G) : true & hero(vase)
		<- !backTo(G);
		.print("Hey, Goblin. I've a VASE for you!");
		drop(vase). // Element-related action from the environment: drop coin
		

+!ensurePickUp(item) : gem(hero) & not vase(hero) & not coin(hero)
	<- pick(gem);
	!ensurePickUp(item). // Recursive call

	
	+!takeTo(item,G) : true & hero(gem)
		<- !backTo(G);
		.print("Hey, Goblin. I've a GEM for you!");
		drop(gem). // Element-related action from the environment: drop coin		

		
// Stop and print message at the end of grid
+!exploreForest : pos(hero,7,7)
	<- .print("End of environment!").	
		
+!ensurePickUp(_).
+!exploreForest.

+!backTo(G) : at(G).
+!backTo(G) <- ?pos(G,X,Y); // Get the position to move towards
	move_towards(X,Y); // Move towards the specified location
	!backTo(G).
