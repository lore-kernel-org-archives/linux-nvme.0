From: luto@kernel.org (Andy Lutomirski)
Date: Wed, 24 May 2017 15:06:31 -0700
Subject: [PATCH 2/2] nvme: Quirk APST on Intel 600P/P3100 devices
In-Reply-To: <cover.1495663545.git.luto@kernel.org>
References: <cover.1495663545.git.luto@kernel.org>
Message-ID: <db392f7634625bea0ede96c119b500d16ba9e9db.1495663545.git.luto@kernel.org>

They have known firmware bugs.  A fix is apparently in the works --
once fixed firmware is available, someone from Intel (Hi, Keith!)
can adjust the quirk accordingly.

Cc: stable at vger.kernel.org # v4.11
Cc: Kai-Heng Feng <kai.heng.feng at canonical.com>
Cc: Mario Limonciello <mario_limonciello at dell.com>
Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fed803232edc..24cf32afaa34 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2288,6 +2288,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0a54),
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
+	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
 	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
-- 
2.9.4
