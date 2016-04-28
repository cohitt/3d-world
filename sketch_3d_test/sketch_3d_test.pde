ArrayList<Block> blocks = new ArrayList<Block>();
PVector eye;
PVector center;
float walkSpeed;
float turnSpeed;
float camRotation;
float groundLevel;

void setup() {
  size(750,500,P3D);
  eye = new PVector(width/2, height/2, (height/2) / tan(PI/6));
  center = new PVector(width/2, height/2, 0);
  
  walkSpeed = 4;
  turnSpeed = 0.05;
  groundLevel = (height/2)+50; // Adjust ground so it is lower than the camera level
  
  blocks.add(new Block(width, groundLevel-50, 100, PI/4)); // Set the y position to groundLevel-(size/2) to place the block on the ground
  blocks.add(new Block(width/2, groundLevel-62.5, 125, PI/3)); 
  blocks.add(new Block(0, groundLevel-37.5, 75, PI/8));
}

void draw() {
  ambientLight(150, 150, 150);
  background(0,115,160);
  fill(100,160,100);
  stroke(0);
 
  pushMatrix(); // Add ground
  translate(width/2, groundLevel, 0);
  rectMode(CENTER);
  rotateX(PI/2);
  rect(0, 0, 2*width, 2*height); 
  popMatrix();
  
  int i = 0;
  while (i < blocks.size()) {
    Block part = blocks.get(i);
    part.render();
    i++;
  }
  
  PVector oldEyePosition = eye.copy();
  PVector oldCenterPosition = center.copy();
  camera(eye.x, eye.y, eye.z, center.x, center.y, center.z, 0, 1, 0); // Set eye and center to their respective variables, and make Y the up-axis
  if (keyPressed == true) { // Camera movement
    PVector de = PVector.mult(PVector.div(PVector.sub(eye,center),PVector.sub(eye,center).mag()),walkSpeed);
    PVector dt = PVector.sub(center,eye);
    PVector rot = new PVector(dt.x, dt.z);
    if (key == 'w') { // Walk forward
      eye.sub(de);
      center.sub(de);
    }
    if (key == 's') { // Walk backwards
      eye.add(de);
      center.add(de);
    }
    if (key == 'a') { // Turn left 
      rot.rotate(-turnSpeed);
      center.x = rot.x + eye.x;
      center.z = rot.y + eye.z;
    }
    if (key == 'd') { // Turn right
      rot.rotate(turnSpeed);
      center.x = rot.x + eye.x;
      center.z = rot.y + eye.z;
    }
    
    i = 0; // Reuse old counter variable
    while (i < blocks.size()) { // Loop through list of blocks and compare their positions to that of the camera
      Block part = blocks.get(i);
      if (part.collision(eye) == true) { // If collision is true, revert to old position
        eye = oldEyePosition;
        center = oldCenterPosition;
      }
      i++; 
    }
  }  
}


 