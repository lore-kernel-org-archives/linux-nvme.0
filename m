From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 20 Mar 2018 14:20:41 +0200
Subject: [PATCH 1/1] nvmet: move device_uuid configfs attr definition to
 suitable place
Message-ID: <1521548441-24490-1-git-send-email-maxg@mellanox.com>

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e6b2d2a..7780a72 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -333,13 +333,13 @@ static ssize_t nvmet_ns_device_uuid_store(struct config_item *item,
 	return ret ? ret : count;
 }
 
+CONFIGFS_ATTR(nvmet_ns_, device_uuid);
+
 static ssize_t nvmet_ns_device_nguid_show(struct config_item *item, char *page)
 {
 	return sprintf(page, "%pUb\n", &to_nvmet_ns(item)->nguid);
 }
 
-CONFIGFS_ATTR(nvmet_ns_, device_uuid);
-
 static ssize_t nvmet_ns_device_nguid_store(struct config_item *item,
 		const char *page, size_t count)
 {
-- 
1.8.3.1
