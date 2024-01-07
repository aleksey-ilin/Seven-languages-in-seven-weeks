;; Implement a function called (big st n) that returns true if a string st is longer than n characters.

(defn big [st n] (> (count st) n))

(println (big "Pavel" 2)) ;; true
(println (big "Pavel" 8)) ;; false

;; Write a function called (collection-type col) that returns :list, :map, or :vector based on the type of collection col.

(defn collection-type [col] (if (list? col) :list (if (map? col) :map (if (vector? col) :vector))))

(println (collection-type (list 1 2 3))) ;; :list
(println (collection-type {:name1 :Pavel :name2 :Petr :name3 :Parviz})) ;; map
(println (collection-type [1 2 3])) ;; :vector
