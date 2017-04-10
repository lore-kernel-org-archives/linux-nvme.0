From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Mon, 10 Apr 2017 10:33:05 +0800
Subject: [PATCH] nvme-cli/list: fix when nvme device can not be open
Message-ID: <1491791585-18936-1-git-send-email-guanjunxiong@huawei.com>

This patch checks the validity of fd returned by open operation on
the nvme divices. For example, when a user who doesn't have the
permission to open the device trys to use nvme list command to list
nvme devices, the fd is returned as -1 and errno indicates permission
denied.
In addition,this patch closes the current open device before
processing the next device.
---
 nvme.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/nvme.c b/nvme.c
index 4cc5a96..d80883c 100644
--- a/nvme.c
+++ b/nvme.c
@@ -811,7 +811,8 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 	char path[256];
 	struct dirent **devices;
 	struct list_item *list_items;
-	unsigned int i, n, fd, ret;
+	unsigned int i, n, ret;
+	int fd;
 	int fmt;
 	const char *desc = "Retrieve basic information for the given device";
 	struct config {
@@ -846,7 +847,13 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 	for (i = 0; i < n; i++) {
 		snprintf(path, sizeof(path), "%s%s", dev, devices[i]->d_name);
 		fd = open(path, O_RDONLY);
+		if (fd < 0) {
+			fprintf(stderr, "can not open %s: %s\n", path,
+					strerror(errno));
+			return errno;
+		}
 		ret = get_nvme_info(fd, &list_items[i], path);
+		close(fd);
 		if (ret)
 			return ret;
 	}
-- 
2.7.4
