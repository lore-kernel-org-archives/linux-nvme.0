From: helen.koike@collabora.co.uk (Helen Koike)
Date: Mon,  2 May 2016 12:17:37 -0300
Subject: [PATCH] NVMe: add missing command size checks
Message-ID: <1462202257-13525-1-git-send-email-helen.koike@collabora.co.uk>

Some commands were not being checked

Signed-off-by: Helen Koike <helen.koike at collabora.co.uk>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4fd733f..caf8e45 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -171,6 +171,9 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_features) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_identify) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != 4096);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != 4096);
-- 
1.9.1
