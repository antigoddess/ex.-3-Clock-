void setup() {
  surface.setTitle("Time passes");
  surface.setResizable(false);

  size(1024, 720);
  smooth(8);
  frameRate(24);
  noStroke();
  fill(BLUE[0], BLUE[1], BLUE[2]);

  grass = loadImage("grass.png");
  grass.resize(1000, 800);

  PImage sun_s = loadImage("sun.png");
  sun_s.resize(128, 128);
  sun = new Entity(sun_s, Type.Sun);

  PImage moon_s = loadImage("moon.png");
  moon_s.resize(128, 128);
  moon = new Entity(moon_s, Type.Moon);
}

PImage grass;
Entity sun;
Entity moon;

int R = 300;
double time;

int[] BLUE = {0, 0, 128};
int[] LIGHT_BLUE = {0, 191, 255};
int[] MAGENTA = {178,34,34};
int[] BLACK = {0, 0, 0};
int[][] COLORS = {BLUE, LIGHT_BLUE, MAGENTA, BLACK};

enum Type {
  Sun, 
    Moon
}

void draw() {
  time = ((millis()/1000.0)%60)/2.5;
  setBG(time);
  sun.setPosition(time);
  moon.setPosition(time);
  image(moon.s, moon.x, moon.y);
  image(sun.s, sun.x, sun.y);
  image(grass, width/2 - grass.width/2, height - grass.height/2);
}

void setBG(double time) {
  int[] f1, f2;
  if (time>0 && time<=6) {
    f1 = BLUE;
    f2 = LIGHT_BLUE;
  } else if (time>6 && time<=12) {
    f1 = LIGHT_BLUE;
    f2 = MAGENTA;
  } else if (time>12 && time<=18) {
    f1 = MAGENTA;
    f2 = BLACK;
  } else {
    f2 = BLUE;
    f1 = BLACK;
  }
  double k = (time%6)/6;
  println((int)(f1[0] + (f2[0] - f1[0]) * k), (int)(f1[1] + (f2[1] - f1[1]) * k), (int)(f1[2] + (f2[2] - f1[2]) * k));
  background((int)(f1[0] + (f2[0] - f1[0]) * k), (int)(f1[1] + (f2[1] - f1[1]) * k), (int)(f1[2] + (f2[2] - f1[2]) * k));
}

class Entity {
  int x;
  int y;
  PImage s;
  Type t;

  Entity(PImage sprite, Type type) {
    if (type == Type.Sun) {
      x = width/2 - R;
      y = height*2/3;
    } else {
      x = width/2 + R;
      y = height*2/3;
    }
    this.s = sprite;
    this.t = type;
  }

  void setPosition(double t) {
    double cos = cos((float)(PI/12*t));
    double sin = sin((float)(PI/12*t));
    if (this.t == Type.Sun) {
      x = (int)((width/2 - cos * R) - s.width/2)%(width-10);
      y = (int)((height/2*3 - sin * R) - s.height/2)%(height-10);
    } else {
      x = (int)((width/2 + cos * R) - s.width/2)%(width-10);
      y = (int)((height/2*3 + sin * R) - s.height/2)%(height-10);
    }
  }
}
