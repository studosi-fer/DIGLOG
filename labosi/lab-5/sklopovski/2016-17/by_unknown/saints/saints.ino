// Memory-mapped registri lijevog i desnog modula tonegen
volatile char *tl = (void *) 0xc0000000;
volatile char *tr = (void *) 0xc0000002;
volatile char *led = (void *) 0xffffff10;

// MIDI kodovi
#define F0  53
#define G0  55
#define A0  57
#define B0  58
#define C   60
#define D   62
#define E   64
#define F   65
#define G   67
#define A   69
#define B   70
#define P   0   // pauza, nema tona

static void play(int l, int r, int t) {
  *tl = l;
  *tr = r;
  *led = (l << 4) | (r & 0xf);
  printf("%d %d\n", l, r); // Tools -> Serial Monitor ili Plotter @ 115200
  delay(450 * t);
}

// the setup function runs once when you press reset or power the board
void setup() {
}

// the loop function runs over and over again forever
void loop() {
  int i;
  
  //oh when the saints
  for (i = 0; i < 3; i++) {
      play(P, C, 1);
      play(P, E, 1);
      play(P, F, 1);
      if ( i==2 ) break;
      play(C, G, 4);
  }
      play(C, G, 2);
      
      play(C, E, 1);
      play(C, C, 1);
      play(C, E, 1);
      play(G0, D, 3);
    
    play(G0, E, 2);
    play(G0, D, 1);
    play(E, C, 3);
    play(C, E, 1);
    play(C, G, 2);
    play(F0, F, 2);

    play(F0, F, 1);
    play(F0, E, 1);
    play(F0, F, 1);
    play(C, G, 2);
    play(C, E, 2);
    play(G0, C, 2);
    play(G0, D, 2);
    play(C, C, 6);  

  //bilo bi ljepse da imam vise vremena, poy
  //linkme620
}
