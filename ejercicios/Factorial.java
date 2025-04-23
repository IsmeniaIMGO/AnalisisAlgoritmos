package ejercicios;

public class Factorial {
    

    //Forma iterativa

    public int factorial (int n) {

        //usa ciclo y modifica la variable resultado
        int resultado = 1;
        if(n==0 || n==1){
            return resultado;
        }else{
            for(int i = 2; i <= n; i++) {
                resultado = resultado * i;
            }
    }
        return resultado;
    }

    

    //Forma recursiva

    public int factorialRecursivo(int n) {
        //no usa ciclo y no hay variable: resultado
        if (n == 0 || n == 1) {
            return 1;
        } else {
            return n * factorialRecursivo(n - 1);
        }
    }


    //forma tabulacion bottom up

    public int factorialTabulacion(int n) {
        //crea un arreglo en vez de una variable resultado
        //tiene ciclo y modifica el arreglo
        int[] tabla = new int[n + 1];
        tabla[0] = 1;
        for (int i = 1; i <= n; i++) {
            tabla[i] = tabla[i - 1] * i;
        }
        return tabla[n];
    }


    //forma memoizacion top down

    public int factorialMemorizacion(int n) {

        //crea un arreglo en vez de una variable resultado
        //no tiene ciclo
        //tiene una condicion para verificar si ya fue calculado
        int[] tabla = new int[n + 1];

        if(n==0 || n==1){
            tabla[n] = 1;
            return 1;
        }

        if(tabla[n] != 0){
            return tabla[n];
        }else{
            tabla[n] = n * factorialMemorizacion(n - 1);
            return tabla[n];
        }
    }

    


}
