From: israelr@mellanox.com (Israel Rukshin)
Date: Mon, 19 Nov 2018 10:58:52 +0000
Subject: [PATCH 2/2] nvme: Remove unused forward declaration
In-Reply-To: <1542625132-21714-1-git-send-email-israelr@mellanox.com>
References: <1542625132-21714-1-git-send-email-israelr@mellanox.com>
Message-ID: <1542625132-21714-2-git-send-email-israelr@mellanox.com>

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 559d567..6b83809 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -97,7 +97,6 @@
 static struct class *nvme_class;
 static struct class *nvme_subsys_class;
 
-static void nvme_ns_remove(struct nvme_ns *ns);
 static int nvme_revalidate_disk(struct gendisk *disk);
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
-- 
1.8.3.1
