#include <iostream>
#include <cstdlib>
#include "zlib.h"
#include <stdio.h>
using namespace std;

int main()
{
    cout << "Hello, world!" << endl;
    printf("zlib version %s = 0x%04x, compile flags = 0x%lx\n",
            ZLIB_VERSION, ZLIB_VERNUM, zlibCompileFlags());
    printf("%s\n", zlibVersion());
    return 0;
}
