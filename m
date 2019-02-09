From: sashal@kernel.org (Sasha Levin)
Date: Sat,  9 Feb 2019 13:48:24 -0500
Subject: [PATCH AUTOSEL 4.19 16/28] nvme-multipath: zero out ANA log buffer
In-Reply-To: <20190209184840.126418-1-sashal@kernel.org>
References: <20190209184840.126418-1-sashal@kernel.org>
Message-ID: <20190209184840.126418-16-sashal@kernel.org>

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
index c27af277e14e..815509dbed84 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -556,6 +556,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return 0;
 out_free_ana_log_buf:
 	kfree(ctrl->ana_log_buf);
+	ctrl->ana_log_buf = NULL;
 out:
 	return error;
 }
@@ -563,5 +564,6 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
 	kfree(ctrl->ana_log_buf);
+	ctrl->ana_log_buf = NULL;
 }
 
-- 
2.19.1
