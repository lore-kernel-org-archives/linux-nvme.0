From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Mar 2019 18:55:01 +0100
Subject: [PATCH 08/17] nvme-fc: fix numa_node when dev is null
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
Message-ID: <20190313175510.20725-9-hch@lst.de>

From: James Smart <jsmart2021@gmail.com>

A recent change added a numa_node field to the nvme controller
and has the transport assign the node using dev_to_node().
However, fcloop registers with a NULL device struct, so the
dev_to_node() call oops.

Revise the assignment to assign no node when device struct is null.

Fixes: 103e515efa89b ("nvme: add a numa_node field to struct nvme_ctrl")
Reported-by: Mike Snitzer <snitzer at redhat.com>
Signed-off-by: James Smart <jsmart2021 at gmail.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Mike Snitzer <snitzer at redhat.com>
[hch: small coding style fixup]
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index ba8f2a9cbdaf..23f6bad19274 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3017,7 +3017,10 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.nr_reconnects = 0;
-	ctrl->ctrl.numa_node = dev_to_node(lport->dev);
+	if (lport->dev)
+		ctrl->ctrl.numa_node = dev_to_node(lport->dev);
+	else
+		ctrl->ctrl.numa_node = NUMA_NO_NODE;
 	INIT_LIST_HEAD(&ctrl->ctrl_list);
 	ctrl->lport = lport;
 	ctrl->rport = rport;
-- 
2.20.1
