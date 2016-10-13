From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Oct 2016 18:40:05 +0300
Subject: [PATCH nvme-cli] argconfig: Rewind optind before looping on
 getopt_long
Message-ID: <1476373205-30860-1-git-send-email-sagi@grimberg.me>

In conf file based discovery we can call argconfig_parse
multiple times.

Reported-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 argconfig.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/argconfig.c b/argconfig.c
index e2bb7ab26446..bda8b03c1cbd 100644
--- a/argconfig.c
+++ b/argconfig.c
@@ -193,6 +193,7 @@ int argconfig_parse(int argc, char *argv[], const char *program_desc,
 	short_opts[short_index++] = 'h';
 	short_opts[short_index] = 0;
 
+	optind = 0;
 	while ((c = getopt_long_only(argc, argv, short_opts, long_opts,
 				&option_index)) != -1) {
 		if (c != 0) {
-- 
2.7.4
