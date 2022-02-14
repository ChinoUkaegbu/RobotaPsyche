
//initial size of the respective array lists
int initial_tuna = 40;
int initial_shark = 2;
int initial_hook = 2;

ArrayList<Tuna> tunas = new ArrayList<Tuna>();
ArrayList<Shark> sharks = new ArrayList<Shark>();
ArrayList<Hook> hooks = new ArrayList<Hook>();
Incubator incubator;

void setup() {
  size(1400, 800);

  //initialize each tuna to spawn at random locations
  for (int i = 0; i < initial_tuna; i++) {
    tunas.add(new Tuna(1.5, // mass
      random(width), random(height))); // initial location
  }

  //initialize each shark to spawn at random locations
  for (int i = 0; i < initial_shark; i++) {
    // Each Shark is initialized randomly.
    sharks.add(new Shark(1.5, // mass
      random(width), random(height))); // initial location
  }

  //initialize the two fishing hooks at the top of the screen
  hooks.add(new Hook((width/2)-150, 0));
  hooks.add(new Hook((width/2)+130, 0));

  //initialize incubator
  incubator = new Incubator((width-100), (height-500));
}

void draw() {
  
  //create split backgroound representing light and dark areas of the sea
  fill(0,255,255);
  rect(0,0,width, height/2);
  fill(0, 84, 119);
  rect(0,height/2, width, height/2);
  
  //sun
  fill(255,255,0);
  circle(0,0,400);
  fill(255,255,255);
  strokeWeight(3);
  line(90,200,130,300);
  line(215,92,321,143);
  
  //displays incubator and adds more tuna to the array list as needed
  incubator.breed();

  // For each tuna
  for (int i = 0; i < tunas.size(); i++) {

    // Now apply the force from all the other tuna on this tuna
    for (int j = 0; j < tunas.size(); j++) {
      // Don’t attract yourself!
      if (i != j) {
        PVector force = tunas.get(j).attract(tunas.get(i));
        tunas.get(i).applyForce(force);
      }
    }
    tunas.get(i).update();
    tunas.get(i).checkEdges();
    tunas.get(i).display();
  }

  // For each shark
  for (int i = 0; i < sharks.size(); i++) {

    // Now apply the force from all the other sharks on this shark
    for (int j = 0; j < sharks.size(); j++) {
      // Don’t repel yourself!
      if (i != j) {
        PVector force = sharks.get(j).repel(sharks.get(i));
        sharks.get(i).applyForce(force);
      }
    }
    sharks.get(i).update();
    sharks.get(i).checkEdges();
    sharks.get(i).display();
    
    //check if shark can eat any tuna around
    for (int j = 0; j < tunas.size(); j++) {
      sharks.get(i).eat(tunas.get(j));
    }
  }

  //Every ten seconds the fishing hooks disappear and reappear after another 10 seconds
  if (frameCount%600 ==0) {
    if (hooks.size()==0)
    {
      hooks.add(new Hook((width/2)-150, 0));
      hooks.add(new Hook((width/2)+130, 0));
    } else
    {
      for (int i =hooks.size()-1; i>=0; i--)
      {
        hooks.remove(i);
      }
    }
  }

  for (int i = 0; i<hooks.size(); i++) {
    hooks.get(i).display();
    for (int j = 0; j < sharks.size(); j++) {
      hooks.get(i)._catch(sharks.get(j)); //the hooks can catch only sharks, not tuna
    }
  }
}

class Tuna {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float G = 0.4;
  boolean breedable = true; //variable to check if tuna has been in the incubator before

  Tuna(float _mass_, float _x_, float _y_) {
    mass = _mass_;
    location = new PVector(_x_, _y_);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  // Newton’s second law.
  void applyForce(PVector force) {
    // Receive a force, divide by mass, and add to acceleration.
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  // The Tuna now knows how to attract another Tuna.
  PVector attract(Tuna t) {

    PVector force = PVector.sub(location, t.location);
    float distance = force.mag();
    distance = constrain(distance, 10.0, 20.0);
    force.normalize();

    float strength = (G * mass * t.mass) / (distance * distance);
    force.mult(strength);

    return force;
  }


  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    //if fish is on the light half of the sea, it's more brightly coloured but as it sims deeper to the darker areas, its color changes to something darker
    if (location.y>(height/2)) {
      fill(144, 6, 3);
    }
    else {
      fill (255, 0, 0);
    }
    
    // Rotate the fish to point in the direction of travel
    // Translate to the center of the move
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading());
    triangle(0, mass*4, 0, -(mass*4), mass*19, 0);
    popMatrix();
  }

  //Fish bounce of edges
  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1; // full velocity, opposite direction
      velocity.x *= 0.8; // lose a bit of energy in the bounce
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1; // full velocity, opposite direction
      velocity.x *= 0.8; // lose a bit of energy in the bounce
    }

    if (location.y > height) {
      location.y = height;
      velocity.y *= -1; // full velocity, opposite direction
      velocity.y *= 0.8; // lose a bit of energy in the bounce
    } else if (location.y < 0) {
      location.y = 0;
      velocity.y *= -1; // full velocity, opposite direction
      velocity.y *= 0.8; // lose a bit of energy in the bounce
    }
  }
}

class Shark {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float G = 0.4;

  Shark(float _mass_, float _x_, float _y_) {
    mass = _mass_;
    location = new PVector(_x_, _y_);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  // Newton’s second law.
  void applyForce(PVector force) {
    // Receive a force, divide by mass, and add to acceleration.
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  // The Shark now knows how to repel another Shark.
  PVector repel(Shark s) {

    PVector force = PVector.sub(location, s.location);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 25.0);
    force.normalize();
    force.mult(-.03);

    return force;
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    //if shark is on the light half of the sea, it's more brightly coloured but as it sims deeper to the darker areas, its color changes to something darker
    stroke(0);
    if (location.y>(height/2)) {
      fill(0, 100, 0);
    }
    else {
      fill (0, 255, 0);   
    }
     // Rotate the mover to point in the direction of travel
    // Translate to the center of the shark
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading());
    // It took lots of trial and error
    // and sketching on paper
    // to get the triangle
    // pointing in the right direction
    triangle(0, mass*17, 0, -(mass*17), mass*40, 0);
    popMatrix();
  }

  //Shark respawns in completely random area

  void checkEdges() {
    if (location.x > width) {
      location.x = random(height);
      velocity.x *= -1; // full velocity, opposite direction
      velocity.x *= 0.8; // lose a bit of energy in the bounce
    } else if (location.x < 0) {
      location.x = random(height);
      velocity.x *= -1; // full velocity, opposite direction
      velocity.x *= 0.8; // lose a bit of energy in the bounce
    }

    if (location.y > height) {
      location.y = random(width);
      velocity.y *= -1; // full velocity, opposite direction
      velocity.y *= 0.8; // lose a bit of energy in the bounce
    } else if (location.y < 0) {
      location.y = random(width);
      velocity.y *= -1; // full velocity, opposite direction
      velocity.y *= 0.8; // lose a bit of energy in the bounce
    }
  }

  //If the shark encounters the tuna, it will eat it
  void eat(Tuna t) {
    if (location.x >= t.location.x && location.x <= t.location.x+0.5)
    {
      tunas.remove(t);
    }
  }
}


class Hook {
  PVector location;

  Hook(float _x_, float _y_) {
    location = new PVector(_x_, _y_);
  }

  void display() {
    fill(10,10,13);
    rect(location.x, location.y, 20, 60);
  }

  //method to catch sharks if they swin close by
  void _catch(Shark s) {
    if (s.location.x >= location.x && s.location.x <= location.x+20 && s.location.y >= 0 && s.location.y <= 60)
    {
      sharks.remove(s);
    }
  }
}

class Incubator {
  PVector location;
  int counter;

  Incubator(float _x_, float _y_) {
    location = new PVector(_x_, _y_);
    counter = 0;
  }

  void display() {
    fill(192, 192, 192);
    rect(location.x, location.y, 100, 300);
  }

  void breed() {
    if (counter==0)
    {
      display();
    }

    //For all the tuna
    for (int i = 0; i<tunas.size(); i++)
    {
      //if the tuna is in the incubator region and hasn't been there before, then increment te counter variable and set brredability of the fish to false;
      if (tunas.get(i).location.x >= location.x && tunas.get(i).location.x <= location.x+100 && tunas.get(i).location.y >= 300 && tunas.get(i).location.y <= 600 && tunas.get(i).breedable == true)
      {
        counter++;
        tunas.get(i).breedable = false;
        break;
      }
    }


    if (counter%2==0 && counter!=0) { //if 2 fish have been in the incubator one after the other (I'll refer to this as one 'iteration', a new tuna fish is spawned and the color of the incubator changes to grey
      fill(192, 192, 192);
      rect(location.x, location.y, 100, 300);
      counter = 0;
      tunas.add(new Tuna(1.5, // mass
        random(width), random(height)));
    } else if (counter%2!=0 && counter!=0) { //if only 1 fish has been in the incubator in that 'iteration' then the color of the incubator changes but 1 more tuna fish for a new fish to be spawned
      //fill(98,13,168);
      fill(81,1,160);
      rect(location.x, location.y, 100, 300);
    }
  }
}
