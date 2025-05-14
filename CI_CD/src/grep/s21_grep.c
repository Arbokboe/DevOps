#include "s21_grep.h"
int main(int argc, char *argv[]) {
  flags opt = {0};
  CheckFlags(argc, argv, &opt);
  if (ErrorOptions(argc, argv, &opt)) {
    ProcessGrepFiles(argc, argv, &opt);
  }
  return 0;
}

void ParseFlags(int argc, char *argv[], flags *opt) {
  int currentFlag = getopt_long(argc, argv, "e:f:ivclnhso", NULL, NULL);
  for (; !opt->error_option && !opt->f_no_pattern_er && currentFlag != -1;
       currentFlag = getopt_long(argc, argv, "e:f:ivclnhso", NULL, NULL)) {
    switch (currentFlag) {
      case 'e':
        opt->e = 1;
        AddPatternToRegex(opt->regex_pattern, optarg, 1);
        break;
      case 'i':
        opt->i = 1;
        break;
      case 'v':
        opt->v = 1;
        break;
      case 'c':
        opt->c = 1;
        break;
      case 'l':
        opt->l = 1;
        break;
      case 'n':
        opt->n = 1;
        break;
      case 'h':
        opt->h = 1;
        break;
      case 's':
        opt->s = 1;
        break;
      case 'f':
        opt->f = 1;
        if (optarg != NULL) {
          optionF(optarg, opt);
        }
        break;
      case 'o':
        opt->o = 1;
        break;
      case '?':
        opt->error_option = 1;
        break;
    }
  }
}

void CheckFlags(int argc, char *argv[], flags *opt) {
  ParseFlags(argc, argv, opt);
  if (!opt->e && !opt->f) {
    AddPatternToRegex(opt->regex_pattern, argv[optind], 0);
  } else {
    opt->regex_pattern[strlen(opt->regex_pattern) - 1] = '\0';
  }
}

int ErrorOptions(int argc, char *argv[], flags *opt) {
  int flag_there = 1;
  if (opt->f_no_pattern_er) {
    fprintf(stderr, "No such file or directory.\n");
    flag_there = 0;
  } else if (!argv[optind] || (optind == 1 && argc == 2)) {
    fprintf(stderr,
            "usage: grep [-abcdDEFGHhIiJLlMmnOopqRSsUVvwXxZz] [-A num] [-B "
            "num] [-C[num]]\n\t[-e pattern] [-f file] [--binary-files=value] "
            "[--color=when]\n\t[--context[=num]] [--directories=action] "
            "[--label] [--line-buffered]\n\t[--null] [pattern] [file ...]");
    flag_there = 0;
  }
  return flag_there;
}

void ProcessGrepFiles(int argc, char *argv[], flags *opt) {
  int only_file = CheckFile(argv, opt);
  if (opt->e != 1 && opt->f != 1) {
    optind++;
  }
  while (optind < argc) {
    FILE *file = fopen(argv[optind], "r");
    if (file == NULL) {
      if (opt->s != 1) {
        fprintf(stderr, "No such file or directory.\n");
      }
    } else {
      SearchPattern(file, argv[optind], opt, only_file);
      fclose(file);
    }
    optind++;
  }
}

int SearchPattern(FILE *file, char *file_name, flags *opt, int only_file) {
  regex_t preg;
  regmatch_t arr_match_reg[1];
  int num_match = 0;
  int num_str_file = 0;
  opt->cflags =
      (opt->i) ? REG_ICASE | REG_NEWLINE | REG_EXTENDED : REG_EXTENDED;
  if (regcomp(&preg, opt->regex_pattern, opt->cflags)) {
    fprintf(stderr, "Failed to compile regex\n");
  }
  while (fgets(opt->strs_file, BUFFER, file) != NULL) {
    num_str_file++;
    char *str = opt->strs_file;
    if (opt->o && !opt->v &&
        (!regexec(&preg, str,
                  sizeof((arr_match_reg)) / sizeof((arr_match_reg)[0]),
                  arr_match_reg, 0))) {
      OutputMatchingStrings(opt, only_file, file_name, &num_match, num_str_file,
                            &preg);
    } else if (regexec(&preg, opt->strs_file, 0, NULL, 0) == 0 && !opt->v &&
               strcmp(opt->strs_file, "\n")) {
      OutputMatchingStrings(opt, only_file, file_name, &num_match, num_str_file,
                            &preg);
    } else if (regexec(&preg, opt->strs_file, 0, NULL, 0) != 0 && opt->v) {
      OutputMatchingStrings(opt, only_file, file_name, &num_match, num_str_file,
                            &preg);
    }
  }
  OutputCount(opt, only_file, file_name, num_match);
  OutputMatchingFiles(opt, file_name, num_match);
  regfree(&preg);
  return 1;
}

int CheckFile(char *argv[], flags *opt) {
  int ValideOpt;
  if (opt->e || opt->f) {
    if (argv[optind + 1] == NULL) {
      ValideOpt = 0;
    } else {
      ValideOpt = 1;
    }
  } else {
    if (argv[optind + 2] == NULL) {
      ValideOpt = 0;
    } else {
      ValideOpt = 1;
    }
  }
  return ValideOpt;
}

void OutputMatchingStrings(flags *opt, int only_file, char *file_name,
                           int *num_match, int num_str_file, regex_t *preg) {
  (*num_match)++;
  if (!opt->c && !opt->l) {
    OutputFilename(only_file, file_name, opt);
    if (opt->o && !opt->v) {
      OptionO(opt, preg, num_str_file);
    } else {
      if (opt->n) {
        printf("%d:", num_str_file);
      }
      if (opt->o && !opt->v) {
        OptionO(opt, preg, num_str_file);
      } else {
        fputs(opt->strs_file, stdout);
      }
      if (opt->strs_file[strlen(opt->strs_file)] == '\0' &&
          opt->strs_file[strlen(opt->strs_file) - 1] != '\n')
        printf("\n");
    }
  }
}

void optionF(char *optarg, flags *opt) {
  char temp_str_file[BUFFER];  // массив строк где хранится содержимое файла
  FILE *temp_file_reg = fopen(optarg, "r");
  if (temp_file_reg != NULL) {
    while (fgets(temp_str_file, BUFFER, temp_file_reg) != NULL) {
      if (temp_str_file[0] == '\n') {
        continue;
      }
      if (temp_str_file[strlen(temp_str_file) - 1] == '\n')
        temp_str_file[strlen(temp_str_file) - 1] = '\0';
      AddPatternToRegex(opt->regex_pattern, temp_str_file, 1);
    }
  } else {
    opt->f_no_pattern_er = 1;
  }
  if (temp_file_reg != NULL) {
    fclose(temp_file_reg);
  }
}

void AddPatternToRegex(char *all_patterns, char *pattern, int reg_operator) {
  if (pattern) {
    strcat(all_patterns, pattern);
    if (reg_operator) {
      all_patterns = strcat(all_patterns, "|");
    }
  }
}

void OptionO(flags *opt, regex_t *preg, int num_str_file) {
  char *str = opt->strs_file;
  regmatch_t arr_match_reg[1];
  regoff_t len;
  while (!regexec(preg, str,
                  sizeof((arr_match_reg)) / sizeof((arr_match_reg)[0]),
                  arr_match_reg, 0)) {
    len = arr_match_reg[0].rm_eo - arr_match_reg[0].rm_so;
    if (opt->n) {
      printf("%d:", num_str_file);
    }
    printf("%.*s\n", (int)len, str + arr_match_reg[0].rm_so);
    str += arr_match_reg[0].rm_eo;
  }
}

void OutputFilename(int only_file, char *file_name, flags *opt) {
  if (only_file && !opt->h) {
    printf("%s:", file_name);
  }
}

void OutputCount(flags *opt, int only_file, char *file_name, int num_match) {
  if (opt->c) {
    OutputFilename(only_file, file_name, opt);
    if (!opt->l) {
      printf("%d\n", num_match);
    } else if (opt->l && num_match > 1) {
      printf("%d\n", 1);
    } else {
      printf("%d\n", num_match);
    }
  }
}

void OutputMatchingFiles(flags *opt, char *file_name, int num_match) {
  if (opt->l && num_match) {
    printf("%s\n", file_name);
  }
}
