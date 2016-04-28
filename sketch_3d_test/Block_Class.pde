class Block {
  PVector pos;
  float size;
  float rotation;
  
  Block (float xpos, float ypos, float s, float r) { // Set position, size, and rotation
    pos = new PVector(xpos, ypos, 0);
    size = s;
    rotation = r;
  }
  
  void render() { // Draw block
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    rotateY(rotation);
    box(size);
    popMatrix();
  }
  
  boolean collision(PVector newEyePosition) { // Check if camera is within the bounds of the block
    PVector rotPos = new PVector(pos.x, pos.z); // Convert position to a 2d vector
    rotPos.rotate(rotation); 
    PVector rotNewPos = new PVector(newEyePosition.x, newEyePosition.z); // Convert new position to 2d vector
    rotNewPos.rotate(rotation); 
    if (rotNewPos.x < rotPos.x+(.95*size) & rotNewPos.x > rotPos.x-(.95*size) & rotNewPos.y < rotPos.y+(.95*size) & rotNewPos.y > rotPos.y-(.95*size)) {
      return true;
    } else {
    return false;
    }
  }
}