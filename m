From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 22 May 2019 19:39:49 +0300
Subject: [PATCH 5/9] nvme: fix coding style issue
In-Reply-To: <1558543193-24752-1-git-send-email-maxg@mellanox.com>
References: <1558543193-24752-1-git-send-email-maxg@mellanox.com>
Message-ID: <1558543193-24752-6-git-send-email-maxg@mellanox.com>

It's more common to use the following coding style:
if (condition) {
   do_that;
   do_this;
} else if (condition2) {
   do_this;
} else {
   do_that;
}

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 nvme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/nvme.c b/nvme.c
index 7cf7225..62f01c8 100644
--- a/nvme.c
+++ b/nvme.c
@@ -982,11 +982,11 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
 		for (i = 0; i < 1024; i++)
 			if (ns_list[i])
 				printf("[%4u]:%#x\n", i, le32_to_cpu(ns_list[i]));
-	}
-	else if (err > 0)
+	} else if (err > 0) {
 		show_nvme_status(err);
-	else
+	} else {
 		perror("id namespace list");
+	}
 
 	close(fd);
 
-- 
1.8.3.1
