(Draft, sort of edited)

Character names - zoinks, jinkies, jeepers (inspired by the Scooby Doo character catchphrases because I couldn't think of anything else) and then "food" particles.

No predator-prey system so they die as a result of natural factors e.g. exposure to sunlight? lack of food (I ended up changing my mind on this)

The zoinks hunger level should increase faster than the others

Or maybe jeepers could be the predators

Alright, I could do the incubator thing where like zoinks and jinkies could either like reproduce within themselves or like a cross between zoinks and jinkies...zinkies maybe (these character names are extremely questionable)


Okay the DNA of each creature is as follows:

Zoinks:
+ Hunger level: depletes way faster than the jinkies and the jeepers
+ Primary food hunters i.e. they actively are attracted to the objects in the "food" class
+ I'm thinking if it's possible for a zoink to interact with a food particle, eat half of that food particle, and then when a jinky interacts with that zoink, they get half of the food...the implementation isn't super clear in my head right now but I'm thinking a variable that alternates between two states...


Jinkies:
+ The protectors of the zoinks
+ Are actively trying to repel the jeepers from the zoinks and so they are attracted to the zoinks and repel the jeepers in an attempt to protect the zoinks
+ However, the jinkies are only able to repel the jeepers in phases, think of like time intervals where the protection variable is set to true for like 20 seconds and then for like 5 seconds,it's set to false
+ The jinkies need less food than the zoinks and they are unable to get the food directly from the food particles floating in the habitat but have to interact with the zoinks in order to get nourishment

Jeepers:
+ Predators of this ecosystem
+ Do not actively attract or repel any of the organisms but they just kind of vibe and the unfortunate organism that comes near them is eaten
+ They don't eat the food particles, only the zoinks and the jinkies
+ You know what might be a good idea...if their hunger levels drop below a certain threshold, perhaps they start actively hunting?

Food:
+ Should have a maximum number of food on the screen at a point (maybe some sort of counter is present on the screen)
+ I can't really visualize the way they will move right now
+ Different sizes of food maybe?
+ Or wait, the higher the value of the food, the closer it is to the jeepers


Zinkies:
+ If implemented, they should be a mix of the zoinks and the jinkies, a more capable lifeform that is able to hunt for food and also defend itself from the jeepers
+ Now that I think about it, they seem to be the most likel lifeform to survive
+ Imagine if the incubator would not work as efficiently until the zoinks and jeepers population drops below a certain threshold and then zinkies would need to be formed as a bid to ensure the population lives on

The way all the creatures react when they interact with the boundary is that they spawn on the opposing boundary because the way I visualize it, they're kind of stuck in a "circular" environment.

I'm trying to think of how the flow field would be implemented...I think it would be useful for some of the properties like making the more valuable food gravitate closer to the jeepers.
