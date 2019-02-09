From: sashal@kernel.org (Sasha Levin)
Date: Sat,  9 Feb 2019 13:47:15 -0500
Subject: [PATCH AUTOSEL 4.20 23/42] nvme-multipath: zero out ANA log buffer
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
Message-ID: <20190209184734.125935-23-sashal@kernel.org>

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit c7055fd15ff46d92eb0dd1c16a4fe010d58224c8 ]

When nvme_init_identify() fails the ANA log buffer is deallocated
but _not_ set to NULL. This can cause double free oops when this
controller is deleted without ever being reconnected.

Signed-off-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/multipath.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9901afd804ce..2b1d1f066efa 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -586,6 +586,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return 0;
 out_free_ana_log_buf:
 	kfree(ctrl->ana_log_buf);
+	ctrl->ana_log_buf = NULL;
 out:
 	return error;
 }
@@ -593,5 +594,6 @@ out:
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
 	kfree(ctrl->ana_log_buf);
+	ctrl->ana_log_buf = NULL;
 }
 
-- 
2.19.1
