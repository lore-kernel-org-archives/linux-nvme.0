From: keith.busch@intel.com (Keith Busch)
Date: Tue, 13 May 2014 10:32:46 -0600
Subject: [PATCH] NVMe: Fix nvme get/put queue semantics
Message-ID: <1399998766-5388-1-git-send-email-keith.busch@intel.com>

The routines to get and lock nvme queues required the caller to "put"
or "unlock" them even if getting one returned NULL. This patch fixes that.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cd8a8bc7..6d0c966 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -277,9 +277,17 @@ static struct nvme_queue *raw_nvmeq(struct nvme_dev *dev, int qid)
 
 static struct nvme_queue *get_nvmeq(struct nvme_dev *dev) __acquires(RCU)
 {
+	struct nvme_queue *nvmeq;
 	unsigned queue_id = get_cpu_var(*dev->io_queue);
+
 	rcu_read_lock();
-	return rcu_dereference(dev->queues[queue_id]);
+	nvmeq = rcu_dereference(dev->queues[queue_id]);
+	if (nvmeq)
+		return nvmeq;
+
+	rcu_read_unlock();
+	put_cpu_var(*dev->io_queue);
+	return NULL;
 }
 
 static void put_nvmeq(struct nvme_queue *nvmeq) __releases(RCU)
@@ -291,8 +299,15 @@ static void put_nvmeq(struct nvme_queue *nvmeq) __releases(RCU)
 static struct nvme_queue *lock_nvmeq(struct nvme_dev *dev, int q_idx)
 							__acquires(RCU)
 {
+	struct nvme_queue *nvmeq;
+
 	rcu_read_lock();
-	return rcu_dereference(dev->queues[q_idx]);
+	nvmeq = rcu_dereference(dev->queues[q_idx]);
+	if (nvmeq)
+		return nvmeq;
+
+	rcu_read_unlock();
+	return NULL;
 }
 
 static void unlock_nvmeq(struct nvme_queue *nvmeq) __releases(RCU)
@@ -801,7 +816,6 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
 	int result = -EBUSY;
 
 	if (!nvmeq) {
-		put_nvmeq(NULL);
 		bio_endio(bio, -EIO);
 		return;
 	}
@@ -876,10 +890,8 @@ static int nvme_submit_sync_cmd(struct nvme_dev *dev, int q_idx,
 	struct nvme_queue *nvmeq;
 
 	nvmeq = lock_nvmeq(dev, q_idx);
-	if (!nvmeq) {
-		unlock_nvmeq(nvmeq);
+	if (!nvmeq)
 		return -ENODEV;
-	}
 
 	cmdinfo.task = current;
 	cmdinfo.status = -EINTR;
@@ -904,9 +916,10 @@ static int nvme_submit_sync_cmd(struct nvme_dev *dev, int q_idx,
 
 	if (cmdinfo.status == -EINTR) {
 		nvmeq = lock_nvmeq(dev, q_idx);
-		if (nvmeq)
+		if (nvmeq) {
 			nvme_abort_command(nvmeq, cmdid);
-		unlock_nvmeq(nvmeq);
+			unlock_nvmeq(nvmeq);
+		}
 		return -EINTR;
 	}
 
-- 
1.7.10.4
