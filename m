From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 10 Jul 2017 17:24:02 +0300
Subject: [PATCH 1/1] nvmet: avoid unneeded assignment of submit_bio return
 value
Message-ID: <1499696642-16717-1-git-send-email-maxg@mellanox.com>

We actually using the cookie returned from the last submit_bio
call.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/io-cmd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 4012879..3b4d47a 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -85,7 +85,7 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 			bio_set_op_attrs(bio, op, op_flags);
 
 			bio_chain(bio, prev);
-			cookie = submit_bio(prev);
+			submit_bio(prev);
 		}
 
 		sector += sg->length >> 9;
-- 
1.7.1
