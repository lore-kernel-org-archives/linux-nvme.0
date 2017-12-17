From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 17 Dec 2017 18:58:28 +0900
Subject: [PATCH V2 1/3] nvme-cli: add support alias command with Firmware
 Activate
Message-ID: <1513504708-30830-1-git-send-email-minwoo.im.dev@gmail.com>

Firmware Activate command were known as "Firmware Activate" in NVMe 1.0
and 1.1. It has been changed to "Firmware Commit" since 1.2.

This patch will make it support a single alias for every subcommands.
Also make "fw-activate" command to be registered in "fw-commit" as an
alias for backward compatibility.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 cmd_handler.h  | 20 ++++++++++++++++----
 nvme-builtin.h |  2 +-
 nvme.c         |  2 +-
 plugin.c       |  3 ++-
 plugin.h       |  1 +
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/cmd_handler.h b/cmd_handler.h
index b2e3e9d..d40740d 100644
--- a/cmd_handler.h
+++ b/cmd_handler.h
@@ -8,7 +8,7 @@
 #define NAME(n, d)
 
 #undef ENTRY
-#define ENTRY(n, h, f) \
+#define ENTRY(n, h, f, ...) \
 static int f(int argc, char **argv, struct command *command, struct plugin *plugin);
 
 #undef COMMAND_LIST
@@ -28,14 +28,26 @@ static int f(int argc, char **argv, struct command *command, struct plugin *plug
 #undef NAME
 #define NAME(n, d)
 
-#undef ENTRY
-#define ENTRY(n, h, f)			\
+#undef ENTRY_W_ALIAS
+#define ENTRY_W_ALIAS(n, h, f, a)	\
 static struct command f ## _cmd = {	\
 	.name = n, 			\
 	.help = h, 			\
 	.fn = f, 			\
+	.alias = a, 			\
 };
 
+#undef ENTRY_WO_ALIAS
+#define ENTRY_WO_ALIAS(n, h, f)		\
+	ENTRY_W_ALIAS(n, h, f, NULL)
+
+#undef ENTRY_SEL
+#define ENTRY_SEL(n, h, f, a, CMD, ...) CMD
+
+#undef ENTRY
+#define ENTRY(...) 		\
+	ENTRY_SEL(__VA_ARGS__, ENTRY_W_ALIAS, ENTRY_WO_ALIAS)(__VA_ARGS__)
+
 #undef COMMAND_LIST
 #define COMMAND_LIST(args...) args
 
@@ -54,7 +66,7 @@ static struct command f ## _cmd = {	\
 #define NAME(n, d)
 
 #undef ENTRY
-#define ENTRY(n, h, f) &f ## _cmd,
+#define ENTRY(n, h, f, ...) &f ## _cmd,
 
 #undef COMMAND_LIST
 #define COMMAND_LIST(args...)	\
diff --git a/nvme-builtin.h b/nvme-builtin.h
index b06eb34..85f9f0f 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -28,7 +28,7 @@ COMMAND_LIST(
 	ENTRY("set-feature", "Set a feature and show the resulting value", set_feature)
 	ENTRY("set-property", "Set a property and show the resulting value", set_property)
 	ENTRY("format", "Format namespace with new block format", format)
-	ENTRY("fw-activate", "Activate new firmware slot", fw_activate)
+	ENTRY("fw-commit", "Verify and commit firmware to a specific slot (fw-activate in old version < 1.2)", fw_commit, "fw-activate")
 	ENTRY("fw-download", "Download new firmware", fw_download)
 	ENTRY("admin-passthru", "Submit an arbitrary admin command, return results", admin_passthru)
 	ENTRY("io-passthru", "Submit an arbitrary IO command, return results", io_passthru)
diff --git a/nvme.c b/nvme.c
index 4b0b861..bb9feaa 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1780,7 +1780,7 @@ static char *nvme_fw_status_reset_type(__u32 status)
 	}
 }
 
-static int fw_activate(int argc, char **argv, struct command *cmd, struct plugin *plugin)
+static int fw_commit(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	const char *desc = "Verify downloaded firmware image and "\
 		"commit to specific firmware slot. Device is not automatically "\
diff --git a/plugin.c b/plugin.c
index 6ca7882..5eb12bf 100644
--- a/plugin.c
+++ b/plugin.c
@@ -133,7 +133,8 @@ int handle_plugin(int argc, char **argv, struct plugin *plugin)
 		if (!strcmp(str, "version"))
 			return version(plugin);
 		if (strcmp(str, cmd->name))
-			continue;
+			if (!cmd->alias || (cmd->alias && strcmp(str, cmd->alias)))
+				continue;
 
 		return (cmd->fn(argc, argv, cmd, plugin));
 	}
diff --git a/plugin.h b/plugin.h
index 68d93d1..91079fb 100644
--- a/plugin.h
+++ b/plugin.h
@@ -26,6 +26,7 @@ struct command {
 	char *name;
 	char *help;
 	int (*fn)(int argc, char **argv, struct command *command, struct plugin *plugin);
+	char *alias;
 };
 
 void usage(struct plugin *plugin);
-- 
2.7.4
