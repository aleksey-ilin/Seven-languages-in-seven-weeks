;; Implement an unless with an else condition using macros.

(defmacro unless [test body1 body2]
    (list 'if (list 'not test) body1 body2))

(unless true (println "Test is false") (println "Test is true")) ;; Test is true
(unless false (println "Test is false") (println "Test is true")) ;; Test is false

;; Write a type using defrecord that implements a protocol.

(defprotocol Bottle
    (has-water [c]))

(defrecord SimpleBottle [water]
    Bottle
    ;; (has-water [_] (if (water) (println "The bottle is full") (println "The bottle is empty"))))
    (has-water [_] (println water)))

(def c (SimpleBottle. true))
(has-water c) ;;true
