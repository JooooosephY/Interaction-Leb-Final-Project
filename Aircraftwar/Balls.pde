class Balls {
  float x_pos;
  float y_pos;
  float vy = 10;
  PImage bullet;
  Balls (int n,int m,int p,float x,float y){
	x_pos = (x-50*width/height) + ((m+1)*100*width/height)/(n+1);
    y_pos = y;
	switch (n){
		case 1:
			switch(p){
			case 1:
			bullet = loadImage("bullet1.png");
			break;
			case 2:
			bullet = loadImage("bullet3.png");
			break;
			}
			break;
		case 2:
			switch(p){
			case 1:
			bullet = loadImage("bullet2.png");
			break;
			case 2:
			bullet = loadImage("bullet4.png");
			break;
			}
			break;
		case 3:
			switch(p){
			case 1:
			bullet = loadImage("bullet2.png");
			break;
			case 2:
			bullet = loadImage("bullet4.png");
			break;
			};			
		default:
			bullet = loadImage("bullet4.png");
			break;			
	}
  }
  void update(){
    //fill(255);
    //ellipse(x_pos,y_pos,8*width/1000,8*width/1000);	
	image(bullet,x_pos,y_pos,25*width/1000,25*width/1000);
    y_pos -= vy * 0.9;
  }
}
        
