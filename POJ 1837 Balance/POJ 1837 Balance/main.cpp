//
//  main.cpp
//  POJ 1837 Balance
//
//  Created by Michael on 4/20/14.
//  Copyright (c) 2014 MichaelBai. All rights reserved.
//

#include <iostream>
#include <cstring>

#define MAX_HOOK_LENGTH 15
#define MAX_WEIGHTS_WEIGHT 25
#define MAX_WEIGETS_NUM 20

using namespace std;

int main(int argc, const char * argv[])
{
    int C, G;
    cin >> C >> G;
    int* c = new int[C]; // positions relative to the center of the balance on the X axis
    int* g = new int[G]; // representing the weights' values
    
    for (int i = 0; i < C; i++) {
        cin >> c[i];
    }
    
    for (int i = 0; i < G; i++) {
        cin >> g[i];
    }

    // note: it exceed max offset in reality
    int arrOffset = MAX_HOOK_LENGTH * MAX_WEIGHTS_WEIGHT * (MAX_WEIGETS_NUM / 2);
    int opt[G+1][arrOffset*2+1];
    memset(opt, 0, sizeof(opt));
    // opt[i+1][k+c[j]*g[i]] += opt[i][k], i=[0,G), j=[0,C), k=[0,7500]
    // opt[i][k] means: By adding first i weights, the possibility of k difference Moment
    for (int i = 0; i < C; i++) {
        opt[1][ c[i]*g[0] + arrOffset ]++;
    }
    for (int i = 1; i < G; i++) {
        for (int j = 0; j < C; j++) {
            for (int k = 0; k <= arrOffset*2; k++) {
                if (opt[i][k]) {
                    opt[i+1][k+c[j]*g[i]] += opt[i][k];
                }
            }
        }
    }
    cout << opt[G][arrOffset] << endl;
    delete c;
    delete g;
    return 0;
}

