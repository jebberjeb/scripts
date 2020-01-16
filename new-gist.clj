(ns new-gist
  (:require [clojure.java.shell :as sh]
            [clojure.string :as str]))

(defn say [& things] (apply println "***" things))

(let [filename (second *command-line-args*)
      _ (say "filename" filename)
      url (:out (sh/sh "gist" filename))]
  (say "url" url)
  (spit filename (str ";; " (last (str/split url #"/"))
                      "\n"
                      (slurp filename)))
  (say "done - id added to " filename))
