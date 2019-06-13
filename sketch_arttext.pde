ArrayList<TextBullet> bullets = new ArrayList<TextBullet>();
float _textSize = 16;
String brush = "YO";
PFont mono;
float lightness = 255;

//----------------------------
void setup(){
    //size(800,600);
    fullScreen();
    frameRate(60);
    noStroke();
    noCursor();
    mono = createFont("PTM55FT.ttf",16);
    textFont(mono);
}

//----------------------------
void draw(){
  background(0,0,0);
  if(mousePressed){
    bullets.add(new TextBullet());
  }
  for (int i = 0; i < bullets.size(); i++) {
    TextBullet bullet = bullets.get(i);
    bullet.draw();
  }
  textSize(_textSize);
  fill(lightness,lightness,lightness);
  text(brush,mouseX,mouseY);
}

//----------------------------
void keyPressed(){
  if(keyCode == ENTER){
    brush = "";
  }else if(keyCode == UP){
    lightness+=10;
    if(lightness>255){
      lightness = 255; 
    }
  }else if(keyCode == DOWN){
    lightness-=10;
    if(lightness<0){
      lightness = 0; 
    }
  }else if(keyCode == DELETE){
    saveFrame("scene-#####.png");
  }else if((key>='a' && key<='z')||(key>='A' && key<='Z')||(key>='0' && key<='9')){
    brush = brush + char(key);
  }
}

//----------------------------
/*void mousePressed(){
  bullets.add(new TextBullet());
}*/
//----------------------------
void mouseWheel(MouseEvent event){
  float e = event.getCount();
  _textSize += e*4;
  if(_textSize<1){
    _textSize = 1;
  }
}

//----------------------------
//TextBullet
//Behaviour and drawing for bullets made out of text
//----------------------------
class TextBullet{
  String label;
  float px;
  float py;
  float vx = 10.0;
  float vy = 10.0;
  float frictionAcc = 0.1;
  float textWidth;
  float textHeight;
  float fontSize;
  float _lightness;
  TextBullet(){
    fontSize = _textSize;
    label=brush;
    _lightness=lightness;
    
    textHeight = fontSize;
    textWidth = fontSize*brush.length()*0.575;
    px = mouseX;
    py = mouseY;
    vx = width/2 - mouseX;
    vy = height/2 - mouseY;
    vx = vx/10;
    vy = vy/10;
  }
  void draw(){
    update();
    textSize(fontSize);
    fill(_lightness,_lightness,_lightness);
    text(label,px,py); 
  }
  void update(){
    px = px+vx;
    py = py+vy;
    
    float speed = sqrt(vx*vx + vy*vy);
    if(abs(speed)<frictionAcc){
      vx=0;
      vy=0;
    }else{
      float ratioX = vx/speed;
      float ratioY = vy/speed;
      speed = speed - frictionAcc;      
      vx = ratioX* speed;
      vy = ratioY* speed;
    }
    
    if((vx>0 && px>width-textWidth)||(vx<0 && px<0)){
      vx = vx*-1.0;
    }
    if((vy>0 && py>height)||(vy<0 && py<0+textHeight/2)){
      vy = vy*-1.0;
    }
  }
  
}
