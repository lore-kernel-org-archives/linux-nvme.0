From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 16 Nov 2015 15:34:36 +0100
Subject: [PATCH 02/13] lightnvm: change max_phys_sect to uint
In-Reply-To: <1447684487-25539-1-git-send-email-m@bjorling.me>
References: <1447684487-25539-1-git-send-email-m@bjorling.me>
Message-ID: <1447684487-25539-3-git-send-email-m@bjorling.me>

The max_phys_sect variable is defined as a char. We do a boundary check
to maximally allow 256 physical page descriptors per command. As we are
not indexing from zero. This expression is always false. Bump the
max_phys_sect to an unsigned int to support the range check.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
Reported-by: Geert Uytterhoeven <geert at linux-m68k.org>
---
 include/linux/lightnvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 69c9057..32b5369 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -220,7 +220,7 @@ struct nvm_dev_ops {
 	nvm_dev_dma_alloc_fn	*dev_dma_alloc;
 	nvm_dev_dma_free_fn	*dev_dma_free;
 
-	uint8_t			max_phys_sect;
+	unsigned int		max_phys_sect;
 };
 
 struct nvm_lun {
-- 
2.1.4
