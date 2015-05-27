class Filter{
  Trends trends; 
  PVector pos = new PVector(1350,60);
  PVector hidePos = new PVector(1350,60);
  PVector showPos = new PVector(1100,60);
  PVector activePos = new PVector(1220,95);
  int w = 250;
  int h = 570;
  int dy = 25;
  int topicPerPage = 20;
  int topicShift = 0; 
  
  boolean hover = false;
  boolean locked = false;
  
  boolean showTab = false;
  boolean hoverTab = false;
  int transit = 0;
  
  int sw = 135;
  int sh = 35;
  
  IntList activeCity = new IntList();
  StringList activeTrends = new StringList();
  String currentHover;
  String[] array;
  boolean[] hoverArray;
  boolean[] clickedArray;
  Filter(Trends t){
    this.trends = t;

    this.array = this.trends.trends.keyArray();
    this.hoverArray = new boolean[array.length];
    this.clickedArray = new boolean[array.length];
    //this.activeTrends.append("#Oscars2015");
    this.activeTrends.append("#Daytona500");
   
    //this.clickedArray[0] = true;
    this.clickedArray[1] = true;
   
  }
  void draw(){
    
    for(int i = 0; i < this.activeTrends.size(); i++){
      if(i < 25){
       fill(255);
       textFont(textFont, 14);
       text(this.activeTrends.get(i), this.activePos.x -65, this.activePos.y+i*25+5);  
      }
    }
    
    translate(this.pos.x-this.sh, this.pos.y+this.h/2+this.sw/2);
    rotate(PI+PI/2);
    if(this.hoverTab){fill(75,75,75,100);}
    else{fill(75,75,75,70);}
    noStroke();
    rect(0,0,this.sw,this.sh);
    fill(250);
    textFont(textFont, 16);
    text("SELECT TOPICS", 17,23);  
    rotate(-(PI+PI/2));
    translate(-(this.pos.x-this.sh), -(this.pos.y+this.h/2+this.sw/2));
    
    fill(75,75,75,70);
    noStroke();
    rect(this.pos.x, this.pos.y, this.w, this.h);
    // draw current filter
    for(int i = this.topicShift; i < this.topicShift + this.topicPerPage; i++){
      if(clickedArray[i] == true){
        if(hoverArray[i] == true ){fill(240);}
        else{fill(255);}
      }
      else if(hoverArray[i] == true ){fill(255);}
      else{fill(175);}
      textFont(textFont, 16);
      text(this.array[i],this.pos.x + 30, this.pos.y + 40 + (i-topicShift)*this.dy);  

    }
    
    // scrollbar
    fill(75);
    rect(this.pos.x+this.w - 20, this.pos.y + 25, 15, this.h - 50);
    if(this.hover){fill(150);}
    else{fill(100);}
    rect(this.pos.x+this.w - 20, this.pos.y + (25+15) + this.topicShift * (this.h- 15 - 50)/this.array.length,15,(this.h- 15 - 50)*20/this.array.length);
    
  }
  void hoverScroll(int mouseX, int mouseY){
    if(mouseX > this.pos.x+this.w - 20 && mouseX < this.pos.x+this.w - 20 + 15 
    && mouseY > this.pos.y + 25 + 15 + this.topicShift * (this.h- 15 - 50)/this.array.length && 
    mouseY < (this.h- 15 - 50)*20/this.array.length+this.pos.y + 25 + 15 + this.topicShift * (this.h- 15 - 50)/this.array.length){
        this.hover = true;
      }
    else{this.hover = false;}
  }
  void clickedTab(int mouseX, int mouseY){
    if(this.showTab==false){
      if(mouseX > this.pos.x-this.sh && mouseX < this.pos.x-this.sh + this.sh
        && mouseY > this.pos.y+this.h/2-this.sw/2 && mouseY < this.pos.y+this.h/2-this.sw/2 + this.sw){
        this.showTab = true;
        this.pos = this.showPos;
        }
        this.transit = 1;
        //starttime = millis();
    }
    else if(this.showTab==true){
      if(mouseX > this.pos.x-this.sh && mouseX < this.pos.x-this.sh + this.sh
        && mouseY > this.pos.y+this.h/2-this.sw/2 && mouseY < this.pos.y+this.h/2-this.sw/2 + this.sw){
        this.showTab = false;
        this.pos = this.hidePos;
        }
        this.transit = -1;
        //starttime = millis();
    }
    
  } 
  void hoverTab(int mouseX, int mouseY){
    if(mouseX > this.pos.x-this.sh && mouseX < this.pos.x-this.sh + this.sh
        && mouseY > this.pos.y+this.h/2-this.sw/2 && mouseY < this.pos.y+this.h/2-this.sw/2 + this.sw){
      this.hoverTab = true;
      }
    else{this.hoverTab = false;}
    
  } 
  void transitTab(PVector dest){
    float dx = dest.x - this.pos.x; 
    if(abs(dx)>0){this.pos.x += dx*0.02;}
    else{this.pos.x = dest.x;}
  }
  void hoverTag(int mouseX, int mouseY){
   
    for (int i = 0; i < 20; i++){
      if(mouseX > this.pos.x + 20 && mouseX < this.pos.x + 20 + 200 && mouseY > this.pos.y + 25 + i*this.dy && mouseY < this.pos.y + 25 + i*this.dy + 20){
        this.hoverArray[i+this.topicShift] = true;
      }
      else{this.hoverArray[i+this.topicShift] = false;}
    }  
  }
  void clickedTag(int mouseX, int mouseY){
    for (int i = 0; i < 20; i++){
      if(mouseX > this.pos.x + 20 && mouseX < this.pos.x + 20 + 200 && mouseY > this.pos.y + 25 + i*this.dy && mouseY < this.pos.y + 25 + i*this.dy + 20){     
        if(this.clickedArray[i+this.topicShift] ){
          this.clickedArray[i+this.topicShift] = false;
          for(int j = 0; j < this.activeTrends.size(); j++){
            String t = this.array[i+this.topicShift];
            if(t.equals(this.activeTrends.get(j))){
              this.activeTrends.remove(j);
              
            }
          }
      }
        else{
          this.clickedArray[i+this.topicShift] = true; 
          this.activeTrends.append(array[i+this.topicShift]);}
        println("added", array[i+this.topicShift]);
      }
    }
  }
  
  void filterScroll(int e){
    this.topicShift = this.topicShift + e;
    if(this.topicShift > this.array.length - 20) {
    this.topicShift = this.array.length  - 20; }
  }
  void updatePosition(int mouseX, int mouseY){
    if(mouseY > this.pos.y + 25 +  this.h - 50 )
    {this.topicShift = this.array.length  - 20;}
    else if(mouseY < this.pos.y + 25)
    {this.topicShift = 0;}
    else{
      int shift =(int) (mouseY-this.pos.y - (25+15) - 25);
      int dy = (int)((this.h)/(this.array.length-20-14));
      
    this.topicShift = shift/dy;
    if(this.topicShift > this.array.length - 20) {
      this.topicShift = this.array.length  - 20; 
    }
    else if(this.topicShift < 0) {
      this.topicShift = 0; }
 
  }

  }
}
