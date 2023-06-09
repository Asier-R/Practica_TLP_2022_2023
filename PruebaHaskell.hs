--module Main where

import System.IO
import Data.Char
import Text.Read


--import Distribution.Simple.Command (OptDescr(BoolOpt))

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
zipi (x:xs) (y:ys) = (x,y) : zipi xs ys
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
mapi f (x:xs) = f x : mapi f xs
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
        ipolidivisible n lon = (mod n lon == 0) && ipolidivisible (div n 10) (lon-1)
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
    | null salida = cad: reescritura r resto 
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
  | c1 > c2   = show c1 ++ " es MAYOR que " ++ show c2
  | c1 < c2   = show c1 ++ " es MENOR que " ++ show c2
  | otherwise = show c1 ++ " es IGUAL que " ++ show c2

ultimo :: String -> String
ultimo (xs:s) = s

entuplar :: Stock -> [String] -> [(String,Int)]
entuplar s p = map (asocia s) p
  where
    asocia :: Stock -> String -> (String,Int)
    asocia s p = (p , retrieveStock s p)

-- ****** PRUEBAS PARA LA REALIZACION DE LA PRACTICA ****** --
--Pruebas sobre el tipo de datos Stock de la práctica
data Stock = ROOTNODE [Stock] | INNERNODE Char [Stock] | INFONODE Int
  deriving (Show,Read,Eq)

createStock :: Stock
createStock = ROOTNODE []

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
retrieveStock (INNERNODE c st) ""                = -1
retrieveStock (INNERNODE c []) _                 = -1
retrieveStock (INNERNODE c (s:st)) k@(p:ps) 
  | c == p && retrieveStock s ps < 0             = retrieveStock (INNERNODE c st) k
  | c /= p                                       = retrieveStock (INNERNODE c st) k
  | otherwise                                    = retrieveStock s ps
retrieveStock (ROOTNODE [])     p                = -1
retrieveStock (ROOTNODE (s:st)) k@(p:ps) 
  | retrieveStock s k < 0                        = retrieveStock (ROOTNODE st) k
  | otherwise                                    = retrieveStock s k

--Funcion que actualiza el stock
updateStock :: Stock         -> String -> Int -> Stock
updateStock (INFONODE  n)          ""       u = INFONODE  u
updateStock (ROOTNODE  [])         k@(p:ps) u = ROOTNODE    [ updateStock (INNERNODE p []) ps u ]
updateStock (INNERNODE c [])       ""       u = INNERNODE c [ INFONODE  u ]
updateStock (INNERNODE c [])       k@(p:ps) u = INNERNODE c [ updateStock (INNERNODE p []) ps u ]
updateStock (INNERNODE c [INFONODE n]) ""   u = INNERNODE c [ INFONODE u ]
updateStock (INNERNODE c [st])     ""       u = INNERNODE c [ INFONODE u, st ]
updateStock (INNERNODE c [st])     k@(p:ps) u = INNERNODE c ( recorrer [st] k u )        
updateStock (INNERNODE c r@(s:st)) k@(p:ps) u = INNERNODE c ( recorrer r k u )         
updateStock (ROOTNODE    r@(s:st)) k@(p:ps) u = ROOTNODE    ( recorrer r k u )
updateStock (INNERNODE c r@(s:st)) ""       u = INNERNODE c ( recorrer r "" u ) 
updateStock s p u = s
recorrer :: [Stock] -> String -> Int -> [Stock]
recorrer [] ""       u = [INFONODE u]
recorrer [] k@(p:ps) u = [updateStock (INNERNODE p []) ps u]
recorrer s@((INFONODE n):stock) "" u = INFONODE u : stock
recorrer s@(st:stock) k@(p:ps) u
  |  compara st [p] ==  0  =  updateStock st ps u : stock
  |  compara st [p] ==  1  =  st : recorrer stock k u 
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
listStock s p = listar (bt (esSol p) (hijos p) s) ""
  where 
    listar :: [Stock] -> String -> [(String,Int)]
    listar [INFONODE n] p = [(p,n)]
    listar [] p = []
    listar ((INFONODE n):st) p    = (p,n) : listar st p
    listar ((INNERNODE c s):st) p = listar s (p++[c]) ++ listar st p
    listar [ROOTNODE (s:st)] p    = listar [s] p ++ listar st p
    esSol :: String -> Stock -> Bool
    esSol p (INFONODE _)    
      | p == ""   = True
      | otherwise = False
    esSol _  (INNERNODE c []) = False
    esSol "" (INNERNODE c _)  = True
    esSol k@(p:ps) (INNERNODE c [s]) = c == p && esSol ps s
    esSol k@(p:ps) (INNERNODE c (s:st)) = c == p && esSol ps s && esSol k (INNERNODE c st)
    esSol p (ROOTNODE [])     = False
    esSol p (ROOTNODE [s])    = esSol p s 
    esSol p (ROOTNODE (s:st)) = esSol p s && esSol p (ROOTNODE st)
    hijos :: String -> Stock -> [Stock]  
    hijos p (INFONODE  n)         
      | p == ""   = [INFONODE n] 
      | otherwise = []
    hijos p (INNERNODE c [])       = []
    hijos "" (INNERNODE c (s:st))  = INNERNODE c (hijos "" s) : hijos "" (INNERNODE c st)
    hijos k@(p:ps) (INNERNODE c (s:st)) 
      | p == c && hijos ps s /= [] = INNERNODE c (hijos ps s) : hijos k (INNERNODE c st)
      | otherwise                  = hijos k (INNERNODE c st)
    hijos p (ROOTNODE [])          = [] 
    hijos k@(p:ps) (ROOTNODE (i@(INNERNODE c s):st)) 
      | c == p && hijos k i /= []  = ROOTNODE (hijos k i) : hijos k (ROOTNODE st)
      | otherwise                  = hijos k (ROOTNODE st) 

listStock2 :: Stock -> String -> [Stock]
listStock2 s p = bt (esSol p) (hijos p) s
  where 
    esSol :: String -> Stock -> Bool
    esSol p (INFONODE _)    
      | p == ""   = True
      | otherwise = False
    esSol _  (INNERNODE c []) = False
    esSol "" (INNERNODE c _)  = True
    esSol k@(p:ps) (INNERNODE c [s]) = c == p && esSol ps s
    esSol k@(p:ps) (INNERNODE c (s:st)) = c == p && esSol ps s && esSol k (INNERNODE c st)
    esSol p (ROOTNODE [])     = False
    esSol p (ROOTNODE [s])    = esSol p s 
    esSol p (ROOTNODE (s:st)) = esSol p s && esSol p (ROOTNODE st)
    hijos :: String -> Stock -> [Stock]  
    hijos p (INFONODE  n)         
      | p == ""   = [INFONODE n] 
      | otherwise = []
    hijos p (INNERNODE c [])       = []
    hijos "" (INNERNODE c (s:st))  = INNERNODE c (hijos "" s) : hijos "" (INNERNODE c st)
    hijos k@(p:ps) (INNERNODE c (s:st)) 
      | p == c && hijos ps s /= [] = INNERNODE c (hijos ps s) : hijos k (INNERNODE c st)
      | otherwise                  = hijos k (INNERNODE c st)
    hijos p (ROOTNODE [])          = [] 
    hijos k@(p:ps) (ROOTNODE (i@(INNERNODE c s):st)) 
      | c == p && hijos k i /= []  = ROOTNODE (hijos k i) : hijos k (ROOTNODE st)
      | otherwise                  = hijos k (ROOTNODE st) 

-- FUNCIÓN GENÉRICA DE BACKTRACKING -- 
-- eS = funcion solucion
-- c  = funcion que devuelve los hijos validos de un nodo
-- n  = nodo actual de exploracion
bt :: (a -> Bool) -> (a -> [a]) -> a -> [a]
bt    eS             c             n
  | eS n      = [n]
  | otherwise = concat (map (bt eS c) (c n))

hijos2 :: String -> Stock -> [Stock]  
hijos2 p (INFONODE  n)         
  | p == ""   = [INFONODE n] 
  | otherwise = []
hijos2 p (INNERNODE c [])       = []
hijos2 "" (INNERNODE c (s:st))  = INNERNODE c (hijos2 "" s) : hijos2 "" (INNERNODE c st)
hijos2 k@(p:ps) (INNERNODE c (s:st)) 
  | p == c && hijos2 ps s /= [] = INNERNODE c (hijos2 ps s) : hijos2 k (INNERNODE c st)
  | otherwise                  = hijos2 k (INNERNODE c st)
hijos2 p (ROOTNODE [])          = [] 
hijos2 k@(p:ps) (ROOTNODE (i@(INNERNODE c s):st)) 
  | c == p && hijos2 k i /= []  = ROOTNODE (hijos2 k i) : hijos2 k (ROOTNODE st)
  | otherwise                  = hijos2 k (ROOTNODE st) 

-- *************** STOCKS DE PRUEBAS ********************** --
cosa  = ROOTNODE [INNERNODE 'c' [INNERNODE 'o' [INNERNODE 's' [INNERNODE 'a' [INFONODE 5]]]]]
cosa2 = ROOTNODE [INNERNODE 'p' [INNERNODE 'l' [INNERNODE 'a' [INNERNODE 't' [INNERNODE 'o' [INFONODE 9, INNERNODE 'n' [INFONODE 99], INNERNODE ' ' [INNERNODE 'h' [INNERNODE 'o' [INNERNODE 'n' [INNERNODE 'd' [INNERNODE 'o' [INFONODE 2]]]]]]]]]]]]
cosa3 = INNERNODE 'p' [INNERNODE 'l' [INNERNODE 'a' [INNERNODE 't' [INNERNODE 'o' [INFONODE 9, INNERNODE 'n' [INFONODE 99], INNERNODE ' ' [INNERNODE 'h' [INNERNODE 'o' [INNERNODE 'n' [INNERNODE 'd' [INNERNODE 'o' [INFONODE 2]]]]]]]]]]]
cosa4 = ROOTNODE [INNERNODE 'g' [INNERNODE 'a' [INNERNODE 't' [INNERNODE 'o' [INFONODE 1]]],INNERNODE 'i' [INNERNODE 'p' [INNERNODE 'i' [INFONODE 2]]]],INNERNODE 'p' [INNERNODE 'a' [INNERNODE 't' [INNERNODE 'o' [INFONODE 19]]],INNERNODE 'l' [INNERNODE 'a' [INNERNODE 't' [INNERNODE 'o' [INFONODE 9, INNERNODE 'n' [INFONODE 99], INNERNODE ' ' [INNERNODE 'h' [INNERNODE 'o' [INNERNODE 'n' [INNERNODE 'd' [INNERNODE 'o' [INFONODE 2]]]]]]]]]]]]
cosa5 = ROOTNODE [INNERNODE 'a' [INFONODE 1],INNERNODE 'l' [INNERNODE 'i' [INNERNODE 'n' [INNERNODE 't' [INNERNODE 'e' [INNERNODE 'r' [INNERNODE 'n' [INNERNODE 'a' [INFONODE 999]]]]]]]],INNERNODE 'p' [INNERNODE 'l' [INNERNODE 'a' [INNERNODE 't' [INNERNODE 'o' [INFONODE 9],INNERNODE 'o' [INNERNODE 'n' [INFONODE 99]],INNERNODE 'o' [INNERNODE ' ' [INNERNODE 'h' [INNERNODE 'o' [INNERNODE 'n' [INNERNODE 'd' [INNERNODE 'o' [INFONODE 2]]]]]]]]]]],INNERNODE 'z' [INFONODE 10,INNERNODE 'o' [INNERNODE 'r' [INFONODE 10]]]]
cosa6 = ROOTNODE [INNERNODE 'a' [INFONODE 1], INNERNODE 'c' [INFONODE 3, INNERNODE 'a' [INFONODE 33]],INNERNODE 'z' [INFONODE 10,INNERNODE 'o' [INNERNODE 'r' [INFONODE 10]]]]
cosa7 = ROOTNODE [INNERNODE 'p' [INNERNODE 'a' [INNERNODE 't' [INNERNODE 'a' [INNERNODE 't' [INNERNODE 'a' [INNERNODE 's' [INFONODE 6,INNERNODE ' ' [INNERNODE 'a' [INNERNODE 'z' [INNERNODE 'u' [INNERNODE 'l' [INNERNODE 'e' [INNERNODE 's' [INFONODE 3]]]]]]],INNERNODE '_' [INNERNODE 'a' [INNERNODE 'm' [INNERNODE 'a' [INNERNODE 'r' [INNERNODE 'i' [INNERNODE 'l' [INNERNODE 'l' [INNERNODE 'a' [INNERNODE 's' [INFONODE 7]]]]]]]]],INNERNODE 'f' [INNERNODE 'r' [INNERNODE 'i' [INNERNODE 't' [INNERNODE 'a' [INNERNODE 's' [INFONODE 66]]]]]]],INNERNODE 'a' [INFONODE 1]],INNERNODE 'z' [INNERNODE 'a' [INFONODE 4]]]]]]]]]
cosa8 = ROOTNODE [INNERNODE 'p' [INNERNODE 'a' [INNERNODE 't' [INNERNODE 'a' [INNERNODE 't' [INNERNODE 'a' [INNERNODE 's' [INFONODE 6]]]]]]]]
-- ******************************************************** --

fileName :: FilePath
fileName = "stock.txt"

saveStock :: Stock -> IO()
saveStock s = writeFile fileName (show s)

loadStock :: IO ()
loadStock = do { fcontent <- readFile' fileName;
                 let flines = (lines fcontent) in
                   case flines of
                     [] -> mainLoop createStock
                     s  -> mainLoop (read (head s)::Stock)
               }

compra :: Stock -> String -> Int -> IO ()
compra s p u = let us = retrieveStock s p in do {
                 if ( us == -1 )
                   then mainLoop (updateStock s p u);
                   else mainLoop (updateStock s p (us+u));
               }

mainLoop :: Stock -> IO ()
mainLoop s = do { 
  putStrLn ("Stock: "++show s);
  putStrLn ( show (retrieveStock s "hamburger"));
  --compra s "hamburger" 14;
  saveStock s;
}

--Programa principal
main = do
  --loadStock
  --putStrLn("00 - Prueba inicio, numero impares del 10 al 20: " ++ show (filter odd [10..20]))
  --putStrLn("01 - sumar 2 3: "                                  ++ show (sumar 2 3))
  --putStrLn("02 - sumaPre 5: "                                  ++ show (sumaPre 5))
  --putStrLn("03 - fiboNum 15: "                                 ++ show (fiboNum 15))
  --putStrLn("04 - fiboList 15: "                                ++ show (fiboList 15))
  --putStrLn("05 - sumar2 [1,2,3]: "                             ++ show (sumar2 [1,2,3]))
  --putStrLn("06 - duplicaCabeza1 [2,3]: "                       ++ show (duplicaCabeza1 [2,3]))
  --putStrLn("06 - duplicaCabeza1 texto: "                       ++ show (duplicaCabeza1 "texto"))
  --putStrLn("07 - duplicaCabeza2 [1,3]: "                       ++ show (duplicaCabeza2 [1,3]))
  --putStrLn("08 - dividir 5 2: "                                ++ show (dividir 5 2))
  --putStrLn("09 - sumar3 5 2: "                                 ++ show (sumar3 5 2))
  --putStrLn("10 - sumarle4 1: "                                 ++ show (sumarle4 1))
  --putStrLn("11 - lstcnc: "                                     ++ show lstcnc)
  --putStrLn("12 - zplst: "                                      ++ show zplst)
  --putStrLn("13 - zplst2: "                                     ++ show zplst2)
  --putStrLn("14 - unzipi zplst: "                               ++ show (unzipi zplst))
  --putStrLn("15 - map sumarle4 lstcnc: "                        ++ show lstMapped)
  --putStrLn("16 - mapi sumarle4 lstcnc: "                       ++ show lstMapped2)
  --putStrLn("16 - map (\\x -> x*x) [1..10]: "                   ++ show lstMapped3)
  --putStrLn("17 - primos: "                                     ++ show primos) -- Solo los primos entre 2 y 100
  --putStrLn("18 - polidivisible 1024: "                         ++ show (polidivisible 1024))
  --putStrLn("19 - polidivisible 1025: "                         ++ show (polidivisible 1025))
  --putStrLn("20 - reescribe POTATO reglas: "                    ++ show (reescribe "POTATO" reglas))
  --putStrLn("21 - reescribe SALUDO reglas: "                    ++ show (reescribe "SALUDO" reglas))
  --putStrLn("22 - reescritura reglas [...]: "                   ++ show (reescritura reglas ["SALUDO","EJECUTANDO","DESPEDIDA"]))
  --putStrLn("23 - existencia2 [-1,6,5]: "                       ++ show (existencia2 [-1,6,5]))
  --putStrLn("24 - ultimo patatas: "                             ++ show (ultimo "patatas"))
  --putStrLn ""

  --putStrLn("z - 1: retrieveStock cosa  'plato'       = " ++ show ( retrieveStock2 cosa  "plato"))
  --putStrLn("z - 2: retrieveStock cosa  'cosa'        = " ++ show ( retrieveStock2 cosa  "cosa"))
  --putStrLn("z - 3: retrieveStock cosa2 'plato'       = " ++ show ( retrieveStock2 cosa2 "plato"))
  --putStrLn("z - 4: retrieveStock cosa2 'plato hondo' = " ++ show ( retrieveStock2 cosa2 "plato hondo"))
  --putStrLn("z - 5: retrieveStock cosa2 'platob'      = " ++ show ( retrieveStock2 cosa2 "platob"))
  --putStrLn("z - 6: retrieveStock cosa  'cosa '       = " ++ show ( retrieveStock2 cosa  "cosa "))
  --putStrLn("z - 7: retrieveStock cosa2 'plato '      = " ++ show ( retrieveStock2 cosa2 "plato "))
  --putStrLn("z - 8: retrieveStock cosa2 'platon'      = " ++ show ( retrieveStock2 cosa2 "platon"))
    --putStrLn("z - 9: comparable                        = " ++ show( comparable '-' 'a' ))
    --putStrLn("z - 9: comparable                        = " ++ show(  (ord '-')  ))
    --putStrLn("z - 9: comparable                        = " ++ show(  (ord 'a')  ))
  --putStrLn("z - 10: head                             = " ++ show( head [ROOTNODE [INNERNODE 'b' []], INNERNODE 'a' []] ))
  --putStrLn("z - 11: drop                             = " ++ show( drop 1 [ROOTNODE [INNERNODE 'b' []], INNERNODE 'a' []] ))
  --putStrLn("z - 12: drop                             = " ++ show( drop 1 [ROOTNODE [INNERNODE 'b' []]] ))
  --putStrLn("z - 13: drop                             = " ++ show( drop 1 (drop 1 [ROOTNODE [INNERNODE 'b' []]] )) )
  --putStrLn("z - 14: head                             = " ++ show( head [cosa] ))
  --putStrLn("z - 15: retrieveStock cosa3 'platon'     = " ++ show ( retrieveStock cosa3 "platon"))
  --putStrLn ""

  --putStrLn("z - 9: updateStock (ROOTNODE []) 'plato' = " ++ show ( updateStock (ROOTNODE []) "plato" 8))
  --putStrLn("z - 10: updateStock cosa 'alato'         = " ++ show ( updateStock cosa "alato" 88))
  --putStrLn("z - 11: updateStock cosa 'plato'         = " ++ show ( updateStock cosa "plato" 99))
  --putStrLn("z - 12: retrieveStock cosa 'plato'       = " ++ show ( retrieveStock (updateStock cosa "plato" 99) "plato" ))
  --putStrLn ""

  --putStrLn("z - 13: entuplar                         = " ++show (entuplar cosa2 ["plato","platon","plato hondo"] ))
  --putStrLn ""
  --putStrLn("z - 14: listStock cosa4 ''               = " ++show (listStock cosa4 ""))
  --putStrLn("z - 15: listStock2 cosa4 pa              = " ++show (listStock cosa4 "plato hondo"))
  --putStrLn("z - 16: listStock2 cosa4 pa              = " ++show (listStock2 cosa4 "pa"))
  --putStrLn("z - 17: hijos cosa4 pa                   = " ++show (hijos2 "plato" cosa4 ))
  --putStrLn ""
  --putStrLn("z - 18: retrieveStock cosa2 'plato hondo' = " ++ show ( retrieveStock cosa4 "plato hondo 1"))
    --putStrLn("z - 19: retrieveStock cosa2 'plato hondo' = " ++ show( updateStock cosa5 "zor" 10))
    --putStrLn("z - 19: retrieveStock cosa2 'plato hondo' = " ++ show( updateStock cosa5 "linterna" 90))
    --putStrLn("z - 19: retrieveStock cosa2 'plato hondo' = " ++ show( updateStock cosa6 "a" 2))
    --putStrLn("z - 19: retrieveStock cosa2 'plato hondo' = " ++ show( updateStock cosa6 "c" 2))
    --putStrLn("z - 19: retrieveStock cosa2 'plato hondo' = " ++ show( updateStock cosa6 "z" 2))
    --putStrLn("z - 19: retrieveStock cosa2 'plato hondo' = " ++ show( updateStock ( updateStock cosa5 "z" (-9)) "zor" (-98)))
  --putStrLn ""

    --putStrLn("z - Test01 = " ++show ( updateStock createStock "hamburger" 14 ))
    
    --mainLoop (updateStock createStock "hamburger" 14)
    --mainLoop (updateStock createStock "mango" 20)

    --writeFile fileName (show ( mainLoop s))


    --putStrLn("z - 99:  = " ++ show( listStock cosa7 ""))
    --putStrLn("z - 99:  = " ++ show( listStock2 cosa7 ""))
    --putStrLn("z - 99:  = " ++ show( updateStock cosa7 "p" 2))
    putStrLn ""
    putStrLn ""
    putStrLn("z - 99:  = " ++ show( listStock cosa8 ""))
    putStrLn("z - 99:  = " ++ show( listStock2 cosa8 ""))
    putStrLn("z - 99:  = " ++ show(    (updateStock (updateStock cosa8 "patatas fritas" 3) "patatas fritas" 2)      )  )
    putStrLn("z - 99:  = " ++ show(    listStock(updateStock (updateStock cosa8 "patatas fritas" 3) "patatas fritas" 2) ""     )  )
    putStrLn ""
    putStrLn ""
    putStrLn("z - 99:  = " ++ show( listStock cosa8 ""))
    putStrLn("z - 99:  = " ++ show( listStock2 cosa8 ""))
    putStrLn("z - 99:  = " ++ show(    updateStock(updateStock (updateStock cosa8 "patatas fritas" 3) "patatas fritas" 2) "p" 99     )  )
    putStrLn("z - 99:  = " ++ show(    listStock(updateStock(updateStock (updateStock cosa8 "patatas fritas" 3) "patatas fritas" 2) "p" 99) ""     )  )