From: hare@suse.de (Hannes Reinecke)
Date: Wed,  9 Jan 2019 09:45:15 +0100
Subject: [PATCH] nvme-multipath: drop optimization for static ANA group IDs
Message-ID: <20190109084515.82076-1-hare@suse.de>

Bit 6 in the ANACAP field is used to indicate that the ANA group ID
doesn't change while the namespace is attached to the controller.
There is an optimisation in the code to only allocate space
for the ANA group header, as the namespace list won't change and
hence would not need to be refreshed.
However, this optimisation was never carried over to the actual
workflow, which always assumes that the buffer is large enough
to hold the ANA header _and_ the namespace list.
So drop this optimisation and always allocate enough space.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index df4b3a6db51b..b9fff3b8ed1b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -545,8 +545,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	timer_setup(&ctrl->anatt_timer, nvme_anatt_timeout, 0);
 	ctrl->ana_log_size = sizeof(struct nvme_ana_rsp_hdr) +
 		ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc);
-	if (!(ctrl->anacap & (1 << 6)))
-		ctrl->ana_log_size += ctrl->max_namespaces * sizeof(__le32);
+	ctrl->ana_log_size += ctrl->max_namespaces * sizeof(__le32);
 
 	if (ctrl->ana_log_size > ctrl->max_hw_sectors << SECTOR_SHIFT) {
 		dev_err(ctrl->device,
-- 
2.16.4
