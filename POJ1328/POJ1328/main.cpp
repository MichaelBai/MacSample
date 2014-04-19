
#include <iostream>
#include <algorithm>
#include <math.h>

using namespace std;

typedef struct {
    int x;
    int y;
}point;

int cmp(point a, point b)
{
    return a.x < b.x;
}

int main(int argc, const char * argv[])
{
    int N, distance;
    char endline[1];
    int count = 0;
    while (cin >> N >> distance) {
        if (N==0 && distance==0) {
            break;
        }
        count++;
        int radars = 0;
        point* points = new point[N];
        for (int i = 0 ; i < N; i++) {
            cin >> points[i].x >> points[i].y;
        }
        cin.getline(endline, 1);
        cin.getline(endline, 1);
        sort(points, points+N, cmp);
        float minCenterX=0.0, maxCenterX=0.0;
        float tmpMin = 0.0, tmpMax = 0.0;
        for (int i=0; i<N; i++) {
            if (points[i].y > distance) {
                radars = -1;
                break;
            }
            float tmpSide = sqrt(distance*distance - points[i].y*points[i].y);
            tmpMin = points[i].x - tmpSide;
            tmpMax = points[i].x + tmpSide;
            
            if (i == 0) {
                radars++;
                minCenterX = tmpMin;
                maxCenterX = tmpMax;
                continue;
            }
            
            if (tmpMin > maxCenterX) {
                radars++;
                minCenterX = tmpMin;
                maxCenterX = tmpMax;
            } else {
                float fArr[4] = {minCenterX, maxCenterX, tmpMin, tmpMax};
                sort(fArr, fArr + 4);
                minCenterX = fArr[1];
                maxCenterX = fArr[2];
            }
        }
        cout << "Case " << count << ": " << radars << endl;
    }
    
    return 0;
}

