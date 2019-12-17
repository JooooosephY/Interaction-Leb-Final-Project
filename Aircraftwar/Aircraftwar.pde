import ddf.minim.*;
import processing.serial.*;
import java.util.*;
import java.text.*;
import java.io.*;

int count = 0;
int score = 0;
int weapon = 10;
int hp = 100;
int ca = 0;
int rem;
int timer;
int valuefromA;
int valuefromB;
int player;
int num_balls = 1;
int display_score = 0;
int tint_fc = 0;
int best;
int best1;
float apx = 500;
float apy = 900;
float apx_1 = 500;
float apy_1 = 880;
float pa = 0;
float pb = 0;
Minim minim;
AudioPlayer bgm;
AudioSample shoot,hit,over;
BufferedReader reader = null;
BufferedReader reader1 = null;
PrintWriter fw;
PrintWriter fw1;
String line = null;
String line1 = null;
PImage bgp;
PImage aircraft1;
PImage aircraft2;
Serial port0;
Serial port1;
boolean portStatus = false;
boolean goin_b1 = true;
boolean goin_b2 = true;
ArrayList<Balls> ball_lst = new ArrayList<Balls>();
ArrayList<Bricks> brick_lst = new ArrayList<Bricks>();
SimpleDateFormat ft = new SimpleDateFormat ("ss");
void setup(){
  fullScreen();
  smooth();
  aircraft1 = loadImage("aircraft2.png");
  reader = createReader("leaderboard0.txt");
  reader1 = createReader("leaderboard1.txt");
try {
    while ((line = reader.readLine()) != null) {
      best = Integer.parseInt(line);
    }
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  } 
try {
    while ((line1 = reader1.readLine()) != null) {
      best1 = Integer.parseInt(line1);
    }
    reader1.close();
  } catch (IOException e) {
    e.printStackTrace();
  }   
  fw = createWriter("leaderboard0.txt");
  fw1 = createWriter("leaderboard1.txt");
  bgp = loadImage("3.png");
  bgp.resize(width,height);
  ball_lst = new ArrayList<Balls>();
  brick_lst = new ArrayList<Bricks>();
  if (Serial.list().length>0){
    portStatus = true;
    port0 = new Serial(this, "COM7", 9600);
	port1 = new Serial(this, "COM12", 9600);
    pa = port0.read();
	pb = port1.read();
	
  }
  minim = new Minim(this);
    shoot = minim.loadSample("shoot.mp3");
    hit = minim.loadSample("boom.mp3");
    bgm = minim.loadFile("funky.mp3");
    over = minim.loadSample("over.mp3");
  frameRate(60);
  //size(2000,2000);
  background(bgp); 
  bgm.loop();
  //ball_lst.add(new Balls(10200,10200,0,0));
  //brick_lst.add(new Bricks());
}
void draw(){
  switch(ca){
    case 0:
	float sizey0 = (height/3)+height/5;
    float sizey1 = (height/3)+1.8*height/5;
    float sizey2 = (height/3)+2.5*height/5;
	  background(bgp);
      fill(255);
      while (portStatus && port0.available() > 0) {
        valuefromA = port0.read();
        float dif = pa - valuefromA;
        if (abs(dif)>8){
          apx = map(valuefromA,0,200,0,height);
          pa = valuefromA;
        }		
      }
      textSize(int(width/10));
      textAlign(CENTER,CENTER);
      text("Strike!",width/2,height/3);
      textSize(width/33);
      text("*Use Your RIGHT Hand to Move The Cursor",width/2,2.5*height/3);      
      textSize(width/25);
      text("-Start-",width/2,sizey0);
      text("-Exit-",width/2,sizey1);
	  if (portStatus){
		  PImage cursor;
		  cursor = loadImage("cursor.png");
		  imageMode(CENTER);
		  image(cursor,2*width/3,apx);
	  }
	  else{
		  apx = mouseY;
	  }
	  if (sizey0-width/20 <apx && apx< sizey0 + width/20){
		  if (goin_b1){
			  timer = second();
		  }
		  goin_b1 = false;
		  fill(0,90);
		  rectMode(CENTER);
		  rect(width/2,sizey0,width*7/8,width/10);
		  rem = second() - timer;
		  if (rem < 4){
			  fill(255);
			  arc(2*width/3, apx, 80, 80, 0, PI*2*(rem+1)/3, PIE);
		  }
		  else{
			  apx = 100;
			  apy = 900;
			  ca = 3;
			  goin_b1 = true;
		  }
	  }
	  else{
		  goin_b1 = true;
	  }
	  
	  if (sizey1-width/20 <apx && apx< sizey1 + width/20){
		  if (goin_b2){
			  timer = second();
		  }
		  goin_b2 = false;
		  fill(255,0,0,70);
		  rectMode(CENTER);
		  rect(width/2,sizey1,width*7/8,width/10);
		  rem = second() - timer;
		  if (rem < 3){
			  fill(255);
			  arc(2*width/3, apx, 80, 80, 0, PI*2*(rem+1)/3, PIE);
		  }
		  else{
			exit();
		  }
	  }
	  else{
		  goin_b2 = true;
	  }
      //noLoop(); 
      break;
    case 1:
    
	  //int x = frameCount % height;
	  //for (int i = x ; i > 0 ; i -= height) {
	  //	copy(bgp, 0, 0, width, height, 0, i, width, height);
	  //}

	  //}

	  fill(255);
      Date dNow = new Date();
	  switch (player){
		  case 1:
      fw = createWriter("leaderboard0.txt");
      while (portStatus && port0.available() > 0) {
        valuefromA = port0.read();
        float dif = pa - valuefromA;
        if (abs(dif)>8){
      if (dif>20){
        apx += 5;
      }
      else if (dif<-20){
        apx -= 5;
      }
      else{
      apx = map(valuefromA,0,220,0,1100);
      }
      pa = valuefromA;
        }
      }

		  break;
		  
		  case 2:
      fw1 = createWriter("leaderboard1.txt");
      while (portStatus && port0.available() > 0) {
        valuefromA = port0.read();
        float dif = pa - valuefromA;
        if (abs(dif)>8){
      if (dif>20){
        apx += 5;
      }
      else if (dif<-20){
        apx -= 5;
      }
      else{
      apx = map(valuefromA,0,220,0,1100);
      }
      pa = valuefromA;
        }
      }
	    while (portStatus && port1.available() > 0) {
        valuefromB = port1.read();
        float dif1 = pb - valuefromB;
        if (abs(dif1)>8){
      if (dif1>20){
        apy += 5;
      }
      else if (dif1<-20){
        apy -= 5;
      }
      else{
      apy = map(valuefromB,0,180,0,950);
      }
      pb = valuefromB;
        }
      }
      break;
}
      if (frameCount-tint_fc>20){
      noTint();
      }
      num_balls = int(floor(score/10)) + 1;
      background(bgp);
      textSize(width/33);
      textAlign(CENTER);
      text("Score: " + display_score,900*width/1000,50*height/1000);
      //text("Weapon: "+ weapon,890*width/1000,950*height/1000);
      text("HP: "+hp,120*width/1000,950*height/1000);
      //tint(255,126);
      imageMode(CENTER);
      image(aircraft1,apx*width/1000,apy*height/1000,100*width/height,100*width/height);
      if (frameCount%30 == 0){
        for (int current_num = 0; current_num<num_balls; current_num++){
        Balls b = new Balls(num_balls,current_num,1,apx*width/1000,(apy-40)*height/1000);
        ball_lst.add(b);
        shoot.trigger();
        }
      }

      for (int i=0; i<brick_lst.size(); i++){
        Bricks temp = brick_lst.get(i);
        temp.exp_update();
        if (temp.y_pos>height){
          brick_lst.remove(i);
          if (temp.mode == 0){
          hp -= 5;
          }
		  tint_fc = frameCount;
		  tint(255,0,0);
        }
      }
      for (int i=0; i<ball_lst.size(); i++) {
        Balls temp = ball_lst.get(i);
        temp.update();
        if (temp.x_pos <0 || temp.x_pos>width || temp.y_pos<0 || temp.y_pos>height){
            ball_lst.remove(i);
            continue;
          }        
        for (int j = 0; j<brick_lst.size(); j++){
          Bricks temp1 = brick_lst.get(j);
		  if (temp1.acDetect(apx*width/1000,apy*height/1000)){
			  brick_lst.remove(j);
			  hp -= 10;
			  tint(255,0,0);
			  tint_fc = frameCount;
			  //tint(255,0,0,70);
		  }
          if (temp1.collisionDetect(temp.x_pos,temp.y_pos)){
			temp1.hp -= 1;
            ball_lst.remove(i);
			if (temp1.hp == 0){
				score += 1;
				display_score += temp1.prize;
				brick_lst.remove(j);
				//weapon += 2;
			}
            hit.trigger();
            continue;
          }
        }
      }
      if (int(ft.format(dNow)) % 3  != 0){
        count = 0;
      }
      if (int(ft.format(dNow)) % 3  == 0 && count == 0){
        Bricks temp = new Bricks(0);
        brick_lst.add(temp);
        if (int(ft.format(dNow)) % 3  == 0){
            count = 1;
        }
      }
	  if (score > 3 && score % 10 < 2){
		  if (frameCount%20 == 0){
			Bricks temp0 = new Bricks(1);
			Bricks temp1 = new Bricks(2);
			brick_lst.add(temp0);
			brick_lst.add(temp1);
		  }
	  } 
	  // 对应Bricks的case 3 & 4
	  if (score > 20 && score % 20 < 2){
		  if (frameCount%45 == 0){
			Bricks temp3 = new Bricks(3);
			Bricks temp4 = new Bricks(4);
			brick_lst.add(temp3);
			brick_lst.add(temp4);
		  }
	  } 
      if (hp<=0){
        ca = 2;
        over.trigger();
      }
      break;
    case 2:
        sizey0 = (height/3)+height/5;
        sizey1 = (height/3)+1.8*height/5;
        sizey2 = (height/3)+2.5*height/5;
        background(bgp);
		bgm.close();
        //over.trigger();
        textSize(int(width/10));
        textAlign(CENTER,CENTER);
        fill(255,0,0);
        text("You Died",width/2,height/4);
        textSize(width/25);
        fill(255);
        switch(player){
          case 1:
          text("Best: "+ best, width/2,sizey0);
        if (best<display_score){
            best = display_score;
            fw.println(String.valueOf(best));
            fw.flush();
            fw.close();
        }
        else{
            fw.println(String.valueOf(best));
            fw.flush();
            fw.close();
        }
        break;
        case 2:
        text("Best: "+ best1, width/2,sizey0);
        if (best1<display_score){
            best1 = display_score;
            fw1.println(String.valueOf(best1));
            fw1.flush();
            fw1.close();
        }
        else{
            fw1.println(String.valueOf(best1));
            fw1.flush();
            fw1.close();
        }
        }
        text("Score: " + display_score,width/2,sizey0-height/7);
        text("-Restart-",width/2,sizey1);
        text("-Exit-",width/2,sizey2);
        //over.trigger()
        //noLoop();
        //rectMode(CENTER);
        //fill(255,0,0);
        //rect(500*1000/width,600*1000/width,250*1000/width,80*1000/width);
        //rect(500*1000/width,740*1000/width,250*1000/width,80*1000/width);
        //textSize(30*width/1000);
        //fill(255);
        //text("Restart",500*width/1000,610*width/1000);
        //text("Exit",500*width/1000,750*width/1000);
      while (portStatus && port0.available() > 0) {
        valuefromA = port0.read();
        float dif = pa - valuefromA;
        if (abs(dif)>8){
      if (dif>20){
        apx += 5;
      }
      else if (dif<-20){
        apx -= 5;
      }
      else{
      apx = map(valuefromA,0,220,0,1100);
      }
      pa = valuefromA;
        }
      }
     if (portStatus){
      PImage cursor;
      cursor = loadImage("cursor.png");
      imageMode(CENTER);
      image(cursor,2*width/3,apx);
    }
    else{
      apx = mouseY;
    }
    if (sizey1-width/20 <apx && apx< sizey1 + width/20){
      if (goin_b1){
        timer = second();
      }
      goin_b1 = false;
      fill(0,90);
      rectMode(CENTER);
      rect(width/2,sizey1,width*7/8,width/10);
      rem = second() - timer;
      if (rem < 4){
        fill(255);
        arc(2*width/3, apx, 80, 80, 0, PI*2*(rem+1)/3, PIE);
      }
      else{
        apx = 100;
        ca = 3;
		initialize();
        goin_b1 = true;
      }
    }
    else{
      goin_b1 = true;
    }
    
    if (sizey2-width/20 <apx && apx< sizey2 + width/20){
      if (goin_b2){
        timer = second();
      }
      goin_b2 = false;
      fill(255,0,0,70);
      rectMode(CENTER);
      rect(width/2,sizey2,width*7/8,width/10);
      rem = second() - timer;
      if (rem < 3){
        fill(255);
        arc(2*width/3, apx, 80, 80, 0, PI*2*(rem+1)/3, PIE);
      }
      else{
      fw.close(); 
      fw1.close();
      exit();
      }
    }
    else{
      goin_b2 = true;
    }
      //noLoop(); 
		break;
	case 3:
	  sizey0 = (height/3)+height/5;
    sizey1 = (height/3)+1.8*height/5;
	  background(bgp);
      fill(255);
      while (portStatus && port0.available() > 0) {
        valuefromA = port0.read();
        float dif = valuefromA - pa;
        if (abs(dif)>8){
		  if (dif>30){
			  apx += 5;
		  }
		  else if (dif<-30){
			  apx -= 5;
		  }
		  else{
			apx = map(valuefromA,0,250,0,height);
		  }
		  pa = valuefromA;
        }
      }
      textSize(int(width/20));
      textAlign(CENTER,CENTER);
      text("Please Choose the Game Mode",width/2,height/3);
      textSize(width/33);
      text("*Use Your RIGHT Hand to Move The Cursor",width/2,2.5*height/3);      
      textSize(width/25);
      text("Easy - Horizontal Only",width/2,sizey0);
      text("Expert - Horizontal&Vertical",width/2,sizey1);
	  if (portStatus){
		  PImage cursor;
		  cursor = loadImage("cursor.png");
		  imageMode(CENTER);
		  image(cursor,2*width/3,apx);
	  }
	  else{
		  apx = mouseY;
	  }
	  if (sizey0-width/20 <apx && apx< sizey0 + width/20){
		  if (goin_b1){
			  timer = second();
		  }
		  goin_b1 = false;
		  fill(0,90);
		  rectMode(CENTER);
		  rect(width/2,sizey0,width*7/8,width/10);
		  rem = second() - timer;
		  if (rem < 4){
			  fill(255);
			  arc(2*width/3, apx, 80, 80, 0, PI*2*(rem+1)/3, PIE);
		  }
		  else{
			  player = 1;
			  ca = 1;
			  goin_b1 = true;
		  }
	  }
	  else{
		  goin_b1 = true;
 
	  }
	  
	  if (sizey1-width/20 <apx && apx< sizey1 + width/20){
		  if (goin_b2){
			  timer = second();
		  }
		  goin_b2 = false;
		  fill(255,0,0,70);
		  rectMode(CENTER);
		  rect(width/2,sizey1,width*7/8,width/10);
		  rem = second() - timer;
		  if (rem < 3){
			  fill(255);
			  arc(2*width/3, apx, 80, 80, 0, PI*2*(rem+1)/3, PIE);
		  }
		  else{
			player = 2;
			ca = 1;
			apx = 333;
			apx_1 = 666;
			goin_b2 = true;
		  }
	  }
	  else{
		  goin_b2 = true;
	  }
      //noLoop(); 
      break;
  }
}

void mousePressed(){
  switch(ca) {
    case 0:
    float sizey0 = (height/3)+height/5;
    float sizey1 = (height/3)+1.8*height/5;
    
    if (sizey0-width/20 <mouseY && mouseY< sizey0 + width/20){
      ca = 1;
      //loop();
    }
    else if (sizey1-width/25 <mouseY && mouseY< sizey1 + width/25){
      fw.close();
      fw1.close();
      exit();
    }
   case 2:
   if (250<mouseX && mouseX< 750 && 560<mouseY && mouseY<640){
     ca = 1;
     score = 0;  
     //weapon = 10;
     hp = 5;
     setup();
     loop();
   }  
     
    }
}
void keyPressed(){
    switch (ca){
      case 1:
		if (keyCode == LEFT){
            apx -= 10*width/1000;
            }
        else if (keyCode == RIGHT){
            apx += 10*width/1000;
            }
        else if (keyCode == UP){
            apy -= 10*height/1000;
            }
        else if (keyCode == DOWN){
            apy += 10*height/1000;
            }
		if (key == 'w'){
			apy_1 -= 10*height/1000;
		}
		else if (key == 's'){
			apy_1 += 10*height/1000;
		}
		else if (key == 'a'){
			apx_1 -= 10*width/1000;
		}
		else if (key == 'd'){
			apx_1 += 10*width/1000;
		}
	break;
    }
}

void initialize(){
background(bgp);
count = 0;
score = 0;
hp = 100;
ca = 0;
num_balls = 1;
display_score = 0;
apx = 500;
apy = 900;
apx_1 = width/3;
apy = 900;
pa = 0;
brick_lst = new ArrayList<Bricks>();
ball_lst = new ArrayList<Balls>();
delay(1000);
}
