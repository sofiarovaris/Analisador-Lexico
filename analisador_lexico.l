/* Este programa realiza a análise léxica de um código no arquivo, reconhecendo os erros léxicos */
/* Autores: Gabriel Pereira e Sofia Rovaris */
/* Desenvolvido em: 20/01/2022 */

%option noyywrap
%{
#include<stdio.h>

//variaveis
int cont=1; //contador de linhas do programa
int totalparenteses; //contador de parenteses
int totalchaves; //contador de chaves
%}

/* Definicoes regulares */
letra [a-zA-Z]
numero -?[0-9]+
caractere [@!#$%&,*|]
aspas ["]
espaco [ ]
simbolos [(){};]

 /* Regras para identificar as classes de tokens e os erros lexicos*/
%%

 /* Categoria: Texto */
({aspas}{1})({letra}|{numero}|{caractere}|{espaco}|{simbolos})*({aspas}{1}) 	printf("Texto constante\n");

 /* Erro Léxico associado a classe de tokens: Texto */
({aspas}{1})({letra}|{numero}|{caractere}|{espaco}|{simbolos})* 				printf("Texto mal formado na linha %d\n", cont);

 /* Categoria: Simbolo */
("(")	totalparenteses = totalparenteses + 1;      							printf("Simbolo\n"); 
(")")	totalparenteses = totalparenteses - 1;									printf("Simbolo\n"); 
("{")	totalchaves = totalchaves + 1;											printf("Simbolo\n"); 
("}")	totalchaves = totalchaves - 1;											printf("Simbolo\n"); 
(",")                                    										printf("Simbolo\n"); 
(";")                                    										printf("Simbolo\n"); 

 /* Categoria: Operador */
("+")                                    										printf("Operador\n"); 
("-")                                    										printf("Operador\n"); 
("*")                                    										printf("Operador\n"); 
("/")                                    										printf("Operador\n"); 
("=")                                    										printf("Operador\n"); 
("&&")                                  										printf("Operador\n"); 
("||")                                   										printf("Operador\n"); 
("==")                                   										printf("Operador\n"); 
("!=")                                   										printf("Operador\n");

 /* Categoria: Tipo de dado */
("int")                                  										printf("Tipo de dado\n"); 
("double")                               										printf("Tipo de dado\n"); 

 /* Categoria: Representacao de tipo de dado */
("%d")									 										printf("Representacao de tipo de dado\n"); 
("%lf")																			printf("Representacao de tipo de dado\n"); 

 /* Categoria: Palavras reservadas */
("do")                                   										printf("Tok_do\n"); 
("for")                                  										printf("Tok_for\n"); 
("if")                                   										printf("Tok_if\n"); 
("else")                                 										printf("Tok_else\n"); 
("printf")                               										printf("Tok_printf\n"); 
("scanf")                                										printf("Tok_scanf\n");
("main")                                 										printf("Tok_main\n");
("void")                                 										printf("Tok_void\n");
("return")                               										printf("Tok_return\n"); 
("while")  				     				                                   	printf("Tok_while\n"); 

 /* Erro Léxico associado a classe de tokens: Numero */
({numero})+({letra}|{caractere}|"_")+(".")?({numero})*                         	printf("Numero mal formado na linha %d\n", cont);
({numero})+(".")?({letra}|{caractere}|"_")+({numero})*                         	printf("Numero mal formado na linha %d\n", cont);
({numero})+(".")?({numero}){9,} 											   	printf("Numero com tamanho excessivo na linha %d\n", cont); 

 /* Categoria: Numero */
({numero})+(".")?({numero})*          			   							   	printf("Numero real\n"); 

 /* Erro Léxico associado a classe de tokens: Identificador */
({caractere})+({letra}|"_")({letra}|"_"|{numero})*  			               	printf("Identificador mal formado na linha %d\n", cont);
({letra}|"_")({letra}|"_"|{numero})*({caractere})+({letra}|"_"|{numero})*      	printf("Identificador mal formado na linha %d\n", cont);
({letra}|"_")({letra}|"_"|{numero}){128,}									   	printf("Identificador com tamanho excessivo na linha %d\n", cont);

 /* Categoria: Identificador */
({letra}|"_")({letra}|"_"|{numero})*         								   	printf("Identificador\n"); 

 /* Categoria: Espaço e quebra de linha */
" "
"\n" {cont++;}

%%

/* Funcao que verifica o numero total de chaves e de parenteses para tratamento de fim inesperado*/
void tratamento_fim()
{
	if(totalparenteses!=0){
		printf("Fim de expressao inesperado\n");
	}

	if(totalchaves!=0){
		printf("Fim de arquivo inesperado\n");
	}
}

/* Funcao para ler arquivo */
void lerArquivo(){
	char fname[100]; 
	printf("Entre com o nome do arquivo:\n");
	scanf("%s",fname);

	if(yyin=fopen(fname,"r")){
		printf("Sucesso ao abrir o arquivo\n\n");
	}else{
		printf("Erro ao abrir o arquivo\n\n");
	}

	yylex();

	fclose(yyin);
}

int main()
{
	lerArquivo();
	tratamento_fim();

	return 0;
}