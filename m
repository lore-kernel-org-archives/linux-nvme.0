From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 19 Nov 2018 13:35:30 -0800
Subject: [PATCH] nvmet: use unlikely for req status check
Message-ID: <20181119213530.7417-1-chaitanya.kulkarni@wdc.com>

This patch adds unlikely in the nvmet request completion path for the 
status check in the low level function __nvmet_req_complete.
This is helpful in the scenario where host and target connection is
working smoothly.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e3e158ff207a..ac98e9212274 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -602,7 +602,7 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 	u32 old_sqhd, new_sqhd;
 	u16 sqhd;
 
-	if (status)
+	if (unlikely(status))
 		nvmet_set_status(req, status);
 
 	if (req->sq->size) {
-- 
2.17.0
