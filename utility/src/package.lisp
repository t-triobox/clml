;-*- coding: utf-8 -*-

(defpackage :clml.utility.csv
  (:use :common-lisp :iterate :parse-number)
  (:nicknames :csv)
  (:export #:read-csv-file
	   #:read-csv-stream
	   #:write-csv-file
	   #:write-csv-stream
	   #:read-csv-file-and-sort))

 (defpackage :clml.utility.priority-que
   (:nicknames :priority-que)
   (:use :cl :iterate)
   (:import-from :alexandria #:define-constant)
   
   #+allegro
   (:use :excl)
  (:export #:make-prique
           #:prique-empty-p
           #:prique-box-item
           #:insert-prique
           #:find-min-prique
           #:delete-min-prique
           #:union-prique
           #:after-decrease-key-prique
           ))

(defpackage :clml.utility.data
  (:use :common-lisp)
  (:export #:fetch))

(defpackage :clml.utility.r-datasets
  (:use :common-lisp :iterate :parse-number :drakma :clml.utility.data :clml.hjs.read-data) 
  (:nicknames :r-datasets)
  (:export 
           #:get-r-dataset-directory
           #:get-dataset 
           #:dataset-documentation
           #:inventory
           )
  (:documentation
   "
* Description
Makes datasets included with the R language distribution available as clml datasets.
R datasets are obtained csv files on Vincent Centarel's github repository.
More information on these datasets can be found at http://vincentarelbundock.github.com/Rdatasets

Because type information is not included it may be necessary to provide a type specification
for the columns in the csv file.

* Example
#+BEGIN_SRC lisp
CL-USER> (ql:quickload :clml.utility)
R-DATASETS> (defparameter dd (get-dataset-directory))
R-DATASETS> (inventory dd)
R-DATASETS> (inventory dd)
Package                   Item                      Title                     
------------------------- ------------------------- ------------------------- 
datasets                  AirPassengers             Monthly Airline Passenger Numbers 1949-1960 
datasets                  BJsales                   Sales Data with Leading Indicator 
datasets                  BOD                       Biochemical Oxygen Demand 
...

R-DATASETS>(dataset-documentation dd "datasets" "BOD")
  R: Biochemical Oxygen Demand

  BODR Documentation

   Biochemical Oxygen Demand 

  Description
    The BOD data frame has 6 rows and 2 columns giving the
  biochemical oxygen demand versus time in an evaluation of water
  quality.
  ...

R-DATASETS> (get-dataset dd "datasets" "BOD")
#<UNSPECIALIZED-DATASET >
DIMENSIONS:  | Time | demand
TYPES:      UNKNOWN | UNKNOWN | UNKNOWN
NUMBER OF DIMENSIONS: 3
DATA POINTS: 6 POINTS

#+END_SRC

* Other uses
This package can also be used as a tool for sharing or distributing bundles of datasets.
To do this a csv file which provides the directory of data sets must be made availabe
via a URL. The csv file MUST comply to the following format:
A header with following collumns
  - Package : package 
  - Item    : dataset name
  - Title   : Brief Description of dataset
  - csv     : URL where dataset is available
  - doc     : URL with documentation describing the dataset

The the contents of the file pointed to by doc ~doc~ can be plaintext of HTML.
If it is HTML the HTML tags will be stripped and what ever whitespace formatting will
be used. This field can be empty however the ~inventory~ method will be un available if it is

 
")
  )

