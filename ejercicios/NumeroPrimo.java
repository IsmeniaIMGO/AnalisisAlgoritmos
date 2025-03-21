package ejercicios;
import java.math.BigInteger;
import java.util.Random;

public class NumeroPrimo {
   


    public boolean determinarNumeroPrimo1 (int numero){
        int resultado = 0;
        for(int i = 2; i < numero; i++ ){

            if (numero % i == 0){
                resultado = 1;
            }

        }
            if (resultado == 0){

                return true;

            }else{

                return false;

            }
    }
    
    
    public boolean determinarNumeroPrimo2 (int numero){

    boolean centi=true;
    int i;
    for (i=2; i <= numero / 2 && centi==true; i++){

        if (numero % i == 0)
        {

        centi = false;

        }

        }
    return centi;

    }


    public boolean determinarNumeroPrimo3 (int numero){

        int i;
        for (i = 2 ; i <= numero / 2 ; i++ )
        {

            if ( numero % i == 0 )
            {

            break;

            }

        }

        if ( numero / 2 < i )
        {

        return true;

        }
        else
        {

        return false;

        }

    }


    public boolean determinarNumeroPrimo4 (int numero){

        for (int i = 2; i <= (int)Math.sqrt(numero); i++)
        {

            if (numero % i == 0)
            {

            return false;

            }

        }
        return true;
    }


    public boolean determinarNumeroPrimo5 (int numero){

        if (numero < 2)
        {

        return false;

        }
        for (int i = 2; i * i <= numero; i++)
        {

            if (numero % i == 0)
            {

            return false;

            }

        }
        return true;

    }


    public boolean pruebaFermat (int Numero, int iteracion){
        if (Numero <= 1) return false;
        if (Numero <= 3) return true;

        Random rand = new Random();
        for (int i = 0; i < iteracion; i++) {
            int a = 2 + rand.nextInt(Numero - 2);
            if (BigInteger.valueOf(a).modPow(BigInteger.valueOf(Numero - 1), BigInteger.valueOf(Numero)).intValue() != 1)
                return false;
        }
        return true;
      
    }

    public boolean pruebaMillerRabin (int numero, int iteracion){
        if (numero <= 1) return false;
        if (numero == 2 || numero == 3) return true;
        if (numero % 2 == 0) return false;

        int s = 0;
        int d = numero - 1;
        while (d % 2 == 0) {
            d /= 2;
            s++;
        }

        for (int i = 0; i < iteracion; i++) {
            int a =  2;
            BigInteger x = BigInteger.valueOf(a).modPow(BigInteger.valueOf(d), BigInteger.valueOf(numero));
            if (x.intValue() == 1 || x.intValue() == numero - 1) continue;
            
            boolean composite = true;
            for (int r = 0; r < s - 1; r++) {
                x = x.modPow(BigInteger.TWO, BigInteger.valueOf(numero));
                if (x.intValue() == numero - 1) {
                    composite = false;
                    break;
                }
            }
            if (composite) return false;
        }
        return true;

    }


    public boolean pruebaSolovayStrassen (int numero, int iteracion){
        if (numero <= 1) return false;
        if (numero == 2) return true;
        if (numero % 2 == 0) return false;

        Random rand = new Random();
        for (int i = 0; i < iteracion; i++) {
            int a = rand.nextInt(numero - 2) + 1;
            int jacobi = jacobiSymbol(a, numero);
            int modExp = BigInteger.valueOf(a).modPow(BigInteger.valueOf((numero - 1) / 2), BigInteger.valueOf(numero)).intValue();
            if (jacobi == 0 || (modExp != (jacobi + numero) % numero)) return false;
        }
        return true;
    }


    public boolean pruebaBailliePSW (int numero){
        return pruebaMillerRabin(numero, 2) && lucasTest(numero);

    }

   

    public boolean pruebaPrimalidadAKS (int numero){
     
        if (numero <= 1) return false;
        if (numero == 2) return true;
        if (BigInteger.valueOf(numero).isProbablePrime(10)) return true;
        
        // Paso 1: Verificar si es una potencia
        for (int b = 2; b * b <= numero; b++) {
            int a = (int) Math.round(Math.pow(numero, 1.0 / b));
            if (Math.pow(a, b) == numero) return false;
        }
        
        // Paso 2: Prueba de divisibilidad por primos pequeños
        for (int p = 2; p <= 1000; p++) {
            if (numero % p == 0 && numero != p) return false;
        }
        
        // Paso 3: Verificación AKS principal
        int r = 2;
        while (true) {
            boolean nextR = false;
            for (int k = 1; k <= 4 * Math.log(numero) / Math.log(2); k++) {
                if (BigInteger.valueOf(numero).modPow(BigInteger.valueOf(k), BigInteger.valueOf(r)).equals(BigInteger.ONE)) {
                    nextR = true;
                    break;
                }
            }
            if (!nextR) break;
            r++;
        }
        
        for (int a = 1; a <= Math.min(r, Math.sqrt(numero) + 1); a++) {
            if (!BigInteger.valueOf(a).modPow(BigInteger.valueOf(numero), BigInteger.valueOf(numero)).equals(BigInteger.valueOf(a))) {
                return false;
            }
        }
        return true;
    }


    public boolean pruebaWilson (int numero){
       
        if (numero <= 1) return false;
        BigInteger factorial = BigInteger.ONE;
        for (int i = 2; i < numero; i++) {
            factorial = factorial.multiply(BigInteger.valueOf(i));
        }
        return factorial.add(BigInteger.ONE).mod(BigInteger.valueOf(numero)).equals(BigInteger.ZERO);
   
    }


    public boolean pruebaLucasLehmer (int numero){
        if (numero < 2) return false;
        BigInteger mersenne = BigInteger.TWO.pow(numero).subtract(BigInteger.ONE);
        BigInteger s = BigInteger.valueOf(4);
        for (int i = 0; i < numero - 2; i++) {
            s = s.multiply(s).subtract(BigInteger.TWO).mod(mersenne);
        }
        return s.equals(BigInteger.ZERO);
       
    }


    public boolean pruebaLehmann (int numero, int iteracion){
        if (numero <= 1) return false;
        if (numero == 2) return true;
        Random rand = new Random();
        for (int i = 0; i < iteracion; i++) {
            int a = rand.nextInt(numero - 2) + 1;
            BigInteger exp = BigInteger.valueOf((numero - 1) / 2);
            BigInteger mod = BigInteger.valueOf(numero);
            BigInteger result = BigInteger.valueOf(a).modPow(exp, mod);
            if (!result.equals(BigInteger.ONE) && !result.equals(mod.subtract(BigInteger.ONE))) {
                return false;
            }
        }
        return true;
       
    }



    //otros metodos

    public int jacobiSymbol(int a, int numero) {
        if (numero <= 0 || numero % 2 == 0) return 0;
        int result = 1;
        a = a % numero;
        while (a != 0) {
            while (a % 2 == 0) {
                a /= 2;
                if (numero % 8 == 3 || numero % 8 == 5) result = -result;
            }
            int temp = a;
            a = numero;
            numero = temp;
            if (a % 4 == 3 && numero % 4 == 3) result = -result;
            a %= numero;
        }
        return (numero == 1) ? result : 0;
    }

 

    public boolean lucasTest(int numero){
        return true;
        
    }



   
}