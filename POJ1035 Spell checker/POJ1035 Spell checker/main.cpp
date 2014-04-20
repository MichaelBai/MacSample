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

using namespace std;

#define MAX_LENGTH 15
int lcs[MAX_LENGTH+1][MAX_LENGTH+1];

int LCS(string a, string b)
{
    memset(lcs, 0, sizeof(lcs));
    for (int i = 1; i <= a.size(); i++) {
        for (int j = 1; j <= b.size(); j++) {
            if (a[i-1] == b[j-1]) {
                lcs[i][j] = lcs[i-1][j-1] + 1;
            } else {
                lcs[i][j] = max(lcs[i-1][j], lcs[i][j-1]);
            }
        }
    }
    return lcs[a.size()][b.size()];
}

bool isConsist(const vector<string>& dic, string insStr)
{
    return (find(dic.begin(), dic.end(), insStr) != dic.end());
}

bool isOnlyOneDiff(string a, string b)
{
    int diffNum = 0;
    for (int i = 0; i < a.size(); i++) {
        if (a[i] != b[i]) {
            diffNum++;
        }
    }
    return (diffNum == 1);
}

bool isOperable(const vector<string>& dic, string insStr, vector<string>& operable)
{
    bool ret = false;
    for (int i = 0; i < dic.size(); i++) {
        if (abs((int)(insStr.size() - dic[i].size())) <= 1) {
            int l = LCS(dic[i], insStr);
            if (dic[i].size() == l ||
                ((dic[i].size() == insStr.size()) && isOnlyOneDiff(dic[i], insStr)) ||
                insStr.size() == l) {
                ret = true;
                operable.push_back(dic[i]);
            }
        }
    }
    return ret;
}

int main(int argc, const char * argv[])
{
    vector<string> dic, ins;
    string dicStr, insStr;
    while (cin >> dicStr) {
        if (dicStr != "#") {
            dic.push_back(dicStr);
        } else {
            break;
        }
    }
    while (cin >> insStr) {
        if (insStr != "#") {
            ins.push_back(insStr);
        } else {
            break;
        }
    }
    vector<string> operable;
    for (int i = 0; i < ins.size(); i++) {
        operable.clear();
        if (isConsist(dic, ins[i])) {
            cout << ins[i] << " is correct" << endl;
        } else if (isOperable(dic, ins[i], operable)) {
            cout << ins[i] << ":";
            for (int j = 0; j < operable.size(); j++) {
                cout << " " << operable[j];
            }
            cout << endl;
        } else {
            cout << ins[i] << ":" << endl;
        }
    }
    
    return 0;
}

