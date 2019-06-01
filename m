From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat,  1 Jun 2019 14:54:28 +0900
Subject: [PATCH] nvme-cli: update command message for "help"
Message-ID: <20190601055428.17906-1-minwoo.im.dev@gmail.com>

The "help" subcommand will show the man page, not the help message which
is printed out to stdout by --help option.  The previous message might
make confusions between man page and --help options so that it needs to
be updated.

Cc: Keith Busch <kbusch at kernel.org>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 plugin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugin.c b/plugin.c
index 4750df6..8fd0605 100644
--- a/plugin.c
+++ b/plugin.c
@@ -91,7 +91,7 @@ void general_help(struct plugin *plugin)
 					plugin->commands[i]->help);
 
 	printf("  %-*s %s\n", padding, "version", "Shows the program version");
-	printf("  %-*s %s\n", padding, "help", "Display this help");
+	printf("  %-*s %s\n", padding, "help", "Display the man page");
 	printf("\n");
 
 	if (plugin->name)
-- 
2.21.0
