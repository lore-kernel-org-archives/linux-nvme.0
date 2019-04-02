From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue,  2 Apr 2019 14:51:54 +0300
Subject: [PATCH 1/1] nvmet: add safety check for subsystem lock during
 nvmet_ns_changed
Message-ID: <1554205914-2203-1-git-send-email-maxg@mellanox.com>

we need to make sure that subsystem lock is taken during ctrl's list
traversing. nvmet_ns_changed function is not static and can be used from
various callers simultaneously.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b3e765a..d42de97 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -214,6 +214,8 @@ void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid)
 {
 	struct nvmet_ctrl *ctrl;
 
+	lockdep_assert_held(&subsys->lock);
+
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
 		nvmet_add_to_changed_ns_log(ctrl, cpu_to_le32(nsid));
 		if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_NS_ATTR))
-- 
1.8.3.1
