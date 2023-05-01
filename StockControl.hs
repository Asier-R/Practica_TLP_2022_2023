module StockControl where

data Stock = ROOTNODE [Stock] | INNERNODE Char [Stock] | INFONODE Int
  deriving (Show,Read,Eq)

-------------------------
-- FUNCIÓN CREATESTOCK --
-------------------------

-- FUNCIÓN QUE DEVUELVE UN STOCK VACÍO --
createStock :: Stock
createStock = ROOTNODE []

---------------------------
-- FUNCIÓN RETRIEVESTOCK --
---------------------------

-- FUNCIÓN QUE DEVUELVE EL NÚMERO DE UNIDADES DE UN PRODUCTO EN EL STOCK --
-- SI NO ESTÁ, DEBERÁ DEVOLVER -1                                        --

retrieveStock :: Stock         -> String -> Int
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

-------------------------
-- FUNCIÓN UPDATESTOCK --
-------------------------

-- FUNCIÓN QUE MODIFICA EL VALOR ASOCIADO A UN PRODUCTO EN EL STOCK --
-- SÓLO PUEDE ALMACENAR NÚMEROS MAYORES O IGUALES A 0               --

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
  |  compara st [p] ==  1  =  st : [updateStock (INNERNODE p []) ps u] 
  |  compara st [p] == -1  =  updateStock (INNERNODE p []) ps u : s
  where 
  compara :: Stock -> String -> Int 
  compara (INFONODE _)     "" = 0
  compara (INFONODE _)     p  = 1
  compara (INNERNODE c st) (p:ps)
    | c == p    =  0
    | c < p     =  1
    | otherwise = -1 


-----------------------
-- FUNCIÓN LISTSTOCK --
-----------------------

-- FUNCIÓN QUE DEVUELVE UNA LISTA PARES PRODUCTO-EXISTENCIA --
-- DEL CATÁLOGO QUE COMIENZAN POR LA CADENA PREFIJO p       --
listStock :: Stock -> String -> [(String,Int)]
listStock s p = [("SIN DESARROLLAR",0)]

-- FUNCIÓN GENÉRICA DE BACKTRACKING --
bt :: (a -> Bool) -> (a -> [a]) -> a -> [a]
bt    eS             c             n
  | eS n      = [n]
  | otherwise = concat (map (bt eS c) (c n))

