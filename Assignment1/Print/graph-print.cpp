#include <fstream>
#include <iostream>
#include "stack.cpp"
#include <unistd.h>
using namespace std;

struct Node {
    Stack * v;
    Node * next;
    Node * dest;
    Node(Stack * i) : v(i) {}
};

std::ofstream out("./outputs/test.txt");

class Graph {
private:
    Node *s, *a1, *a2, *a3, *d;
    int n, recursiveCalls, moves;
    bool animation, movesValid;
    double delay;
public:
    Graph(int n, bool animation = true, double delay = 0) :
        n(n), animation(animation), delay(delay), recursiveCalls(0),
        moves(0), movesValid(true){

        s = new Node(new Stack(n, "Start"));
        a1 = new Node(new Stack(n, "Aux1"));
        a2 = new Node(new Stack(n, "Aux2"));
        a3 = new Node(new Stack(n, "Aux3"));
        d = new Node(new Stack(n, "Dest"));

        s->next = a1;
        a1->next = a2;
        a2->next = a3;
        a3->next = a1;
        a3->dest = d;

        for(int i = n; i > 0;i--)
            s->v->push(i);

        Hanoi(n);
        out.close();
    }

    ~Graph() {
        delete s;
        delete a1;
        delete a2;
        delete a3;
        delete d;
    }

    void Hanoi(int n) {
        if(!s->v->isEmpty() && n >= 1) {
            Hanoi(n-1);
            moveNext(s, a2);
            H1(n-1, a3, a2, a1);
            moveNext(a2,a3);
            if(!s->v->isEmpty())
                H2(n-1, a1, a2, a3);
            else
                Hanoi(n-1);
        } else if(s->v->isEmpty()) {
            if(n == 0)
                moveNext(a3,d);
            else if(n >= 1) {
                moveNext(a3, d);
                H2(n-1, a1, a2, a3);
                moveNext(a1, a2);
                H1(n-1, a3, a2, a1);
                moveNext(a2, a3);
                Hanoi(n-1);
            }
        } recursiveCalls++;
    }


    void H2(int n, Node * begin, Node * aux, Node * end) {
        if(n == 1)
            moveNext(begin, end);
        else if(n >= 2) {
            H2(n-1, begin, aux, end);
            moveNext(begin, aux);
            H1(n-1, end, aux, begin);
            moveNext(aux, end);
            H2(n-1, begin, aux, end);
        } recursiveCalls++;
    }

    void H1(int n, Node * begin, Node * aux, Node * end) {
        if(n == 1)
            moveNext(begin, end);
        else if(n >= 2) {
            H2(n-1, begin, end, aux);
            moveNext(begin, end);
            H2(n-1, aux, begin, end);
        } recursiveCalls++;
    }

    void moveNext(Node * a, Node * b) {
        if(b == d) {
            if(b == d && a == a3) {
                out << a->v->getName() << " -> " << a->v->top()
                    << " -> " << d->v->getName() << std::endl;
                b->v->push(a->v->pop());
            } else {
                out << a->v->getName() << " -> " << a->v->top()
                    << " -> " << a->next->v->getName() << std::endl;
                a->next->v->push(a->v->pop());
                moveNext(a->next, b);
            }
        } else if(a->next == b) {
            out << a->v->getName() << " -> " << a->v->top()
                << " -> " << b->v->getName() << std::endl;
            b->v->push(a->v->pop());
        } else {
            out << a->v->getName() << " -> " << a->v->top()
                << " -> " << a->next->v->getName() << std::endl;
            a->next->v->push(a->v->pop());
            moveNext(a->next, b);
        } moves++;
    }
};