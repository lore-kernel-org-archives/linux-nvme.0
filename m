From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Dec 2018 09:53:18 +0100
Subject: [PATCH V2 01/12] nvme: remove nvme_common command cdw10 array
In-Reply-To: <20181212231148.4107-2-chaitanya.kulkarni@wdc.com>
References: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
 <20181212231148.4107-2-chaitanya.kulkarni@wdc.com>
Message-ID: <20181213085318.GB1611@lst.de>

This needs a little fix for lightnvm:

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index f145fc0220d6..b759c25c89c8 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -937,9 +937,9 @@ static int nvme_nvm_user_vcmd(struct nvme_ns *ns, int admin,
 	/* cdw11-12 */
 	c.ph_rw.length = cpu_to_le16(vcmd.nppas);
 	c.ph_rw.control  = cpu_to_le16(vcmd.control);
-	c.common.cdw10[3] = cpu_to_le32(vcmd.cdw13);
-	c.common.cdw10[4] = cpu_to_le32(vcmd.cdw14);
-	c.common.cdw10[5] = cpu_to_le32(vcmd.cdw15);
+	c.common.cdw13 = cpu_to_le32(vcmd.cdw13);
+	c.common.cdw14 = cpu_to_le32(vcmd.cdw14);
+	c.common.cdw15 = cpu_to_le32(vcmd.cdw15);
 
 	if (vcmd.timeout_ms)
 		timeout = msecs_to_jiffies(vcmd.timeout_ms);
