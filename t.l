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

Parser.l

%{
	#include "y.tab.h" //including the header file where token(eg FOR,EQU etc) definition is define
%}

%%
for {return FOR;}
"=" {return EQU;}
"++" {return INC;}
-- {return DEC;}
"<=" {return LE;}
>= {return GE;}
"<" {return LT;}
> {return GT;}
!= {return NE;}
== {return EQ;}
"(" {return OPBR;}
")" {return CLBR;}
";" {return SEMIC;}
[0-9]+ {yylval.p=atoi(yytext);//ASCII to integer conversion of yytext
	 return NUM;} 
[int |float |double |long ]*[a-zA-Z]+ { return ID;}
%%


parser.y

%{
	#include<stdio.h>
	#include<stdlib.h>
	//To avoid the warning we include the below definitions
	int yylex();
	void yyerror(const char *s);
%}
%union
{
	double p;
}
//Declaration of tokens
%token FOR EQU INC DEC LE GE LT GT NE EQ OPBR CLBR SEMIC NUM ID
//Operator precedence(in ascending order) and associativity 
%right EQU
%left GE NE LT GT LE EQ
//RULES
%%

S: ST {printf("\nACCEPTED\n");
	exit(0);}//if starting symbol is reached it means it is accepted
ST: FOR OPBR exp1 SEMIC exp2 SEMIC exp3 CLBR  //for(exp1;exp2;exp3)
    | FOR OPBR SEMIC SEMIC CLBR   //for(;;)
exp1: ID EQU ID // eg a=b
    | ID EQU NUM// eg a=1
exp2: ID RELOP ID 
    | ID RELOP NUM
exp3: ID INC
    | ID DEC
RELOP : LT
	| GT
	| LE
	| GE
	| NE
	| EQ
	;
%%
int main()
{
	yyparse();//start the parsing
}
void yyerror(const char *s){printf("\nREJECTED\n");}//if it doesn't reaches start symbol the line is rejected
/* OUTPUT
shubham@shubham-HP-15-Notebook-PC:~/Desktop/CL1$ lex parser.l 
shubham@shubham-HP-15-Notebook-PC:~/Desktop/CL1$ yacc -d parser.y    (-d is to make y.tab.h file in same directory)
shubham@shubham-HP-15-Notebook-PC:~/Desktop/CL1$ gcc  lex.yy.c y.tab.c -ll (-ll include the lex library so that yywrap error can be removed)
shubham@shubham-HP-15-Notebook-PC:~/Desktop/CL1$ ./a.out 
for(int i=0;i<4;i++)

ACCEPTED
shubham@shubham-HP-15-Notebook-PC:~/Desktop/CL1$ ./a.out 
for(i=0,i<4;i++)
,
REJECTED
shubham@shubham-HP-15-Notebook-PC:~/Desktop/CL1$ 
*/

Subset of C

	%{
		#include<stdio.h>
		FILE *fp;
		int flag=0;
		char var[20];
	%}
	letter [a-zA-Z]
	digit [0-9] 
	%%

		['#'][" "".""<"a-z">"]* { printf("\n%s : Header",yytext); }
		['{'] {printf("\n%s : Start of Block",yytext);}
		['}'] {printf("\n%s : End of Block",yytext);}
		"void"|"int"|"double"|"float"|
		"auto"|"break"|"case"|"const"|
		printf("\n%s : Keyword",yytext);}
		"printf"|"scanf" { printf("\n%s : Built in function",yytext);}
		[a-z]+['('][a-z" "","]*[')'] { printf("\n%s : Function",yytext);}
		[a-z|"_"]+[a-z0-9"_"]*"["[0-9]
		[a-z|_]+[a-z0-9_]* { printf("\n%s : Variable",yytext);}
		";" {printf("\n%s : Delimiter",yytext);}

		"*"|"+"|"-"|"/" { printf("\n%s : Arithmatic Operator”,yytext);}

		{digit}*{letter}*"$"{digit}*{
		{digit}*{letter}*"]"{digit}*{
		{digit}*{letter}*"("{digit}*{
		{digit}*{letter}*")"{digit}*{
		{digit}*{letter}*"#"{digit}*{
		{digit}*{letter}*"."{digit}*{
		{digit}*{letter}*"\""{digit}*{
		{digit}*{letter}*"\\"{digit}*{
		{digit}*{letter}*","{digit}*{
		{digit}+{letter}+ {printf("\n%s : Invalid variable name ",yytext); }
	
		"%d" |
		"%s" |
		"%c" |
		"%f" |
		"%e" {printf("\n%s : is a format specifier",yytext); }
		. {printf("");}
	%%

	void main()
	{
		fp=fopen("a.c","r");
		yyin = fp;
		yylex();
	}

Input:- sk.c
	#include <stdio.h> 
	int sum(int a,int b)
	{
		printf("%d", a+b);
	} 
	int main()
	{
		int a[]; 
		float b$a;
		int b; 
		return a; 
	}

Output:-
	apr@ubuntu:~$ lex 5.l
	apr@ubuntu:~$ cc lex.yy.c -ll
	apr@ubuntu:~$ ./a.out
	#include <stdio.h> : Header
	int : Data Type
	sum(int a,int b) : Function
	{ : Start of Block
	printf : Built in function
	%d : is a format specifier
	a : Variable
	+ : Arithmatic Operator
	b : Variable
	; : Delimiter
	} : End of Block
	int : Data Type
	main() : Function
	{ : Start of Block
	int : Data Type
	a[] : Array
	; : Delimiter
	float : Data Type
	b$a : Invalid variable name 
	; : Delimiter
	int : Data Type
	b : Variable
	; : Delimiter
	return : Keyword
	a : Variable
	; : Delimiter
	} : End of Block
Quicksort

#include<iostream>
#include<stdlib.h>
#include<time.h>
#include<omp.h>

using namespace std;
int n;


int partition(int a[],int low,int high)//array its low and high
{
        
	int pivot=a[high];	//making pivot position to be highest
	int i=low-1,j,temp; //assigning i to low-1
	for(j=low;j<high;j++)//traversing j to low to high
	{
		if(a[j] <= pivot)
		{
			i++;
			temp=a[i];//swapping based on pivot
			a[i]=a[j];
			a[j]=temp;
		}
	}
	//finally swapping with exact position of pivot elements  
	temp=a[i+1];
	a[i+1]=a[high];
	a[high]=temp;
	
	return i+1;
}
void quicksortparallel(int arr[],int low,int high)
{
	if(low<high)//if size of array is atleast 1
	{
		int pi=partition(arr,low,high);//getting the index position of pivot after placeing in its final position
		#pragma omp parallel//The omp parallel sections directive effectively combines the omp parallel and omp sections directives. This directive lets you define a parallel region containing a single sections directive in one step
		{
			quicksortparallel(arr,low,pi-1);//calling quiksort for left sub array before pivot
			quicksortparallel(arr,pi+1,high);//calling quicksort for right sub array after pivot
			
		}
	}
}
void quicksortserial(int arr[],int low,int high)
{
	if(low<high)
	{
			int pi=partition(arr,low,high);//getting the index position of pivot after placeing in its final position
			quicksortserial(arr,low,pi-1);//calling quiksort for left sub array before pivot
			quicksortserial(arr,pi+1,high);//calling quicksort for right sub array after pivot
			
		
	}
}
int main()
{
	
	cout<<"\nEnter total number of elements : ";
	cin>>n;
	
	int a[n],b[n]; //a array for serial and b array for parallel
	
	for(int i=0;i<n;i++)
        {
        	a[i]=rand()%1000;//a[i] will contain any random value from 0-999
        	b[i]=a[i];//same number is copy to b array
        }
        
        clock_t start_t, end_t, total_t;
        
        start_t=clock();
	quicksortserial(a,0,n-1); //Calling Serial quick sort array
	end_t=clock();
	cout<<"\n\nSorted Array in serial is\n\n";
	for(int i=0;i<n;i++)
        {
        	cout<<a[i]<<" ";
        }
        cout<<"\n\nTime taken in serial is "<<(double)(end_t-start_t)/CLOCKS_PER_SEC<<" seconds\n"; //calculating time in serial array
        
        start_t=clock();
	quicksortparallel(b,0,n-1);
	end_t=clock();
	cout<<"\n\nSorted Array in parallel is\n\n";//calling Parallel quick sort array
	for(int i=0;i<n;i++)
        {
        	cout<<b[i]<<" ";
        }
        cout<<"\n\nTime taken in parallel is "<<(double)(end_t-start_t)/CLOCKS_PER_SEC<<" seconds\n";
}

/*  OUTPUT

shubham@shubham-HP-15-Notebook-PC:~/Desktop/CL1$ g++ quick.cpp 
shubham@shubham-HP-15-Notebook-PC:~/Desktop/CL1$ ./a.out 

Enter total number of elements : 1000


Sorted Array in serial is

0 0 2 2 4 6 8 9 10 11 11 12 16 17 17 18 19 21 21 21 21 22 23 25 27 27 28 29 30 30 30 31 32 33 34 36 36 36 39 40 41 42 42 42 43 43 46 47 49 49 50 51 52 53 54 55 57 57 57 58 59 59 59 60 62 63 67 67 69 71 71 72 73 74 74 80 81 81 81 81 81 82 82 84 84 84 84 86 87 87 88 90 90 90 91 93 94 95 97 97 97 98 99 100 100 105 107 109 109 114 115 116 117 117 120 121 122 122 123 124 124 125 126 126 127 127 127 127 128 130 131 131 133 134 134 135 136 137 139 139 142 143 144 147 149 149 150 151 152 153 154 154 155 157 157 157 159 159 163 167 168 170 171 171 172 172 172 173 176 177 178 179 179 179 181 181 181 183 184 188 189 189 189 190 190 190 193 195 195 196 197 197 198 199 199 202 202 204 205 205 205 206 207 209 210 211 211 211 214 215 217 217 218 218 219 222 223 224 224 225 226 226 227 228 228 228 229 231 231 231 232 232 233 234 234 235 235 236 237 237 238 244 245 248 249 250 253 253 254 255 255 258 259 260 261 262 262 266 266 269 269 269 270 270 270 272 273 274 275 276 278 278 280 281 281 282 283 283 284 285 285 286 289 289 290 291 291 292 292 292 294 296 297 297 298 298 299 299 301 301 303 303 304 305 305 306 308 308 309 309 310 311 312 312 313 314 314 315 317 320 321 321 324 324 324 325 325 326 327 328 333 334 335 335 335 336 336 336 337 338 338 338 339 340 340 340 340 342 342 343 343 346 346 347 348 348 350 350 350 353 355 355 355 358 358 360 360 362 363 363 364 365 365 367 367 367 368 368 368 368 368 369 370 372 373 375 376 376 377 378 378 379 379 379 379 379 382 382 383 385 386 386 388 390 390 393 393 395 396 398 398 399 403 403 404 404 404 407 412 412 412 413 414 415 415 416 417 417 418 421 421 421 422 422 425 426 426 427 428 428 428 429 429 431 432 433 433 434 434 435 436 437 437 438 440 441 443 443 444 444 445 445 451 452 456 457 458 459 460 460 462 464 465 466 467 468 470 471 474 476 478 479 481 483 483 483 485 486 486 487 488 490 490 491 491 492 492 493 494 497 497 498 499 499 500 500 500 503 503 504 504 505 505 506 506 506 507 512 516 516 518 518 521 522 522 524 524 525 525 526 528 528 528 528 528 529 529 529 530 532 532 535 536 537 537 538 538 539 539 540 541 542 542 543 545 550 551 551 552 552 555 555 556 559 560 560 563 563 566 566 567 567 567 567 568 569 569 570 570 571 573 573 574 574 577 578 579 580 581 582 582 583 584 586 586 587 587 589 590 590 590 593 593 593 595 596 599 600 601 603 604 605 606 606 607 610 610 611 613 613 614 614 618 618 618 619 620 621 621 622 622 624 624 625 626 626 627 629 630 631 633 637 637 639 639 640 640 641 641 643 644 647 647 648 649 651 651 652 653 657 657 658 659 660 661 661 667 668 669 672 672 675 676 677 677 681 681 682 682 682 683 683 684 685 685 685 686 688 689 690 690 691 692 697 698 699 699 701 703 705 708 708 708 709 710 710 711 713 713 713 714 715 715 717 720 720 721 722 722 723 723 725 726 728 729 729 729 729 730 732 732 732 735 736 736 739 740 743 743 743 744 746 746 747 748 750 753 754 754 754 756 756 757 759 761 762 763 763 763 764 764 768 769 770 770 771 772 773 774 775 776 776 776 776 776 777 777 782 783 783 784 784 786 787 788 788 789 791 793 793 794 794 795 795 796 796 797 797 801 802 804 805 805 805 805 806 808 808 810 811 812 813 813 814 814 815 818 818 818 819 819 820 821 822 825 826 827 828 829 829 830 836 839 839 840 841 842 846 846 847 848 849 850 850 850 851 853 856 856 856 857 857 857 857 858 858 859 860 860 862 862 862 865 865 868 868 871 872 873 873 873 875 878 881 882 884 886 886 887 888 888 888 890 890 892 892 892 894 895 898 898 898 899 899 900 902 902 904 904 904 904 907 908 910 911 914 915 916 917 917 918 919 919 920 921 921 924 924 925 925 926 926 927 928 928 929 930 930 931 932 932 933 933 934 936 936 939 940 943 944 945 946 947 949 949 950 950 951 952 954 954 954 955 955 955 956 958 959 959 961 962 963 964 965 967 969 970 970 971 972 973 975 976 977 977 980 981 981 982 982 984 984 987 987 988 989 990 990 991 993 993 994 994 996 996 996 996 996 997 999 

Time taken in serial is 0.000397 seconds


Sorted Array in parallel is

0 0 2 2 4 6 8 9 10 11 11 12 16 17 17 18 19 21 21 21 21 22 23 25 27 27 28 29 30 30 30 31 32 33 34 36 36 36 39 40 41 42 42 42 43 43 46 47 49 49 50 51 52 53 54 55 57 57 57 58 59 59 59 60 62 63 67 67 69 71 71 72 73 74 74 80 81 81 81 81 81 82 82 84 84 84 84 86 87 87 88 90 90 90 91 93 94 95 97 97 97 98 99 100 100 105 107 109 109 114 115 116 117 117 120 121 122 122 123 124 124 125 126 126 127 127 127 127 128 130 131 131 133 134 134 135 136 137 139 139 142 143 144 147 149 149 150 151 152 153 154 154 155 157 157 157 159 159 163 167 168 170 171 171 172 172 172 173 176 177 178 179 179 179 181 181 181 183 184 188 189 189 189 190 190 190 193 195 195 196 197 197 198 199 199 202 202 204 205 205 205 206 207 209 210 211 211 211 214 215 217 217 218 218 219 222 223 224 224 225 226 226 227 228 228 228 229 231 231 231 232 232 233 234 234 235 235 236 237 237 238 244 245 248 249 250 253 253 254 255 255 258 259 260 261 262 262 266 266 269 269 269 270 270 270 272 273 274 275 276 278 278 280 281 281 282 283 283 284 285 285 286 289 289 290 291 291 292 292 292 294 296 297 297 298 298 299 299 301 301 303 303 304 305 305 306 308 308 309 309 310 311 312 312 313 314 314 315 317 320 321 321 324 324 324 325 325 326 327 328 333 334 335 335 335 336 336 336 337 338 338 338 339 340 340 340 340 342 342 343 343 346 346 347 348 348 350 350 350 353 355 355 355 358 358 360 360 362 363 363 364 365 365 367 367 367 368 368 368 368 368 369 370 372 373 375 376 376 377 378 378 379 379 379 379 379 382 382 383 385 386 386 388 390 390 393 393 395 396 398 398 399 403 403 404 404 404 407 412 412 412 413 414 415 415 416 417 417 418 421 421 421 422 422 425 426 426 427 428 428 428 429 429 431 432 433 433 434 434 435 436 437 437 438 440 441 443 443 444 444 445 445 451 452 456 457 458 459 460 460 462 464 465 466 467 468 470 471 474 476 478 479 481 483 483 483 485 486 486 487 488 490 490 491 491 492 492 493 494 497 497 498 499 499 500 500 500 503 503 504 504 505 505 506 506 506 507 512 516 516 518 518 521 522 522 524 524 525 525 526 528 528 528 528 528 529 529 529 530 532 532 535 536 537 537 538 538 539 539 540 541 542 542 543 545 550 551 551 552 552 555 555 556 559 560 560 563 563 566 566 567 567 567 567 568 569 569 570 570 571 573 573 574 574 577 578 579 580 581 582 582 583 584 586 586 587 587 589 590 590 590 593 593 593 595 596 599 600 601 603 604 605 606 606 607 610 610 611 613 613 614 614 618 618 618 619 620 621 621 622 622 624 624 625 626 626 627 629 630 631 633 637 637 639 639 640 640 641 641 643 644 647 647 648 649 651 651 652 653 657 657 658 659 660 661 661 667 668 669 672 672 675 676 677 677 681 681 682 682 682 683 683 684 685 685 685 686 688 689 690 690 691 692 697 698 699 699 701 703 705 708 708 708 709 710 710 711 713 713 713 714 715 715 717 720 720 721 722 722 723 723 725 726 728 729 729 729 729 730 732 732 732 735 736 736 739 740 743 743 743 744 746 746 747 748 750 753 754 754 754 756 756 757 759 761 762 763 763 763 764 764 768 769 770 770 771 772 773 774 775 776 776 776 776 776 777 777 782 783 783 784 784 786 787 788 788 789 791 793 793 794 794 795 795 796 796 797 797 801 802 804 805 805 805 805 806 808 808 810 811 812 813 813 814 814 815 818 818 818 819 819 820 821 822 825 826 827 828 829 829 830 836 839 839 840 841 842 846 846 847 848 849 850 850 850 851 853 856 856 856 857 857 857 857 858 858 859 860 860 862 862 862 865 865 868 868 871 872 873 873 873 875 878 881 882 884 886 886 887 888 888 888 890 890 892 892 892 894 895 898 898 898 899 899 900 902 902 904 904 904 904 907 908 910 911 914 915 916 917 917 918 919 919 920 921 921 924 924 925 925 926 926 927 928 928 929 930 930 931 932 932 933 933 934 936 936 939 940 943 944 945 946 947 949 949 950 950 951 952 954 954 954 955 955 955 956 958 959 959 961 962 963 964 965 967 969 970 970 971 972 973 975 976 977 977 980 981 981 982 982 984 984 987 987 988 989 990 990 991 993 993 994 994 996 996 996 996 996 997 999 

Time taken in parallel is 0.000395 seconds
shubham@shubham-HP-15-Notebook-PC:~/Desktop/CL1$ 
shubham CL1 $ 
*/

Write a program to implement Binary Search in C++/ Java/ Python/Scala using Divide and Conquer Strategy

#include <iostream>
using namespace std;

int binarySearch(int a[],int s, int f, int l)
{
  if (l >= f)  
  {  
      int mid = (f + l) / 2;

      if (s == a[mid])
        return mid;

      else if (s < a[mid])
        return binarySearch(a, s, f, mid - 1);

      else 
        return binarySearch(a, s, mid + 1, l);
   }
   else
     return -1;
}

int main()
{
  
  int n,s;
  cout<<"\n Enter The No. of Elements in array = ";
  cin>>n; 

  int a[n];
  cout<<"Enter The Elements=\n";
  for(int i=0;i<n;i++)
	cin>>a[i];

  int f= 0;		//first element position
  int l = n-1;		//last element position in array

  cout << "Please enter a number to find: " << endl;
  cin >> s;

  int res = binarySearch(a, s, f, l);
  if ( res == -1 )
  {
      cout << "number not found" <<endl;
  }
  else
  {
      cout <<" number is found in position " << res + 1 << endl;
  }

  return 0;
}

MergeSort

#include<stdlib.h>
#include<stdio.h>
#include<time.h>
// First subarray is arr[l..m]
// Second subarray is arr[m+1..r]
void merge(int arr[], int l, int m, int r)
{
	int i, j, k;
	int n1 = m - l + 1; 	//size of left array
	int n2 = r - m; 		//size of right array
	int L[n1], R[n2];
	for (i = 0; i < n1; i++)
	L[i] = arr[l + i];
	for (j = 0; j < n2; j++)
	R[j] = arr[m + 1+ j];
	// arr[l..r]
	i = 0; 			// Initial index of first subarray
	j = 0; 			// Initial index of second subarray
	k = l; 			// Initial index of merged subarray
	while (i < n1 && j < n2)
	{
		if (L[i] <= R[j])
		{
			arr[k] = L[i];
			i++;
		}
		else
		{
			arr[k] = R[j];
			j++;
		}
		k++;
	}
	while (i < n1)	 /* Copy the remaining elements of L[], if there are any */
	{
		arr[k] = L[i];
		i++;
		k++;
	}
	while (j < n2) 	/* Copy the remaining elements of R[], if there are any */
	{
		arr[k] = R[j];
		j++;
		k++;
	}
}
void mergeSort(int arr[], int l, int r)
{
	if (l < r)
	{
		int m = l+(r-l)/2;
		mergeSort(arr, l, m);
		mergeSort(arr, m+1, r);
		merge(arr, l, m, r);
	}
}
int main()
{
	time_t t;
	//Intializes random number generator
	srand((unsigned) time(&t));
	int N, i, element, ch;
	printf("Enter the number of elements: \n");
	scanf("%d",&N);
	int arr[N];
	int arr_size = N;
	do
	{
		printf("\nTaking %d input randomly\n",N);
		for(i = 0 ; i < N ; i++ )
		arr[i] = rand()%10000;
		printf("Sorting");
		clock_t begin = clock();
		mergeSort(arr, 0, arr_size - 1);
		clock_t end = clock();
		double time1 = difftime(end, begin)/3600;
		printf("\nTime required is : %f\n",time1);
		printf("Do you want to continue (Yes=1, No=0) : ");
		scanf("%d",&ch);
	}
	while(ch == 1);
	return 0;
}

Output :-

100 elements

sourabh@sourabh-VPCEL15EN:~CL1$ gcc merge.c
sourabh@sourabh-VPCEL15EN:~CL1$ ./a.out
Enter the number of elements:
100
Taking 100 input randomly
Sorting
Time required is : 0.005833
Do you want to continue (Yes=1, No=0) : 1
Taking 100 input randomly
Sorting
Time required is : 0.004167
Do you want to continue (Yes=1, No=0) : 1
Taking 100 input randomly
Sorting
Time required is : 0.007778
Do you want to continue (Yes=1, No=0) : 0

1000 elements
sourabh@sourabh-VPCEL15EN:~CL1$ ./a.out
Enter the number of elements:
1000
Taking 1000 input randomly
Sorting
Time required is : 0.058889
Do you want to continue (Yes=1, No=0) : 1
Taking 1000 input randomly
Sorting
Time required is : 0.050000
Do you want to continue (Yes=1, No=0) : 1
Taking 1000 input randomly
Sorting
Time required is : 0.051944
Do you want to continue (Yes=1, No=0) : 0

10000 elements
sourabh@sourabh-VPCEL15EN:~CL1$ ./a.out
Enter the number of elements:
10000
Taking 10000 input randomly
Sorting
Time required is : 0.663611
Do you want to continue (Yes=1, No=0) : 1
Taking 10000 input randomly
Sorting
Time required is : 0.587222
Do you want to continue (Yes=1, No=0) : 1
Taking 10000 input randomly
Sorting
Time required is : 0.705000
Do you want to continue (Yes=1, No=0) : 0

KNN

#include<iostream>
#include<fstream>
#include<math.h>
using namespace std;

class data
{
	public:
		float sLen,sWid,pLen,pWid,dist; //sepal length,sepal width,petal length ,petal width
		string fSpecies; //featured species
};
int main()
{
	int k;
	cout<<"\nEnter value of k(nearest neighbour to be compared): ";
	cin>>k;
	
	data d[150],test; //d[150] as there are total 150 data set in iris
	
	cout<<"Enter the testdata(for identification of species using knn):\nSepal Length:  ";
	cin>>test.sLen;
	cout<<"Sepal Width: ";
	cin>>test.sWid;
	cout<<"Petal Length: ";
	cin>>test.pLen;
	cout<<"Petal Width: ";
	cin>>test.pWid;
	
	
	ifstream in;
	in.open("iris.csv");
	
	//Taking input from iris file
	for(int i=0;i<150;i++)
	{
		in>>d[i].sLen>>d[i].sWid>>d[i].pLen>>d[i].pWid>>d[i].fSpecies;	
	}
	
	//calculating distance from test data set to each data set in iris
	float dist[4];
	for(int i=0;i<150;i++)
	{
		//cout<<d[i].sLen<<" "<<d[i].sWid<<" "<<d[i].pLen<<" "<<d[i].pWid<<"\n";
		dist[0]=test.sLen-d[i].sLen;
		dist[1]=test.sWid-d[i].sWid;
		dist[2]=test.pLen-d[i].pLen;
		dist[3]=test.pWid-d[i].pWid;
		
		d[i].dist=sqrt(dist[0]*dist[0]+dist[1]*dist[1]+dist[2]*dist[2]+dist[3]*dist[3]);	
	}
	
	//Sorting the data set according to distance in bubble sort
	data temp;
	for(int i=0;i<150;i++)
	{
		for(int j=0;j<149;j++)
		{
			if(d[j].dist>d[j+1].dist)	
			{
				temp=d[j];
				d[j]=d[j+1];
				d[j+1]=temp;
			}
		}
	}
	//Displaying the data set
	cout<<"\n Data Sets according to increase in distance\n\n";
	for(int i=0;i<150;i++)
	{
		cout<<d[i].sLen<<" "<<d[i].sWid<<" "<<d[i].pLen<<" "<<d[i].pWid<<" "<<d[i].fSpecies<<" "<<d[i].dist<<"\n";
	}
	
	//Finding the nearest neighbour through count of each species
	int setCnt=0,verCnt=0,virCnt=0;
	for(int i=0;i<k;i++)
	{
		if(d[i].fSpecies=="Iris-setosa,")
			setCnt++;
		else if (d[i].fSpecies=="Iris-versicolor,")
			verCnt++;
		else
			virCnt++;
	}
	cout<<"\n"<<setCnt<<" "<<verCnt<<" "<<virCnt<<"\n";
	
	//Displaying test dataset as the species according to maximum number of nearest neighbour species
	if(setCnt>verCnt && setCnt>virCnt)
            cout<<"\nThe class predicted for test data is: Iris-setosa";
        else if(verCnt>setCnt && verCnt>virCnt)
            cout<<"\nThe class predicted for test data is: Iris-versicolor";
        else if(virCnt>verCnt && virCnt>setCnt)
            cout<<"\nThe class predicted for test data is: Iris-virginica";
        else
        	cout<<"\nThe class can't be predicted for test data!";
	cout<<"\n\n";
	
	
}

PROBLEM STATEMENT :- Write a Program for Intermediate Code Generation for subset of C (If loop) using 					LEX & YACC
 CODE

// LEX FILE :-

%{
 #include<stdio.h>
 #include<ctype.h>	
 #include<stdlib.h>
#include<string.h>
 #include "y.tab.h" 
%}

%%
"if"		{strcpy(yylval.cval,yytext);return IF;}
[0-9]+		{yylval.dval=atoi(yytext);return DIGIT;}
[a-z]+		{strcpy(yylval.cval,yytext);return ID;}
"("|")"		{return *yytext;}
[{]		{strcpy(yylval.cval,yytext);return STCB;}
[}]		{strcpy(yylval.cval,yytext);return ENCB;}
"<"|">"		{strcpy(yylval.cval,yytext);return RELOP;}	
[=]		{strcpy(yylval.cval,yytext);return EQUAL;}
[+-]		{strcpy(yylval.cval,yytext);return PLUS;}
[;]		{strcpy(yylval.cval,yytext);return SEMI;}
%%




// YACC FILE :-

%{
#include<stdio.h>
#include<ctype.h>
#include<stdlib.h>
#include<string.h>
/*#include "lex.yy.c"*/
struct icode
{
  char op1[20],op2[20],opr[20],result[20];
  //int indx;
};
int icnt=1;
struct icode ic[10];
int var;
char tmp[20];
void add_into_table(char op1[20],char op2[20],char opr[20],char result[20]); 
void disp();
void yyerror(char *s);
int yywrap();
%}
%union { char cval[10];
	  int dval;	
	}
%token<cval> ID IF STCB ENCB RELOP SEMI EQUAL PLUS
%token<dval> DIGIT
%type<cval> S D E B A S1 
%left PLUS
%%

S:EXP	{disp();}
    ;
EXP:D'('E')'B
   ;
D:IF	
 ; 
E:ID RELOP ID	{
	          add_into_table($1,$3,$2,"t");
                  var=icnt+2;   //icnt=2
		  sprintf(tmp,"%d",var);
		  add_into_table("t","--","IF",tmp);
		}
  ;
B:STCB S1 ENCB		{
				  sprintf(tmp,"%d",icnt);		
				  strcpy(ic[3].result,tmp);
				}
  ;         
S1:ID EQUAL A SEMI		{add_into_table("tx","--","=",$1);}//icnt=5
  ;
A:ID	{strcpy($$,$1);}
 |DIGIT	{sprintf(tmp,"%d",$1);
         strcpy($$,tmp);}
 |A PLUS A	{var=icnt+3;
		 sprintf(tmp,"%d",var);
		 add_into_table("--","--","goto",tmp);  //icnt=4
		 add_into_table($1,$3,$2,"tx");		
		} 
 ;
%%

void add_into_table(char op1[20],char op2[20],char opr[20],char result[20])
 { 
   strcpy(ic[icnt].op2,op2);
   strcpy(ic[icnt].op1,op1);	
   strcpy(ic[icnt].opr,opr);
    strcpy(ic[icnt].result,result);
      icnt++; 
   printf("Entry Added");
 }

void disp()
 {
    int i,temp1,temp_indx;
  printf("\nQUADRUPLE  FORM");
  printf("\n---------------");
  printf("\nS.NO\tOperator\tOperand1\tOperand2\tResult\n\n");
   for(i=1;i<=icnt;i++)
    {
      printf("%d\t",i);	
      printf("%s\t\t",ic[i].opr);
      printf("%s\t\t",ic[i].op1);
      printf("%s\t\t",ic[i].op2);
      printf("%s\t\t",ic[i].result);
      printf("\n"); 
    }	 
 }
int main()
{
yyparse();
return 0;
}

void yyerror(char *s)
{
printf("\n%s",s);
}

int yywrap()
{
 return 1;
}


// OUTPUT :- 

ccompl10-08@ccompl10-08:~/Desktop$ lex icg.l
ccompl10-08@ccompl10-08:~/Desktop$ yacc icg.y -d
ccompl10-08@ccompl10-08:~/Desktop$ gcc lex.yy.c y.tab.c -ll -ly
ccompl10-08@ccompl10-08:~/Desktop$ ./a.out
if(a<b)
Entry AddedEntry Added
{
   a=a+b;
 Entry AddedEntry  Added
}


QUADRUPLE  FORM
---------------
S.NO	Operator	Operand1	Operand2	Result

1	<		a		b		t		
2	IF		t		--		4		
3	goto		--		--		6		
4	+		a		b		tx		
5	=		tx		--		a		
6	

N Queens

from math import *
import sys

x = {}
n = int(sys.argv[1])

def place(k, i):
    if (i in x.values()):
        return False
    j = 1
    while(j < k):
        if abs(x[j]-i) == abs(j-k):
            return False
        j+=1
    return True
def clear_future_blocks(k):
    for i in range(k,n+1):
       x[i]=None
def NQueens(k):
    for i in range(1, n + 1):
        clear_future_blocks(k)
        if place(k, i):
            x[k] = i
            if (k==n):
                for j in x:
                    print (x[j])
                print ('---------')
            else:
                NQueens(k+1)


NQueens(1)

Binary C

#include<stdio.h>
#include<stdlib.h>

//Recursive Binary Search to be applied on sorted array

int Binary_search(int search,int *a,int start,int end)
{

	if(start>end) //condition to stop the search and return not found
		return 0;
	int mid=(start+end)/2; //caluclating the mid position
	
	if(search>a[mid])//recursive calling right binary Search 
		Binary_search(search,a,mid+1,end);
	else if(search<a[mid])//Recursive calling left binary search
		Binary_search(search,a,start,mid-1);
	else if(a[mid]==search)//If found returning 1
		return 1;	
}

int main()
{
	int a[10], search, n;
	printf("\n\nEnter the 10 elements: ");
	for(int i=0; i<10; i++)
		{
			scanf("%d",&n);
			a[i]=n;
		}
	
	printf("\n\nEnter the search element: ");
	scanf("%d",&search);
	
	int found=Binary_search(search,a,0,9);
	
	if(found)
		printf("\n\nFound\n");
	else
	 	printf("\n\nNot Found\n");
}

MergeSort

#include<stdio.h>
#include<stdlib.h>

int merge(int *a,int start,int mid,int end)//taking the array with start,mid and end section and merging it
{
	int i=start; //index for first half array
	int j=mid+1; //index for second half array
	int k=start; //index for final sorted array
	int c[1000]; //temp array where sorted elements would be kept
	
	while(i<=mid && j<=end) //as the first half and second half are already sorted so the first element of each array is compared and are added to the sorted final array c
	{
		if(a[i]<a[j])
		{
			c[k]=a[i];
			k++;
			i++;
		}
		else
		{
			c[k]=a[j];
			k++;
			j++;
		}
	
	}
	while(i<=mid)//this is done to copy the remaining leftover elements to the sorted array c
	{
		c[k]=a[i];
		k++;
		i++;
	}
	while(j<=end)//this is done to copy the remaining leftover elements to the sorted array c
	{
		c[k]=a[j];
		k++;
		j++;
	}
	for(i=start;i<k;i++) //copying final array to the original array
		a[i]=c[i];
}


void mergesort(int *a,int start,int end) 
{
	if(start<end)// if array contain more than one elements
	{
		int mid=(start+end)/2; //Find the middle point of array which is to be divided in two equal half
		mergesort(a,start,mid);//Mergesort for unsorted first half
		mergesort(a,mid+1,end);//Mergesort for unsorted second half 
		merge(a,start,mid,end);//Merging the sorted first and second half
	}
		
}

int main()
{
	int n;
	printf("Enter no. of elements: ");
	scanf("%d",&n);
	
	int a[n],search;
	
	printf("\nUnsorted Merge Sort:\n\n"); 
	
	for(int i=0;i<n;i++)
	{
		a[i]=rand()%1000;//this will generate all the random number between 0 to 999 
		printf("%d ",a[i]);
	}
	mergesort(a,0,n-1); //calling of mergesort
	
	printf("\n\n Sorted array is : \n\n");
	for(int i=0;i<n;i++)
	{
		printf("%d ",a[i]);
	}
	{printf("\n");}
	
}
