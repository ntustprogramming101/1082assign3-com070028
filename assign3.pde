PImage bg, life, soldier, cabbage;
PImage title, startHovered, startNormal;
PImage gameOver, restartHovered, restartNormal;
PImage groundhogIdleImg, groundhogDownImg, groundhogLeftImg, groundhogRightImg;
PImage []imgSoil;
PImage stone1, stone2;

int measure=80;
int grid =80;

//gamestate
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState = 0; 


//groundHoG position
float groundHogX, groundHogY, groundHog_W, groundHog_H;
float groundhogLestY, groundHogLestX;



//start botton  
final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 360+60;
final int BUTTON_LEFT = 240;
final int BUTTON_RIGHT = 240+144;


//moving
boolean upPressed = false;
boolean downPressed= false;
boolean leftPressed=false;
boolean rightPressed=false;
int groundhogFrame; 
float LT; 
float translateY;




//loop+array
int layerSoil=24;
int soilType=6;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
  frameRate = (60);
  size(640, 480, P2D);
  // Enter Your Setup Code Here
  //soil
  imgSoil= new PImage [soilType];
  for (int i=0; i<soilType; i++) {
    imgSoil[i]=loadImage("img/soil"+i+".png");
  }

  stone1=loadImage("img/stone1.png");
  stone2=loadImage("img/stone2.png");

  bg= loadImage("img/bg.jpg"); 

  groundhogIdleImg= loadImage("img/groundhogIdle.png");
  groundhogDownImg = loadImage("img/groundhogDown.png");
  groundhogLeftImg = loadImage("img/groundhogLeft.png");
  groundhogRightImg = loadImage("img/groundhogRight.png");
  life= loadImage("img/life.png");
  soldier= loadImage("img/soldier.png");
  cabbage= loadImage("img/cabbage.png");

  title= loadImage("img/title.jpg"); 
  startHovered= loadImage("img/startHovered.png"); 
  startNormal= loadImage("img/startNormal.png"); 
  gameOver= loadImage("img/gameover.jpg"); 
  restartHovered= loadImage("img/restartHovered.png"); 
  restartNormal= loadImage("img/restartNormal.png"); 


  groundHogX= 4*measure;
  groundHogY= 1*measure ;
  groundHog_W=groundHog_H =80;


  frameRate = 60;
  LT=millis();
  translateY=0;
}

void draw() {

  /* ------ Debug Function ------ 
   
   Please DO NOT edit the code here.
   It's for reviewing other requirements when you fail to complete the camera moving requirement.
   
   */
  if (debugMode) {
    pushMatrix();
    translate(0, cameraOffsetY);
  }
  /* ------ End of Debug Function ------ */



  // Switch Game State
  switch(gameState) {

    // Game Start
  case GAME_START:
    image(title, 0, 0);

    if (mouseX > BUTTON_LEFT  && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM) {

      image(startHovered, 248, 360);
      if (mousePressed) {
        gameState = GAME_RUN;
      }
    } else {
      image(startNormal, 248, 360);
    }

    break;




    // Game Run
  case GAME_RUN:

    pushMatrix();  //////////////////////////begining of the translate
    translate(0, translateY);


    //soil
    image(bg, 0, 0);
    //soil
    for (int i=0; i<24; i++) {
      for (int k=0; k<8; k++) {
        int grid=80;
        if (i>=0 && i<4) {

          image(imgSoil[0], grid*k, 2*grid+grid*i);
        }

        if (i>=4 && i<8) {
          image(imgSoil[1], grid*k, 2*grid+grid*i);
        }

        if (i>=8 && i<12) {
          image(imgSoil[2], grid*k, 2*grid+grid*i);
        }

        if (i>=12 && i<16) {
          image(imgSoil[3], grid*k, 2*grid+grid*i);
        }

        if (i>=16 && i<20) {
          image(imgSoil[4], grid*k, 2*grid+grid*i);
        }

        if (i>=20 && i<24) {
          image(imgSoil[5], grid*k, 2*grid+grid*i);
        }

        //1-8 stone1
        if (i>=0 && i<8) {
          image(stone1, grid*i, 2*grid+grid*i);
        }

        //8-16 stone1
        if (i>=8 && i<16 ) {
          if (i%4==1||i%4==2) {
            if (k%4==0||k%4==3) {
              image(stone1, grid*k, 2*grid+grid*i);
            }
          }
        } 

        if (i>=8 && i<16 ) {
          if (i%4==0||i%4==3) {
            if (k%4==1||k%4==2) {
              image(stone1, grid*k, 2*grid+grid*i);
            }
          }
        }


        //16-24 stone 1+ stone 2
        //stone1
        if (i>=16 && i<24 ) {
          if (i==16||i==19||i==22) {
            if (k%3==1||k%3==2) {
              image(stone1, grid*k, 2*grid+grid*i);
            }
            if (k%3==2) {
              image(stone2, grid*k, 2*grid+grid*i);
            }
          }//i
        }//if i>=16 <24

        if (i>=16 && i<24 ) {
          if (i==17||i==20||i==23) {
            if (k%3==0||k%3==1) {
              image(stone1, grid*k, 2*grid+grid*i);
            }
            if (k%3==1) {
              image(stone2, grid*k, 2*grid+grid*i);
            }
          }//i
        }//if i>=16 <24

        if (i>=16 && i<24 ) {
          if (i==18||i==21) {
            if (k%3==0||k%3==2) {
              image(stone1, grid*k, 2*grid+grid*i);
            }
            if (k%3==0) {
              image(stone2, grid*k, 2*grid+grid*i);
            }
          }//i
        }//if i>=16 <24
      }
    }


    //grass
    fill(124, 204, 25);
    noStroke();
    rect(0, 2*measure-15, 8*measure, 15);

    //sun
    noStroke();
    fill(255, 255, 0);
    ellipse(590, 50, 130, 130);
    noStroke();
    fill(253, 184, 19);
    ellipse(590, 50, 120, 120);


    //groundhog
    //print(downPressed+"\n");
    if (downPressed == false && leftPressed == false && rightPressed == false) {
      image(groundhogIdleImg, groundHogX, 0+groundHogY, groundHog_W, groundHog_H);
    }


    //draw the groundhogDown image between 1-14 frames

    if (downPressed) {

      if (translateY>-20*measure) {
        groundhogFrame++;

        if (groundhogFrame++ > 0 && groundhogFrame++ < 15) {
          translateY -= measure / 15.0; //move animation
          groundHogY += measure / 15.0; //move animation
          image(groundhogDownImg, groundHogX, groundHogY, groundHog_W, groundHog_H);
        } else {
          translateY = groundhogLestY - measure; //move
          groundHogY = translateY*-1+measure; //move
          downPressed = false;
        }//newposition
      } else {//translate the canvus until 19th layer
        groundhogFrame++;
        if (groundhogFrame++ > 0 && groundhogFrame++ < 15) {
          groundHogY += measure / 15.0; //move animation
          image(groundhogDownImg, groundHogX, groundHogY, groundHog_W, groundHog_H);
        } else {
          groundHogY = groundhogLestY + measure;
          downPressed = false;
        }
      }
    }//downpressed



    //draw the groundhogLeft image between 1-14 frames
    if (leftPressed) {
      groundhogFrame++;
      if (groundhogFrame++ > 0 && groundhogFrame++ < 15) {
        groundHogX -= measure / 15.0;
        image(groundhogLeftImg, groundHogX, groundHogY, groundHog_W, groundHog_H);
      } else {
        groundHogX = groundHogLestX - measure;
        leftPressed = false;
      }
    }

    //draw the groundhogRight image between 1-14 frames
    if (rightPressed) {
      groundhogFrame++;
      if (groundhogFrame++ > 0 && groundhogFrame++ < 15) { //increase 1 measure per 1/60s
        groundHogX += measure / 15.0;//increase 80/15 per 1/60s
        image(groundhogRightImg, groundHogX, groundHogY, groundHog_W, groundHog_H);
      } else {
        groundHogX = groundHogLestX + measure;
        rightPressed = false;
      }
    }

    //boundary detection
    if (groundHogX>width-1*groundHog_W) {
      groundHogX=width-1*groundHog_W;
    }
    if (groundHogX<=0) {
      groundHogX=0;
    }

    if (groundHogY>=translateY*-1+5*measure) {
      groundHogY=translateY*-1+5*measure;
    }

    popMatrix();  //////////////////////////end of the translate


    // Health UI
    float lifeX = 10; 
    float lifeY = 10;
    float lifeSpacing = 70;

    for (int j=0; j<playerHealth; j++) {
      lifeX = 10+j*lifeSpacing;
      image(life, lifeX, lifeY);
    }


    break;//gamestate


    // Game Lose
  case GAME_LOSE:
    image(gameOver, 0, 0);
    if (mouseX > BUTTON_LEFT  && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM) {

      image(restartHovered, 248, 360);
      if (mousePressed) {
        downPressed =false;
        leftPressed = false;
        rightPressed = false;



        break;
      }
    }
  }
  // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
  if (debugMode) {
    popMatrix();
  }
}





void keyPressed() {
  float ST =millis();
  // Add your moving input code here
  if (key == CODED) {
    switch (keyCode) {
    case DOWN:
      if (translateY>-20*measure) {
        if (ST - LT > 250 ) {
          downPressed = true;
          groundhogFrame = 0;
          groundhogLestY = translateY;
          LT = ST;
        }
      } else {
        downPressed = true;
        groundhogFrame = 0;
        groundhogLestY = groundHogY;
        LT = ST;
      }


      break;
    case LEFT:
      if (ST - LT > 250) {
        leftPressed = true;
        groundhogFrame = 0;
        groundHogLestX = groundHogX;
        LT = ST;
      }
      break;
    case RIGHT:
      if (ST - LT > 250) {
        rightPressed = true;
        groundhogFrame = 0;
        groundHogLestX = groundHogX;
        LT = ST;
      }
      break;
    }
  }
  // DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
  switch(key) {
  case 'w':
    debugMode = true;
    cameraOffsetY += 25;
    break;

  case 's':
    debugMode = true;
    cameraOffsetY -= 100;
    break;

  case 'a':
    if (playerHealth > 0) playerHealth --;
    break;

  case 'd':
    if (playerHealth < 5) playerHealth ++;
    break;
  }
}

void keyReleased() {
}
