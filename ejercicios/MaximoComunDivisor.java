package ejercicios;

public class MaximoComunDivisor {
    
public int determinarMCD1(int a,int b)

{

int valora, valorb;
valora = a;
valorb = b;

while (valora!=valorb)
{

if(valora<valorb)
{

valorb = valorb - valora;

}
else
{

valora = valora - valorb;

}

}
return valora;

}




public int determinarMCD2(int a, int b)
{

int resultado = 1;
boolean valor = false;

for (int i = b; i > 0; i--)
{
if (a%i==0 && b%i==0 && valor!=true)
{

resultado = i;
valor = true;

}
}
return resultado;

}



public int determinarMCD3(int a, int b)
{
int temp;
while (b != 0)
{
temp = b;
b = a % b;
a = temp;
}
return a;
}











}
