#include <stdio.h>

void foo() { printf("In foo\n"); }

int main() {
    printf("Start\n");
    foo();
    printf("End\n");
    return 0;
}
