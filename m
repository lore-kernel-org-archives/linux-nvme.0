From: sashal@kernel.org (Sasha Levin)
Date: Wed, 27 Mar 2019 13:57:37 -0400
Subject: [PATCH AUTOSEL 5.0 002/262] nvme-fc: fix numa_node when dev is null
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
Message-ID: <20190327180158.10245-2-sashal@kernel.org>

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 06f3d71ea071b70e62bcc146cd9ff7ed1f9d4e43 ]

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
Signed-off-by: Jens Axboe <axboe at kernel.dk>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/fc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 89accc76d71c..c37d5bbd72ab 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3018,7 +3018,10 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
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
2.19.1
