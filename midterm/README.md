# Midterm Project - *Behaviours*

## Chinonyerem Ukaegbu


**Description**

The task was to develop a more complex ecology, either continuing with what was created for February 14, or creating a new ecology. Incorporate various behaviors such as following a flow field, attraction, aggression, arriving, cohesion, separation, and flocking.

**Inspiration**

The names of the character as well as the colors used to depict them were drawn from the hit TV series Scooby Doo. The behaviours were inspired by a combination of real life systems as well as imagined ones.

**Concept**

This project is a depiction of a made up ecosyste, consisting of three creatures: the zoinks, jinkies and jeepers. Alongside the living creatures, there exists the food particles present in the ecosystem as well as an incubator.

The initial concept I had planned for the project can be found in [this section](https://github.com/ChinoUkaegbu/RobotaPsyche/blob/main/midterm/journal.md#27th-february-2022) of the journal



**Implementation**

Yuh

**Difficulties**

+ **Initializing attraction and repulsion:**\
I really wanted the tuna to actually move together like as one huge school but I couldn't really figure out what values to initialize the strength of the attract() method with. In the end, I just went with the gravitational force we used in class because I felt like the behaviour was satisfactory so they don't really move as one uniform mass but they just kind of move...together?. Now that i think about it, if they had been moving as one mass, they would have been eaten quite quickly by the sharks. Or maybe they would have reproduced too quickly. Also for the repulsion of the sharks, I ended up going with a constant value after I experimented.

+ **Detecting when objects were colliding:**\
It turns out that collision detection using triangles is very...stressful (compared to working with circles at least). I actually couldn't end up figuring this bug out completely and so sometimes the fishes disappear when they're close to the shark (not necesarily overlapping with the shark) but I was able to modify the eat() method so that the margin of error isn't so bad.

+ **Detecting when 2 tuna are in the incubator:**\
I wanted the new tuna to be spawned only when 2 tuna were in the incubator at the same time but I found it a bit tricky so now we have this sort of system where fish 1 drops the eggs in the incubator and after fish 2 takes care of the egg until it's ready to be added to the array list. This is probably not biologically accurate but well...


**Possible Improvements**

+ Reducing margin of error for collisions
+ Smoother transition from light stage to dark stage

**Photos of Project**

![1](images/Screenshot_1.png)

![2](images/Screenshot_2.png)

![3](images/Screenshot_3.png)

[Link to Video](https://youtu.be/xJ4EKzne_9Y)

**Conclusion**

This was a really cool project to do and I really enjoyed it. It was really nice thinking up the rules and implementing them and even having to modify them was quite the learning experience.

**Clever Things I Learned**

+ I realized that allong the way< I was creating classes depending on what I observed the ecosystem needed. For instance when the sharks were eating the tuna too quickly, I introduced the fishermen hooks and when I noticed that the tuna were still dying quickly, I introduced the incubator to spawn more fishes. I think the flexibility was really cool, it was kind of like building my own miniature city.
