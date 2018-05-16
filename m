From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 16 May 2018 12:03:05 +0800
Subject: [PATCH V6 03/11] nvme: pci: unquiesce admin queue after controller is
 shutdown
In-Reply-To: <20180516040313.13596-1-ming.lei@redhat.com>
References: <20180516040313.13596-1-ming.lei@redhat.com>
Message-ID: <20180516040313.13596-4-ming.lei@redhat.com>

Given timeout event can come during reset, nvme_dev_disable() shouldn't
keep admin queue as quiesced after controller is shutdown. Otherwise
it may block admin IO in reset, and cause reset hang forever.

This patch fixes this issue by unquiescing admin queue at the end
of nvme_dev_disable().

Cc: James Smart <james.smart at broadcom.com>
Cc: Jianchao Wang <jianchao.w.wang at oracle.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: linux-nvme at lists.infradead.org
Cc: Laurence Oberman <loberman at redhat.com>
Reported-by: Jianchao Wang <jianchao.w.wang at oracle.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b60f727b844c..9e28d7118232 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1557,8 +1557,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 			dev->ctrl.admin_q = NULL;
 			return -ENODEV;
 		}
-	} else
-		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
+	}
 
 	return 0;
 }
@@ -2303,6 +2302,17 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 */
 	if (shutdown)
 		nvme_start_queues(&dev->ctrl);
+
+	/*
+	 * Avoid to stuck reset because timeout may happen during reset and
+	 * reset may hang forever if admin queue is kept as quiesced.
+	 *
+	 * Druing reset, if admin queue isn't ready, the command will be
+	 * failed immediately, that means we don't need to quiesce admin
+	 * queue.
+	 */
+	if (dev->ctrl.admin_q)
+		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
 	mutex_unlock(&dev->shutdown_lock);
 }
 
-- 
2.9.5
