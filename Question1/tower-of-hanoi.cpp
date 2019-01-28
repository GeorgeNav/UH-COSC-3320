#include <string>
#include <iostream>
#include "graph.cpp"

void towerOfHanoi(int);
void threeDisks(int, Stack&, Stack&, Stack&);

int main() {
    int n;
    double delay = 0;
    bool animation;

    std::cout << "Enter the # of disks: ";
    std::cin >> n;
    std::cout << "Animate moves? 0 is no and 1 is yes: ";
    std::cin >> animation;
    if(animation == true) {
        std::cout << "Delay in moves? 1 for fastest, 2 slower, 3 even slower... : ";
        std::cin >> delay;
    }

    std::cout << delay << std::endl;

    Graph graph = Graph(n, animation, delay);

    return 0;
}
