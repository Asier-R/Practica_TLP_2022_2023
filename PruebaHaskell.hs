
--{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
--{-# HLINT ignore "Redundant bracket" #-}

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
--Si suma no es vacia, suma el primer elemento x a la suma de su cola xs
sumar2 [] = 0
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

--Listas por compresión (ver pag 75 del texto base)
divisores n = [ d | d <- [1..n] , mod n d == 0 ]
primos = [ p | p <- [2..100] , divisores p == [1,p] ] -- Se le indica limite del 2 al 100 para que el programa no se ejecute indefinidamente.


--Ejercicios de autoevaluación
polidivisible n 
    | n <= 0 = False
    | otherwise = ipolidivisible n (long n)
    where
        ipolidivisible _ 1 = True
        ipolidivisible n lon = ((mod n lon) == 0) && (ipolidivisible (div n 10) (lon-1))
        long n
            | n< 10 = 1
            | otherwise = 1 + long (div n 10)

reglas = 
    [
        ("DESPEDIDA",["ADIOS", "NOS VEREMOS"]),
        ("HOLA",["ENCANTADO"]),
        ("SALUDO",["HOLA","QUE TAL?"])
    ]
    
reescribe cad [] = []
reescribe cad ( (ent,sal):resto )
    | cad == ent = sal
    | otherwise = reescribe cad resto
    
reescritura r [] = []
reescritura r (cad:resto) 
    | null salida = cad:( reescritura r resto )
    | otherwise = reescritura r ( salida ++ resto )
    where 
        salida = reescribe cad r

existencia2 :: [Int] -> Int
existencia2 l@(x:xs)
  | null l = -1 
  | l /= [] && x == -1 = existencia2 xs
  | otherwise = x

comparable :: Char -> Char -> String
comparable c1 c2 
  | c1 > c2 = show(c1)++" es MAYOR que "++show(c2)
  | c1 < c2 = show(c1)++" es MENOR que "++show(c2)
  | otherwise = show(c1)++" es IGUAL que "++show(c2)

ultimo :: String -> String
ultimo (xs:s) = s

-- ****** PRUEBAS PARA LA REALIZACION DE LA PRACTICA ****** --
--Pruebas sobre el tipo de datos Stock de la práctica
data Stock = ROOTNODE [Stock] | INNERNODE Char [Stock] | INFONODE Int
  deriving (Show,Read,Eq)

createStock :: Stock
createStock = ROOTNODE []

--Un Stock concreto
cosa  = ROOTNODE [INNERNODE 'c' [INNERNODE 'o' [INNERNODE 's' [INNERNODE 'a' [INFONODE 5]]]]]
cosa2 = ROOTNODE [INNERNODE 'p' [INNERNODE 'l' [INNERNODE 'a' [INNERNODE 't' [INNERNODE 'o' [INFONODE 9, INNERNODE 'n' [INFONODE 99], INNERNODE ' ' [INNERNODE 'h' [INNERNODE 'o' [INNERNODE 'n' [INNERNODE 'd' [INNERNODE 'o' [INFONODE 2]]]]]]]]]]]]
cosa3 = INNERNODE 'c' [INNERNODE 'o' [INNERNODE 's' [INNERNODE 'a' [INFONODE 5]]]]

--Funcion que devuelve el número de elementos de ese stock
retrieveStock2 :: Stock -> String -> Int
retrieveStock2 (INFONODE num) p 
  | p == "" = num
  | otherwise = -6
retrieveStock2 (INNERNODE chr ( s@(INFONODE n) : stocks )) p
  | p == "" = retrieveStock2 s p
  | p /= "" && stocks /= [] = retrieveStock2 (INNERNODE chr stocks) p
  | otherwise = -5
retrieveStock2 (INNERNODE _ ( s@(INNERNODE c _) : _ )) "" = -4
retrieveStock2 (INNERNODE chr ( s@(INNERNODE c st) : stocks )) k@(p:ps)
  | c == p = retrieveStock2 s ps
  | c /= p && stocks /= [] = retrieveStock2 (INNERNODE chr stocks) k --"c:"++show(c)++" p:"++show(p)++" chr:"++show(chr)++" k:"++k ++" stocks:"++show(stocks)  --retrieveStock (INNERNODE chr stocks) k --
  | otherwise = -2
retrieveStock2 (ROOTNODE l@( i@(INNERNODE c st) : stocks )) k@(p:ps) 
  | null l = -1
  | c == p = retrieveStock2 i ps
  | c /= p && stocks /= [] = retrieveStock2 (ROOTNODE stocks) k
  | otherwise = -1

--Funcion que devuelve el número de elementos de ese stock MAS COMPACTA
retrieveStock :: Stock -> String -> Int
retrieveStock (INFONODE n) ""                    = n
retrieveStock (INFONODE n)  p                    = -1
retrieveStock (INNERNODE c ((INFONODE n):st)) "" = n
retrieveStock (INNERNODE c st) ""                = -2
retrieveStock (INNERNODE c []) _                 = -3
retrieveStock (INNERNODE c (s:st)) k@(p:ps) 
  | c == p && retrieveStock s ps < 0             = retrieveStock (INNERNODE c st) k
  | c /= p                                       = retrieveStock (INNERNODE c st) k
  | otherwise                                    = retrieveStock s ps
retrieveStock (ROOTNODE [])     p                = -5
retrieveStock (ROOTNODE (s:st)) k@(p:ps) 
  | retrieveStock s k < 0                        = retrieveStock (ROOTNODE st) k
  | otherwise                                    = retrieveStock s k

--Funcion que actualiza el stock
updateStock :: Stock         -> String -> Int -> Stock
updateStock (INFONODE  n)          ""  u      = INFONODE  u
updateStock (ROOTNODE  [])         k@(p:ps) u = ROOTNODE    [ updateStock (INNERNODE p []) ps u ]
updateStock (INNERNODE c [])       "" u       = INNERNODE c [INFONODE  u]
updateStock (INNERNODE c [])       k@(p:ps) u = INNERNODE c [ updateStock (INNERNODE p []) ps u ]
updateStock (INNERNODE c r@(s:st)) k@(p:ps) u = INNERNODE c (recorrer r k u)         
updateStock (ROOTNODE  r@(s:st))   k@(p:ps) u = ROOTNODE    (recorrer r k u)
recorrer :: [Stock] -> String -> Int -> [Stock]
recorrer s@(st:stock) k@(p:ps) u
  |  null s && k == ""     =  [INFONODE u]
  |  null s && k /= ""     =  [updateStock (INNERNODE p []) ps u]
  |  compara st [p] ==  0  =  updateStock st ps u : stock
  |  compara st [p] ==  1  =  st : [updateStock (INNERNODE p []) ps u] -- st : (recorrer stock k u)
  |  compara st [p] == -1  =  updateStock (INNERNODE p []) ps u : s
  where 
  compara :: Stock -> String -> Int 
  compara (INFONODE _)     "" = 0
  compara (INFONODE _)     p  = 1
  compara (INNERNODE c st) (p:ps)
    | c == p    =  0
    | c < p     =  1
    | otherwise = -1 

-- FUNCIÓN QUE DEVUELVE UNA LISTA PARES PRODUCTO-EXISTENCIA --
-- DEL CATÁLOGO QUE COMIENZAN POR LA CADENA PREFIJO p       --
listStock :: Stock -> String -> [(String,Int)]
listStock s p = [("SIN DESARROLLAS",0)]

-- FUNCIÓN GENÉRICA DE BACKTRACKING -- 
-- eS = funcion solucion
-- c  = funcion que devuelve los hijos validos de un nodo
-- n  = nodo actual de exploracion
bt :: (a -> Bool) -> (a -> [a]) -> a -> [a]
bt    eS             c             n
  | eS n      = [n]
  | otherwise = concat (map (bt eS c) (c n))



-- ******************************************************** --





--Programa principal
main = do
  putStrLn("00 - Prueba inicio, numero impares del 10 al 20: " ++ show (filter odd [10..20]))
  putStrLn("01 - sumar 2 3: "                                  ++ show (sumar 2 3))
  putStrLn("02 - sumaPre 5: "                                  ++ show (sumaPre 5))
  putStrLn("03 - fiboNum 15: "                                 ++ show (fiboNum 15))
  putStrLn("04 - fiboList 15: "                                ++ show (fiboList 15))
  putStrLn("05 - sumar2 [1,2,3]: "                             ++ show (sumar2 [1,2,3]))
  putStrLn("06 - duplicaCabeza1 [2,3]: "                       ++ show (duplicaCabeza1 [2,3]))
  putStrLn("06 - duplicaCabeza1 texto: "                       ++ show (duplicaCabeza1 "texto"))
  putStrLn("07 - duplicaCabeza2 [1,3]: "                       ++ show (duplicaCabeza2 [1,3]))
  putStrLn("08 - dividir 5 2: "                                ++ show (dividir 5 2))
  putStrLn("09 - sumar3 5 2: "                                 ++ show (sumar3 5 2))
  putStrLn("10 - sumarle4 1: "                                 ++ show (sumarle4 1))
  putStrLn("11 - lstcnc: "                                     ++ show lstcnc)
  putStrLn("12 - zplst: "                                      ++ show zplst)
  putStrLn("13 - zplst2: "                                     ++ show zplst2)
  putStrLn("14 - unzipi zplst: "                               ++ show (unzipi zplst))
  putStrLn("15 - map sumarle4 lstcnc: "                        ++ show lstMapped)
  putStrLn("16 - mapi sumarle4 lstcnc: "                       ++ show lstMapped2)
  putStrLn("16 - map (\\x -> x*x) [1..10]: "                   ++ show lstMapped3)
  putStrLn("17 - primos: "                                     ++ show primos) -- Solo los primos entre 2 y 100
  putStrLn("18 - polidivisible 1024: "                         ++ show (polidivisible 1024))
  putStrLn("19 - polidivisible 1025: "                         ++ show (polidivisible 1025))
  putStrLn("20 - reescribe POTATO reglas: "                    ++ show (reescribe "POTATO" reglas))
  putStrLn("21 - reescribe SALUDO reglas: "                    ++ show (reescribe "SALUDO" reglas))
  putStrLn("22 - reescritura reglas [...]: "                   ++ show (reescritura reglas ["SALUDO","EJECUTANDO","DESPEDIDA"]))
  putStrLn("23 - existencia2 [-1,6,5]: "                       ++ show (existencia2 [-1,6,5]))
  putStrLn("24 - ultimo patatas: "                             ++ show (ultimo "patatas"))
  putStrLn ""

  putStrLn("z - 1: retrieveStock cosa  'plato'       = "                              ++ show ( retrieveStock2 cosa  "plato"))
  putStrLn("z - 2: retrieveStock cosa  'cosa'        = "                              ++ show ( retrieveStock2 cosa  "cosa"))
  putStrLn("z - 3: retrieveStock cosa2 'plato'       = "                              ++ show ( retrieveStock2 cosa2 "plato"))
  putStrLn("z - 4: retrieveStock cosa2 'plato hondo' = "                              ++ show ( retrieveStock2 cosa2 "plato hondo"))
  putStrLn("z - 5: retrieveStock cosa2 'platob'      = "                              ++ show ( retrieveStock2 cosa2 "platob"))
  putStrLn("z - 6: retrieveStock cosa  'cosa '       = "                              ++ show ( retrieveStock2 cosa  "cosa "))
  putStrLn("z - 7: retrieveStock cosa2 'plato '      = "                              ++ show ( retrieveStock2 cosa2 "plato "))
  putStrLn("z - 8: retrieveStock cosa2 'platon'      = "                              ++ show ( retrieveStock2 cosa2 "platon"))
  putStrLn("z - 9: comparable = " ++ show( comparable 'l' 'h' ))
  putStrLn("z - 10: head = " ++ show( head [ROOTNODE [INNERNODE 'b' []], INNERNODE 'a' []] ))
  putStrLn("z - 11: drop = " ++ show( drop 1 [ROOTNODE [INNERNODE 'b' []], INNERNODE 'a' []] ))
  putStrLn("z - 12: drop = " ++ show( drop 1 [ROOTNODE [INNERNODE 'b' []]] ))
  putStrLn("z - 13: drop = " ++ show( drop 1 (drop 1 [ROOTNODE [INNERNODE 'b' []]] )) )
  putStrLn("z - 14: head = " ++ show( head [cosa] ))
  putStrLn("z - 15: retrieveStock cosa3 'cosa'      = "                              ++ show ( retrieveStock cosa3 "cosa"))

  putStrLn ""

  putStrLn("z - 9: updateStock (ROOTNODE []) 'plato' = "                              ++ show ( updateStock (ROOTNODE []) "plato" 8))
  putStrLn("z - 10: updateStock cosa 'alato'         = "                              ++ show ( updateStock cosa "alato" 88))
  putStrLn("z - 11: updateStock cosa 'plato'         = "                              ++ show ( updateStock cosa "plato" 99))
  putStrLn("z - 12: retrieveStock cosa 'plato'       = "                              ++ show ( retrieveStock (updateStock cosa "plato" 99) "plato" ))


