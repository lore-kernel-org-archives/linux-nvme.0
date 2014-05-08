From: keith.busch@intel.com (Keith Busch)
Date: Thu,  8 May 2014 09:26:49 -0600
Subject: [PATCH] NVMe: Fix potentail NULL deferences oops
Message-ID: <1399562809-13986-1-git-send-email-keith.busch@intel.com>

We were relying on a macro to not use a NULL pointer in a "hot remove"
scenario, but we should not depend on this macro never to change.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reported-by: Dan Carpenter <dan.carpenter at oracle.com>
---
Tested like this:

 # dd if=/dev/nvme0n1 of=/dev/null bs=4k iflag=direct conv=noerror &
 # echo 1 > /sys/bus/pci/devices/<D:B:D.f>/remove

 drivers/block/nvme-core.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cd8a8bc7..d2b9f4e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -282,6 +282,12 @@ static struct nvme_queue *get_nvmeq(struct nvme_dev *dev) __acquires(RCU)
 	return rcu_dereference(dev->queues[queue_id]);
 }
 
+static void put_ioqueue(struct nvme_dev *dev) __releases(RCU)
+{
+	rcu_read_unlock();
+	put_cpu_var(dev->io_queue);
+}
+
 static void put_nvmeq(struct nvme_queue *nvmeq) __releases(RCU)
 {
 	rcu_read_unlock();
@@ -801,7 +807,7 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
 	int result = -EBUSY;
 
 	if (!nvmeq) {
-		put_nvmeq(NULL);
+		put_ioqueue(ns->dev);
 		bio_endio(bio, -EIO);
 		return;
 	}
-- 
1.7.10.4
