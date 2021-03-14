#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int  bit[8] = {1, 2, 4, 8, 16, 64, 128};
char let[8] = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'};

int n;
int k;

class minterm{
    public:
        char rep[8];
        vector<int> m;
        int i;
        int n;
        minterm(){
            for(int ii = 0; ii < 8; ++ii){
                rep[ii]= 2;
            }
            i = 1;
            n = 0;
        }
};
        
minterm set_minterm(int x, int sz){
    minterm tmp;
    tmp.m.push_back(x);
    for(int i = 0; i < sz; ++i){
        if(x & bit[i]){
            tmp.rep[i] = 1;
        }
        else{
            tmp.rep[i] = 0;
        }
    }
    return tmp;
}

int can_combine(minterm a, minterm b){
    if(a.m.size() != b.m.size()){
        //cout<<" rez1 ";
        return -1;
    }
    int sz = a.m.size();
    for(int i = 0; i < sz; ++i){
        if(a.m[i] == b.m[i]){
            //cout<<" rez2 ";
            return -1;
        }
    }
    
    int cnt = 0;
    int dif_pos = 0;
    
    for(int i = 0;i < 8; ++i){
        if(a.rep[i] != b.rep[i]){
            ++cnt;
            dif_pos = i;
        }
    }
    if(cnt == 1){
        return dif_pos;
    }
    else{
        //cout<<" rez3 ("<<cnt<<") ";
        return -1;
    }
    
    return -1;   
}

minterm combine(minterm a, minterm b, int dif_pos){
    minterm tmp = a;
    for(int i = 0; i < b.m.size(); ++i){
        tmp.m.push_back(b.m[i]);
    }
    sort(tmp.m.begin(), tmp.m.end());
    tmp.rep[dif_pos] = 2;
    tmp.i = 1;
    return tmp;
}

int is_equal(minterm a, minterm b){
    if(a.m.size() != b.m.size()){
        return 0;
    }
    
    for(int i = 0; i < a.m.size(); ++i){
        if(a.m[i] != b.m[i]){
            return 0;
        }
    }
    return 1;
}

vector<minterm> v;
vector<int>     inp;

int main(void){
    cin>>n;
    cin>>k;
    int p1 = 0;
    int p2 = k;
    for(int i = 0; i < k; ++i){
        minterm tmp;
        int tmp_m;
        cin>>tmp_m;
        tmp = set_minterm(tmp_m, n);
        v.push_back(tmp);
        inp.push_back(tmp_m);
    }
    int num_loops = 0;
    int cnt = 0;
    while(p1 != p2){
        cnt = 0;
        for(int i = p1; i < p2; ++i){
            for(int j = i+1; j < p2; ++j){
                //cout<<"--> "<<i<<", "<<j;
                int tmp = can_combine(v[i], v[j]);
                minterm tmp_m;
                if(tmp != -1){
                    tmp_m = combine(v[i], v[j], tmp);
                    int i_haz = 0;
                    for(int l = p2; l < p2 + cnt; ++l){
                        if(is_equal(tmp_m, v[l])){
                            v[i].i = 0;
                            v[j].i = 0;
                            ++i_haz;
                        }
                    }
                    if(!i_haz){
                        cout<<" ( ";
                        for(int l = 0; l < v[i].m.size(); ++l){
                            cout<<v[i].m[l]<<" ";
                        }
                        cout<<" ) - ( ";
                        for(int l = 0; l < v[i].m.size(); ++l){
                            cout<<v[j].m[l]<<" ";
                        }
                        cout<<" ) = ( ";
                        for(int l = 0; l < tmp_m.m.size(); ++l){
                            cout<<tmp_m.m[l]<<" ";
                        }
                        cout<<" ) "<<endl;
                        v.push_back(tmp_m);
                        v[i].i = 0;
                        v[j].i = 0;
                        ++cnt;
                    }
                }
            }
        }
        p1 = p2;
        p2 += cnt;
        cout<<num_loops<<endl;
        ++num_loops;
        
    }
    cout<<"-+-+-+-+-+-+-+-+- "<<endl;
    
    for(int l = 0; l < inp.size(); ++l){
        int cnt = 0;
        int pos = 0;
        for(int i = 0; i < p2; ++i){
            for(int j = 0; j < v[i].m.size(); ++j){
                if((v[i].m[j] == inp[l]) && (v[i].i)){
                    ++cnt;
                    pos = i;
                }
            }
        }
        if(cnt == 1){
            v[pos].n = 1;
        }
    }
    
    for(int i = 0; i < p2; ++i){
        if(v[i].i){
            int cnt = 0;
            for(int j = 0; j < n; ++j){
                if(v[i].rep[n-j-1] != 2){
                    if(cnt){
                        cout<<"and ";
                    }
                    ++cnt;
                    if(v[i].rep[n-j-1] == 1){
                        cout<<let[j]<<" ";
                    }
                    else{
                        cout<<"not "<<let[j]<<" ";
                    }
                }
            }
            cout<<" || ";
            for(int j = 0; j < v[i].m.size(); ++j){
                cout<<v[i].m[j]<<" ";
            }
            if(v[i].n){
                cout<<" || bitan ";
            }
            cout<<endl;
        }
    }
    
    
    system("pause");
}
