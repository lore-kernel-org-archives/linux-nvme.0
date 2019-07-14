From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 14 Jul 2019 17:18:42 +0900
Subject: [PATCH] nvme: tcp: selects CRYPTO_CRC32C for nvme-tcp
Message-ID: <20190714081842.32427-1-minwoo.im.dev@gmail.com>

The tcp host module is now taking those APIs from crypto ahash:
	(1) crypto_ahash_final()
	(2) crypto_ahash_digest()
	(3) crypto_alloc_ahash()

nvme-tcp should depends on CRYPTO_CRC32C.

Cc: Christoph Hellwig <hch at lst.de>
Cc: Keith Busch <kbusch at kernel.org>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Jens Axboe <axboe at fb.com>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index ec43ac9199e2..2b36f052bfb9 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -64,6 +64,7 @@ config NVME_TCP
 	depends on INET
 	depends on BLK_DEV_NVME
 	select NVME_FABRICS
+	select CRYPTO_CRC32C
 	help
 	  This provides support for the NVMe over Fabrics protocol using
 	  the TCP transport.  This allows you to use remote block devices
-- 
2.17.1
