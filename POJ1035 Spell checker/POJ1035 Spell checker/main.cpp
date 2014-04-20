//
//  main.cpp
//  POJ1035 Spell checker
//
//  Created by Michael on 4/20/14.
//  Copyright (c) 2014 MichaelBai. All rights reserved.
//

#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <cstring>
#include <cstdio>

using namespace std;

#define MAX_LENGTH 15
#define MAX_DATA 10000

int lcs[MAX_LENGTH+1][MAX_LENGTH+1];

int LCS(char* a, char* b)
{
    memset(lcs, 0, sizeof(lcs));
    for (int i = 1; i <= strlen(a); i++) {
        for (int j = 1; j <= strlen(b); j++) {
            if (a[i-1] == b[j-1]) {
                lcs[i][j] = lcs[i-1][j-1] + 1;
            } else {
                lcs[i][j] = max(lcs[i-1][j], lcs[i][j-1]);
            }
        }
    }
    return lcs[strlen(a)][strlen(b)];
}

bool isOnlyOneDiff(char* a, char* b)
{
    int diffNum = 0;
    for (int i = 0; i < strlen(a); i++) {
        if (a[i] != b[i]) {
            diffNum++;
        }
    }
    return (diffNum == 1);
}

char dic[10001][16];

int main(int argc, const char * argv[])
{
    
    int dicSize = 0;
    memset(dic, 0, sizeof(dic));
    while (scanf("%s", dic[dicSize]) && dic[dicSize++][0] != '#');
    dicSize--;
    
    char ins[16];
    while (scanf("%s", ins) && ins[0] != '#') {
        bool correct = false;
        for (int i = 0; i < dicSize; i++) {
            if (strcmp(dic[i], ins) == 0) {
                correct = true;
                break;
            }
        }
        if (correct) {
            cout << ins << " is correct" << endl;
        }
        else
        {
            cout << ins << ":";
            for (int i = 0; i < dicSize; i++) {
                if (abs((int)(strlen(ins) - strlen(dic[i]))) <= 1) {
                    int l = LCS(dic[i], ins);
                    if (strlen(dic[i]) == l ||
                        ((strlen(dic[i]) == strlen(ins)) && isOnlyOneDiff(dic[i], ins)) ||
                        strlen(ins) == l) {
                        cout << " " << dic[i];
                    }
                }
            }
            cout << endl;
        }
    }
    
    return 0;
}

