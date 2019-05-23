From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 23 May 2019 12:00:54 +0300
Subject: [PATCH 5/9] nvme: fix coding style issue
In-Reply-To: <1558602058-29434-1-git-send-email-maxg@mellanox.com>
References: <1558602058-29434-1-git-send-email-maxg@mellanox.com>
Message-ID: <1558602058-29434-6-git-send-email-maxg@mellanox.com>

It's more common to use the following coding style:
if (condition) {
   do_that;
   do_this;
} else if (condition2) {
   do_this;
} else {
   do_that;
}

Reviewed-by: Minwoo Im <minwoo.im at samsung.com>
Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 nvme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/nvme.c b/nvme.c
index fd86779..8edf398 100644
--- a/nvme.c
+++ b/nvme.c
@@ -985,11 +985,11 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
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
