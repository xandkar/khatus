#include <signal.h>
#include <assert.h>
#include <ctype.h>
#include <errno.h>
#include <limits.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#include "khlib_log.h"
#include "khlib_time.h"

#define usage(...) {print_usage(); fprintf(stderr, "Error:\n    " __VA_ARGS__); exit(EXIT_FAILURE);}

#define MAX_LEN 20

char *argv0;

double  opt_interval = 1.0;
char   *opt_battery  = "BAT0";

void
print_usage()
{
	printf(
	    "%s: [OPT ...]\n"
	    "\n"
	    "OPT = -i int     # interval\n"
	    "    | -b string  # battery file name from /sys/class/power_supply/\n"
	    "    | -h         # help message (i.e. what you're reading now :) )\n",
	    argv0);
}

void
opt_parse(int argc, char **argv)
{
	char c;

	while ((c = getopt(argc, argv, "b:i:h")) != -1)
		switch (c) {
		case 'b':
			opt_battery = calloc(strlen(optarg), sizeof(char));
			strcpy(opt_battery, optarg);
			break;
		case 'i':
			opt_interval = atof(optarg);
			break;
		case 'h':
			print_usage();
			exit(EXIT_SUCCESS);
		case '?':
			if (optopt == 'b' || optopt == 'i')
				fprintf(stderr,
					"Option -%c requires an argument.\n",
					optopt);
			else if (isprint(optopt))
				fprintf (stderr,
					"Unknown option `-%c'.\n",
					optopt);
			else
				fprintf(stderr,
					"Unknown option character `\\x%x'.\n",
					optopt);
			exit(EXIT_FAILURE);
		default:
			assert(0);
		}
}

int
get_capacity(char *buf, char *path)
{
	FILE *fp;
	int cap;

	if (!(fp = fopen(path, "r")))
		khlib_fatal(
		    "Failed to open %s. errno: %d, msg: %s\n",
		    path,
		    errno,
		    strerror(errno)
		);

	switch (fscanf(fp, "%d", &cap)) {
	case -1: khlib_fatal("EOF\n");
	case  0: khlib_fatal("Read 0\n");
	case  1: break;
	default: assert(0);
	}
	fclose(fp);
	return snprintf(buf, 6, "%3d%%", cap);
}

int
main(int argc, char **argv)
{
	argv0 = argv[0];

	char  buf[10];
	char path[PATH_MAX];
	char *path_fmt = "/sys/class/power_supply/%s/capacity";
	struct timespec ti;

	opt_parse(argc, argv);
	ti = khlib_timespec_of_float(opt_interval);
	khlib_debug("opt_battery: \"%s\"\n", opt_battery);
	khlib_debug("opt_interval: %f\n", opt_interval);
	khlib_debug("ti: {tv_sec = %ld, tv_nsec = %ld}\n",ti.tv_sec,ti.tv_nsec);
	memset(path, '\0', PATH_MAX);
	snprintf(path, PATH_MAX, path_fmt, opt_battery);
	signal(SIGPIPE, SIG_IGN);

	for (;;) {
		get_capacity(buf, path);
		puts(buf);
		fflush(stdout);
		khlib_sleep(&ti);
	}
	return EXIT_SUCCESS;
}
