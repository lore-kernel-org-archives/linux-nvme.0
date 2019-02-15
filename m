From: sashal@kernel.org (Sasha Levin)
Date: Thu, 14 Feb 2019 21:08:39 -0500
Subject: [PATCH AUTOSEL 4.20 61/77] nvme-multipath: drop optimization for
 static ANA group IDs
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
Message-ID: <20190215020855.176727-61-sashal@kernel.org>

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 78a61cd42a64f3587862b372a79e1d6aaf131fd7 ]

Bit 6 in the ANACAP field is used to indicate that the ANA group ID
doesn't change while the namespace is attached to the controller.
There is an optimisation in the code to only allocate space
for the ANA group header, as the namespace list won't change and
hence would not need to be refreshed.
However, this optimisation was never carried over to the actual
workflow, which always assumes that the buffer is large enough
to hold the ANA header _and_ the namespace list.
So drop this optimisation and always allocate enough space.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Jens Axboe <axboe at kernel.dk>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/multipath.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9901afd804ce..266bac07ed11 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -561,8 +561,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	timer_setup(&ctrl->anatt_timer, nvme_anatt_timeout, 0);
 	ctrl->ana_log_size = sizeof(struct nvme_ana_rsp_hdr) +
 		ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc);
-	if (!(ctrl->anacap & (1 << 6)))
-		ctrl->ana_log_size += ctrl->max_namespaces * sizeof(__le32);
+	ctrl->ana_log_size += ctrl->max_namespaces * sizeof(__le32);
 
 	if (ctrl->ana_log_size > ctrl->max_hw_sectors << SECTOR_SHIFT) {
 		dev_err(ctrl->device,
-- 
2.19.1
