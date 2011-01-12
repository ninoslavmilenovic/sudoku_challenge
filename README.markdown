Ruby command line tool which solves sudoku puzzles.

The implementation (less than 10 lines) of the class method *Soduku.from_text* in lib/sudoku.rb has been removed. By studying the source code and not making ANY changes except for the one method, we would like you to make it work like the below example demonstrates. With the method implemented, the solver should be able to solve all of the included challenges.

Once solved, please save the implementation of *Soduku.from_text* in a [private gist](https://gist.github.com/) and provide us with the link.

    tel@tel-imac sudoku $ ruby sudoku.rb challenges/board_13.txt


    Input:
    ------------------------------
     4     3 |       6 |    9    |
     7  1    |    9  8 | 3       |
             |       7 |       6 |

     6       | 1     2 | 9     5 |
             |         |         |
     8     9 | 7     3 |       1 |

     1       | 8       |         |
           2 | 6  3    |    4  7 |
        6    | 9       | 8     2 |

    ------------------------------
    Solution (found in 80 iterations):
    ------------------------------
     4  5  3 | 2  1  6 | 7  9  8 |
     7  1  6 | 5  9  8 | 3  2  4 |
     2  9  8 | 3  4  7 | 1  5  6 |

     6  3  4 | 1  8  2 | 9  7  5 |
     5  7  1 | 4  6  9 | 2  8  3 |
     8  2  9 | 7  5  3 | 4  6  1 |

     1  4  7 | 8  2  5 | 6  3  9 |
     9  8  2 | 6  3  1 | 5  4  7 |
     3  6  5 | 9  7  4 | 8  1  2 |

    ------------------------------