--Suma de dos números
sumar x y = x + y

--Suma de unidades previas a la entrada n
--Las barras verticales separan las 'guardas' (ver pag 51-52 text base)
sumaPre n 
    | n <= 0 = 0
    | otherwise = n + sumaPre (n-1)

--Funciones con subfunciones (ver pag 51 texto base)
--Función número de fibonacci para indice n
fiboNum :: Int -> Integer --Tipo de la función (ver pag 54 texto base)
fiboNum n = fibs !! n
  where fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

--Función lista completa
fiboList :: Int -> [Integer] --Tipo de la función (ver pag 54 texto base)
fiboList n = take (n+1) fibs
  where fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

--Define función suma
--Si suma es lista vacia entonces es 0
sumar2 [] = 0
--Si suma no es vacia, suma el primer elemento x a la suma de su cola xs
sumar2 (x:xs) = x + sumar2 xs

--Patrones (ver pag 50 text base)
duplicaCabeza1 (x:xs) = x:x:xs
duplicaCabeza2 l@(x:xs) = x:l

--La función error (ver pag 53 del texto base)
dividir a 0 = error "No se puede dividir por 0"
dividir a b = a/b

--Currificación de funciones y aplicación parcial
sumar3 :: Integer -> (Integer -> Integer) --originalmente era Float -> (Float -> Float)
sumar3 x y = x + y

sumarle4 :: Integer -> Integer --originalmente era Float -> Float
sumarle4 = sumar3 4

--Concatenar listas (ver pag 67 del texto base)
lista1 = [1,2,3]
lista2 = [4,5,6]
lstcnc = lista1 ++ lista2

--Combinar listas en tuplas (ver pag 69 del texto base)
zplst = zip lista1 lista2
--Lo que hace la función zip (el orden es importante o siempre devolveria lista vacía)
zipi (x:xs) (y:ys) = (x,y) : (zipi xs ys)
zipi _ _ = []
lista3 = [1,2,3]
lista4 = [4,5] --la lista más corta define el tamaño de la lista de tuplas
zplst2 = zipi lista3 lista4

--Separar tuplas a una tupla de dos listas, una con los primeros elementos de cada tupla y la otra con los segundos elementos (ver pag 68 del texto base)
unzipi xs = unzipiAux xs ([],[])  --Aquí se define la función interna que será recursiva. Primer parametro la lista de tuplas, segundo parametro el resultado acumulado.
  where
    unzipiAux [] acumulado = acumulado --Si el primer parametro está vacio devuelve el segundo, el acumulado hasta el momento. Si se empiza con una tupla vacia se devuelve ([],[])
    unzipiAux ((a,b):xs) (as,bs) = unzipiAux xs (as++[a],bs++[b]) --Si lista no vacia se realiza esta otra función que recibe una función por parametro. 
                                                                  --Se toma la primera tupla y usando patrones se indica que concatene el primer elemento (lista) de la tupla que representa
                                                                  --el acumulado, con el primer elemento de la cabeza de la lista de tuplas. Se procede de forma análoga con el segundo elemento. 

--Aplicar una función a todos los elementos de una lista (ver pag 69 del texto base)
lstMapped = map sumarle4 lstcnc
--Lo que hace map (ver pag 70 del texto base)
mapi _ [] = [] --Si la lista está vacia no importa la función, siempre devuelve la lista vacia.
mapi f (x:xs) = (f x) : (mapi f xs)
lstMapped2 = mapi sumarle4 lstcnc
--Para obtener los diez primeros cuadrados
lstMapped3 = map (\x -> x*x) [1..10] --la barra se utiliza cuando no queremos nombrar la función => funciones anónimas

--Función filtro (ver pag 73 del texto base)




--Programa principal
main = do
  putStrLn("00 - Prueba inicio, numero impares del 10 al 20: " ++ show (filter odd [10..20]))
  putStrLn("01 - sumar 2 3: "                                  ++ show (sumar 2 3))
  putStrLn("02 - sumaPre 5: "                                  ++ show (sumaPre 5))
  putStrLn("03 - fiboNum 15: "                                 ++ show (fiboNum 15))
  putStrLn("04 - fiboList 15: "                                ++ show (fiboList 15))
  putStrLn("05 - sumar2 [1,2,3]: "                             ++ show (sumar2 [1,2,3]))
  putStrLn("06 - duplicaCabeza1 [2,3]: "                       ++ show (duplicaCabeza1 [2,3]))
  putStrLn("07 - duplicaCabeza2 [1,3]: "                       ++ show (duplicaCabeza2 [1,3]))
  putStrLn("08 - dividir 5 2: "                                ++ show (dividir 5 2))
  putStrLn("09 - sumar3 5 2: "                                 ++ show (sumar3 5 2))
  putStrLn("10 - sumarle4 1: "                                 ++ show (sumarle4 1))
  putStrLn("11 - lstcnc: "                                     ++ show (lstcnc))
  putStrLn("12 - zplst: "                                      ++ show (zplst))
  putStrLn("13 - zplst2: "                                     ++ show (zplst2))
  putStrLn("14 - unzipi zplst: "                               ++ show (unzipi zplst))
  putStrLn("15 - map sumarle4 lstcnc: "                        ++ show (lstMapped))
  putStrLn("16 - mapi sumarle4 lstcnc: "                       ++ show (lstMapped2))
  putStrLn("16 - map (\\x -> x*x) [1..10]: "                    ++ show (lstMapped3))
  
