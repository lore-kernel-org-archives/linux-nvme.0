From: jsmart2021@gmail.com (James Smart)
Date: Sat, 24 Dec 2016 09:46:42 -0800
Subject: [PATCH] nvmet_fc: Clear SG list to avoid double frees
Message-ID: <585eb482.c+IlMeE1LJXQhHJk%jsmart2021@gmail.com>


Clear SG list to avoid double frees of payload page list

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index ce1f08d..fe74fc6 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1616,6 +1616,8 @@ nvmet_fc_free_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 	for_each_sg(fod->data_sg, sg, fod->data_sg_cnt, count)
 		__free_page(sg_page(sg));
 	kfree(fod->data_sg);
+	fod->data_sg = NULL;
+	fod->data_sg_cnt = 0;
 }
 
 
-- 
2.5.0
