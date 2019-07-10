From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 10 Jul 2019 09:31:31 -0700
Subject: [PATCH] nvme: fix regression upon hot device removal and insertion
Message-ID: <20190710163131.30295-1-sagi@grimberg.me>

When we validate the new controller id, we want to skip
controllers that are either deleting or dead. Fix the check
to do that and not on the newly added controller.

Fixes: 1b1031ca63b2 ("nvme: validate cntlid during controller initialisation")
Reported-by: Jon Derrick <jonathan.derrick at intel.com>
Tested-by: Jon Derrick <jonathan.derrick at intel.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e28717d11f9a..04d5ce1a42c1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2419,8 +2419,8 @@ static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 	lockdep_assert_held(&nvme_subsystems_lock);
 
 	list_for_each_entry(tmp, &subsys->ctrls, subsys_entry) {
-		if (ctrl->state == NVME_CTRL_DELETING ||
-		    ctrl->state == NVME_CTRL_DEAD)
+		if (tmp->state == NVME_CTRL_DELETING ||
+		    tmp->state == NVME_CTRL_DEAD)
 			continue;
 
 		if (tmp->cntlid == ctrl->cntlid) {
-- 
2.17.1
