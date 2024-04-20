SliderHandler sliderHandler;

void setup(){
  size(800,800);
  background(125);
  sliderHandler = new SliderHandler();
  sliderHandler.addSlider();
  sliderHandler.defRange(0,100,1000);
}

void draw(){
  background(255);
  sliderHandler.drawAndUpdateSlider();
  println(sliderHandler.getRangedOutput(0));
}

void mouseClicked(){
  sliderHandler.addSlider(); 
}

void keyPressed(){
  sliderHandler.changeParameter(key);
  sliderHandler.printSliderConfig(); 
}
