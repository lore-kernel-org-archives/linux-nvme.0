From: hare@suse.de (Hannes Reinecke)
Date: Thu, 24 May 2018 16:18:16 +0200
Subject: [PATCH 2/3] nvme: avoid reconnection for the discovery controller
In-Reply-To: <20180524141817.127576-1-hare@suse.de>
References: <20180524141817.127576-1-hare@suse.de>
Message-ID: <20180524141817.127576-3-hare@suse.de>

If the connection to the discovery controller fails for whatever
reason we should not attempt to reconnect; rather the user should
retry the discovery altogether.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fabrics.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index d25aa4322d16..997d8677ab44 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -474,6 +474,9 @@ EXPORT_SYMBOL_GPL(nvmf_connect_io_queue);
 
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
 {
+	if (ctrl->opts->discovery_nqn)
+		return false;
+
 	if (ctrl->opts->max_reconnects != -1 &&
 	    ctrl->nr_reconnects < ctrl->opts->max_reconnects)
 		return true;
-- 
2.12.3
