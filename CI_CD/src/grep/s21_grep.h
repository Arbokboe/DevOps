#ifndef S21_GREP_H
#define S21_GREP_H

#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFFER 2048

typedef struct {
  int e, f, i, v, c, l, n, h, s, o, error_option, cflags, f_no_pattern_er;
  char regex_pattern[BUFFER];
  char strs_file[BUFFER];
} flags;

void CheckFlags(int argc, char *argv[], flags *opt);
void ParseFlags(int argc, char *argv[], flags *opt);
int ErrorOptions(int argc, char *argv[], flags *opt);
void ProcessGrepFiles(int argc, char *argv[], flags *opt);
int SearchPattern(FILE *file, char *file_name, flags *opt, int only_file);
int CheckFile(char *argv[], flags *opt);
void OutputMatchingStrings(flags *opt, int only_file, char *file_name,
                           int *num_match, int num_str_file, regex_t *preg);
void OutputFilename(int only_file, char *file_name, flags *opt);
void optionF(char *optarg, flags *opt);
void OptionO(flags *opt, regex_t *preg, int num_str_file);
void OutputCount(flags *opt, int only_file, char *file_name, int num_match);
void OutputMatchingFiles(flags *opt, char *file_name, int num_match);
void AddPatternToRegex(char *all_patterns, char *pattern, int reg_operator);

#endif
