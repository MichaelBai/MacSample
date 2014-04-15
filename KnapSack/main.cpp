//
//  main.cpp
//  KnapSack
//
//  Created by Michael on 4/15/14.
//  Copyright (c) 2014 MichaelBai. All rights reserved.
//

#include <iostream>
#include <algorithm>

//存储元素的结构
typedef struct item
{
    int weight;
    int values;
} item;

using namespace std;
int main()
{
    int weight=10;
    int itemnum=4;
    
    item items[4]={{6,30},{3,14},{4,16},{2,9}};
    
    int* m = new int[weight+1];
    memset(m, 0, weight+1);
    for (int i = 1; i <= itemnum; i++) {
        for (int w = weight; w > 0; w--) {
            if (w >= items[i-1].weight) {
                m[w] = max(m[w], m[w-items[i-1].weight]+items[i-1].values);
            }
        }
    }
    for (int i = 0; i <= weight; i++) {
        cout << m[i] << " ";
    }
    cout<<endl;
    
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