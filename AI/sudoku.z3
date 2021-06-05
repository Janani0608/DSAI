(set-option :produce-models true)
(declare-datatypes () ((Col x0 x1 x2 x3 x4 x5 x6 x7 x8)))
(declare-datatypes () ((Row y0 y1 y2 y3 y4 y5 y6 y7 y8)))
(declare-fun Board (Col Row) Int)


; Fill in the missing constraints into the designated sections


;;;;;; --- BEGIN-CONSTRAINTS-1 --- 

; ** Sudoku constraints **
; TODO constraints for 1.

; Constraint specifications to check if te rows have distinct values
(assert (distinct (Board x0 y0) (Board x0 y1) (Board x0 y2) (Board x0 y3) (Board x0 y4) (Board x0 y5) (Board x0 y6) (Board x0 y7) (Board x0 y8)))
(assert (distinct (Board x1 y0) (Board x1 y1) (Board x1 y2) (Board x1 y3) (Board x1 y4) (Board x1 y5) (Board x1 y6) (Board x1 y7) (Board x1 y8)))
(assert (distinct (Board x2 y0) (Board x2 y1) (Board x2 y2) (Board x2 y3) (Board x2 y4) (Board x2 y5) (Board x2 y6) (Board x2 y7) (Board x2 y8)))
(assert (distinct (Board x3 y0) (Board x3 y1) (Board x3 y2) (Board x3 y3) (Board x3 y4) (Board x3 y5) (Board x3 y6) (Board x3 y7) (Board x3 y8)))
(assert (distinct (Board x4 y0) (Board x4 y1) (Board x4 y2) (Board x4 y3) (Board x4 y4) (Board x4 y5) (Board x4 y6) (Board x4 y7) (Board x4 y8)))
(assert (distinct (Board x5 y0) (Board x5 y1) (Board x5 y2) (Board x5 y3) (Board x5 y4) (Board x5 y5) (Board x5 y6) (Board x5 y7) (Board x5 y8)))
(assert (distinct (Board x6 y0) (Board x6 y1) (Board x6 y2) (Board x6 y3) (Board x6 y4) (Board x6 y5) (Board x6 y6) (Board x6 y7) (Board x6 y8)))
(assert (distinct (Board x7 y0) (Board x7 y1) (Board x7 y2) (Board x7 y3) (Board x7 y4) (Board x7 y5) (Board x7 y6) (Board x7 y7) (Board x7 y8)))
(assert (distinct (Board x8 y0) (Board x8 y1) (Board x8 y2) (Board x8 y3) (Board x8 y4) (Board x8 y5) (Board x8 y6) (Board x8 y7) (Board x8 y8)))

;Constraint specifications to check if the columns have distinct values
(assert (distinct (Board x0 y0) (Board x1 y0) (Board x2 y0) (Board x3 y0) (Board x4 y0) (Board x5 y0) (Board x6 y0) (Board x7 y0) (Board x8 y0)))
(assert (distinct (Board x0 y1) (Board x1 y1) (Board x2 y1) (Board x3 y1) (Board x4 y1) (Board x5 y1) (Board x6 y1) (Board x7 y1) (Board x8 y1)))
(assert (distinct (Board x0 y2) (Board x1 y2) (Board x2 y2) (Board x3 y2) (Board x4 y2) (Board x5 y2) (Board x6 y2) (Board x7 y2) (Board x8 y2)))
(assert (distinct (Board x0 y3) (Board x1 y3) (Board x2 y3) (Board x3 y3) (Board x4 y3) (Board x5 y3) (Board x6 y3) (Board x7 y3) (Board x8 y3)))
(assert (distinct (Board x0 y4) (Board x1 y4) (Board x2 y4) (Board x3 y4) (Board x4 y4) (Board x5 y4) (Board x6 y4) (Board x7 y4) (Board x8 y4)))
(assert (distinct (Board x0 y5) (Board x1 y5) (Board x2 y5) (Board x3 y5) (Board x4 y5) (Board x5 y5) (Board x6 y5) (Board x7 y5) (Board x8 y5)))
(assert (distinct (Board x0 y6) (Board x1 y6) (Board x2 y6) (Board x3 y6) (Board x4 y6) (Board x5 y6) (Board x6 y6) (Board x7 y6) (Board x8 y6)))
(assert (distinct (Board x0 y7) (Board x1 y7) (Board x2 y7) (Board x3 y7) (Board x4 y7) (Board x5 y7) (Board x6 y7) (Board x7 y7) (Board x8 y7)))
(assert (distinct (Board x0 y8) (Board x1 y8) (Board x2 y8) (Board x3 y8) (Board x4 y8) (Board x5 y8) (Board x6 y8) (Board x7 y8) (Board x8 y8)))

;Constraint specifications to check if individual 3x3 cells have distinct values

;square 1: top left
(assert (distinct (Board y0 x0) (Board y0 x1) (Board y0 x2) (Board y1 x0) (Board y1 x1) (Board y1 x2) (Board y2 x0) (Board y2 x1) (Board y2 x2)))

;square 2: top center
(assert (distinct (Board y0 x3) (Board y0 x4) (Board y0 x5) (Board y1 x3) (Board y1 x4) (Board y1 x5) (Board y2 x3) (Board y2 x4) (Board y2 x5)))

;square 3: top right
(assert (distinct (Board y0 x6) (Board y0 x7) (Board y0 x8) (Board y1 x6) (Board y1 x7) (Board y1 x8) (Board y2 x6) (Board y2 x7) (Board y2 x8)))
;;END square 1: top left

;;square 4: middle left
(assert (distinct (Board y3 x0) (Board y3 x1) (Board y3 x2) (Board y4 x0) (Board y4 x1) (Board y4 x2) (Board y5 x0) (Board y5 x1) (Board y5 x2)))

;square 5: middle center
(assert (distinct (Board y3 x3) (Board y3 x4) (Board y3 x5) (Board y4 x3) (Board y4 x4) (Board y4 x5) (Board y5 x3) (Board y5 x4) (Board y5 x5)))

;square 6: middle right
(assert (distinct (Board y3 x6) (Board y3 x7) (Board y3 x8) (Board y4 x6) (Board y4 x7) (Board y4 x8) (Board y5 x6) (Board y5 x7) (Board y5 x8)))

;square 7: bottom left
(assert (distinct (Board y6 x0) (Board y6 x1) (Board y6 x2) (Board y7 x0) (Board y7 x1) (Board y7 x2) (Board y8 x0) (Board y8 x1) (Board y8 x2)))

;square 8: bottom center
(assert (distinct (Board y6 x3) (Board y6 x4) (Board y6 x5) (Board y7 x3) (Board y7 x4) (Board y7 x5) (Board y8 x3) (Board y8 x4) (Board y8 x5)))

;square 9: bottom right
(assert (distinct (Board y6 x6) (Board y6 x7) (Board y6 x8) (Board y7 x6) (Board y7 x7) (Board y7 x8) (Board y8 x6) (Board y8 x7) (Board y8 x8)))


(assert (and (= (Board y0 x5) 5) (= (Board y1 x1) 5) (= (Board y1 x2) 1) (= (Board y1 x4) 7) (= (Board y2 x3) 6) (= (Board y3 x3) 4) (= (Board y3 x6) 6) (= (Board y4 x1) 9) (= (Board y6 x3) 3) (= (Board y6 x4) 8) (= (Board y7 x8) 2) (= (Board y8 x4) 2) (= (Board y8 x7) 6)))

;;;;;; --- END-CONSTRAINTS-1 ---



;;;;;; --- BEGIN-CONSTRAINTS-2 --- 

; ** Constraints for top left square **
; TODO constraints for 2.

(assert (or 
		(and 
			(> (Board y0 x0) 4)
			(<= (Board y0 x2) 4)
			(<= (Board y2 x0) 4)
			(<= (Board y2 x2) 4)
 		) 
		(and 
			(<= (Board y0 x0) 4)
                 	(> (Board y0 x2) 4)
			(<= (Board y2 x0) 4)
			(<= (Board y2 x2) 4)
		) 
		(and 
			(<= (Board y0 x0) 4)
                 	(<= (Board y0 x2) 4)
			(> (Board y2 x0) 4)
			(<= (Board y2 x2) 4)
		) 
		(and 
			(<= (Board y0 x0) 4)
                 	(<= (Board y0 x2) 4)
			(<= (Board y2 x0) 4)
			(> (Board y2 x2) 4)
		)
	)
)

;;;;;; --- END-CONSTRAINTS-2 ---



;;;;;; --- BEGIN-CONSTRAINTS-3 --- 

; ** Constraints for top right square **
; TODO constraints for 3.

(assert (= 
		(+ (Board y6 x0) (Board y7 x0) (Board y8 x0))
		(+ (Board y6 x1) (Board y7 x1) (Board y8 x1))
		(+ (Board y6 x2) (Board y7 x2) (Board y8 x2))
	)
)

;;;;;; --- END-CONSTRAINTS-3 ---



;;;;;; --- BEGIN-CONSTRAINTS-4 --- 

; ** Constraints for middle left square **
; TODO constraints for 4.

(assert (and 
		(or 
			(= (Board y3 x0) (+ (Board y3 x1) 1))
			(= (Board y3 x0) (+ (Board y4 x0) 1))
		)
		(or 
			(= (Board y3 x2) (+ (Board y3 x1) 1))
			(= (Board y3 x2) (+ (Board y4 x2) 1))
		)
		(or 
			(= (Board y5 x0) (+ (Board y4 x0) 1))
			(= (Board y5 x0) (+ (Board y5 x1) 1))
		)
		(or 
			(= (Board y5 x2) (+ (Board y4 x2) 1))
			(= (Board y5 x2) (+ (Board y5 x1) 1))
		)
	)
)

;;;;;; --- END-CONSTRAINTS-4 ---



;;;;;; --- BEGIN-CONSTRAINTS-5 --- 

; ** Constraints for center square **
; TODO constraints for 5.

(assert (and 
		(= (+ (Board y3 x4) (Board y3 x5)) 13)
		(= (/ (Board y5 x5) (Board y4 x5)) 2)
		(= (- (Board y5 x3) (Board y5 x4)) 6)
	)
)

;;;;;; --- END-CONSTRAINTS-5 ---



;;;;;; --- BEGIN-CONSTRAINTS-6 --- 

; ** Constraints for center right square **
; TODO constraints for 6.

(assert 
	(= (+ (Board y3 x7) (Board y4 x6) (Board y5 x7) (Board y4 x8)) (* (Board y4 x7) 3))
)

;;;;;; --- END-CONSTRAINTS-6 ---



;;;;;; --- BEGIN-CONSTRAINTS-7 --- 

; ** Constraints for bottom left square **
; TODO constraints for 7.

(assert (and
		(< (Board y6 x0) (Board y7 x0))
		(< (Board y7 x0) (Board y8 x0))
		(< (Board y6 x1) (Board y7 x1))
		(< (Board y7 x1) (Board y8 x1))
		(< (Board y6 x2) (Board y7 x2))
		(< (Board y7 x2) (Board y8 x2))
	)
)

;;;;;; --- END-CONSTRAINTS-7 ---



;;;;;; --- BEGIN-CONSTRAINTS-8 --- 

; ** Constraints for bottom middle square **
; TODO constraints for 8.



;;;;;; --- END-CONSTRAINTS-8 ---



;;;;;; --- BEGIN-CONSTRAINTS-9 --- 

; ** Constraints for bottom right square **
; TODO constraints for 9.

(assert (or 
		(and 
			(or 
				(= (Board y6 x6) 1)
				(= (Board y6 x6) 3)
				(= (Board y6 x6) 5)
				(= (Board y6 x6) 7)
				(= (Board y6 x6) 9)
			)
			(or 
				(= (Board y6 x8) 1)
				(= (Board y6 x8) 3)
				(= (Board y6 x8) 5)
				(= (Board y6 x8) 7)
				(= (Board y6 x8) 9)
			)
			(or 
				(= (Board y8 x6) 1)
				(= (Board y8 x6) 3)
				(= (Board y8 x6) 5)
				(= (Board y8 x6) 7)
				(= (Board y8 x6) 9)
			)
			(or 
				(= (Board y8 x8) 1)
				(= (Board y8 x8) 3)
				(= (Board y8 x8) 5)
				(= (Board y8 x8) 7)
				(= (Board y8 x8) 9)
			)
			(or
				(= (Board y7 x7) 2)
				(= (Board y7 x7) 4)
				(= (Board y7 x7) 6)
				(= (Board y7 x7) 8)
			)
		)
		(and 
			(or 
				(= (Board y6 x6) 2)
				(= (Board y6 x6) 4)
				(= (Board y6 x6) 6)
				(= (Board y6 x6) 8)
			)
			(or 
				(= (Board y6 x8) 2)
				(= (Board y6 x8) 4)
				(= (Board y6 x8) 6)
				(= (Board y6 x8) 8)
			)
			(or 
				(= (Board y8 x6) 2)
				(= (Board y8 x6) 4)
				(= (Board y8 x6) 6)
				(= (Board y8 x6) 8)
			)
			(or 
				(= (Board y8 x8) 2)
				(= (Board y8 x8) 4)
				(= (Board y8 x8) 6)
				(= (Board y8 x8) 8)
			)
			(or
				(= (Board y7 x7) 1)
				(= (Board y7 x7) 3)
				(= (Board y7 x7) 5)
				(= (Board y7 x7) 7)
				(= (Board y7 x7) 9)
			)
		)
	)
)

;;;;;; --- END-CONSTRAINTS-9 ---



;;;;;; --- BEGIN-CONSTRAINTS-DOMAIN ---

; Each cell may be assigned only to integer values between 1 and 9:

(assert (and (< (Board x0 y0) 10) (> (Board x0 y0) 0)))
(assert (and (< (Board x0 y1) 10) (> (Board x0 y1) 0)))
(assert (and (< (Board x0 y2) 10) (> (Board x0 y2) 0)))
(assert (and (< (Board x0 y3) 10) (> (Board x0 y3) 0)))
(assert (and (< (Board x0 y4) 10) (> (Board x0 y4) 0)))
(assert (and (< (Board x0 y5) 10) (> (Board x0 y5) 0)))
(assert (and (< (Board x0 y6) 10) (> (Board x0 y6) 0)))
(assert (and (< (Board x0 y7) 10) (> (Board x0 y7) 0)))
(assert (and (< (Board x0 y8) 10) (> (Board x0 y8) 0)))
(assert (and (< (Board x1 y0) 10) (> (Board x1 y0) 0)))
(assert (and (< (Board x1 y1) 10) (> (Board x1 y1) 0)))
(assert (and (< (Board x1 y2) 10) (> (Board x1 y2) 0)))
(assert (and (< (Board x1 y3) 10) (> (Board x1 y3) 0)))
(assert (and (< (Board x1 y4) 10) (> (Board x1 y4) 0)))
(assert (and (< (Board x1 y5) 10) (> (Board x1 y5) 0)))
(assert (and (< (Board x1 y6) 10) (> (Board x1 y6) 0)))
(assert (and (< (Board x1 y7) 10) (> (Board x1 y7) 0)))
(assert (and (< (Board x1 y8) 10) (> (Board x1 y8) 0)))
(assert (and (< (Board x2 y0) 10) (> (Board x2 y0) 0)))
(assert (and (< (Board x2 y1) 10) (> (Board x2 y1) 0)))
(assert (and (< (Board x2 y2) 10) (> (Board x2 y2) 0)))
(assert (and (< (Board x2 y3) 10) (> (Board x2 y3) 0)))
(assert (and (< (Board x2 y4) 10) (> (Board x2 y4) 0)))
(assert (and (< (Board x2 y5) 10) (> (Board x2 y5) 0)))
(assert (and (< (Board x2 y6) 10) (> (Board x2 y6) 0)))
(assert (and (< (Board x2 y7) 10) (> (Board x2 y7) 0)))
(assert (and (< (Board x2 y8) 10) (> (Board x2 y8) 0)))
(assert (and (< (Board x3 y0) 10) (> (Board x3 y0) 0)))
(assert (and (< (Board x3 y1) 10) (> (Board x3 y1) 0)))
(assert (and (< (Board x3 y2) 10) (> (Board x3 y2) 0)))
(assert (and (< (Board x3 y3) 10) (> (Board x3 y3) 0)))
(assert (and (< (Board x3 y4) 10) (> (Board x3 y4) 0)))
(assert (and (< (Board x3 y5) 10) (> (Board x3 y5) 0)))
(assert (and (< (Board x3 y6) 10) (> (Board x3 y6) 0)))
(assert (and (< (Board x3 y7) 10) (> (Board x3 y7) 0)))
(assert (and (< (Board x3 y8) 10) (> (Board x3 y8) 0)))
(assert (and (< (Board x4 y0) 10) (> (Board x4 y0) 0)))
(assert (and (< (Board x4 y1) 10) (> (Board x4 y1) 0)))
(assert (and (< (Board x4 y2) 10) (> (Board x4 y2) 0)))
(assert (and (< (Board x4 y3) 10) (> (Board x4 y3) 0)))
(assert (and (< (Board x4 y4) 10) (> (Board x4 y4) 0)))
(assert (and (< (Board x4 y5) 10) (> (Board x4 y5) 0)))
(assert (and (< (Board x4 y6) 10) (> (Board x4 y6) 0)))
(assert (and (< (Board x4 y7) 10) (> (Board x4 y7) 0)))
(assert (and (< (Board x4 y8) 10) (> (Board x4 y8) 0)))
(assert (and (< (Board x5 y0) 10) (> (Board x5 y0) 0)))
(assert (and (< (Board x5 y1) 10) (> (Board x5 y1) 0)))
(assert (and (< (Board x5 y2) 10) (> (Board x5 y2) 0)))
(assert (and (< (Board x5 y3) 10) (> (Board x5 y3) 0)))
(assert (and (< (Board x5 y4) 10) (> (Board x5 y4) 0)))
(assert (and (< (Board x5 y5) 10) (> (Board x5 y5) 0)))
(assert (and (< (Board x5 y6) 10) (> (Board x5 y6) 0)))
(assert (and (< (Board x5 y7) 10) (> (Board x5 y7) 0)))
(assert (and (< (Board x5 y8) 10) (> (Board x5 y8) 0)))
(assert (and (< (Board x6 y0) 10) (> (Board x6 y0) 0)))
(assert (and (< (Board x6 y1) 10) (> (Board x6 y1) 0)))
(assert (and (< (Board x6 y2) 10) (> (Board x6 y2) 0)))
(assert (and (< (Board x6 y3) 10) (> (Board x6 y3) 0)))
(assert (and (< (Board x6 y4) 10) (> (Board x6 y4) 0)))
(assert (and (< (Board x6 y5) 10) (> (Board x6 y5) 0)))
(assert (and (< (Board x6 y6) 10) (> (Board x6 y6) 0)))
(assert (and (< (Board x6 y7) 10) (> (Board x6 y7) 0)))
(assert (and (< (Board x6 y8) 10) (> (Board x6 y8) 0)))
(assert (and (< (Board x7 y0) 10) (> (Board x7 y0) 0)))
(assert (and (< (Board x7 y1) 10) (> (Board x7 y1) 0)))
(assert (and (< (Board x7 y2) 10) (> (Board x7 y2) 0)))
(assert (and (< (Board x7 y3) 10) (> (Board x7 y3) 0)))
(assert (and (< (Board x7 y4) 10) (> (Board x7 y4) 0)))
(assert (and (< (Board x7 y5) 10) (> (Board x7 y5) 0)))
(assert (and (< (Board x7 y6) 10) (> (Board x7 y6) 0)))
(assert (and (< (Board x7 y7) 10) (> (Board x7 y7) 0)))
(assert (and (< (Board x7 y8) 10) (> (Board x7 y8) 0)))
(assert (and (< (Board x8 y0) 10) (> (Board x8 y0) 0)))
(assert (and (< (Board x8 y1) 10) (> (Board x8 y1) 0)))
(assert (and (< (Board x8 y2) 10) (> (Board x8 y2) 0)))
(assert (and (< (Board x8 y3) 10) (> (Board x8 y3) 0)))
(assert (and (< (Board x8 y4) 10) (> (Board x8 y4) 0)))
(assert (and (< (Board x8 y5) 10) (> (Board x8 y5) 0)))
(assert (and (< (Board x8 y6) 10) (> (Board x8 y6) 0)))
(assert (and (< (Board x8 y7) 10) (> (Board x8 y7) 0)))
(assert (and (< (Board x8 y8) 10) (> (Board x8 y8) 0)))

;;;;;; --- END-CONSTRAINTS-DOMAIN ---



; Compute solution

(check-sat)



; Print solution, line by line

(get-value ((Board x0 y0)))
(get-value ((Board x1 y0)))
(get-value ((Board x2 y0)))
(get-value ((Board x3 y0)))
(get-value ((Board x4 y0)))
(get-value ((Board x5 y0)))
(get-value ((Board x6 y0)))
(get-value ((Board x7 y0)))
(get-value ((Board x8 y0)))
(get-value ((Board x0 y1)))
(get-value ((Board x1 y1)))
(get-value ((Board x2 y1)))
(get-value ((Board x3 y1)))
(get-value ((Board x4 y1)))
(get-value ((Board x5 y1)))
(get-value ((Board x6 y1)))
(get-value ((Board x7 y1)))
(get-value ((Board x8 y1)))
(get-value ((Board x0 y2)))
(get-value ((Board x1 y2)))
(get-value ((Board x2 y2)))
(get-value ((Board x3 y2)))
(get-value ((Board x4 y2)))
(get-value ((Board x5 y2)))
(get-value ((Board x6 y2)))
(get-value ((Board x7 y2)))
(get-value ((Board x8 y2)))
(get-value ((Board x0 y3)))
(get-value ((Board x1 y3)))
(get-value ((Board x2 y3)))
(get-value ((Board x3 y3)))
(get-value ((Board x4 y3)))
(get-value ((Board x5 y3)))
(get-value ((Board x6 y3)))
(get-value ((Board x7 y3)))
(get-value ((Board x8 y3)))
(get-value ((Board x0 y4)))
(get-value ((Board x1 y4)))
(get-value ((Board x2 y4)))
(get-value ((Board x3 y4)))
(get-value ((Board x4 y4)))
(get-value ((Board x5 y4)))
(get-value ((Board x6 y4)))
(get-value ((Board x7 y4)))
(get-value ((Board x8 y4)))
(get-value ((Board x0 y5)))
(get-value ((Board x1 y5)))
(get-value ((Board x2 y5)))
(get-value ((Board x3 y5)))
(get-value ((Board x4 y5)))
(get-value ((Board x5 y5)))
(get-value ((Board x6 y5)))
(get-value ((Board x7 y5)))
(get-value ((Board x8 y5)))
(get-value ((Board x0 y6)))
(get-value ((Board x1 y6)))
(get-value ((Board x2 y6)))
(get-value ((Board x3 y6)))
(get-value ((Board x4 y6)))
(get-value ((Board x5 y6)))
(get-value ((Board x6 y6)))
(get-value ((Board x7 y6)))
(get-value ((Board x8 y6)))
(get-value ((Board x0 y7)))
(get-value ((Board x1 y7)))
(get-value ((Board x2 y7)))
(get-value ((Board x3 y7)))
(get-value ((Board x4 y7)))
(get-value ((Board x5 y7)))
(get-value ((Board x6 y7)))
(get-value ((Board x7 y7)))
(get-value ((Board x8 y7)))
(get-value ((Board x0 y8)))
(get-value ((Board x1 y8)))
(get-value ((Board x2 y8)))
(get-value ((Board x3 y8)))
(get-value ((Board x4 y8)))
(get-value ((Board x5 y8)))
(get-value ((Board x6 y8)))
(get-value ((Board x7 y8)))
(get-value ((Board x8 y8)))

