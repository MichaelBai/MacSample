
#include <iostream>
#include <string>
#include <algorithm>

using namespace std;

#define MAX_LENGTH 7

int LCS(string str1, string str2)
{
    int matrix[MAX_LENGTH +1][MAX_LENGTH + 1];
    for (int i = 0; i <= str1.size(); i++)
        matrix[i][0] = 0;
    
    for (int j = 0; j <= str2.size(); j++)
        matrix[0][j] = 0;
    
    for (int i = 1; i <= str1.size(); i++)
    {
        for (int j = 1; j <= str2.size(); j++)
        {
            if (str1[i - 1] == str2[j - 1])
            {
                matrix[i][j] = matrix[i - 1][j - 1] + 1;
            }
            else
            {
                if (matrix[i - 1][j] >= matrix[i][j - 1])
                    matrix[i][j] = matrix[i - 1][j];
                else
                    matrix[i][j] = matrix[i][j - 1];
            }
        }
    }
    return matrix[str1.size()][str2.size()];
}

int main(int argc, const char * argv[])
{
    string origin;
    char newStr[8];
    cin >> origin;
    
    int newStrLen = 0;
    int asNum = 0;
    for (int i = 0; i < origin.size(); i++) {
        if (origin[i] != '*') {
            newStr[newStrLen++] = origin[i];
        } else {
            asNum++;
        }
    }
    sort(newStr, newStr + newStrLen);
    string newStdStr(newStr);
    
    string alphabet;
    while (cin >> alphabet) {
        int lcs = LCS(newStdStr, alphabet);
        if (lcs + asNum >= alphabet.size()) {
            cout << alphabet << endl;
        }
    }
    return 0;
}

