From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  3 Jul 2018 15:09:24 +0300
Subject: [PATCH 1/2] fabrics: fail early if argconfig_parse failed
Message-ID: <20180703120925.1095-1-sagi@grimberg.me>

If user got params wrong or asked for --help,
we shouldn't try to execute the command.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 9a31f1719c3f..fadbc95b6daa 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -784,7 +784,9 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 		while ((ptr = strsep(&args, " =\n")) != NULL)
 			argv[argc++] = ptr;
 
-		argconfig_parse(argc, argv, desc, opts, &cfg, sizeof(cfg));
+		err = argconfig_parse(argc, argv, desc, opts, &cfg, sizeof(cfg));
+		if (err)
+			continue;
 
 		err = build_options(argstr, BUF_SIZE);
 		if (err) {
@@ -827,8 +829,10 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{NULL},
 	};
 
-	argconfig_parse(argc, argv, desc, command_line_options, &cfg,
+	ret = argconfig_parse(argc, argv, desc, command_line_options, &cfg,
 			sizeof(cfg));
+	if (ret)
+		return ret;
 
 	cfg.nqn = NVME_DISC_SUBSYS_NAME;
 
@@ -865,8 +869,10 @@ int connect(const char *desc, int argc, char **argv)
 		{NULL},
 	};
 
-	argconfig_parse(argc, argv, desc, command_line_options, &cfg,
+	ret = argconfig_parse(argc, argv, desc, command_line_options, &cfg,
 			sizeof(cfg));
+	if (ret)
+		return ret;
 
 	ret = build_options(argstr, BUF_SIZE);
 	if (ret)
@@ -971,7 +977,7 @@ int disconnect(const char *desc, int argc, char **argv)
 {
 	const char *nqn = "nqn name";
 	const char *device = "nvme device";
-	int ret = 0;
+	int ret;
 
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"nqn",    'n', "LIST", CFG_STRING, &cfg.nqn,    required_argument, nqn},
@@ -979,8 +985,11 @@ int disconnect(const char *desc, int argc, char **argv)
 		{NULL},
 	};
 
-	argconfig_parse(argc, argv, desc, command_line_options, &cfg,
+	ret = argconfig_parse(argc, argv, desc, command_line_options, &cfg,
 			sizeof(cfg));
+	if (ret)
+		return ret;
+
 	if (!cfg.nqn && !cfg.device) {
 		fprintf(stderr, "need a -n or -d argument\n");
 		return -EINVAL;
-- 
2.14.1
