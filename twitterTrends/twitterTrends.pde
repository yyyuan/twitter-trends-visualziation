/*
Visualize Twitter Trends
by Irene Ye Yuan
*/

PFont textFont;
PFont titleFont;

//
Trends trends = new Trends(); 
IntDict cityIndex = new IntDict();
Slider slider = new Slider();
City[][] cities = new City[12][60]; // # of all tags - 137
Filter filter;

//
int duration = 1000; 
int starttime; 

void setup(){
// setup font
textFont = loadFont("MyriadPro-Regular-48.vlw");
titleFont = loadFont("MyriadPro-Bold-25.vlw");
colorMode(RGB,255,255,255,100);
size(1350,670);
smooth();
frameRate(30);

// load trends
// for(int i = 0; i < 12; i++){trends[i] = new Trends();}
loadTrends(trends);  
// load city index
loadCityIndex(cityIndex);
//println(cityIndex);
// load cities data
loadCities(cities);

//setup filter
filter = new Filter(trends);
  

}

void draw(){
  if(slider.play){
     if( millis() < starttime + duration ){
       
     }
     else{
       if(slider.currentTime<12){slider.increaseTime();}
        else{slider.stopPlay();} 
        starttime = millis();
     }
  }  
  
  /*
  if(filter.transit == 1){
     if( millis() < starttime + duration ){
       
     }
     else{
       if(slider.currentTime<12){slider.increaseTime();}
        else{slider.stopPlay();} 
        starttime = millis();
     }
  }  
  */
  
  // background
  background(26);
  // 
  stroke(255);
  noFill();
  // title
  //rect(25,25,250,50);
  textFont(titleFont,25);
  fill(255);
  text("WHAT PEOPLE TWEETED ABOUT ON FEB 22 2015",30,55);
  /*text("WHAT PEOPLE ",30,55);
  fill(6,207,255);
  text("TWEETED",30+12*14.5,55);
  fill(255);
  text(" ABOUT ON FEB 22 2015",30+(12+7)*15,55);*/
  noFill();
  

  // draw slider
  slider.hoverSlider(mouseX,mouseY);
  slider.draw();
  
  // draw time zone labels
  drawTimeLabel(1120,505,"UTC-05:00");
  drawTimeLabel(658,505,"UTC-06:00");
  drawTimeLabel(382,505,"UTC-07:00");
  drawTimeLabel(199,505,"UTC-08:00");
  drawTimeLabel(106,505,"UTC-10:00");
  
  drawTimeLine(1120,85);
  drawTimeLine(658,187);
  drawTimeLine(382,392);
  drawTimeLine(199,187);
  drawTimeLine(106,490);
  
  // city areas
  //rect(285,85,990,590);  
  // draw circles
  for(int i = 0; i <60; i++){
    // check hover
    if(cities[slider.currentTime][i].hoverCircle(mouseX,mouseY)!="0"){
      filter.currentHover = cities[slider.currentTime][i].hoverCircle(mouseX,mouseY);
    } 
    cities[slider.currentTime][i].hoverCity(mouseX,mouseY);
  }
  
 
 if(filter.currentHover!=null){
  for(int j = 0; j <60; j++){
    cities[slider.currentTime][j].setHover(filter.currentHover);
  }
 }
  
for(int i = 0; i <60; i++){
    // check hover
    if(!cities[slider.currentTime][i].out){
      filter.currentHover = null;
    } 
  }
 
  for(int i = 0; i < 60; i++){
      cities[slider.currentTime][i].setActive(filter.activeTrends);
  }
  
  filter.hoverTag(mouseX, mouseY);
  filter.hoverScroll(mouseX,mouseY);
  filter.hoverTab(mouseX, mouseY);
  
  for(int i = 0; i <60; i++){
    cities[slider.currentTime][i].draw();
    //cities[activeTime][i].drawTextBox(mouseX,mouseY);
  }
  
  
  for(int i = 0; i <60; i++){
    cities[slider.currentTime][i].drawTextBox(mouseX,mouseY);
  }
  
   // filter
  
  filter.draw(); 

}

void mouseClicked() {
  // check main area
   for(int i = 0; i <60; i++){
    cities[slider.currentTime][i].clickedCircle(mouseX,mouseY);
    cities[slider.currentTime][i].clickedCity(mouseX,mouseY);
  }
  slider.clickedControl(mouseX,mouseY);
  // check sidebar
  filter.clickedTag(mouseX, mouseY);
  //println(filter.activeTrends);
  filter.clickedTab(mouseX, mouseY);
}

void mousePressed() {
  if(slider.hover){
    slider.locked = true;
  }
  if(filter.hover){
    filter.locked = true;
    println("start to scroll");
  }
}
 
void mouseDragged() {
  if(slider.locked){
    slider.updatePosition(mouseX, mouseY); 
    slider.setTime(mouseX, mouseY); 
    //println();
  }
  if(filter.locked){
    filter.updatePosition(mouseX, mouseY); 
    //println();
  }
}
 
void mouseReleased() {
  slider.locked = false;
  filter.locked = false;
}

void mouseWheel(MouseEvent event) {
  int e = (int)event.getCount();
  filter.filterScroll(e);
}


void drawTimeLabel(int x, int y, String text){
  // change color 
  translate(x,y);
  rotate(PI/2);
  //stroke(102,102,102);
  //line(-5,-7,-5,17);
  textFont(textFont,12);
  fill(100,100,100);
  text(text,2,2);
  rotate(-PI/2);
  translate(-x,-y);
}

void drawTimeLine(int x, int y){
  // change color 
  translate(x,y);
  rotate(PI/2);
  stroke(100,100,100);
  line(-5,-3,-5,15);
  line(-5,-3,abs(495-y),-3);
  rotate(-PI/2);
  translate(-x,-y);
}
