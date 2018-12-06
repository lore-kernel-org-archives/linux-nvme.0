From: cascardo@canonical.com (Thadeu Lima de Souza Cascardo)
Date: Thu,  6 Dec 2018 14:48:11 -0200
Subject: [PATCH 3/4] nvme: Should not warn when a disk path is opened
In-Reply-To: <20181206164812.30925-1-cascardo@canonical.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
Message-ID: <20181206164812.30925-4-cascardo@canonical.com>

As we hide the disks used for nvme multipath, their open functions
should be allowed to be called, as their devices are not exposed.

However, not exposing the devices cause problems with lsblk, which won't
find the devices and show them, which is even more of a problem when
holders/slaves relationships are exposed.

Not warning here allow us to expose the disks without creating spurious
warnings. A failure should still be returned, which is the case here,
and still allows lsblk to work.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo at canonical.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1dc29795f1ee..22424b2adfad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1327,8 +1327,8 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
 
 #ifdef CONFIG_NVME_MULTIPATH
-	/* should never be called due to GENHD_FL_HIDDEN */
-	if (WARN_ON_ONCE(ns->head->disk))
+	/* Should fail as it's hidden */
+	if (ns->head->disk)
 		goto fail;
 #endif
 	if (!kref_get_unless_zero(&ns->kref))
-- 
2.19.1
