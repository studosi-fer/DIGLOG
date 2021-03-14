// Memory-mapped registri lijevog i desnog modula tonegen
volatile char *tl = (char *) 0xffffff13;
volatile char *tr = (char *) 0xffffff12;
volatile char *led = (char *) 0xffffff10;
volatile char *reset = (char *) 0xffffff00;

// MIDI kodovi
#define MIDI_A0  57
#define MIDI_B0  58
#define MIDI_C   60
#define MIDI_D   62
#define MIDI_E   64
#define MIDI_F   65
#define MIDI_G   67
#define MIDI_A   69
#define MIDI_B   70
#define MIDI_P   0   // pauza, nema tona
#define MIDI_S 65 // podesiti negdje između 50 i 70


static void play(int l, int r, int t) {
  *tl = l;
  *tr = r;
  *led = (l << 4) | (r & 0xf);
  printf("%d %d\n", l, r); // Tools -> Serial Monitor ili Plotter @ 115200
  delay(450 * t);
}

static void play(int pus) {
    int i;
    for (i=0; i<pus; i++) {
        *tl = MIDI_S;
        *tr = MIDI_S;
        delay(200/pus); //sviraj ovaj zvuk ovisno u pus-u (puta u sekundi), dakle za pus = 1, zvuk svira 200ms te je onda 800ms tišine
        *tl = MIDI_P;
        *tr = MIDI_P;
        delay(800/pus);
      }
  }

  static void reset_loop(int *stanje) {
    *stanje = 0;
    do {
      if (*stanje == 0) {
        *stanje = 1;
        *led = 64; //ledice korespondiraju tezinama dakle 0 1 2 3 4 5 6 7 = 1 2 4 8 16 32 64 128; dakle ak zelimo da svijetle prva i druga moramo staviti broj 3
        delay(1000);
      } else if (*stanje == 1) {
        *stanje = 0;
        *led = 0;
        delay(1000);
      }
    } while (*reset == 4);
    *stanje = 1; //ide jedan jer kad se vratimo u program zelimo da nastavi normalno, odnosno da nakon stanje++ trenutno stanje bude s2, po uputama zadatka
}

// the setup function runs once when you press reset or power the board
void setup() {
}

// the loop function runs over and over again forever
void loop() {
  int stanje = 1; //pocetno stanje automata je 2, ali zbog pozicioniranja 'stanje++;' stavljam 1
  int timer = 0; //broj sekundi; u tablici T
  int i; // brojac
 
 
  do {
        if (stanje == 4) { //ako je zeleno za pjesaka sviraj ubrzano (4 puta u sekundi) timer sekundi
          for (i=0; i<timer; i++) {
            if (*reset == 4) {
              reset_loop(&stanje);
              break; //izadji iz petlje, te nastavi normalno
              }
            play(4);
          }
        } else for (i=0; i<timer; i++) {
          if (*reset == 4) {
              reset_loop(&stanje);
              break;
              }
          play(1); //inace sviraj jednom u sekundi zvucni signal
        }
        stanje++;
        if (stanje > 7) stanje = 2;
        if (stanje == 2) {
            timer = 4;
            *led = 72;
        } else if (stanje == 3) {
            timer = 3;
            *led = 136;
        } else if (stanje == 4) {
            timer = 3;
            *led = 132;
        } else if (stanje == 5) {
            timer = 4;
            *led = 136;
        } else if (stanje == 6) {
            timer = 3;
            *led = 200;
        } else if (stanje == 7) {
            timer = 13;
            *led = 40;
        }
    } while (1);
}
