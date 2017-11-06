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
