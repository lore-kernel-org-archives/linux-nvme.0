From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 19 Aug 2018 12:57:31 -0400
Subject: [PATCH] nvme-cli: fix sparse warnings for declaration
Message-ID: <20180819165731.29284-1-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 argconfig.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/argconfig.c b/argconfig.c
index 3fda34d..2689cd3 100644
--- a/argconfig.c
+++ b/argconfig.c
@@ -304,6 +304,7 @@ int argconfig_parse(int argc, char *argv[], const char *program_desc,
 			char **opts = ((char **)value_addr);
 			int remaining_space = CFG_MAX_SUBOPTS;
 			int enddefault = 0;
+			int r;
 			while (0 && *opts != NULL) {
 				if (*opts == END_DEFAULT)
 					enddefault = 1;
@@ -317,9 +318,8 @@ int argconfig_parse(int argc, char *argv[], const char *program_desc,
 				opts += 2;
 			}
 
-			int r =
-			    argconfig_parse_subopt_string(optarg, opts,
-							  remaining_space);
+			r = argconfig_parse_subopt_string(optarg, opts,
+					remaining_space);
 			if (r == 2) {
 				fprintf(stderr,
 					"Error Parsing Sub-Options: Too many options!\n");
@@ -335,6 +335,7 @@ int argconfig_parse(int argc, char *argv[], const char *program_desc,
 			   s->config_type == CFG_FILE_RP ||
 			   s->config_type == CFG_FILE_WP) {
 			const char *fopts = "";
+			FILE *f;
 			if (s->config_type == CFG_FILE_A)
 				fopts = "a";
 			else if (s->config_type == CFG_FILE_R)
@@ -348,7 +349,7 @@ int argconfig_parse(int argc, char *argv[], const char *program_desc,
 			else if (s->config_type == CFG_FILE_WP)
 				fopts = "w+";
 
-			FILE *f = fopen(optarg, fopts);
+			f = fopen(optarg, fopts);
 			if (f == NULL) {
 				fprintf(stderr, "Unable to open %s file: %s\n",
 					s->option, optarg);
@@ -372,6 +373,7 @@ int argconfig_parse_subopt_string(char *string, char **options,
 {
 	char **o = options;
 	char *tmp;
+	size_t toklen;
 
 	if (!string || !strlen(string)) {
 		*(o++) = NULL;
@@ -382,7 +384,6 @@ int argconfig_parse_subopt_string(char *string, char **options,
 	tmp = calloc(strlen(string) + 2, 1);
 	strcpy(tmp, string);
 
-	size_t toklen;
 	toklen = strcspn(tmp, "=");
 
 	if (!toklen) {
-- 
2.14.1
