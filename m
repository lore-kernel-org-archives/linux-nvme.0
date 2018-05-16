From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 16 May 2018 12:03:07 +0800
Subject: [PATCH V6 05/11] nvme: pci: only wait freezing if queue is frozen
In-Reply-To: <20180516040313.13596-1-ming.lei@redhat.com>
References: <20180516040313.13596-1-ming.lei@redhat.com>
Message-ID: <20180516040313.13596-6-ming.lei@redhat.com>

In nvme_dev_disable() called during shutting down controler,
nvme_wait_freeze_timeout() may be done on the controller not
frozen yet, so add the check for avoiding the case.

Cc: James Smart <james.smart at broadcom.com>
Cc: Jianchao Wang <jianchao.w.wang at oracle.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: linux-nvme at lists.infradead.org
Cc: Laurence Oberman <loberman at redhat.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e94a103ead1e..6413dad51107 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2259,14 +2259,17 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	int i;
 	bool dead = true;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	bool frozen = false;
 
 	mutex_lock(&dev->shutdown_lock);
 	if (pci_is_enabled(pdev)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
 		if (dev->ctrl.state == NVME_CTRL_LIVE ||
-		    dev->ctrl.state == NVME_CTRL_RESETTING)
+		    dev->ctrl.state == NVME_CTRL_RESETTING) {
 			nvme_start_freeze(&dev->ctrl);
+			frozen = true;
+		}
 		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
 			pdev->error_state  != pci_channel_io_normal);
 	}
@@ -2276,7 +2279,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 * doing a safe shutdown.
 	 */
 	if (!dead) {
-		if (shutdown)
+		if (shutdown && frozen)
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 	}
 
-- 
2.9.5
