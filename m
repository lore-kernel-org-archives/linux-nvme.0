From: ianb@mellanox.com (Ian Bakshan)
Date: Mon, 21 Dec 2015 10:39:24 +0200
Subject: [PATCH] nvmet: Improve device_path output
Message-ID: <1450687164-61677-1-git-send-email-ianb@mellanox.com>

Add '\n' when printing device path.

Signed-off-by: Ian Bakshan <ianb at mellanox.com>
Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
---
 drivers/nvme/target/configfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 3a108b9..8b9b170 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -23,7 +23,7 @@ CONFIGFS_ATTR_OPS(nvmet_ns);
 
 static ssize_t nvmet_ns_device_path_show(struct nvmet_ns *ns, char *page)
 {
-	return sprintf(page, "%s", ns->device_path);
+	return sprintf(page, "%s\n", ns->device_path);
 }
 
 static ssize_t nvmet_ns_device_path_store(struct nvmet_ns *ns, const char *page,
-- 
1.8.4.3
