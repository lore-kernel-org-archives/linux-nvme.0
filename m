From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 23:38:55 -0800
Subject: [PATCH v3 2/5] nvme-fabrics: add missing nvmf_ctrl_options
 documentation
In-Reply-To: <20181212073858.7102-1-sagi@grimberg.me>
References: <20181212073858.7102-1-sagi@grimberg.me>
Message-ID: <20181212073858.7102-3-sagi@grimberg.me>

Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 524a02a67817..28dc916ef26b 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -88,6 +88,9 @@ enum {
  * @max_reconnects: maximum number of allowed reconnect attempts before removing
  *              the controller, (-1) means reconnect forever, zero means remove
  *              immediately;
+ * @disable_sqflow: disable controller sq flow control
+ * @hdr_digest: generate/verify header digest (TCP)
+ * @data_digest: generate/verify data digest (TCP)
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
-- 
2.17.1
