From: hch@lst.de (Christoph Hellwig)
Date: Fri, 21 Apr 2017 10:50:02 +0200
Subject: [PATCH 4/7] nvmet/fc: fix endianess annoations for
 nvmet_fc_format_rsp_hdr
In-Reply-To: <20170421085005.5945-1-hch@lst.de>
References: <20170421085005.5945-1-hch@lst.de>
Message-ID: <20170421085005.5945-5-hch@lst.de>

The passed in desc_len is a big endian value, so mark it as such.

Found by sparse.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 3626dd8cc8a1..d504c52ac9cb 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1058,7 +1058,7 @@ EXPORT_SYMBOL_GPL(nvmet_fc_unregister_targetport);
 
 
 static void
-nvmet_fc_format_rsp_hdr(void *buf, u8 ls_cmd, u32 desc_len, u8 rqst_ls_cmd)
+nvmet_fc_format_rsp_hdr(void *buf, u8 ls_cmd, __be32 desc_len, u8 rqst_ls_cmd)
 {
 	struct fcnvme_ls_acc_hdr *acc = buf;
 
-- 
2.11.0
