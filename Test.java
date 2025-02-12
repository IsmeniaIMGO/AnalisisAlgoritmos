public class Test {
    public static void main(String[] args) {
        Algoritmos algoritmos = new Algoritmos();

        int iteracion = 5;
        int numero = 31;
        //int numero = 32;
        //int numero = 100003;
        //int numero = 999999937;
        //int numero = 999999999;

        long startTime = System.nanoTime();

        long endTime = System.nanoTime();
        
/* 
        System.out.println("DeterminarNumeroPrimo1");
        System.out.println("Numero: " + numero);
        
        startTime = System.nanoTime();
        System.out.println(algoritmos.determinarNumeroPrimo1(numero));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución: " + (endTime - startTime) + " nanosegundos \n");


        System.out.println("DeterminarNumeroPrimo2");
        System.out.println("Numero: " + numero);
        startTime = System.nanoTime();
        System.out.println(algoritmos.determinarNumeroPrimo2(numero));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución: " + (endTime - startTime) + " nanosegundos \n");


        System.out.println("DeterminarNumeroPrimo3");
        System.out.println("Numero: " + numero);
        startTime = System.nanoTime();
        System.out.println(algoritmos.determinarNumeroPrimo3(numero));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución: " + (endTime - startTime) + " nanosegundos \n");
   

        System.out.println("DeterminarNumeroPrimo4");
        System.out.println("Numero: " + numero);
        startTime = System.nanoTime();
        System.out.println(algoritmos.determinarNumeroPrimo4(numero));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución: " + (endTime - startTime) + " nanosegundos \n");


        System.out.println("DeterminarNumeroPrimo5");
        System.out.println("Numero: " + numero);
        startTime = System.nanoTime();
        System.out.println(algoritmos.determinarNumeroPrimo5(numero));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución: " + (endTime - startTime) + " nanosegundos \n");


        System.out.println("Fermat");
        System.out.println("Numero: " + numero);
        startTime = System.nanoTime();
        System.out.println(algoritmos.pruebaFermat(numero, iteracion));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución: " + (endTime - startTime) + " nanosegundos \n");


        System.out.println("Miller Rabin");
        System.out.println("Numero: " + numero);
        startTime = System.nanoTime();
        System.out.println(algoritmos.pruebaMillerRabin(numero, iteracion));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución: " + (endTime - startTime) + " nanosegundos \n");


        System.out.println("Solovay - Strassen");
        System.out.println("Numero: " + numero);
        startTime = System.nanoTime();
        System.out.println(algoritmos.pruebaSolovayStrassen(numero, iteracion));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución: " + (endTime - startTime) + " nanosegundos \n");


        System.out.println("Baillie - PSW CORREGIR, NO FUNCIONA");
        System.out.println("Numero: " + numero);
        startTime = System.nanoTime();
        //System.out.println(algoritmos.pruebaBailliePSW(numero));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución " + (endTime - startTime) + " nanosegundos \n");


        System.out.println("Primalidad AKS");
        System.out.println("Numero: " + numero);
        startTime = System.nanoTime();
        System.out.println(algoritmos.pruebaPrimalidadAKS(numero));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución: " + (endTime - startTime) + " nanosegundos \n");



        System.out.println("Wilson no es para numeros grandes");
        System.out.println("Numero: " + numero);
        startTime = System.nanoTime();
        //System.out.println(algoritmos.pruebaWilson(numero));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución:" + (endTime - startTime) + " nanosegundos \n");


        System.out.println("LucasLehmer solo funciona con numeros Mersenne");
        System.out.println("Numero: " + numero);
        startTime = System.nanoTime();
        //System.out.println(algoritmos.pruebaLucasLehmer(numero));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución: " + (endTime - startTime) + " nanosegundos \n");



        System.out.println("Lechman");
        System.out.println("Numero: " + numero);
        startTime = System.nanoTime();
        System.out.println(algoritmos.pruebaLehmann(numero, iteracion));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución: " + (endTime - startTime) + " nanosegundos \n");


        */


        //------------------------------------------------MATRIZ------------------------------

        //double [][] arreglo = {{15, 6, 8,}, {6, 21, 43}, {8, 43, 3}};
        
        /*double [][] arreglo = {
        {1, 2, 3, 4, 5},
        {2, 6, 7, 8, 9},
        {3, 7, 10, 11, 12},
        {4, 8, 11, 13, 14},
        {5, 9, 12, 14, 15}};*/

        int tamanio = 500;
        double[][] arreglo = new double[tamanio][tamanio];

        // Llenar la matriz de manera que sea simétrica
        for (int i = 0; i < tamanio; i++) {
            for (int j = 0; j <= i; j++) {
                arreglo[i][j] = arreglo[j][i] = Math.random() * 100; // Puedes cambiar el rango de valores si lo deseas
            }
        }

        Matriz matriz = new Matriz();


        System.out.println("Es simetrica1");
        startTime = System.nanoTime();
        System.out.println(matriz.esSimetrica1(arreglo));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución: " + (endTime - startTime) + " nanosegundos \n");


        System.out.println("Es simetrica2");
        startTime = System.nanoTime();
        System.out.println(matriz.esSimetrica2(arreglo));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución: " + (endTime - startTime) + " nanosegundos \n");


        System.err.println("Es simetrica 3");
        startTime = System.nanoTime();
        System.out.println(matriz.esSimetrica3(arreglo));
        endTime = System.nanoTime();
        System.out.println("Tiempo de ejecución: " + (endTime - startTime) + " nanosegundos \n");




    }


    
}

