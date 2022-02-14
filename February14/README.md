# Production Assignment - *Under the Sea*

## Chinonyerem Ukaegbu


**Description**

Develop a set of rules for simulating the real-world behavior of a creature, using the code example above as inspiration (or as a starting place), implement your creature.

**Concept and Implementation**

This project is a simulation of the lives of fishes under the sea and their reactions to certain elements around them. There are two fishes implemented and consequntly two classes created for the two fishes : tuna and sharks. 

The tuna are small fishes that move together in groups (schooling). I wanted to simulate that behaviour in Processing and so in the Tuna class, I created a method called attract() which would make each tuna attracted to every tuna apart from itself. 

The  shark are big fishes that prey on the tuna. To simulate that behaviour, I created an eat() method in the Shark class which would remove any tuna that bumped into the shark from the array list of Tuna (i.e. the shark would consume said fish). Also, I wanted the sharks to be competing for the tuna in the ecosystem and so in order for them to not 'work together', I created a repel() method so that the sharks would repel each other.

Also, I wanted the sharks to have unpredictable movements to sort of put the tuna in a frenzy and so I modified the checkEdges() method so that instead of the sharks bouncing when they hit the boundaries, they appear in a random position on the screen. However the tuna still bounce when they hit the edges.

In addition to having the fish, there is also two 'fishing hooks' represented by the two rectangles at the top of the screen. I wanted the hooks to simulate fisherman fishing by throwing their hooks in the water. However, the fishermen are only going after the sharks because they feel as though the tuna are too small and not worth anything. The hooks are meant to serve as a threat to the shark population because each hook class has a catch() method so that if any of the sharks swim close to the hooks, they are caught and removed from the arraylist. Furthermore, the hooks also disappear for 10 seconds and reappear after that interval because I thought that the fishermen's arms might be hurting and so at some point they would take the hooks out of the water to rest.

Furthermore, there is an 'incubator' class which is responsible for creating more tuna. The idea is that each tuna has an attribute know as 'breedable' which is a boolean variable initially set to true. This means all tuna initially is capable of entering the incubator and having an effect on it. The incubator class has a variable called 'counter' (set initially to 0) and a method known as breed(). The breed() method checks if 2 fishes have entered into the incubator consecutively and if both fishes have the breedable attribute set to true, the counter is incremented  by 2 and the breedable attribute is set to false. When this happens, a new tuna is added to the array list and is thus introduced to the ecosystem.

Finally, the ecosystem itself has a behaviour which I thought would be a fun addition. The background is made up of two rectangles that cover half the height of the window and stretch out across the entire width. The top rectangle is a lighter shade than the bottom rectangle. This is due to the presence of the sun (the yellow sector in the top left corner of the window) because as depth decreases, less light gets into the water. Also, the fishes (both sharks and tuna) obey this rule because when they are in the 'light area' they have a lighter more vibrant shade but once they cross over into the 'dark area', they have a darker and somewhat duller shade to signify the influence of sunlight on the ecosystem.

**Process**

+ I first got to work on the breadboard
+ I got the parts of the circuit I would be using and placed the buttons and LEDs on the breadboard, making sure to connect the appropriate resistors.
+ Then I started with the wiring. I I wanted it to look a little organized because there were a lot of parts on the board, so I tried to align the components and use similar coloured wires.
+ Below is the schematic diagram:

![Schematic](images/Screenshot%20(298).jpg)

+ Also, here are the messages being displayed in the serial monitor while the game is running:

![SerialMonitor](images/Screenshot_(293).jpeg)

**Difficulties**

+ **Randomizing the values:**\
I was actually lowkey grateful for this difficulty because without it, I wouldn't have discovered the randomSeed() function. I noticed that anytime I printed the "random" value, it was the same number that popped up. It turns out that Arduino's random function isn't as random as I thought. I searched for help on Google and discovered that you could "initialize the pseudo-random number generator, causing it to start at an arbitrary point in its random sequence" using randomSeed() and not only did I fix the error, I also gained insight into how computers randomize values.

+ **Incrementing the counter:**\
I tried to increment the counter with each button push but the counter just stayed at some random position. I didn't fix this actually, I just worked my way around it outlined in this part of the code:

```js
if (switch1Position == HIGH) {
      counter1 = 5;
      digitalWrite(YELLOWLED1, HIGH);
    } else  {
      digitalWrite(YELLOWLED1, LOW);
    }

    if (switch2Position == HIGH) {
      counter2 = 10;
      digitalWrite(YELLOWLED2, HIGH);
    } else  {
      digitalWrite(YELLOWLED2, LOW);
    }

    if (switch3Position == HIGH) {
      counter3 = 20;
      digitalWrite(YELLOWLED3, HIGH);
    } else  {
      digitalWrite(YELLOWLED3, LOW);
    }

    sum = counter1 + counter2 + counter3;
    if (sum == answer) {
      digitalWrite(GREENLED, HIGH);
      digitalWrite(REDLED, LOW);
      Serial.print("Congratulations! You guessed right \n");
      Serial.print("Game Over! \n");
      startgame = false;
```
So that's basically why the buttons can only be pushed once to actually have an effect. Some may call it a design flaw, I see it as a way to make the game more challenging 😆

**Interesting Things I Found:**

+ randomSeed()
+ analogRead()
+ I didn't use this, but I also found this cool function that basically made the momentary switches act as toggles, so instead of the LEDs going off when the button isn't being pushed, it actually stays on or off, depending. This is it: 
```js
const int LED=13;
const int SW=7;
boolean state = true; //declare variable state as boolean
int val=0;

void setup()
{
  pinMode(LED,OUTPUT);
  pinMode(SW,INPUT);
  }
void loop()
{
  val=digitalRead(SW);
  delay(120); // Software debouncing using 120ms delay

if(val==HIGH)

{state=!state; // Compliment variable state using ! operator
  digitalWrite(LED,state);
}
}
```
Source: https://www.circuitstoday.com/simple-led-projects-using-arduino

**Possible Improvements**

+ The values of the LEDs being randomized instead of being fixed would make it a bit more interesting I guess
+ If I could get the counter to increment, there could be multiple ways to arrive at a solution

**Photos of Circuit**

![1](images/Screenshot%20(294).jpg)

![2](images/Screenshot%20(295).jpeg)

![3](images/Screenshot%20(296).jpg)

![4](images/Screenshot%20(297).jpeg)

**Conclusion**

This was a really cool project to do and I really enjoyed it. It was cool actually working with like tangible objects and seeing the way code kind of brought them to life.

**Cool Things the Circuit Does**

I was making up llike classes depending on what I observed the ecosystem needed. Like when the sharks were eating the fish too quickly, I introduced the fishermen hooks and when I noticed that the fish were still dying quickly, I introduced the incubator to spawn more fishes.
