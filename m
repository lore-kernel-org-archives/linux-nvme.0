From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 12:43:08 +0200
Subject: [PATCH 1/2] nvme: fix byte swapping in the streams code
Message-ID: <20170714104309.10757-1-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c |  2 +-
 include/linux/nvme.h     | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb96f4a7ae3a..3b77cfe5aa1e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -336,7 +336,7 @@ static int nvme_get_stream_params(struct nvme_ctrl *ctrl,
 
 	c.directive.opcode = nvme_admin_directive_recv;
 	c.directive.nsid = cpu_to_le32(nsid);
-	c.directive.numd = sizeof(*s);
+	c.directive.numd = cpu_to_le32(sizeof(*s));
 	c.directive.doper = NVME_DIR_RCV_ST_OP_PARAM;
 	c.directive.dtype = NVME_DIR_STREAMS;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 6b8ee9e628e1..bc74da018bdc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -963,14 +963,14 @@ struct nvme_dbbuf {
 };
 
 struct streams_directive_params {
-	__u16	msl;
-	__u16	nssa;
-	__u16	nsso;
+	__le16	msl;
+	__le16	nssa;
+	__le16	nsso;
 	__u8	rsvd[10];
-	__u32	sws;
-	__u16	sgs;
-	__u16	nsa;
-	__u16	nso;
+	__le32	sws;
+	__le16	sgs;
+	__le16	nsa;
+	__le16	nso;
 	__u8	rsvd2[6];
 };
 
-- 
2.11.0
