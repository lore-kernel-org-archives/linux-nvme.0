From: jsmart2021@gmail.com (James Smart)
Date: Thu, 20 Jun 2019 13:07:14 -0700
Subject: [PATCH] nvme-fcloop: Resole warnings on RCU usage and
Message-ID: <20190620200714.15709-1-jsmart2021@gmail.com>

With additional debugging enabled, seeing warnings for suspicious
RCU usage or Sleeping function called from invalid context.

These both map to allocation of a work structure which is currently
GFP_KERNEL, meaning it can sleep. For the RCU warning, the sequence
was sleeping while holding the RCU lock.

Convert the allocation to GFP_ATOMIC.

Signed-off-by: James Smart <jsmart2021 at gmail.com>
---
 drivers/nvme/target/fcloop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index e64969d2a7c5..b50b53db3746 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -535,7 +535,7 @@ fcloop_fcp_req(struct nvme_fc_local_port *localport,
 	if (!rport->targetport)
 		return -ECONNREFUSED;
 
-	tfcp_req = kzalloc(sizeof(*tfcp_req), GFP_KERNEL);
+	tfcp_req = kzalloc(sizeof(*tfcp_req), GFP_ATOMIC);
 	if (!tfcp_req)
 		return -ENOMEM;
 
-- 
2.13.7
