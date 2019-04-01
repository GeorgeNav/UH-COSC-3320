/*
 * Carlos Flores 03/02/19
 * File: huffman.cpp
 * --------------------
 * This program reads an arbitrary text file and compresses it losslessly.
 * It is meant to demonstrate the efficiency and functionality of Huffman Encoding techniques.
 */

#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include "support.h"
using namespace std;

//TODO: fix the combine() output ; it isn't displaying the largest huffman subtree in the priority queue
//todo: implement a decrypter.
//Todo: clean up the source code


int main() {
    string inputFilePath = "./input1.txt";   // Read this file
    string stepPath = "./steps.txt";         // Show how the code words were made
    string outputFilePath = "./output.txt";  // Write the encrypted file here
    int countSpaces=0, countLetters=0, countUnique=0, i=1, countEncryptedBits=0;
    double compressionRatio = 0, uniqueRatio = 0;

    /// Step 1) Create a Hash Map of {char : occurrences}
    unordered_map<string, int> frequencyTable;
    makeFrequencyTable(frequencyTable, inputFilePath, countSpaces, countLetters, countUnique);
    priority_queue<Node*, vector<Node*>, CompareCount> pqCount;                 // Push the map contents onto a PQ
    initializePQ(frequencyTable, pqCount);                                      // Order the PQ by occurences

    /// Step 2) Create a Huffman Tree & Encoding Table
    Node* huffmanTree = combineHuffmanNodes(pqCount, stepPath);
    unordered_map<string, string> encoder;
    makeEncoderMap(huffmanTree, encoder, "");
    encodeFile(inputFilePath, outputFilePath, encoder, countEncryptedBits);

    cout << "\nThe file contains:\n" << countLetters << " total letters\n" << countUnique << " unique letters\n";
    cout << frequencyTable[" "] << "  whitespace delimiters\n" << countLetters*8 << " uncompressed bits" << endl;
    cout << countEncryptedBits << " compressed bits " << endl;
    uniqueRatio = 100*countUnique/double(countLetters);
    compressionRatio = 100*countEncryptedBits/double(countLetters*8);
    cout << "The redundant   ratio is : " << 100-uniqueRatio << "%" << endl;
    cout << "The compression ratio is : " << compressionRatio << "%" << endl;

    cout << "\nThe program compiles!" << endl;
    return 0;
}