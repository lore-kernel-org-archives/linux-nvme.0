From: jsmart2021@gmail.com (James Smart)
Date: Tue, 19 Sep 2017 16:33:56 -0700
Subject: [PATCH v2] nvmet_fc: ensure target queue id within range.
Message-ID: <20170919233356.15403-1-jsmart2021@gmail.com>

When searching for queue id's ensure they are within the expected range

Signed-off-by: James Smart <james.smart at broadcom.com>

---
v2: v1 did a >= check, should be > check only

 drivers/nvme/target/fc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 0d262052a19a..75b1752e8375 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -776,6 +776,9 @@ nvmet_fc_find_target_queue(struct nvmet_fc_tgtport *tgtport,
 	u16 qid = nvmet_fc_getqueueid(connection_id);
 	unsigned long flags;
 
+	if (qid > NVMET_NR_QUEUES)
+		return NULL;
+
 	spin_lock_irqsave(&tgtport->lock, flags);
 	list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
 		if (association_id == assoc->association_id) {
-- 
2.13.1
