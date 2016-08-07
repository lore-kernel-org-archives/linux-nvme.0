From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  7 Aug 2016 15:19:25 +0300
Subject: [PATCH RFC nvme-cli 4/4] fabrics: Allow discover params to come from
 a conf file
In-Reply-To: <1470572365-20674-1-git-send-email-sagi@grimberg.me>
References: <1470572365-20674-1-git-send-email-sagi@grimberg.me>
Message-ID: <1470572365-20674-5-git-send-email-sagi@grimberg.me>

Allow the user to just run "nvme discover" or "nvme connect-all"
in case it finds a default /etc/nvme/nvmf_disc conf file.

We allow multiple discovery addresses by iterating over the
lines of the file and executing a discover (with or without
connect) for each line. We allow newlines and '#' prefixed comments.

The return value is or'ed on all discover attempts.

In order to minimize some parsing code, I just convert the
file line into an (argc, argv) pair and feed it to argconfig_parse()
which dictates that the file lines are identical to what one would
pass nvme discover <params>. I'm open to better ideas.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Not sure if anyone will find this useful, but worth a
shot.

 fabrics.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 8c1a8331cc45..53af68d66c57 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -50,6 +50,8 @@ struct config {
 
 #define BUF_SIZE		4096
 #define PATH_NVME_FABRICS	"/dev/nvme-fabrics"
+#define PATH_NVMF_DISC		"/etc/nvme/nvmf_disc"
+# define MAX_DISC_ARGS		10
 
 enum {
 	OPT_INSTANCE,
@@ -581,6 +583,48 @@ static int do_discover(char *argstr, bool connect)
 	return ret;
 }
 
+static int discover_from_conf_file(const char *desc, char *argstr,
+	const struct argconfig_commandline_options *opts, bool connect)
+{
+	FILE *f;
+	char line[255], *ptr, *args, **argv;
+	int argc, ret = 0;
+
+	f = fopen(PATH_NVMF_DISC, "r");
+	if (f == NULL) {
+		fprintf(stderr, "No discover params given and no %s conf\n", PATH_NVMF_DISC);
+		return -EINVAL;
+	}
+
+	while (fgets(line, sizeof(line), f) != NULL) {
+		if (line[0] == '#' || line[0] == '\n')
+			continue;
+
+		args = strdup(line);
+		if (!args)
+			continue;
+
+		argv = calloc(MAX_DISC_ARGS, BUF_SIZE);
+		if (!argv)
+			return -EINVAL;
+
+		argc = 0;
+		argv[argc++] = "discover";
+		while ((ptr = strsep(&args, " =")) != NULL)
+			argv[argc++] = ptr;
+
+		argconfig_parse(argc, argv, desc, opts, &cfg, sizeof(cfg));
+
+		ret |= do_discover(argstr, connect);
+
+		free(args);
+		free(argv);
+	}
+
+	fclose(f);
+	return ret;
+}
+
 int discover(const char *desc, int argc, char **argv, bool connect)
 {
 	char argstr[BUF_SIZE];
@@ -598,7 +642,11 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 
 	argconfig_parse(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
 
-	return do_discover(argstr, connect);
+	if (!cfg.transport && !cfg.traddr)
+		return discover_from_conf_file(desc, argstr,
+				command_line_options, connect);
+	else
+		return do_discover(argstr, connect);
 }
 
 int connect(const char *desc, int argc, char **argv)
-- 
1.9.1
