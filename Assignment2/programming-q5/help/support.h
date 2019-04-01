#ifndef ALGOHW2HUFFMAN_SUPPORT_H
#define ALGOHW2HUFFMAN_SUPPORT_H
#include <iostream>
#include <fstream>
#include <sstream>
#include <utility>
#include <iterator>
#include <algorithm>
#include <vector>
#include <queue>
#include <unordered_map>
#include<unistd.h>
using namespace std;

struct Node {
    string symbol;
    int counter, height;
    Node *left, *right;

    // Explicit Constructor (no children are passed)
    Node(string a, int b){
        symbol = a, counter = b, height = 1, left = right = nullptr;
    } // Explicit Constructor w/children nodes passed as well as height.
    Node(string a, int b, Node* l, Node* r, int h){
        symbol = a, counter = b, height = h, left = l, right = r;
    }
};

// Comparison Classes for the Priority Queue
struct CompareCount {
    bool operator()(Node* t1, Node* t2) {
        return (t1->counter > t2->counter);
    }
};

struct CompareAlpha {
    bool operator()(Node* t1, Node* t2) {
        return (t1->symbol > t2->symbol);
    }
};

struct CompareHeight {
    bool operator()(Node* t1, Node* t2) {
        return (t1->height < t2->height);
    }
};

void printSideways(Node* cu, string indent);
void printByOrder(priority_queue<Node*, vector<Node*>, CompareCount> &pq, string x);

/*
     * Method: addSpaces
     * Usage: addSpaces(string& line)
     * ------------------------------------
     * Adds whitespace delimiters to a string for the string stream processing.
     * Precondition: The argument is a raw line received from the file.
     * Postcondition: The number of blank spaces in the hash table is incremented by one.
     * Postcondition: The line has been tokenized
*/
string addSpaces(string& line) {
    string res;
    int size = line.length();
    for (int i = 0; i < size ; i++) {               // Check every char in the string
        res = (res + line[i] + " ");
    }
    return res;                                     // Return the result string.
}


/*
     * Method: makeFrequencyTable
     * Usage: makeFrequencyTable(unordered_map<string,int> &myMap, string inPath, int &cS, int &cL, int &cU);
     * ------------------------------------
     * Reads a file (character by character), finds the char in the map and increment it by one
     * Precondition: The input file stream has been initialized at the first-line (or rewound).
     * Postcondition: The map has been filled with the raw data.
     * Postcondition: The statistical counts have been updated.
*/
void makeFrequencyTable(unordered_map<string,int> &myMap, string inPath, int &cS, int &cL, int &cU){
    string temp, letter;
    ifstream in;
    in.open(inPath);
    while (in >> temp){                              // Create a Hash Map of {unique symbol : occurrences}
        cS++;
        istringstream readFileByWord(addSpaces(temp));
        while (readFileByWord >> letter){
            auto& findWord = myMap[letter];     // pointer to location of the letter in the hash map
            findWord++;
            cL++;
        }
    }

    auto& findWord = myMap[" "];     // pointer to location of a blank space in the hash map
    findWord += cS;
    cL += cS;

    for (const auto& x : myMap){
        cU++;
    }
    in.close();
}

void mapOutput(const string a, const int b){
    string timeFormat = "}", letterFormat;
    b < 10 ? timeFormat = " " + timeFormat : timeFormat;
    a.length() > 3 ? letterFormat = "..." : letterFormat = a;
    cout << "{\"" << letterFormat << "\":" << b << timeFormat << endl;
}

Node* combine(Node* a, Node* b, int i, ofstream &out){
    out << "The nodes \"" << a->symbol << "\" and \"" << b->symbol << "\" will combine to form \"X" << i  << ".\""<< endl;
    Node* c = new Node("X"+ to_string(i), a->counter+b->counter);
    c->left = a, c->right = b;
    (a->height > b->height) ? c->height = a->height+1: c->height = b->height+1;
    return c;
}

// For every item in the table, push it onto the queue,
// and order it from least to greatest number of  occurrences
void initializePQ(unordered_map<string, int> table,
                  priority_queue<Node*, vector<Node*>, CompareCount> &pq){
    Node* placeholder;
    for (const auto& x : table){
        placeholder = new Node(x.first,x.second);
        pq.push(placeholder);
    }
}

Node* combineHuffmanNodes(priority_queue<Node*, vector<Node*>, CompareCount> &pq, string outfile){
    int i = 1, j=1;
    string numFormat;
    Node *temp1, *temp2, *temp3;
    ofstream output(outfile);
    while (pq.size()>1){
        temp1 = new Node(pq.top()->symbol, pq.top()->counter, pq.top()->left, pq.top()->right, pq.top()->height);
        pq.pop();
        temp2 = new Node(pq.top()->symbol, pq.top()->counter,pq.top()->left, pq.top()->right, pq.top()->height);
        pq.pop();
        temp3 = combine(temp1, temp2, i, output);
        i++;
        pq.push(temp3);

        //for (j=i; j<20 ;j++){
        //    cout << endl;
        //}
        printByOrder(pq, "h");
        cout<< "------------------------------------------------ X" << i << endl;
        sleep(2);
    }
    //printByOrder(pq, "h");
    output.close();
    return new Node(pq.top()->symbol, pq.top()->counter, pq.top()->left, pq.top()->right, pq.top()->height);

};


void printByOrder(priority_queue<Node*, vector<Node*>, CompareCount> &pq, string x){
    int i = 1;
    string numFormat;
    Node* placeholder;
    if (x == "a"){
        priority_queue<Node*, vector<Node*>, CompareAlpha> a;
        while (!pq.empty()){
            placeholder = new Node(pq.top()->symbol, pq.top()->counter, pq.top()->left, pq.top()->right, pq.top()->height);
            a.push(placeholder);
            pq.pop();
        }
        // Print the queue in order and push onto the original pq.
        while (!a.empty()){
            i < 10 ? numFormat = " " : numFormat = "";
            cout << numFormat << i << ". ";
            mapOutput(a.top()->symbol, a.top()->counter);
            placeholder = new Node(a.top()->symbol, a.top()->counter, a.top()->left, a.top()->right, pq.top()->height);
            pq.push(placeholder);
            a.pop();
            i++;
        }
    } else if (x == "h") {
        priority_queue<Node*, vector<Node*>, CompareHeight> h;
        while (!pq.empty()){
            placeholder = new Node(pq.top()->symbol, pq.top()->counter, pq.top()->left, pq.top()->right, pq.top()->height);
            h.push(placeholder);
            pq.pop();
        }
        printSideways(h.top(), "");
        cout << endl;

        // Print the queue in order and push onto the original pq.
        while (!h.empty()){
            //i < 10 ? numFormat = " " : numFormat = "";
            //cout << numFormat << i << ". ";
            //mapOutput(h.top()->symbol, h.top()->counter);
            placeholder = new Node(h.top()->symbol, h.top()->counter, h.top()->left, h.top()->right, pq.top()->height);
            pq.push(placeholder);
            h.pop();
            i++;
        }

    } else {
        priority_queue<Node*, vector<Node*>, CompareCount> c;
        if (x != "c") {
            cout << "Invalid Argument: Switching to Default Order." << endl;
        }
        while (!pq.empty()){
            placeholder = new Node(pq.top()->symbol, pq.top()->counter, pq.top()->left, pq.top()->right, pq.top()->height);
            c.push(placeholder);
            pq.pop();
        }
        // Print the queue in order and push onto the original pq.
        while (!c.empty()){
            i < 10 ? numFormat = " " : numFormat = "";
            cout << numFormat << i << ". ";
            mapOutput(c.top()->symbol, c.top()->counter);
            placeholder = new Node(c.top()->symbol, c.top()->counter, c.top()->left, c.top()->right, pq.top()->height);
            pq.push(placeholder);
            c.pop();
            i++;
        }
    }
}

void printSideways(Node* cu, string indent){
    if (cu != nullptr) {
        printSideways(cu->left, indent + "\t");
        cout << indent;
        mapOutput(cu->symbol, cu->counter);
        printSideways(cu->right, indent + "\t");
    }
}

void fillEncoderMap(Node* tree, unordered_map<string, string> &myMap, string path){
    if (tree == nullptr){
        return;
    } else {
        if ((tree->left == nullptr) && (tree->right == nullptr)) {
            auto& findWord = myMap[tree->symbol];     // pointer to location of a blank space in the hash map
            findWord = path;
        } else {
            fillEncoderMap(tree->left, myMap, path+"0");
            fillEncoderMap(tree->right, myMap, path+"1");
        }
    }
}

void makeEncoderMap(Node* tree, unordered_map<string, string> &myMap, string path){
    fillEncoderMap(tree, myMap, path);
    for (const auto& x : myMap){
        cout << x.first << " : " << x.second << endl;
    }
}

void encodeFile(string inPath, string outPath, unordered_map<string, string> &myMap, int &i){
    ifstream in(inPath);
    ofstream out(outPath);
    string temp, letter;
    while (in >> temp){
        //Read a word until you find a delimiter
        istringstream readFileByWord(addSpaces(temp));
        while (readFileByWord >> letter){
            // Find the letter in the encryption table and write it to the file
            out << myMap[letter] << endl;
            i += myMap[letter].length();
        }
        // Write the delimiter to the file as a single whitespace character.
        i += myMap[" "].length();
        out << myMap[" "];
    }
    in.close();
    out.close();
}

#endif //ALGOHW2HUFFMAN_SUPPORT_H

