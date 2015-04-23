/*

	renderizador del audio

*/

var mic;
var steps = 200;
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
	fill(221, 213, 178, 120);
	for(var i = 0; i < steps; i++){
		ellipse(width/2, height - (i * spaceY), step[i], step[i]);
	}
	fill(255);
	rect(width/2, height - (count * spaceY), width * .5, 2);
}

function pelotita(){
	micLevel = mic.getLevel();
	ellipse(width/2, constrain(height-micLevel*height*5, 0, height), 10, 10);
}

