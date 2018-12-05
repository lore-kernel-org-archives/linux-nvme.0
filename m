From: sashal@kernel.org (Sasha Levin)
Date: Wed,  5 Dec 2018 04:35:42 -0500
Subject: [PATCH AUTOSEL 4.19 110/123] nvme: flush namespace scanning work just
 before removing namespaces
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Message-ID: <20181205093555.5386-110-sashal@kernel.org>

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit f6c8e432cb0479255322c5d0335b9f1699a0270c ]

nvme_stop_ctrl can be called also for reset flow and there is no need to
flush the scan_work as namespaces are not being removed. This can cause
deadlock in rdma, fc and loop drivers since nvme_stop_ctrl barriers
before controller teardown (and specifically I/O cancellation of the
scan_work itself) takes place, but the scan_work will be blocked anyways
so there is no need to flush it.

Instead, move scan_work flush to nvme_remove_namespaces() where it really
needs to flush.

Reported-by: Ming Lei <ming.lei at redhat.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Keith Busch <keith.busch at intel.com>
Reviewed by: James Smart <jsmart2021 at gmail.com>
Tested-by: Ewan D. Milne <emilne at redhat.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0ba301f7e8b4..b7b2659e02fa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3308,6 +3308,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(ns_list);
 
+	/* prevent racing with ns scanning */
+	flush_work(&ctrl->scan_work);
+
 	/*
 	 * The dead states indicates the controller was not gracefully
 	 * disconnected. In that case, we won't be able to flush any data while
@@ -3463,7 +3466,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_mpath_stop(ctrl);
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
-	flush_work(&ctrl->scan_work);
 	cancel_work_sync(&ctrl->fw_act_work);
 	if (ctrl->ops->stop_ctrl)
 		ctrl->ops->stop_ctrl(ctrl);
-- 
2.17.1
