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
