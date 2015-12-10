#include <iostream>
#include <cstdlib>
#include "zlib.h"
#include <stdio.h>
#include <curl/curl.h>
using namespace std;

int main()
{
    cout << "Hello, world!" << endl;
    printf("zlib version %s = 0x%04x, compile flags = 0x%lx\n",
            ZLIB_VERSION, ZLIB_VERNUM, zlibCompileFlags());
    printf("%s\n", zlibVersion());
    
    curl_global_init(CURL_GLOBAL_ALL);
    
    return 0;
}
