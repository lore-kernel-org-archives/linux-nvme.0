From: misha@nasledov.com (Misha Nasledov)
Date: Mon, 15 Jul 2019 00:11:49 -0700
Subject: [PATCH] NVME: ignore subnqn for ADATA SX6000LNP
Message-ID: <20190715071149.GA24206@nasledov.com>

The ADATA SX6000LNP NVMe SSDs have the same subnqn and, due to this,
a system with more than one of these SSDs will only have one usable.

[ 0.942706] nvme nvme1: ignoring ctrl due to duplicate subnqn (nqn.2018-05.com.example:nvme:nvm-subsystem-OUI00E04C).
[ 0.943017] nvme nvme1: Removing after probe failure status: -22

# lspci | grep Non-Volatile
02:00.0 Non-Volatile memory controller [0108]: Realtek Semiconductor Co., Ltd. Device [10ec:5762] (rev 01)
71:00.0 Non-Volatile memory controller [0108]: Realtek Semiconductor Co., Ltd. Device [10ec:5762] (rev 01)

There are no firmware updates available from the vendor,
unfortunately. Applying the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk for
these SSDs resolves the issue, and they all work after this patch:

# nvme list
/dev/nvme0n1     2J1120050420         ADATA SX6000LNP [...]
/dev/nvme1n1     2J1120050540         ADATA SX6000LNP [...]

Signed-off-by: Misha Nasledov <misha at nasledov.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 189352081994..762ae6927689 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3005,6 +3005,8 @@ static const struct pci_device_id nvme_id_table[] = {
        { PCI_VDEVICE(INTEL, 0x5845),   /* Qemu emulated controller */
                .driver_data = NVME_QUIRK_IDENTIFY_CNS |
                                NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+       { PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
+               .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
        { PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
                .driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
        { PCI_DEVICE(0x1c58, 0x0003),   /* HGST adapter */

-- 
Misha Nasledov <misha at nasledov.com>
GPG: A063 B99A 2BD3 2D48 F2D7 8E68 0F27 4D21 948F 8F06
