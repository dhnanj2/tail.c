#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Node structure for the linked list
struct Node {
    char *line;
    struct Node *next;
};

// Function to create a new node
struct Node* createNode(char *line) {
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    if (newNode != NULL) {
        newNode->line = strdup(line); // Duplicate the line to store it dynamically
        newNode->next = NULL;
    }
    return newNode;
}

// Function to free the linked list memory
void freeList(struct Node *head) {
    while (head != NULL) {
        struct Node *temp = head;
        head = head->next;
        free(temp->line);
        free(temp);
    }
}

// Function to print the last 'n' lines
void printLastNLines(struct Node *head, int n) {
    if (n <= 0)
        return;

    // Move the 'end' pointer to the nth node
    struct Node *end = head;
    for (int i = 0; i < n && end != NULL; i++) {
        end = end->next;
    }

    // Move both pointers until 'end' reaches the end of the list
    struct Node *prev = NULL;
    struct Node *start = head;
    while (end != NULL) {
        end = end->next;
        prev = start;
        start = start->next;
    }

    // Print the last 'n' lines
    while (start != NULL) {
        printf("%s", start->line);
        prev = start;
        start = start->next;
        free(prev->line);
        free(prev);
    }
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <n>\n", argv[0]);
        return 1;
    }

    int n = atoi(argv[1]);

    struct Node *head = NULL;
    char buffer[1024];

    while (fgets(buffer, sizeof(buffer), stdin) != NULL) {
        // Create a new node and add it to the linked list
        struct Node *newNode = createNode(buffer);
        if (newNode == NULL) {
            printf("Memory allocation error.\n");
            freeList(head);
            return 1;
        }

        newNode->next = head;
        head = newNode;
    }

    // Print the last 'n' lines
    printLastNLines(head, n);

    // Free the linked list memory
    freeList(head);

    return 0;
}
