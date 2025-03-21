package ejercicios;
public class Multiplicacion {
    

    /**
     * Multiplicar dos matrices
     * usa auxiliar para almacenar el resultado de la multiplicacion
     * @param A
     * @param B
     * @return
     */
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


    /**
     * Multiplicar dos matrices
     * modifica directamente la matriz resultado
     * @param A
     * @param B
     * @return
     */
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


    /**
     *recorre los arreglos de entrada desde el final hacia el principio (de derecha a izquierda).
     * Multiplica los elementos de los arreglos y los suma al resultado dentro del bucle, es inmediato
     * @param arreglo1
     * @param arreglo2
     * @return
     */
    public int[] multiplicarNumeroGrande1 ( int arreglo1[], int arreglo2[] )
    {
        //Crear un arreglo con la suma de los tamaños de los arreglos
        int resultado []= new int [arreglo1.length + arreglo2.length];

        //Recorrer el arreglo 2
        for ( int i = arreglo2.length-1 ; i >= 0; i-- )
        {
            //Recorrer el arreglo 1
            for ( int j = arreglo1.length-1; j >= 0 ; j-- )
            {
                //Multiplica los elementos de los arreglos y los suma al resultado
                resultado [ i + j + 1 ] += arreglo1 [ j ] * arreglo2 [ i ];
                //Divide el resultado entre 10 y lo suma al resultado
                resultado [ i + j ] += (resultado [ i + j + 1 ] / 10);
                //Modulo del resultado
                resultado [ i + j + 1 ] %= 10;

            }

        }
        return resultado;

    }


    /**
     * Multiplicar dos numeros grandes
     * recorre los arreglos de entrada desde el final hacia el principio (de izquierda a derecha).
     * Multiplica los elementos de los arreglos y los suma al resultado fuera del bucle, no es inmediato
     * @param arreglo1
     * @param arreglo2
     * @return
     */
    public int[] multiplicarNumeroGrande2 (int[] arreglo1, int[] arreglo2)
    {

        //Crear un arreglo con la suma de los tamaños de los arreglos
        int tam = arreglo1.length + arreglo2.length;

        //Crear un arreglo con el tamaño de la suma de los arreglos
        int[] resultado = new int [tam];

        //Recorrer el arreglo 2
        for (int i=0; i< arreglo2.length; i++)
        {
            //Recorrer el arreglo 1
            for(int j=0; j< arreglo1.length; j++)
            {
            //Multiplica los elementos de los arreglos y los suma al resultado
            resultado[i+j+1]+= arreglo1[j]* arreglo2[i];

            }

        }

        //Recorrer el arreglo
        for (int k=tam-1; k>0; k--)
        {
        //Divide el resultado entre 10 y lo suma al resultado
        resultado[k-1]+= resultado[k]/10;
        //Modulo del resultado
        resultado [k]%=10;

        }

        return resultado;

    }

}
