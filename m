From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Wed, 2 Aug 2017 15:51:09 +0800
Subject: [PATCH V2] nvme-cli/list: fix when nvme device can not be open
Message-ID: <1501660269-11024-1-git-send-email-guanjunxiong@huawei.com>

This patch checks the validity of fd returned by open operation on
the nvme divices. For example, when a user who doesn't have the
permission to open the device trys to use nvme list command to list
nvme devices, the fd is returned as -1 and errno indicates permission
denied.
In addition,this patch closes the current open device before
processing the next device.

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---

The V1 version was _applied_ in the mail list , but isn't applied into
nvme-cli mainstream. Here comes the new version:

change since V1:
* rebase latest master branch and fix conflicts
* add reviewed-by tag of Christoph

 nvme.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/nvme.c b/nvme.c
index 235a1bb..b4a039a 100644
--- a/nvme.c
+++ b/nvme.c
@@ -911,7 +911,13 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
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
2.11.1
