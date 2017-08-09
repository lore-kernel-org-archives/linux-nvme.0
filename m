From: kwan.huen@ssi.samsung.com (kwan.huen@ssi.samsung.com)
Date: Wed, 09 Aug 2017 11:26:29 -0700
Subject: [PATCH] nvme: fix directive command numd calculation
References: <CGME20170809182322epcas2p177ff5f42184c24dcab4a73a9c640916b@epcas2p1.samsung.com>
Message-ID: <1502303189-11939-1-git-send-email-kwan.huen@ssi.samsung.com>

From: "Kwan (Hingkwan) Huen-SSI" <kwan.huen@samsung.com>

The numd field of directive receive command takes number of dwords to 
transfer. This fix has the correct calculation for numd.

Signed-off-by: Kwan (Hingkwan) Huen-SSI <kwan.huen at samsung.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c49f1f8..95de9a5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -336,7 +336,7 @@ static int nvme_get_stream_params(struct nvme_ctrl *ctrl,
 
 	c.directive.opcode = nvme_admin_directive_recv;
 	c.directive.nsid = cpu_to_le32(nsid);
-	c.directive.numd = cpu_to_le32(sizeof(*s));
+	c.directive.numd = cpu_to_le32((sizeof(*s) >> 2) - 1);
 	c.directive.doper = NVME_DIR_RCV_ST_OP_PARAM;
 	c.directive.dtype = NVME_DIR_STREAMS;
 
-- 
2.7.4
