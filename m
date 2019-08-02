From: sashal@kernel.org (Sasha Levin)
Date: Fri,  2 Aug 2019 09:19:33 -0400
Subject: [PATCH AUTOSEL 5.2 59/76] nvme: ignore subnqn for ADATA SX6000LNP
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
Message-ID: <20190802131951.11600-59-sashal@kernel.org>

From: Misha Nasledov <misha@nasledov.com>

[ Upstream commit 08b903b5fd0c49e5f224a9bf085b6329ec3c55c0 ]

The ADATA SX6000LNP NVMe SSDs have the same subnqn and, due to this, a
system with more than one of these SSDs will only have one usable.

[ 0.942706] nvme nvme1: ignoring ctrl due to duplicate subnqn (nqn.2018-05.com.example:nvme:nvm-subsystem-OUI00E04C).
[ 0.943017] nvme nvme1: Removing after probe failure status: -22

02:00.0 Non-Volatile memory controller [0108]: Realtek Semiconductor Co., Ltd. Device [10ec:5762] (rev 01)
71:00.0 Non-Volatile memory controller [0108]: Realtek Semiconductor Co., Ltd. Device [10ec:5762] (rev 01)

There are no firmware updates available from the vendor, unfortunately.
Applying the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk for these SSDs resolves
the issue, and they all work after this patch:

/dev/nvme0n1     2J1120050420         ADATA SX6000LNP [...]
/dev/nvme1n1     2J1120050540         ADATA SX6000LNP [...]

Signed-off-by: Misha Nasledov <misha at nasledov.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7fbcd72c438f6..f9959eaaa185e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2959,6 +2959,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
+	{ PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.20.1
