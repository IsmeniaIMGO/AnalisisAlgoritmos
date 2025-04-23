package ejercicios;
public class Matriz {
    


    //Recorre la matriz completa y verifica si es simetrica
    public boolean esSimetrica1 ( double[][] arreglo )
    {

    boolean aux = true;

    for (int i = 0; i < arreglo.length && aux==true; i++ )
    {

    for (int j = 0; j < arreglo[0].length && aux==true ; j++ )
    {

    if (arreglo[i][j]!= arreglo[j][i] && i!=j)
    {

    aux=false;

    }

    }

    }
    return aux;
    }


    //Recorre la matriz solo la mitad sobre la diagonal principal y verifica si es simetrica
    public boolean esSimetrica2 (double[][] arreglo)
    {

    for (int i = 0; i < arreglo.length; i++)
    {

    for (int j = i + 1; j < arreglo.length; j++)
    {

    if (arreglo[i][j] != arreglo[j][i])
    {

    return false;

    }

    }

    }
    return true;

    }


    //Recorre la matriz solo la mitad debajo de la diagonal principal y verifica si es simetrica
    public boolean esSimetrica3(double[][] arreglo) {
        int n = arreglo.length;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < i; j++) {
                if (arreglo[i][j] != arreglo[j][i]) {
                    return false;
                }
            }
        }
        return true;
    }



}
