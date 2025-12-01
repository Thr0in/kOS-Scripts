// src/utils.ks
// Utility functions for general use.

// A switchBy function that mimics switch-case behavior.
// Takes a condition, a lexicon of cases (functions), and a default case (function).
global function switchBy {
    declare parameter condition.
    declare parameter cases.
    declare parameter defaultCase.

    if cases:haskey(condition) {
         cases[condition]().
    } else {
        defaultCase().
    }
}.
