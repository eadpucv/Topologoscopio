var mic;
function setup(){
	createCanvas(40, displayHeight);
	mic = new p5.AudioIn()
	mic.start();
}
function draw(){
	background(0);
	micLevel = mic.getLevel();
	ellipse(width/2, constrain(height-micLevel*height*5, 0, height), 10, 10);
}