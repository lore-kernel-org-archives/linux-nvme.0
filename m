From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Sat,  8 Jul 2017 17:36:45 -0700
Subject: [PATCH] nvme-cli: Fix to the logic of the nvme list-ns <device> -a
 command.
Message-ID: <1499560605-16815-1-git-send-email-chaitanya.kulkarni@hgst.com>

This fix will reverse the logic of the -a parm in the nvme list-ns
command. Currently, the -a option only shows the attached namespaces
and not all the namespaces. By removing the extra ! it will show attached
inactive namespaces with -a option as mentioned in the help text.

Example : Controller has 3 namespaces, two of them are not attached.

Default exection with ?!!? :-
$ nvme list-ns  /dev/nvme0 -a
[   0]:0x1

Execution with ?!? :-
 nvme list-ns  /dev/nvme0 -a
[   0]:0x1
[   1]:0x2
[   2]:0x3

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme.c b/nvme.c
index d64d042..a3abff0 100644
--- a/nvme.c
+++ b/nvme.c
@@ -560,7 +560,7 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
 	if (fd < 0)
 		return fd;
 
-	err = nvme_identify_ns_list(fd, cfg.namespace_id, !!cfg.all, ns_list);
+	err = nvme_identify_ns_list(fd, cfg.namespace_id, !cfg.all, ns_list);
 	if (!err) {
 		for (i = 0; i < 1024; i++)
 			if (ns_list[i])
-- 
2.7.4
