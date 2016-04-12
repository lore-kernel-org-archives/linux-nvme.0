From: Jeff.Lien@hgst.com (Jeff Lien)
Date: Tue, 12 Apr 2016 17:56:12 +0000
Subject: [PATCH 2/2] nvme/quirk: Add a delay before checking for adapter
 readiness
In-Reply-To: <1460405751-8884-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1460405751-8884-1-git-send-email-gpiccoli@linux.vnet.ibm.com>,
 <1460405751-8884-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-ID: <BL2PR04MB163667E7A08D934896BBA7192950@BL2PR04MB163.namprd04.prod.outlook.com>

Guilherme, 
What kernel level and system architecture are you running when you hit this problem?   I just verified that the nvme_disable_ctrl call works fine with the HGST device on Centos 6.5 with the 2.6.32-431 kernel on x86_64 arch.   

Also, have you been able to verify that other nvme devices do not require the delay patch?

----------------------------------------------------------
Jeff Lien
Linux Device Driver Development
Device Host Apps and Drivers
Western Digital Corporation
e.? jeff.lien at hgst.com
o.? +1-507-322-2416
m. +1-507-273-9124





________________________________________
From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Sent: Monday, April 11, 2016 3:15 PM
To: linux-nvme at lists.infradead.org; keith.busch at intel.com; axboe at fb.com
Cc: brking at linux.vnet.ibm.com; guenther at tum.de; mniyer at us.ibm.com; gpiccoli at linux.vnet.ibm.com
Subject: [PATCH 2/2] nvme/quirk: Add a delay before checking for adapter readiness

When disabling the controller, the specification says the register
NVME_REG_CC should be written and then driver needs to wait the
adapter to be ready, which is checked by reading another register
bit (NVME_CSTS_RDY). There's a timeout validation in this checking,
so in case this timeout is reached the driver gives up and removes
the adapter from the system.

The PCI_DEVICE(0x1c58, 0x0003) (HGST adapter) end up being removed
after a reset because driver keeps verifying the NVME_REG_CSTS until
the timeout is reached. This patch adds a quirk for this adapter, by
introducing a delay before nvme_wait_ready(), so the reset procedure
is able to be completed. This quirk is necessary because just
increasing the timeout is not enough - the driver must wait _before_
start reading NVME_REG_CSTS register on this specific adapter.

Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
---
 drivers/nvme/host/core.c |? 4 ++++
 drivers/nvme/host/nvme.h | 13 +++++++++++++
 drivers/nvme/host/pci.c? |? 2 ++
 3 files changed, 19 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 643f457..37817bb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -824,6 +824,10 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
??????? ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
??????? if (ret)
??????????????? return ret;
+
+?????? if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHECK_RDY)
+?????????????? msleep(NVME_QUIRK_DELAY_AMOUNT_MS);
+
??????? return nvme_wait_ready(ctrl, cap, false);
 }
 EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f846da4..b8247c4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -65,8 +65,21 @@ enum nvme_quirks {
???????? * logical blocks.
???????? */
??????? NVME_QUIRK_DISCARD_ZEROES?????????????? = (1 << 2),
+
+?????? /*
+?????? * The controller needs a delay before starts checking the device
+?????? * readiness, which is done by reading the NVME_CSTS_RDY bit.
+?????? */
+?????? NVME_QUIRK_DELAY_BEFORE_CHECK_RDY?????? = (1 << 3),
 };

+/* The below value is the specific amount of delay needed before checking
+ * readiness in case of the PCI_DEVICE(0x1c58, 0x0003), which needs the
+ * NVME_QUIRK_DELAY_BEFORE_CHECK_RDY quirk enabled. The value was found
+ * empirically. The value is in milliseconds.
+ */
+#define NVME_QUIRK_DELAY_AMOUNT_MS???????????? 2000
+
 struct nvme_ctrl {
??????? const struct nvme_ctrl_ops *ops;
??????? struct request_queue *admin_q;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 220e0b5..a5e3d0e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2173,6 +2173,8 @@ static const struct pci_device_id nvme_id_table[] = {
??????? { PCI_VDEVICE(INTEL, 0x5845),?? /* Qemu emulated controller */
??????????????? .driver_data = NVME_QUIRK_IDENTIFY_CNS, },
??????? { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
+?????? { PCI_DEVICE(0x1c58, 0x0003),?? /*HGST adapter */
+?????????????? .driver_data = NVME_QUIRK_DELAY_BEFORE_CHECK_RDY, },
??????? { PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
??????? { 0, }
 };
--
2.1.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
