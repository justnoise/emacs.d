(defun draw-julia-fractal ()
  "Draws a julia fractal, cause I was curious about writing more elisp
uses netpbm image format: https://en.wikipedia.org/wiki/Netpbm_format
Inspired by https://www.reddit.com/r/dailyprogrammer/comments/4v5h3u/20160729_challenge_277_hard_trippy_julia_fractals/
and http://nullprogram.com/blog/2012/09/14/

Todo: add some randomness to the parameters
"
  (interactive)
  (pop-to-buffer (get-buffer-create "*trippypic*"))
  (let ((w 400) (h 400)
	(cr -0.191) (ci -.683)
	;; (cr (- (/ (random 10000) 5000.0) 1.0))
	;; (ci (- (/ (random 10000) 5000.0) 1.0))
	;;(randval (+ (/ (random 800) 900.0) 0.1)))
	(randval .75556))
    (message (format "%f  %f  %f" randval cr ci))
    (fundamental-mode)
    (erase-buffer)
    (set-buffer-multibyte nil)
    (insert (format "P6\n%d %d\n255\n" w h))
    (dotimes (y h)
      (dotimes (x w)
	(let ((zr (- (/ x w randval) 1.0))
	      (zi (- (/ y h randval) 1.0))
	      (i 0))
	  (while (and (< i 256)
		      (< (+ (* zr zr) (* zi zi)) 2))
	    (cl-psetq zr (+ (* zr zr) (- (* zi zi)) cr)
		   zi (+ (* (* zr zi) 2) ci)
		   i (+ i 1))
	    )
	  (insert-char i 3)
	  )))
    (image-mode)))


(defun draw-ascii-fractal ()
  "Draws an ASCII julia fractal, cause ASCII is cool."
  (interactive)
  (pop-to-buffer (get-buffer-create "*trippyascii*"))
  (let ((w 190) (h 50)
	(color-depth " .'`^\",:;Il!i><~+_-?][}{1)(|\/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$")
	(cr -0.221) (ci -.713)
	;; (cr (- (/ (random 10000) 5000.0) 1.0))
	;; (ci (- (/ (random 10000) 5000.0) 1.0))
        (randval (+ (/ (random 800) 900.0) 0.1)))
    (message (format "%f  %f  %f" randval cr ci))
    (fundamental-mode)
    (erase-buffer)
    (set-buffer-multibyte t)
    (dotimes (y h)
      (dotimes (x w)
	(let ((zr (- (/ x w randval) 1.0))
	      (zi (- (/ y h randval) 1.0))
	      (i 0))
	  (while (and (< i 256)
		      (< (+ (* zr zr) (* zi zi)) 2))
	    (cl-psetq zr (+ (* zr zr) (- (* zi zi)) cr)
		   zi (+ (* (* zr zi) 2) ci)
		   i (+ i 1))
	    )
	  (let ((depth (floor (* i (/ 68.0 256.0)))))
	    (insert (substring color-depth depth (+ 1 depth))))
	  ))
      (insert "\n"))
    ))
