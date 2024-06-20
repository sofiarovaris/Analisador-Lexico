# Lexical Analyzer

## Description

This project was developed as part of the college Compilers subject. The goal was to create a lexical analyzer that receives an input file and identifies lexical errors found in the code of a language created by us - students - which is a subset of C.

The tokens and expressions recognized by the language are detailed in the [README.pdf](README.pdf) file.

## Technologies Used

- **Flex (Fast Lexical Analyzer Generator)**: Tool for generating the lexical analyzer.
- **Bison**: Tool for generating parsers.
- **Programming Language**: C
- **Compiler**: GCC

## How to Run

### Prerequisites

- Flex installed
- Bison installed
- GCC installed
- Operating system configured with the correct environment variables (PATH)

### Installing Flex and Bison

To install Flex and Bison, follow the tutorial available on Stack Overflow:
[How to compile Lex & Yacc files on Windows](https://stackoverflow.com/questions/5456011/how-to-compile-lex-yacc-files-on-windows).

### Execution Steps

1. **Generate the Lexical Analyzer**
    ```bash
    flex .\analisador_lexico.l
    ```

2. **Compile the Generated Code**
    ```bash
    gcc lex.yy.c -o analisador_lexico.exe
    ```

3. **Run the Lexical Analyzer**
    ```bash
    ./analisador_lexico
    ```

### Functionality

The software operates in a very simple manner. When executed, it will prompt for the name of a file, which will be read. The software will perform a lexical analysis on the code contained in the file, recognizing token classes and identifying any lexical errors found.

### Example of Use

To analyze an input file `codigo.txt`, you can redirect the input to the program:
```bash
./analisador_lexico < codigo.txt
