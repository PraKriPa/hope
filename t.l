Find and replace

%{
	#include<stdio.h>
	#include<string.h>
	char find[20], replace[20];
	FILE *r_f, *w_f;
%}

%%
[a-zA-Z0-9]+ {	
		if (strcmp(find,yytext)==0)
		{
			fprintf(w_f,replace);
		}
		else 
		{
			fprintf(w_f,yytext);
		}
	     }
[^a-zA-Z0-9]+
	     {
		fprintf(w_f,yytext);
	     }
%%

int main(int argc, char **argv)
{
	printf("Enter the word you want to replace. \n");
	scanf("%s",find);
	printf("Enter the word you want to replace with. \n");
	scanf("%s",replace);
	r_f=fopen(argv[1], "r");
	w_f=fopen("corrected", "w");
	yyin=r_f;
	yylex();
	fclose(w_f);
	fclose(r_f);
	return 0;
}

int yywrap()
{return 1;}

Average of numbers

%{
	#include<stdio.h>
	#include<math.h>
	#include<string.h>
	int sum=0, n=0, val=0;
	FILE *r;
%}

%%
[0-9] {
	  printf("\nThe numbers are: ");
	  printf("\n%i\n", atoi(yytext));
	  sum=sum+atoi(yytext);
	  n++;
       }
[\n] {
 	float avg=((float)sum/(float)n);
 	printf("\nThe average of the numbers is: %f\n", avg);
 	return 0;
     }
%%

int main(int argc, char **argv)
{
	r=fopen(argv[1],"r+");
	yyin=r;
	yylex();
	fclose(r);
	return(0);
}

int yywrap()
{return(1);}

Without using declaration and sub rountine section (include lex library at cc)

%%
[A-Za-z] printf("\nLetter: %s",yytext);//Variable yytext is a pointer to the matched string (NULL-terminated)
[0-9] printf("\nDigit: %s",yytext);
%%

Noun Pronoun

%{
	#include<stdio.h>//header file is declared
%}
%%

He|She|he|she printf("\nPronoun: %s",yytext);//Variable yytext is a pointer to the matched string (NULL-terminated) ,yytext is char pointer
Shubham|Shivam|boy printf("\nNoun: %s",yytext);
good printf("\nAdjective: %s",yytext);
a|an|the printf("\nArticle: %s",yytext);
is|are|was|were {printf("\nVerb: %s",yytext);}
[ \n\t] 
. printf("\nSpecial character : %s\n",yytext);

%%

int main()
{
	yylex(); //call to invoke lexer, returns token(integer) ,main entry point of lex
	
}
int yywrap(){};//Function yywrap is called by lex when input is exhausted. Return 1 if you are done or 0 if more processing is required.


Lines characters

%{
	#include<stdio.h>
	int words=0,chars=0,lines=0,vowels=0; //initialising all variable to
%}
%%
a|e|i|o|u|A|E|I|O|U { chars++; vowels++;}
[a-zA-Z0-9] {chars++;}
[ ] {words++;}
\n {lines++;}
. {} //to ignore any special characters and display nothing
    
%%

int main(int argc,char **argv)
{
	FILE *fp=fopen(argv[1],"r+"); //openinng the file in read mode
	yyin=fp;// the input stream pointer (i.e it points to an input file which is to be scanned or tokenised), however the default input of default main() is stdin .
	yylex();// implies the main entry point for lex, reads the input stream generates tokens, returns zero at the end of input stream . It is called to invoke the lexer (or scanner) and each time yylex() is called, the scanner continues processing the input from where it last left off.
	printf("\n VOWELS: %d",vowels);
	printf("\n CHARACTERS: %d",chars);
	printf("\n WORDS: %d",words+lines);
	printf("\n LINES: %d\n",lines);
	fclose(fp);
	return(0);
}
int yywrap(){}//t is called by lex when input is exhausted (or at EOF). default yywrap always return 1.
 
/*	OUTPUT
	
shubham@shubham-HP-15-Notebook-PC:~/Desktop/website/CL1$ lex A4_3.l 
shubham@shubham-HP-15-Notebook-PC:~/Desktop/website/CL1$ gcc lex.yy.c 
shubham@shubham-HP-15-Notebook-PC:~/Desktop/website/CL1$ ./a.out abc1.txt 

 VOWELS: 13
 CHARACTERS: 32
 WORDS: 11
 LINES: 3
shubham@shubham-HP-15-Notebook-PC:~/Desktop/website/CL1$ 
*/

find replace

%{
	#include<stdio.h>
	#include<string.h>
	FILE *read_f,*write_f; //readfile pointer and write file pointer
	char find[20],replace[20];
%}

%%

[a-zA-Z0-9]+ {	
		if(strcmp(find,yytext)==0) //if the the search word is found
			fprintf(write_f,replace); //then the search word is replaced
		else 
			fprintf(write_f,yytext);}// same word which was taken in yyin is written in corrected file
[^a-zA-Z0-9] { fprintf(write_f,yytext);}//for special characters copy it as it is

%%

int main(int argc,char **argv)
{
	printf("Enter String to be find: ");
	scanf("%s",find); //important, not to do as &find
	printf("Enter string to be replaced with %s: ",find);
	scanf("%s",replace);
	read_f=fopen(argv[1],"r+");
	write_f=fopen("corrected.txt","w");
	
	yyin=read_f;//yyin: the input stream pointer (i.e it points to an input file which is to be scanned or tokenised), however the default input of default main() is stdin .
	yylex();//implies the main entry point for lex, reads the input stream generates tokens, returns zero at the end of input stream . It is called to invoke the lexer (or scanner) and each time yylex() is called, the scanner continues processing the input from where it last left off.
	
	fclose(read_f);
	fclose(write_f);
	return 0;
}	
int yywrap(){}//dont forget yywrap is a function else it will give some unknown error 

// it is called by lex when input is exhausted (or at EOF). default yywrap always return 1.
/*
	OUTPUT
	
shubham@shubham-HP-15-Notebook-PC:~/Desktop/website/CL1$ lex A4_4.l
shubham@shubham-HP-15-Notebook-PC:~/Desktop/website/CL1$ gcc lex.yy.c 
A4_4.l: In function :
A4_4.l:12:20: warning: format not a string literal and no format arguments [-Wformat-security]
   fprintf(write_f,replace); 
                   ^
A4_4.l:14:4: warning: format not a string literal and no format arguments [-Wformat-security]
   fprintf(write_f,yytext);}
   ^
A4_4.l:15:1: warning: format not a string literal and no format arguments [-Wformat-security]
[^a-zA-Z0-9] { fprintf(write_f,yytext);}
^
shubham@shubham-HP-15-Notebook-PC:~/Desktop/website/CL1$ ./a.out abc1.txt
Enter String to be find: nice
Enter string to be replaced with nice: good


abc1.txt

Hi my name is abc
whats up|!@
Have a nice day

corrected.txt

Hi my name is abc
whats up|!@
Have a good day   

*/

uppper case lower case

%{
	#include<stdio.h>
	#include<ctype.h>
	#include<string.h>
%}

%%
[a-zA-Z0-9 .]+ {                                    //regular expression to take input as a line 
	      
	      printf("UPPER CASE: ");
	      int i=0;
	      while(yytext[i])
	     	{ 
	      	putchar(toupper(yytext[i])); //to convert each character to uppercase
	      	i++;
	     	}
	     	
	      
	      printf("\nLOWER CASE: ");
	      i=0;
	      while(yytext[i])
	     	{ 
	      	putchar(tolower(yytext[i])); //to convert each character to lowercase
	      	i++;
	     	}
	     	
	      printf("\nTOGGLE CASE: ");
	      i=0;
	      while(yytext[i])
	     	{ 
	     	if(islower(yytext[i]))
	     		putchar(toupper(yytext[i]));
	     	else
	     		putchar(tolower(yytext[i]));
	      	i++;
	     	}
	     	
	      printf("\nSENTENCE CASE: ");
	      if(islower(yytext[0]))
	      		putchar(toupper(yytext[0]));
	      else
			putchar(yytext[0]);
	      i=1;	
	      while(yytext[i])
	     	{ 
	     		putchar(tolower(yytext[i]));
	      		i++;
	     	}
	     }
%%
int main()
{
	
	yylex();
	return(0);
}
int yywrap(){}
/*
shubham@shubham-HP-15-Notebook-PC:~/Desktop/website/CL1$ lex A4_5.l
shubham@shubham-HP-15-Notebook-PC:~/Desktop/website/CL1$ gcc lex.yy.c 
shubham@shubham-HP-15-Notebook-PC:~/Desktop/website/CL1$ ./a.out
My name is Shubham Singhal
UPPER CASE: MY NAME IS SHUBHAM SINGHAL
LOWER CASE: my name is shubham singhal
TOGGLE CASE: mY NAME IS sHUBHAM sINGHAL
SENTENCE CASE: My name is shubham singhal

*/

longest string

%{
	#include<stdio.h>
	#include<string.h>
	int len=0;
	char long_String[100];
%}

%%
[A-Za-z0-9]+ { if(len<strlen(yytext))
	       {
	       		len=strlen(yytext);
	       		for(int i=0;yytext[i];i++)
	       			long_String[i]=yytext[i];
	       }
	     }
[\n] {printf("\n Longest String is %s of length %d",long_String,len);}
%%
int  main()
{
	yylex();
	return(0);
}
int yywrap(){}	   
/*
shubham@shubham-HP-15-Notebook-PC:~/Desktop/website/CL1$ lex A4_6.l
shubham@shubham-HP-15-Notebook-PC:~/Desktop/website/CL1$ gcc lex.yy.c 
shubham@shubham-HP-15-Notebook-PC:~/Desktop/website/CL1$ ./a.out
My name is Shubham
   
 Longest String is Shubham of length 7 
 */ 
	
Calculator
Calci.l

%{
	#include<stdio.h>
	#include "y.tab.h" //this is included because SIN, COS, TAN and SQRT token declaration is in y.tab.h file

%}



%%
sin			{
				return(SIN); //return SIN token to parser
			}
cos			{
				return(COS); //return COS token to parser
			}
tan			{
				return(TAN); //return TAN token to parser
			}
sqrt			{
				return(SQRT);//return SQRT token to parser
			}
[a-zA-Z]+	 	{			
			 ;// return nothing
			}
			
[0-9]+			{
				yylval.p=atof(yytext);//atof(ASCII to float conversion)
						     // yylex has a return type of int that returns a token
						     //Values associated with the token are returned by lex in variable yylval and and p is define in calcirules as double(union)				
				return (NUM); //return NUM as token whose value is in yylval.p  
			}
			
[0-9]+\.[0-9]*		{
				//same as above it is used for floating tokens
				yylval.p=atof(yytext);				
				return (NUM);
			}
[=+*;/\(\)\-]		{
				return (yytext[0]);//yytext holds the text matched by the current token. So yytext[0] holds the first character of the text matched by the current token. Sometimes you have a rule which can match different texts so you need to get the real text matched like for variable names or you have a rule to match all arithmetic operations.
			}
[ \t\n]+		{   }
.			{printf("Lexical error");}
%%

calciRules.y
%{
	#include<stdio.h>
	#include<math.h>
	int yylex(); //To remove  the warning ( basically used remove implicit declaration)
	int yyerror();//To remove  the warning ( basically used remove implicit declaration) (TIP: If not understand please comment these two line and run the program
	
%}
//The purpose of the union is to allow storing different kind of objects into nodes emitted by flex.
//For more explaination go to https://stackoverflow.com/questions/1853204/yylval-and-union
%union
{
	double p;
}
%token <p> NUM //defining NUM as token whose datatype is p
%token  SIN COS TAN SQRT //defining token
/*
 The precedences and associativities are attached to tokens in the declarations section. This is done by a series of lines beginning with a Yacc keyword: %left, %right, or %nonassoc, followed by a list of tokens. All of the tokens on the same line

are assumed to have the same precedence level and associativity; the lines are listed in order of increasing precedence or binding strength. Thus,

        %left  '+'  '-'
        %left  '*'  '/'

describes the precedence and associativity of the four arithmetic operators. Plus and minus are left associative, and have lower precedence than star and slash, which are also left associative. The keyword %right is used to describe right associative operators, and the keyword %nonassoc is used to describe operators, like the operator .LT. in Fortran, that may not associate with themselves;
*/
%left '+' '-'
%left '*' '/'
%type <p> E //gives an individual type for the values associated with each part of the grammar,


%%
Edash:E';'{printf("\n=%f\n",$1); }//$1 represent E
	|Edash E';'{printf("\n=%f\n",$2);} //$2 represent E
	;
E: 	E'+'E 	{$$=$1+$3;}//$$ it is for LHS E and $1 is for 2st E and 3rd E  
	|E'-'E 	{$$=$1-$3;}
	|E'*'E 	{$$=$1*$3;}
	|E'/'E 	{$$=$1/$3;}
	|NUM	{$$=$1;}
	|'('E')'	{$$=$2;}
	|SIN'('E')'		{$$ = sin($3*22/(180*7));}
	|COS'('E')'		{$$ = cos($3*22/(180*7));}
	|TAN'('E')'		{$$ = tan($3*22/(180*7));}
	|SQRT'('E')'		{$$ = sqrt($3);}
	;
%%

int main()
{
	yyparse();
	return 0;
}
/*
	 Actions, C declarations and code

	$$ 	resulting value for any part of the grammar
	$1, $2, etc. 	values from sub-parts of the grammar
	yyparse 	routine created by YACC from (expected input, action) lists.
  		(It actually returns a value indicating if it failed to recognise the input.)
	yylex 	routine called by yyparse for all its input.
  		We are using getchar, which just reads characters from the input.
	yyerror 	routine called by yyparse whenever it detects an error in its input.
*/

int yyerror (char *s) {fprintf (stderr, "%s\n", s);}// to display the error if persists
/* OUTPUT
	shubham@shubham-HP-15-Notebook-PC:~/Desktop/CL1/Final$ lex calci.l            (this will create lex.yy.c)
shubham@shubham-HP-15-Notebook-PC:~/Desktop/CL1/Final$ yacc -d -v calciRules.y       (-d for creating y.tab.h in same directory , -v is used to create y.output file which contain all states function of LALR parser and this line will produce y.tab.c file)
shubham@shubham-HP-15-Notebook-PC:~/Desktop/CL1/Final$ gcc lex.yy.c y.tab.c -ll -ly -lm (-ll to include lex library -ly to include yacc library and -lm to include maths library)
shubham@shubham-HP-15-Notebook-PC:~/Desktop/CL1/Final$ ./a.out
1+2;

=3.000000
3-4;

=-1.000000
3*2;

=6.000000
9/3;

=3.000000
sin(0);

=0.000000
cos(0);

=1.000000
tan(0);

=0.000000
sqrt(16);

=4.000000
^Z
[1]+  Stopped                 ./a.out
shubham@shubham-HP-15-Notebook-PC:~/Desktop/CL1/Final$
*/

	
