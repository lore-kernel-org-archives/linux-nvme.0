From: jsmart2021@gmail.com (James Smart)
Date: Thu,  7 Sep 2017 16:27:28 -0700
Subject: [PATCH 4/5] nvmet-fcloop: remove use of FC-specific error codes
In-Reply-To: <20170907232729.28763-1-jsmart2021@gmail.com>
References: <20170907232729.28763-1-jsmart2021@gmail.com>
Message-ID: <20170907232729.28763-5-jsmart2021@gmail.com>

The FC-NVME transport loopback test module used the FC-specific error
codes in cases where it emulated a transport abort case. Instead of
using the FC-specific values, now use a generic value (NVME_SC_INTERNAL).

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fcloop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 1cb9847ec261..1fd1afbb8b2a 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -576,7 +576,7 @@ fcloop_tgt_fcp_abort(struct nvmet_fc_target_port *tgtport,
 	tfcp_req->aborted = true;
 	spin_unlock(&tfcp_req->reqlock);
 
-	tfcp_req->status = NVME_SC_FC_TRANSPORT_ABORTED;
+	tfcp_req->status = NVME_SC_INTERNAL;
 
 	/*
 	 * nothing more to do. If io wasn't active, the transport should
-- 
2.13.1
