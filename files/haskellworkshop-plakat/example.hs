primzahlen :: [Int]
primzahlen = filterPrimzahl [2..] where
  filterPrimzahl (p:xs) = 
    p : filterPrimzahl
    	[x | x <- xs, x `mod` p /= 0]