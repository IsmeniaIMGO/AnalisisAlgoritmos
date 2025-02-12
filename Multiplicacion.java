public class Multiplicacion {
    

    public int[][] multiplicarMatriz1(int [][] A, int [][] B)
    {
        //Crear nueva matriz con el tamaño de las filas de A y las columnas de B
        int [][] matriz = new int [A.length][B[0].length]; 
        
        //Si el numero de columnas de A es igual al numero de filas de B
        if (A[0].length == B.length)
        {
            //Recorrer las filas de A
            for (int i = 0; i < A.length; i++)
            {
                //Recorrer las columnas de B
                for (int j = 0; j < B[0].length; j++)
                {
                    //Variable auxiliar para almacenar el resultado de la multiplicacion
                    int auxiliar = 0;

                    //recorre numero de filas de B
                    for (int k = 0; k < B.length; k++){
                        //Multiplica los elementos de A y B y los suma a la variable auxiliar
                        auxiliar += (A[i][k] * B[k][j]);
                    
                    }
                    //Almacena el resultado en la matriz
                    matriz[i][j] = auxiliar;
                
                }
            
            }
        
        }
        return matriz;
        
        
    }


    public int[][] multiplicarMatriz2(int [][] A, int [][] B)
    {

        //Crear nueva matriz con el tamaño de las filas de A y las columnas de B
        int [][] matriz = new int [A.length][B[0].length];

        //Si el numero de columnas de A es igual al numero de filas de B
        if (A[0].length == B.length)
        {
            //recorrer las filas de A
            for (int i = 0; i < A.length; i++)
            {
                //recorrer las columnas de B
                for (int j = 0; j < B[0].length; j++)
                {
                    //inicializar la matriz en 0
                    matriz [i][j] = 0;
                    //recorrer las filas de B
                    for (int k = 0; k < B.length; k++) 
                    {
                        //Multiplica los elementos de A y B y los suma a la matriz
                        matriz [i][j]+= (A[i][k]*B[k][j]);

                    }

                }

            }

        }
        return matriz;

    }


    public int[] multiplicarNumeroGrande1 ( int arreglo1[], int arreglo2[] )
    {

        int resultado []= new int [arreglo1.length + arreglo2.length];
        for ( int i = arreglo2.length-1 ; i >= 0; i-- )
        {

        for ( int j = arreglo1.length-1; j >= 0 ; j-- )
        {

        resultado [ i + j + 1 ] += arreglo1 [ j ] * arreglo2 [ i ];
        resultado [ i + j ] += (resultado [ i + j + 1 ] / 10);
        resultado [ i + j + 1 ] %= 10;

        }

        }
        return resultado;

    }


    public int[] multiplicarNumeroGrande2 (int[] arreglo1, int[] arreglo2)
    {

        int tam = arreglo1.length + arreglo2.length;
        int[] resultado = new int [tam];
        for (int i=0; i< arreglo2.length; i++)
        {

        for(int j=0; j< arreglo1.length; j++)
        {

        resultado[i+j+1]+= arreglo1[j]* arreglo2[i];

        }

        }
        for (int k=tam-1; k>0; k--)
        {

        resultado[k-1]+= resultado[k]/10;
        resultado [k]%=10;

        }
        return resultado;

    }

}
