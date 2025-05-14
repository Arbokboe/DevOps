#include "s21_cat.h"

int main(int argc, char *argv[]) {
  (void)argv;
  flag opt = {0, 0, 0, 0, 0, 0};
  ParseFlag(argc, argv, &opt);
  ParseFile(argc, argv, &opt);
  return 0;
}

void ParseFlag(int argc, char *argv[], flag *opt) {
  struct option LongOptions[] = {{"number-nonblank", 0, NULL, 'b'},
                                 {"number", 0, NULL, 'n'},
                                 {"squeeze-blank", 0, NULL, 's'},
                                 {NULL, 0, NULL, 0}};
  int current_flag = getopt_long(argc, argv, "beEvnstT", LongOptions, NULL);
  for (; current_flag != -1;
       current_flag = getopt_long(argc, argv, "bevEnstT", LongOptions, NULL)) {
    if (current_flag == 'b') {
      opt->b = 1;
    }
    if (current_flag == 'e') {
      opt->e = 1;
      opt->v = 1;
    }
    if (current_flag == 'v') {
      opt->v = 1;
    }
    if (current_flag == 'E') {
      opt->e = 1;
    }
    if (current_flag == 'n') {
      opt->n = 1;
    }
    if (current_flag == 's') {
      opt->s = 1;
    }
    if (current_flag == 't') {
      opt->t = 1;
      opt->v = 1;
    }
    if (current_flag == 'T') {
      opt->t = 1;
    }
  }
}

void ParseFile(int argc, char *argv[], flag *opt) {
  for (int i = 1; i < argc; i++) {
    if (*argv[i] != '-') {
      OpenFile(argv[i], opt);
    }
  }
}

void OpenFile(char *input_file, flag *opt) {
  FILE *fp = fopen(input_file, "r");
  if (fp == NULL) {
    printf("No such file or directory - %s\n", input_file);
  } else {
    char m;
    int str_count = 1, new_line = 1, second_empty = 0, third_empty = 0;
    m = fgetc(fp);
    while (!feof(fp)) {
      if (opt->s && m == '\n' && new_line && third_empty) {
        third_empty = -1;
      }
      if (opt->n && new_line && !opt->b && third_empty != -1) {
        printf("%6d\t", str_count++);
      }
      if (opt->b && new_line && m != '\n') {
        printf("%6d\t", str_count++);
      }
      if (opt->e && m == '\n' && !third_empty && opt->s) {
        printf("$");
      } else {
        if (opt->e && m == '\n' && !opt->s) {
          printf("$");
        }
      }
      if (opt->v) {
        if (m < 32 && m != 9 && m != 10)
          if (m += 64) printf("^");
        if (m == 127)
          if ((m = '?')) printf("^");
      }
      if (opt->t && m == '\t') {
        printf("^");
        m = 'I';
      }
      if (third_empty != -1) {
        printf("%c", m);
      }
      new_line = (m == '\n') ? 1 : 0;
      third_empty = (new_line && second_empty) ? 1 : 0;
      second_empty = (m == '\n' && new_line) ? 1 : 0;
      m = fgetc(fp);
    }
    fclose(fp);
  }
}
