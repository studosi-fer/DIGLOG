#include <stdio.h>
#include <algorithm>
#include <vector>
#include <string>
using namespace std;

int bt[] = {2,1,0,3}; 
/*
Kako unijeti brojeve u ovaj niz (bt):
Kodne rijeci promatras kao da su u binarnom zapisu i tim redoslijedom uneses.
Primjer:
Za zadane ovakve podatke
N=15
Znamenka/ Kodna rijec
0/ 10
1/ 11
2/ 01
3/ 00
U niz unesete {2,3,1,0}
Zato sto prva kodna rijec 10 gledana u bin zapisu je 2,druga 11 je 3...

Jos malo primjera:
N=12 {2,1,0,3}
N=6 {1,2,0,3}
*/

vector <int> r0_min, r1_min, cout_min, z0_min, z1_min;

string tobin(int b){
    char tmp[3]="  ";
    tmp[1]=(b&1)?'1':'0';
    tmp[0]=(b&2)?'1':'0';
    return tmp;
}

void zbroji(int a, int b, int cin){
    int r=a+b+cin;
    int cout = r >> 2; r&=3;

    int mint=(((bt[a]<<2)|bt[b])<<1)|cin;
    if (bt[r]&1) r0_min.push_back(mint);
    if (bt[r]&2) r1_min.push_back(mint);
    if (cout) cout_min.push_back(mint);
    printf("%-4s %-4s %-3d %-4d %-4s \n", tobin(bt[a]).c_str(), tobin(bt[b]).c_str(), cin, cout, tobin(bt[r]).c_str());
    sort(r0_min.begin(), r0_min.end());
    sort(r1_min.begin(), r1_min.end());
    sort(cout_min.begin(), cout_min.end());
}

void mux(int a, int b, int s){

    int r= s ? b: a;
    int mint = (a << 3) | (b << 1) | s;
    printf("%-4s %-4s %-4d %s     %d\n", tobin(a).c_str(), tobin(b).c_str(), s, tobin(r).c_str(), mint);
    if (r&1) z0_min.push_back(mint);
    if (r&2) z1_min.push_back(mint);
    sort(z0_min.begin(), z0_min.end());
    sort(z1_min.begin(), z1_min.end());
}
void FA_tablica(){
    printf("a1a0 b1b0 Cin Cout r1r0\n");
    printf("---------------------------\n");

    for(int a=0; a<4; ++a)
        for(int b=0; b<4; ++b){
            zbroji(a,b,0);
            zbroji(a,b,1);
        }

    printf("Mintermi za r0: ");
    for (int i=0; i<r0_min.size(); ++i){
        printf("%d, ", r0_min[i]);
    }
    printf("\n");

    printf("Mintermi za r1: ");
    for (int i=0; i<r1_min.size(); ++i){
        printf("%d, ", r1_min[i]);
    }
    printf("\n");

    printf("Mintermi za Cout: ");
    for (int i=0; i<cout_min.size(); ++i){
        printf("%d, ", cout_min[i]);
    }
    printf("\n");
}

void komplement_tablica() {
    printf("x1x0  y1y0\n");
    printf("----------\n");
    for (int a=0; a<4; ++a){
        int r=3-a;
        printf("%s    %s\n", tobin(bt[a]).c_str(), tobin(bt[r]).c_str());
    }
}

void mux_tablica(){
    printf("x1x0 y1y0  s  z1z0\n");
    printf("------------------\n");

  for(int a=0; a<4; ++a)
        for (int b=0; b<4; ++b){
            mux(a,b,0);
            mux(a,b,1);
        }

    printf("\nMintermi za z1: ");
    for (int i=0; i<z1_min.size(); ++i){
        printf("%d, ", z1_min[i]);
    }
    printf("\n");

    printf("Mintermi za z0: ");
    for (int i=0; i<z0_min.size(); ++i){
        printf("%d, ", z0_min[i]);
    }
    printf("\n");
}
int main(){
    FA_tablica();
    //komplement_tablica();
    //mux_tablica();
    system("PAUSE");
    return 0;
}