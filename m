From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 30 May 2019 12:43:26 +0300
Subject: [PATCH 5/5] nvme: fix coding style issue
In-Reply-To: <1559209406-713-1-git-send-email-maxg@mellanox.com>
References: <1559209406-713-1-git-send-email-maxg@mellanox.com>
Message-ID: <1559209406-713-5-git-send-email-maxg@mellanox.com>

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
index 3310abd..2fd4362 100644
--- a/nvme.c
+++ b/nvme.c
@@ -988,11 +988,11 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
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
 
 close_fd:
 	close(fd);
-- 
1.8.3.1
