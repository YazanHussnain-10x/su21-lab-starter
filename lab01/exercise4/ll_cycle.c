#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* TODO: Implement ll_has_cycle */
    // Write Function
    if(head == NULL){
        return 0;
    }
    node *ptr1 = head;
    node *ptr2 = head->next;

    while((ptr2 != NULL) && (ptr2->next != NULL)){
        if(ptr1 == ptr2){
            return 1;
        }

        ptr1 = ptr1->next;
        ptr2 = ptr2->next->next;
    }

    return 0;
}
