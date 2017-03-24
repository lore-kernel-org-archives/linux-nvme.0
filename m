From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu, 23 Mar 2017 20:41:26 -0700
Subject: [PATCH 5/6] nvmet_fc: Clear SG list to avoid double frees
In-Reply-To: <20170324034127.8676-1-jsmart2021@gmail.com>
References: <20170324034127.8676-1-jsmart2021@gmail.com>
Message-ID: <20170324034127.8676-6-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Clear SG list to avoid double frees of payload page list

Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/target/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 3a0f22e..2c0709f 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1624,6 +1624,8 @@ nvmet_fc_free_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 	for_each_sg(fod->data_sg, sg, fod->data_sg_cnt, count)
 		__free_page(sg_page(sg));
 	kfree(fod->data_sg);
+	fod->data_sg = NULL;
+	fod->data_sg_cnt = 0;
 }
 
 
-- 
2.9.3
