From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 22 May 2019 19:39:46 +0300
Subject: [PATCH 2/9] nvme: update description for "nvme list" command
In-Reply-To: <1558543193-24752-1-git-send-email-maxg@mellanox.com>
References: <1558543193-24752-1-git-send-email-maxg@mellanox.com>
Message-ID: <1558543193-24752-3-git-send-email-maxg@mellanox.com>

The "nvme list" command doesn't get any device handle as an input
argument. This operation prints out a basic information for all NVMe
namespaces in the system.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme.c b/nvme.c
index de77956..7cf7225 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1794,7 +1794,7 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 	struct list_item *list_items;
 	unsigned int list_cnt = 0;
 	int fmt, ret, fd, i, n;
-	const char *desc = "Retrieve basic information for the given device";
+	const char *desc = "Retrieve basic information for all NVMe namespaces";
 	struct config {
 		char *output_format;
 	};
-- 
1.8.3.1
