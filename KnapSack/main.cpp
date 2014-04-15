//
//  main.cpp
//  KnapSack
//
//  Created by Michael on 4/15/14.
//  Copyright (c) 2014 MichaelBai. All rights reserved.
//

#include <iostream>
#include <algorithm>
#include <vector>
#include <cstring>
#include <math.h>

typedef struct item
{
    int weight;
    int values;
} item;

using namespace std;

vector<int> getLogParam(int x)
{
    vector<int> ret;
    int i = 0;
    while (x - pow(2, i) > 0) {
        ret.push_back(pow(2, i));
        x = x - pow(2, i);
        i++;
    }
    ret.push_back(x);
    return ret;
}

int main()
{
    int weight=10;
    int itemnum=4;
    int N;
    while (cin >> weight) {
        cin >> N;
        int* n = new int[N];
        int* D = new int[N];
        
        vector<item> items;
        for (int i = 0; i < N; i++) {
            cin >> n[i] >> D[i];
            if (n[i] == 0) {
                continue;
            }
            vector<int> vecLogParam = getLogParam(n[i]);
            for (int j = 0; j < vecLogParam.size(); j++) {
                items.push_back({vecLogParam[j]*D[i], vecLogParam[j]*D[i]});
            }
        }
        itemnum = (int)items.size();
        
        // ignore nul weight and nul item
        if (weight == 0 || itemnum == 0) {
            cout << 0 << endl;
            delete n;
            delete D;
            continue;
        }
        
        int* m = new int[weight+1];
        memset(m, 0, sizeof(int)*(weight+1));
        for (int i = 1; i <= itemnum; i++) {
            for (int w = weight; w > 0; w--) {
                if (w >= items[i-1].weight) {
                    m[w] = max(m[w], m[w-items[i-1].weight]+items[i-1].values);
                }
            }
        }
        cout << m[weight];
        cout << endl;
        delete n;
        delete D;
        delete m;
    }
    
    //    item items[4]={{6,30},{3,14},{4,16},{2,9}};
    //    int (*m)[11] = new int[5][11];
    //    memset(m, 0, (itemnum+1)*(weight+1));
    
    //    for (int i = 1; i <= itemnum; i++) {
    //        for (int w = 1; w <= weight; w++) {
    //            if (items[i-1].weight > w) {
    //                m[i][w] = m[i-1][w];
    //            }
    //            else
    //            {
    //                m[i][w] = max(m[i-1][w], m[i-1][w-items[i-1].weight] + items[i-1].values);
    //            }
    //        }
    //    }
    //
    //    for(int i=0;i<=itemnum;i++)
    //    {
    //        for(int j=0;j<=weight;j++)
    //        {
    //            cout<<m[i][j]<<" ";
    //        }
    //        cout<<"\n";
    //    }
    
    return 0;
}