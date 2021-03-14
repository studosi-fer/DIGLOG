// Memory-mapped registri lijevog i desnog modula tonegen
volatile char *tl = (void *) 0xc0000000;
volatile char *tr = (void *) 0xc0000002;
volatile char *led = (void *) 0xffffff10;

// MIDI kodovi

#define F0  53
#define G0  55
#define A0  57
#define H0  59
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
  delay( 200 * t);
}

// the setup function runs once when you press reset or power the board
void setup() {
}

// the loop function runs over and over again forever
void loop() {
  int i;
  
  play(P , E, 2);
  play(P, G, 1);
  
  play(F0 , A, 9);
  play(P ,A ,2 );
  play(P ,G ,1 );
  
  play(C ,E ,9 );
  play(P ,E ,2 );
  play(P ,G ,1 );

  play(F0 , A, 9);
  play(P ,A ,2 );
  play(P ,G ,1 );
  
  play(C ,E ,4 );
  play(C ,F ,1 );
  play(C, E, 1);
  play(G0, D, 4);
  play(G0, C, 1);
  play(G0, H0, 1);
  play(C, C, 6);


//linkme620, isprike zbog bijednog ritma

    
  
}
