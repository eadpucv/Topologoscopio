/*

	renderizador del audio

*/

var mic;
var steps = 400;
var step = [];
var count = 0;
var maxDiam;
var spaceY;

function setup(){
	createCanvas(40, displayHeight);
	noStroke();
	mic = new p5.AudioIn()
	mic.start();
	maxDiam = width * 1.33;
	spaceY = height / (steps + 1);
	// reset all sonogram values
	for(var i = 0; i < steps; i++){
		step[i] = 0;
	}
	ellipseMode(CENTER);
	rectMode(CENTER);
}

function draw(){
	background(0);
	step[count] = mic.getLevel() * maxDiam;
	sonograma();
	count = (count + 1) % steps;
	// pelotita();
}

function sonograma(){

	// sonograma
	beginShape();
	fill(230, 100, 70);
	for(var i = 0; i < steps; i++){
		vertex(width/2 - step[i]/2, height - (i * spaceY));
	}
	for(var i = steps-1; i >= 0; i--){
		vertex(width/2 + step[i]/2, height - (i * spaceY));
	}
	endShape();

	// cabezal
	fill(255);
	rect(width/2, height - (count * spaceY) - 3, width * .8, 4);
}

function pelotita(){
	micLevel = mic.getLevel();
	ellipse(width/2, constrain(height-micLevel*height*5, 0, height), 10, 10);
}

