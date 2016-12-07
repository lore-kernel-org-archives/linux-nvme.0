From: ddstreet@ieee.org (Dan Streetman)
Date: Wed,  7 Dec 2016 17:03:48 -0500
Subject: [PATCH] nvme: use the correct msix vector for each queue
Message-ID: <20161207220348.8572-1-ddstreet@ieee.org>

Change each queue's cq_vector to match its qid, instead of qid - 1.

The first queue is always the admin queue, and the remaining queues are
I/O queues.  The interrupt vectors they use are all in the same array,
however, the vector indexes for the admin and I/O queues are setup
differently; the admin queue's cq_vector is manually set to 0, while
each I/O queue's cq_vector is set to qid - 1.  Since the admin queue
is qid 0, and the I/O queues start at qid 1, using qid - 1 is wrong for the
I/O queues, as it makes the first I/O queue (qid 1) share the vector from
the admin queue (qid 0), and no queue uses the last interrupt vector.
Instead, each I/O queue should set their cq_vector to qid.

Signed-off-by: Dan Streetman <dan.streetman at canonical.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5e52034..def2285 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1117,7 +1117,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	struct nvme_dev *dev = nvmeq->dev;
 	int result;
 
-	nvmeq->cq_vector = qid - 1;
+	nvmeq->cq_vector = qid;
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
 		return result;
-- 
2.9.3
