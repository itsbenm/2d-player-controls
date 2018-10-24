boolean[] keys = {false,false,false,false,false}; // Stop key ghosting
float playerX = 610; // Player starting x position
float playerY = 445;

// Bullet stats

int bulletWidth = 4;
int bulletHeight = 10;
boolean canShoot = false;
int cooldown; // Firerate of player

ArrayList<Bullet> bullet; // For the bullets, need multiple at once

void setup() {
  size(1280,960);
  noStroke();
  
  bullet = new ArrayList<Bullet>(); // Creating the ArrayList
  bullet.add(new Bullet(0,0,bulletWidth,bulletHeight)); // Adding an object into the ArrayList
}

void draw() {
  background(0);
  rect(playerX,playerY,80,30);
  
  // Player Controls
  
  if(keys[0] && playerX>4) playerX -= 10;
  if(keys[1] && playerX<width-84) playerX += 10;
  if(keys[2] && playerY>4) playerY -= 10;
  if(keys[3] && playerY<height-34) playerY += 10;
  if(keys[4] && canShoot) {
    bullet.add(new Bullet(playerX+38,playerY,bulletWidth,bulletHeight));
    canShoot = false;
    cooldown = 0;
  }
  
  // Player firerate
  
  if(canShoot == false) {
    cooldown++;
    if(cooldown == 10) {
      canShoot = true;
    }
  }
  
  // Checking through the ArrayList and making each object move, appear and disappear
  
  for(int i = bullet.size()-1;i >= 0;i--) {
    Bullet bullets = bullet.get(i);
    bullets.display();
    bullets.move();
    if(bullets.finished()) {
      bullet.remove(i);
    }
  }
}

// Player Controls

void keyPressed() {
  if(keyCode == LEFT) keys[0] = true;
  if(keyCode == RIGHT) keys[1] = true;
  if(keyCode == UP) keys[2] = true;
  if(keyCode == DOWN) keys[3] = true;
  if(key == ' ') keys[4] = true;  
}

void keyReleased() {
  if(keyCode == LEFT) keys[0] = false;
  if(keyCode == RIGHT) keys[1] = false;
  if(keyCode == UP) keys[2] = false;
  if(keyCode == DOWN) keys[3] = false;
  if(key == ' ') keys[4] = false; 
}

// Properties of the bullets

class Bullet {
  float x;
  float y;
  float w;
  float h;
  int bulletSpeed = 15;
  
  Bullet(float tempX, float tempY,float tempW,float tempH) {  
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
  }
  
  void move() {
    y -= bulletSpeed;
  }
    
  void display() {
    rect(x,y,w,h);
  }
  
  boolean finished() {
    if(y<0) {
      return true;
    }
    else {
      return false;
    }
  }
}
