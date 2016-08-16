From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 16 Aug 2016 12:46:26 +0300
Subject: [PATCH v3 nvme-cli 3/4] fabrics: Allow discover params to come from a
 conf file
In-Reply-To: <1471340787-26922-1-git-send-email-sagi@grimberg.me>
References: <1471340787-26922-1-git-send-email-sagi@grimberg.me>
Message-ID: <1471340787-26922-4-git-send-email-sagi@grimberg.me>

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
 fabrics.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 1bcd6fc8cf17..6bbe239c1f70 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -56,6 +56,8 @@ struct config {
 
 #define BUF_SIZE		4096
 #define PATH_NVME_FABRICS	"/dev/nvme-fabrics"
+#define PATH_NVMF_DISC		"/etc/nvme/discovery.conf"
+#define MAX_DISC_ARGS		10
 
 enum {
 	OPT_INSTANCE,
@@ -578,6 +580,66 @@ static int do_discover(char *argstr, bool connect)
 	return ret;
 }
 
+static int discover_from_conf_file(const char *desc, char *argstr,
+		const struct argconfig_commandline_options *opts, bool connect)
+{
+	FILE *f;
+	char line[256], *ptr, *args, **argv;
+	int argc, err, ret = 0;
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
+		if (!args) {
+			fprintf(stderr, "failed to strdup args\n");
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		argv = calloc(MAX_DISC_ARGS, BUF_SIZE);
+		if (!argv) {
+			fprintf(stderr, "failed to allocate argv vector\n");
+			free(args);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		argc = 0;
+		argv[argc++] = "discover";
+		while ((ptr = strsep(&args, " =\n")) != NULL)
+			argv[argc++] = ptr;
+
+		argconfig_parse(argc, argv, desc, opts, &cfg, sizeof(cfg));
+
+		err = build_options(argstr, BUF_SIZE);
+		if (err) {
+			ret = err;
+			continue;
+		}
+
+		err = do_discover(argstr, connect);
+		if (err) {
+			ret = err;
+			continue;
+		}
+
+		free(args);
+		free(argv);
+	}
+
+out:
+	fclose(f);
+	return ret;
+}
+
 int discover(const char *desc, int argc, char **argv, bool connect)
 {
 	char argstr[BUF_SIZE];
@@ -600,11 +662,16 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 
 	cfg.nqn = NVME_DISC_SUBSYS_NAME;
 
-	ret = build_options(argstr, BUF_SIZE);
-	if (ret)
-		return ret;
+	if (!cfg.transport && !cfg.traddr) {
+		return discover_from_conf_file(desc, argstr,
+				command_line_options, connect);
+	} else {
+		ret = build_options(argstr, BUF_SIZE);
+		if (ret)
+			return ret;
 
-	return do_discover(argstr, connect);
+		return do_discover(argstr, connect);
+	}
 }
 
 int connect(const char *desc, int argc, char **argv)
-- 
1.9.1
