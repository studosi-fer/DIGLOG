#include <iostream>
using namespace std;

int c[4] = {0,1,2,3};
char mat[32][8] = {0};
int bits[5] = {1, 2, 4, 8, 16};

int val(int a, int b){
    return a * 2 + b;
}

int bit(int x, int i){
    return (x&(bits[i]))/bits[i];
}

int r_val(int x){
    for(int i = 0; i < 4; ++i){
        if(c[i] == x){
            return i;
        }
    }
    return 0;
}

int main(void){
    
    cout<<"unesite kodove za tablicu, sve odvajajte razmakom "<<endl<<"unos je oblika '1 0' ili '1 1'"<<endl;
    char s[2];
    for(int i = 0; i < 4; ++i){
        cout<<"unesite kodnu rijec za znamenku "<<i<<" : ";
        cin>>s[1]>>s[0];
        c[i] = (s[1]-'0') * 2 + (s[0]-'0');
    }
    
    for(int i = 0; i < 32; ++i){
        for(int j = 0; j < 5; ++j){
            mat[i][j] = bit(i, 4-j);
        }
    }
    
    
    for(int i = 0; i < 32; ++i){
        int tmp1 = val(mat[i][0], mat[i][1]);
        int tmp2 = val(mat[i][2], mat[i][3]);
        int v1 = r_val(tmp1);
        int v2 = r_val(tmp2);
        int v3 = v1 + v2 + mat[i][4];
        if(v3 > 3){
            mat[i][7] = 1;
            v3 -= 4;
        }
        mat[i][5] = bit(c[v3], 1);
        mat[i][6] = bit(c[v3], 0);
    }
    
    cout<<endl<<endl;
    
    cout<<"u zagradama se nalaze pravje vrijednosti (to je samo za provjeru i da znate o cem se radi)"<<endl;
    cout<<"iza okomite crte se nalaze vrijednosti tablice... tocke i vodoravne crte su tu samo da vam pomognu"<<endl;
    cout<<"vrijednosti u tablici redom (iza okomite crte): a1a0.b1b0 . cin .. r1r0 . cout"<<endl<<endl;
    
    cout<<"                          a1a0.b1b0 .cin.. r1r0. cout"<<endl<<endl;
    
    for(int i = 0; i < 32; ++i){
        cout<<" ( "<<r_val(val(mat[i][0], mat[i][1]))<<" , "<<r_val(val(mat[i][2], mat[i][3]))<<" , "<<(int)mat[i][4]<<" | ";
        cout<<r_val(val(mat[i][5],mat[i][6]))<<" , "<<(int)mat[i][7]<<" ) || ";
        
        cout<<(int)mat[i][0]<<" "<<(int)mat[i][1]<<" . "<<(int)mat[i][2]<<" "<<(int)mat[i][3]<<" . "<<(int)mat[i][4]<<" .. ";
        cout<<(int)mat[i][5]<<" "<<(int)mat[i][6]<<" . "<<(int)mat[i][7]<<endl;
        
        if(i % 8 == 7){
            cout<<"--------------------------------------------------"<<endl;
        }
        
        /*for(int j = 0; j < 8; ++j){
            cout<<(int)mat[i][j];
        }
        cout<<endl;*/
    }
    
    system("pause");
    return 0;   
}
