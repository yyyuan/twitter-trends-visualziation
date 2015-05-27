class Slider{
  PVector start = new PVector(80,627.5);
  int w = 13;
  int h = 13;
  boolean hover = false;
  boolean locked = false;
  boolean play = false;
  boolean hoverControl = false;
  int currentTime = 0;
  PVector position = new PVector(80+((1010-80)/12)*currentTime,617.5);
  String[] times = {"10:10 AM PST", "11:10 AM PST", "12:10 PM PST",
                    "01:10 PM PST", "02:10 PM PST", "03:10 PM PST",
                    "04:10 PM PST", "05:10 PM PST", "06:10 PM PST",
                    "07:10 PM PST", "08:10 PM PST", "10:40 PM PST",};
  void hoverSlider(int mouseX, int mouseY){
    float x = this.position.x;
    float y = this.position.y;
    if(mouseX >= x && mouseX <= x + this.w && mouseY >= y && mouseY <= y+this.h ){
      hover = true;
    }
    else{hover = false;}
    // hover control
    if(mouseX >= 45 && mouseX <= 60 && mouseY >= 618 && mouseY <= 632 ){
      this.hoverControl = true;
    }
    else{this.hoverControl = false;}
  }
  void clickedControl(int mouseX, int mouseY){
    float x = this.position.x;
    float y = this.position.y;
    // hover control
    if(mouseX >= 45 && mouseX <= 60 && mouseY >= 618 && mouseY <= 632 ){
      if(this.play==false){this.play=true; starttime = millis();}
      else{this.play=false;}
    }
  }
  void draw(){
    fill(230);
    rect(80,625,1000-80,0.5);
    if(this.hover){fill(255);}
    else{fill(200);}
    ellipse(this.position.x,this.position.y+this.w/2+2,this.w,this.h);
    // draw text
    textFont(textFont, 16);
    fill(230);
    text(times[this.currentTime],1000+20,630);
    if(!play){
      if(this.hoverControl){fill(255);}
      else{fill(200);}
      triangle(45, 618, 60,  625, 45, 632);
    }
    else{
      if(this.hoverControl){fill(255);}
      else{fill(200);}
      rect(45,618,5,14);
      rect(55,618,5,14);
    }
  }
  void updatePosition(int mouseX, int mouseY){
    if(mouseX > 80+1000-80){this.position.x = 80+1000-80;}
    else if(mouseX < 80){this.position.x = this.start.x;}
    else{this.position.x = mouseX;}
  }
  void setTime(int mouseX, int mouseY){
    int t = (mouseX - 80)/((1000-80)/11); 
    if(t>11){t=11;}
    if(t<0){t=0;}
    //println(t);
    this.currentTime = t;
  }
  void increaseTime(){
    this.currentTime = this.currentTime + 1;
    if(this.currentTime > 11){this.currentTime = 11; this.play = false;}
    this.position.x = 80+(1000-80)/11*this.currentTime;
  }
  void stopPlay(){
    this.play = false;
  
  }
}
