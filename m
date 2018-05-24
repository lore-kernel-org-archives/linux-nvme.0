From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Thu, 24 May 2018 17:51:34 +0800
Subject: [PATCH 2/2] nvme-pci: don't send delete cq command when allocate sq
 return -EINTR
In-Reply-To: <1527155494-1891-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1527155494-1891-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1527155494-1891-2-git-send-email-jianchao.w.wang@oracle.com>

When allocate sq in nvme_create_queue return -EINTR, it means the
allocate sq command times out and is completed with NVME_REQ_CANCELLED.
At the moment, the controller has been disabled and admin request
queue has been quiesced. Don't send delete cq command, otherwise,
it will incur io hang.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 70b79f2..4ce1c89 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1478,7 +1478,15 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 		goto out;
 
 	result = adapter_alloc_sq(dev, qid, nvmeq);
-	if (result < 0)
+	/*
+	 * If return -EINTR, it means the allocate sq command times out and is completed
+	 * with NVME_REQ_CANCELLED. At the time, the controller has been disabled
+	 * and admin request queue has been quiesced. So don't try to send delete cq
+	 * command any more.
+	 */
+	if (result == -EINTR)
+		goto out;
+	else if (result < 0)
 		goto release_cq;
 
 	/*
-- 
2.7.4
