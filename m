From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Mon, 15 May 2017 18:01:19 +0800
Subject: [PATCH] nvme-fabrics: fix comment typo of nvmf_reg_write32
Message-ID: <1494842479-10556-1-git-send-email-guanjunxiong@huawei.com>

---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5b7386f..5f58342 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -232,7 +232,7 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read64);
 /**
  * nvmf_reg_write32() -  NVMe Fabrics "Property Write" API function.
  * @ctrl:	Host NVMe controller instance maintaining the admin
- *		queue used to submit the property read command to
+ *		queue used to submit the property write command to
  *		the allocated NVMe controller resource on the target system.
  * @off:	Starting offset value of the targeted property
  *		register (see the fabrics section of the NVMe standard).
-- 
2.7.4
