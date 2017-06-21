From: mauricfo@linux.vnet.ibm.com (Mauricio Faria de Oliveira)
Date: Wed, 21 Jun 2017 15:03:23 -0300
Subject: [PATCH 2/2] nvme: apply DELAY_BEFORE_CHK_RDY quirk at probe time too
In-Reply-To: <1498068203-29900-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1498068203-29900-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-ID: <1498068203-29900-3-git-send-email-mauricfo@linux.vnet.ibm.com>

From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>

Commit 54adc01055b7 ("nvme/quirk: Add a delay before checking for adapter
readiness") introduced a quirk to adapters that cannot read the bit
NVME_CSTS_RDY right after register NVME_REG_CC is set; these adapters
need a delay or else the action of reading the bit NVME_CSTS_RDY could
somehow corrupt adapter's registers state and it never recovers.

When this quirk was added, we checked ctrl->tagset in order to avoid
quirking in probe time, supposing we would never require such delay
during probe. Well, it was too optimistic; we in fact need this quirk
at probe time in some cases, like after a kexec.

In some experiments, after abnormal shutdown of machine (aka power cord
unplug), we booted into our bootloader in Power, which is a Linux kernel,
and kexec'ed into another distro. If this kexec is too quick, we end up
reaching the probe of NVMe adapter in that distro when adapter is in
bad state (not fully initialized on our bootloader). What happens next
is that nvme_wait_ready() is unable to complete, except if the quirk is
enabled.

So, this patch removes the original ctrl->tagset verification in order
to enable the quirk even on probe time.

Fixes: 54adc01055b7 ("nvme/quirk: Add a delay before checking for adapter readiness")
Reported-by: Andrew Byrne <byrneadw at ie.ibm.com>
Reported-by: Jaime A. H. Gomez <jahgomez at mx1.ibm.com>
Reported-by: Zachary D. Myers <zdmyers at us.ibm.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
Acked-by: Jeffrey Lien <Jeff.Lien at wdc.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
[mauricfo: backport to v4.4.70 without nvme quirk handling & nvme_ctrl]
Signed-off-by: Mauricio Faria de Oliveira <mauricfo at linux.vnet.ibm.com>
Tested-by: Narasimhan Vaidyanathan <vnarasimhan at in.ibm.com>
---
 drivers/nvme/host/pci.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e9750a0a6f2c..4c673d45f1bd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1639,12 +1639,7 @@ static int nvme_disable_ctrl(struct nvme_dev *dev, u64 cap)
 	dev->ctrl_config &= ~NVME_CC_ENABLE;
 	writel(dev->ctrl_config, &dev->bar->cc);
 
-	/* Checking for dev->tagset is a trick to avoid sleeping on module
-	 * load, since we only need the quirk on reset_controller. Notice
-	 * that the HGST device needs this delay only in firmware activation
-	 * procedure; unfortunately we have no (easy) way to verify this.
-	 */
-	if (pdev->vendor == 0x1c58 && pdev->device == 0x0003 && dev->tagset)
+	if (pdev->vendor == 0x1c58 && pdev->device == 0x0003)
 		msleep(NVME_QUIRK_DELAY_AMOUNT);
 
 	return nvme_wait_ready(dev, cap, false);
-- 
1.8.3.1
