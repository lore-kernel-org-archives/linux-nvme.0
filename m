From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Feb 2018 07:24:08 -0800
Subject: [PATCH 1/3] nvme-fabrics: don't check for non-NULL module in
 nvmf_register_transport
In-Reply-To: <20180222152410.19222-1-hch@lst.de>
References: <20180222152410.19222-1-hch@lst.de>
Message-ID: <20180222152410.19222-2-hch@lst.de>

THIS_MODULE evaluates to NULL when used from code built into the kernel,
thus breaking built-in transport modules.  Remove the bogus check.

Fixes: 0de5cd36 ("nvme-fabrics: protect against module unload during create_ctrl")
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5dd4ceefed8f..a1c58e35075e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -493,7 +493,7 @@ EXPORT_SYMBOL_GPL(nvmf_should_reconnect);
  */
 int nvmf_register_transport(struct nvmf_transport_ops *ops)
 {
-	if (!ops->create_ctrl || !ops->module)
+	if (!ops->create_ctrl)
 		return -EINVAL;
 
 	down_write(&nvmf_transports_rwsem);
-- 
2.14.2
