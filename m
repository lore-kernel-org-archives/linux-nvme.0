From: sashal@kernel.org (Sasha Levin)
Date: Wed,  5 Dec 2018 04:42:38 -0500
Subject: [PATCH AUTOSEL 4.14 60/69] nvme: flush namespace scanning work just
 before removing namespaces
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Message-ID: <20181205094247.6556-60-sashal@kernel.org>

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
index 3a63d58d2ca9..65f3f1a34b6b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2572,6 +2572,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns, *next;
 
+	/* prevent racing with ns scanning */
+	flush_work(&ctrl->scan_work);
+
 	/*
 	 * The dead states indicates the controller was not gracefully
 	 * disconnected. In that case, we won't be able to flush any data while
@@ -2743,7 +2746,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
-	flush_work(&ctrl->scan_work);
 	cancel_work_sync(&ctrl->fw_act_work);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
-- 
2.17.1
