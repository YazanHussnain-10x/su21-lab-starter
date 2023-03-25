#include <stdio.h>
#include <string.h>

typedef struct stdnt {
    char name[50];
    int id;
    int age;
}student;

int main() {
    student s;

    printf("Enter name: ");
    fgets(s.name, sizeof(s.name), stdin);
    s.name[strcspn(s.name, "\n")] = '\0';

    printf("Enter ID: ");
    scanf("%d", &s.id);

    printf("Enter age: ");
    scanf("%d", &s.age);

    printf("Name: %s\n", s.name);
    printf("ID: %d\n", s.id);
    printf("Age: %d\n", s.age);

    return 0;
}
