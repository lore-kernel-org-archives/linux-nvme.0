From: khoroshilov@ispras.ru (Alexey Khoroshilov)
Date: Sat,  7 Mar 2015 01:43:41 +0300
Subject: [PATCH] NVMe: Fix error handling of class_create("nvme")
Message-ID: <1425681821-620-1-git-send-email-khoroshilov@ispras.ru>

class_create() returns ERR_PTR on failure,
so IS_ERR() should be used instead of check for NULL.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov at ispras.ru>
---
 drivers/block/nvme-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ceb32dd52a6c..30ac50b3009d 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -3165,8 +3165,10 @@ static int __init nvme_init(void)
 		nvme_char_major = result;
 
 	nvme_class = class_create(THIS_MODULE, "nvme");
-	if (!nvme_class)
+	if (IS_ERR(nvme_class)) {
+		result = PTR_ERR(nvme_class);
 		goto unregister_chrdev;
+	}
 
 	result = pci_register_driver(&nvme_driver);
 	if (result)
-- 
1.9.1
