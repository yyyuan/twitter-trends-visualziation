class City {
  PVector position = new PVector(0,0);
  String[] trends = new String[3];
  String cityName;
  int timeZone;
  float[] radius = {25,47,68}; 
  boolean[] active = {false, false, false, false}; 
  boolean[] hover = {false, false, false, false};
  color[] cs = new color[4];
  boolean out = false;
  // 0 for inactive, 1 for active, 2 for hover
  City(String n){
    this.cityName = n;
    int index = cityIndex.get(n)-1;
    int y = index%5;
    int x = index/5;
    //println(x,y);
    this.position.x = 63+x*(155-63);
    this.position.y = 528-y*(222-120);
    //println("location: "+ this.position.x+" "+this.position.x);
    if(cityIndex.get(n)==1){ 
    this.cs[0] = color(196,206,74,90);this.cs[1] = color(196,206,74,70);this.cs[2] = color(196,206,74,40);this.cs[3] = color(196,206,74,20);
    }
    else if(cityIndex.get(n) > 1 && cityIndex.get(n) < 10){
    this.cs[0] = color(151,204,76,90);this.cs[1] = color(151,204,76,70);this.cs[2] = color(151,204,76,40);this.cs[3] = color(151,204,76,20);
    }
    else if(cityIndex.get(n) > 9 && cityIndex.get(n) < 18){
    this.cs[0] = color(74,209,84,90);this.cs[1] = color(74,209,84,70);this.cs[2] = color(74,209,84,40);this.cs[3] = color(74,209,84,20);
    }
    else if(cityIndex.get(n) > 17 && cityIndex.get(n) < 35){
    this.cs[0] = color(74,206,149,90);this.cs[1] = color(74,206,149,70);this.cs[2] = color(74,206,149,40);this.cs[3] = color(74,206,149,20);
    }
    else{
    this.cs[0] = color(71,204,214,90);this.cs[1] = color(71,204,214,70);this.cs[2] = color(71,204,214,40);this.cs[3] = color(71,204,214,20);
    } 
  }
  void addTrend(String s, int r){
    this.trends[r-1] = s;
    //println(trends[r-1]);
  }
  String hoverCircle(int mouseX, int mouseY){
    float distance = sqrt(sq(mouseX-this.position.x) + sq(mouseY-this.position.y));
    if(distance < this.radius[0]-12){
      this.out = false;
      this.hover[0] = true; 
      this.hover[1] = this.hover[2] = this.hover[3] = false;
      return this.trends[0];
    }
    else if(distance < this.radius[1] - 24){
      this.out = false;
      this.hover[1] = true; 
      this.hover[0] = this.hover[2] = this.hover[3] = false;
      return this.trends[1];
    }
    else if(distance < this.radius[2]-34){
      this.out = false;
      this.hover[2] = true; 
      this.hover[0] = this.hover[1] = this.hover[3] = false;
      return this.trends[2];
    }
    else if(distance > this.radius[2]-34){
      this.hover[0] = this.hover[1] = this.hover[2] = this.hover[3] = false;
      this.out = true;
      return "0";
    }
    else{return "0";}
  }
  void setHover(String currentHover){
     for(int i = 0; i < 3; i++){
        if(currentHover.equals(this.trends[i]))
        {this.hover[i]=true;}
        else{this.hover[i]=false;}
      }
  }
  void clickedCircle(int mouseX, int mouseY){
    float distance = sqrt(sq(mouseX-this.position.x) + sq(mouseY-this.position.y));
    if(distance < this.radius[0]-12){
      if(this.active[0]){this.active[0] = false;}
      else{this.active[0] = true;}; 
    }
    else if(distance < this.radius[1] - 24){
      if(this.active[1]){this.active[1] = false;}
      else{this.active[1] = true;};  
    }
    else if(distance < this.radius[2]-34){
      if(this.active[2]){this.active[2] = false;}
      else{this.active[2] = true;}; 
    }
  }
  
  void setActive(StringList currentActive){
    for(int i = 0; i < 3; i++){
      //println(currentActive.equals(this.trends[i]));
      //println(trends[i]);
      boolean exist = false; 
      for(int j = 0; j < currentActive.size(); j++){
        if(currentActive.get(j).equals(this.trends[i])){exist=true;}
      }
      if(exist){this.active[i] = true;}
      else{this.active[i] = false;}
    }
  }
  
  
  void hoverCity(int mouseX, int mouseY){
    float x = this.position.x-5*this.cityName.length()/2;
    float y = this.position.y+50-12;
    float w = 6*this.cityName.length();
    float h = 12;
    if(mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y+h ){
      this.hover[3] = true; 
      this.hover[0] = this.hover[1] = this.hover[2] = false;
    }
  }
  void clickedCity(int mouseX, int mouseY){
    float x = this.position.x-5*this.cityName.length()/2;
    float y = this.position.y+50-12;
    float w = 6*this.cityName.length();
    float h = 12;
    if(mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y+h ){
      this.active[3] = true; 
    }
  
  }
  void draw(){
   
    // fill out the areas depending on the current state
    noStroke();
    if(this.hover[2]){fill(this.cs[0]);}
    else if(this.active[2]){fill(this.cs[3]);}
    else{fill(26);}
    ellipse(this.position.x,this.position.y,this.radius[2],this.radius[2]);
    fill(26);
    ellipse(this.position.x,this.position.y,this.radius[1],this.radius[1]);
    if(this.hover[1]){fill(this.cs[0]);}
    else if(this.active[1]){fill(this.cs[2]);}
    else{fill(26);}
    ellipse(this.position.x,this.position.y,this.radius[1],this.radius[1]);
    fill(26);
    ellipse(this.position.x,this.position.y,this.radius[0],this.radius[0]);
    if(this.hover[0]){fill(this.cs[0]);}
    else if(this.active[0]){fill(this.cs[1]);}
    else{fill(26);}
    ellipse(this.position.x,this.position.y,this.radius[0],this.radius[0]);
    
    // draw all the boundaries
    stroke(this.cs[0]);
    strokeWeight(0.7);
    translate(this.position.x,this.position.y);
    dashedCircle(this.radius[2]-34,3,3);
    dashedCircle(this.radius[1]-24,3,5);
    dashedCircle(this.radius[0]-12,3,9);
    translate(-this.position.x,-this.position.y);
    
    // draw the city name
    if(this.hover[3]){fill(255);}
    else if(this.active[3]){fill(255);}
    else{fill(255);}
    textFont(textFont, 12);
    text(this.cityName,this.position.x-5*this.cityName.length()/2,this.position.y+50); 
    
  }
  void drawTextBox(int mouseX, int mouseY){
    if(!this.out){
    if(this.hover[0]){
      noStroke();
      fill(26,26,26,70);
      rect(mouseX+20,mouseY-17,150,45);
      textFont(textFont, 14);
      fill(255);
      text("RANK: #1",mouseX+25+5,mouseY-5+5);
      text(this.trends[0],mouseX+25+5,mouseY-5+5+17);
    }
    else if(this.hover[1]){
      noStroke();
      fill(26,26,26,70);
      rect(mouseX+20,mouseY-17,150,45);
      textFont(textFont, 14);
      fill(255);
      text("RANK: #2",mouseX+25+5,mouseY-5+5);
      text(this.trends[1],mouseX+25+5,mouseY-5+5+17);
    }
    else if(this.hover[2]){
      noStroke();
      fill(26,26,26,70);
      rect(mouseX+20,mouseY-17,150,45);
      textFont(textFont, 14);
      fill(255);
      text("RANK: #3",mouseX+25+5,mouseY-5+5);
      text(this.trends[2],mouseX+25+5,mouseY-5+5+17);
    }
    else if(this.hover[3]){
      noStroke();
      fill(26,26,26,70);
      rect(mouseX+20,mouseY-17,180,60);
      textFont(textFont, 12);
      fill(255);
      text("1ST RANK: "+this.trends[0],mouseX+25+5,mouseY-5+5);
      text("2ND RANK: "+this.trends[1],mouseX+25+5,mouseY-5+5+15);
      text("3RD RANK: "+this.trends[2],mouseX+25+5,mouseY-5+5+30);
    }
  }
  }
}

/* 
the following dashed circle method drawn from open processing 
code http://www.openprocessing.org/sketch/28215 
*/
void dashedCircle(float radius, int dashWidth, int dashSpacing) {
    int steps = 200;
    int dashPeriod = dashWidth + dashSpacing;
    boolean lastDashed = false;
    for(int i = 0; i < steps; i++) {
      boolean curDashed = (i % dashPeriod) < dashWidth;
      if(curDashed && !lastDashed) {
        beginShape();
      }
      if(!curDashed && lastDashed) {
        endShape();
      }
      if(curDashed) {
        float theta = map(i, 0, steps, 0, TWO_PI);
        vertex(cos(theta) * radius, sin(theta) * radius);
      }
      lastDashed = curDashed;
    }
    if(lastDashed) {
      endShape();
    }
}
