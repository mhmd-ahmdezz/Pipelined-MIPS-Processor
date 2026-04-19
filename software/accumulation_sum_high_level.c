
int sum (int *a, int size) {
    int result = 0 ;
    for(int i=0;i<size;i++){
        result += a[i] ;
    }
    return result;
}

int main() {
    int array[5];
    for(int i=0;i<5;i++){
        array[i] = i*2 ;
    }
    sum(&array,5);
}