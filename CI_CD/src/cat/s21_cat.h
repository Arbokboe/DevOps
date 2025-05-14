#ifndef S21_CAT_H
#define S21_CAT_H

#include <getopt.h>
#include <stdio.h>

typedef struct {
  int b, e, s, t, n, v;
} flag;
void OpenFile(char *input_file, flag *opt);
void ParseFile(int argc, char *argv[], flag *opt);
void ParseFlag(int argc, char *argv[], flag *opt);

#endif
