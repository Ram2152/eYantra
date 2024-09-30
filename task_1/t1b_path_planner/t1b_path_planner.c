
/*
* AstroTinker Bot (AB): Task 1B Path Planner
*
* This program computes the valid path from the start point to the end point.
* Make sure you don't change anything outside the "Add your code here" section.
*/

#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#ifdef __linux__ // for host pc

    #include <stdio.h>

    void _put_byte(char c) { putchar(c); }

    void _put_str(char *str) {
        while (*str) {
            _put_byte(*str++);
        }
    }

    void print_output(uint8_t num) {
        if (num == 0) {
            putchar('0'); // if the number is 0, directly print '0'
            _put_byte('\n');
            return;
        }

        if (num < 0) {
            putchar('-'); // print the negative sign for negative numbers
            num = -num;   // make the number positive for easier processing
        }

        // convert the integer to a string
        char buffer[20]; // assuming a 32-bit integer, the maximum number of digits is 10 (plus sign and null terminator)
        uint8_t index = 0;

        while (num > 0) {
            buffer[index++] = '0' + num % 10; // convert the last digit to its character representation
            num /= 10;                        // move to the next digit
        }

        // print the characters in reverse order (from right to left)
        while (index > 0) { putchar(buffer[--index]); }
        _put_byte('\n');
    }

    void _put_value(uint8_t val) { print_output(val); }

#else  // for the test device

    void _put_value(uint8_t val) { }
    void _put_str(char *str) { }

#endif


// main function
int main(int argc, char const *argv[]) {

    #ifdef __linux__

        const uint8_t START_POINT   = atoi(argv[1]);
        const uint8_t END_POINT     = atoi(argv[2]);
        uint8_t CPU_DONE            = 0;

    #else

        #define START_POINT         (* (volatile uint8_t * ) 0x20000000)
        #define END_POINT           (* (volatile uint8_t * ) 0x20000001)
        #define CPU_DONE            (* (volatile uint8_t * ) 0x20000003)

    #endif

    // array to store the planned path
    uint8_t path_planned[32];

    // index to keep track of the sam array
    uint8_t idx = 0;

    // instead of using printf() function for debugging,
    // use the below function calls to print a number, string or a newline

    // for newline: _put_byte('\n');
    // for string:  _put_str("your string here");
    // for number:  _put_value(your_number_here);

    // Examples:
    // _put_value(START_POINT);
    // _put_value(END_POINT);
    // _put_str("Hello World!");
    // _put_byte('\n');

    // ############# Add your code here #############
    int adj[30][4] = {{1,0,0,0},{0,2,29,0},{1,3,8,0},{2,28,4,0},{3,5,6,0},{4,0,0,0},{4,7,0,0},{6,8,0,0},{2,7,9,12},{8,10,11,0},{9,0,0,0},{9,0,0,0},{8,13,19,0},{12,14,0,0},{15,13,16,0},{14,0,0,0},{14,17,18,0},{16,0,0,0},{16,19,0,0},{12,18,20,0},{19,21,24,29},{20,22,23,0},{21,0,0,0},{21,0,0,0},{20,25,0,0},{26,24,0,0},{25,27,28,0},{26,0,0,0},{3,26,29,0},{1,20,28,0}};
    int cost[30];
    int prev[30];
    for (int i = 0; i < 30; i++) {
        if (i!=START_POINT) {
            cost[i]=10000;
        }
        else {
            cost[i]=0;
        }
    }
    int queue[30], min_dist, j;
    queue[0]=START_POINT;
    queue[START_POINT]=0;
    for (int i = 0; i < 30; i++){
        if (i!=0 && i!=START_POINT){
            queue[i]=i;
        }
    }
    bool var;
    for (int i = 0; i < 30; i++){
        j=0;
        do{
            min_dist=cost[adj[queue[i]][j]];
            if (cost[queue[i]]+1<min_dist) {
                cost[adj[queue[i]][j]]=cost[queue[i]]+1;
                prev[adj[queue[i]][j]]=queue[i];
            }
            j++;
        } while (adj[queue[i]][j]!=0 && j<4);
        for (int a = 0; a < 30; a++){
            var=false;
            for (int b = 0; b < 29; b++){
                if (cost[queue[b]]>cost[queue[b+1]]) {
                    int temp=queue[b];
                    queue[b]=queue[b+1];
                    queue[b+1]=temp;
                    var=true;
                }
            }
            if (!var) break;
        }
    }
    int sam[32];
    int k=END_POINT,l=prev[k];
    sam[0]=END_POINT;
    int m=1;
    while (prev[k]!=START_POINT) {
        sam[m]=prev[k];
        k=prev[k];
        m++;
    }
    sam[m]=START_POINT;
    idx=m+1;
    for (int i = 0; i < m+1; i++){
        path_planned[i]=sam[m-i];
    }
    // ##############################################

    #ifdef __linux__    // for host pc

        _put_str("######### Planned Path #########\n");
        for (int i = 0; i < idx; ++i) {
            _put_value(path_planned[i]);
        }
        _put_str("################################\n");

    #endif

    return 0;
}
