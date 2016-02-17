(ns update-gist
  (:require [clojure.java.shell :as sh]
            [clojure.string :as str]))

(defn say [& things] (apply println "***" things))

(let [filename (second *command-line-args*)
      _ (say "filename" filename)
      file-contents (slurp filename)
      gist-id (-> file-contents
                  str/split-lines
                  first
                  (str/split #";;")
                  second
                  str/trim)
      _ (say "gist id" gist-id)
      url (:out (sh/sh "gist" "-u" gist-id filename))]
  (say "url" url)
  (say "done - id added to " filename))
