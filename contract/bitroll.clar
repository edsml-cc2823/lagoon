;;defining 3 different maps, one linking employee to their unique wallet,
;;employee to their seniority,
;; seniority to pay amount.
(define-map employee_to_wallet { employee: string-utf8 } { wallet: principal })
(define-map employee_to_seniority { employee: string-utf8 } { seniority: uint })
(define-map payroll seniority pay uint)

;;different seniorities
(map-set payroll "Grade I" u500)
(map-set payroll "Grade II" u100)
(map-set payroll "Grade III" u80)
(map-set payroll "Grade IV" u50)
(map-set payroll "Grade V" u30)

;;This function takes an employee as input, retrieves their seniority level, 
;;and then uses that seniority level to look up the pay amount from the payroll map. 
;;If the pay amount is found, it is returned; otherwise, an error message is returned.

(define-public (get-payroll (employee-input: (string-utf8 50)))
  (let ((seniority-level (map-get? employee_to_seniority {employee: employee-input})))
    (if (is-none? seniority-level)
      (err "Employee not found")
      (let ((pay (map-get? payroll {seniority: (unwrap seniority-level "Seniority level not defined")})))
        (if (is-none? pay)
          (err "Pay not found")
          (ok (unwrap pay "Pay not found")))))))