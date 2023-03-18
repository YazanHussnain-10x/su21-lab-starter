#include <assert.h>
#include <stdio.h>
#include "pwd_checker.h"

int main() {
    printf("Running tests...\n\n");

    const char *test1_first = "Abraham";
    const char *test1_last = "Garcia";
    const char *test1_pwd = "qrtv?,mp!ltrA0b13rab4ham";
    bool test1 = check_password(test1_first, test1_last, test1_pwd);
    assert(!test1); //change test1 => !test1

    printf("Congrats! The first test case is now passing. You should remove the assert statements that you added "
           "to pwd_checker.c because these correspond to the first test case and will not necessarily work for the remaining "
           "test cases!\n\n");

    const char *test2_first = "Anjali";
    const char *test2_last = "Patel";
    const char *test2_pwd = "Aj8r";
    bool test2 = check_password(test2_first, test2_last, test2_pwd);
    assert(!test2);

    const char *test3_first = "Chantelle";
    const char *test3_last = "Brown";
    const char *test3_pwd = "QLRIOW815N";
    bool test3 = check_password(test3_first, test3_last, test3_pwd);
    assert(!test3);

    const char *test4_first = "Wei";
    const char *test4_last = "Zhang";
    const char *test4_pwd = "pjkdihn!o901";
    bool test4 = check_password(test4_first, test4_last, test4_pwd);
    assert(!test4);

    const char *test5_first = "John";
    const char *test5_last = "Smith";
    const char *test5_pwd = "ALKLIenhLq";
    bool test5 = check_password(test5_first, test5_last, test5_pwd);
    assert(!test5);

    const char *test6_first = "Haeun";
    const char *test6_last = "Kim";
    const char *test6_pwd = "Ji9anjwHaeun";
    bool test6 = check_password(test6_first, test6_last, test6_pwd);
    assert(!test6);

    const char *test7_first = "Adeline";
    const char *test7_last = "DuBois";
    const char *test7_pwd = "ALKLIDuBoisen3hLq";
    bool test7 = check_password(test7_first, test7_last, test7_pwd);
    assert(!test7);

    const char *test8_first = "10";
    const char *test8_last = "xEngineers";
    const char *test8_pwd = "Password108";
    bool test8 = check_password(test8_first, test8_last, test8_pwd);
    assert(!test8);

    const char *test9_first = "";
    const char *test9_last = "";
    const char *test9_pwd = "hajA*&@10 ";
    bool test9 = check_password(test9_first, test9_last, test9_pwd);
    assert(!test9);

    printf("Congrats! You have passed all of the test cases!\n");
    return 0;
}
