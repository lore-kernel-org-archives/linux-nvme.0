From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 30 Nov 2017 16:12:10 +0100
Subject: [PATCH v2] nvme-fc: don't require user to enter host_traddr
Message-ID: <20171130151210.8168-1-jthumshirn@suse.de>

One major usability difference between NVMf RDMA and FC is resolving
the default host transport address in RDMA. This is perfectly doable
in FC as well, as we already have all possible lport <-> rport
combinations pre-populated so we can pick the first lport that has a
connection to our desired rport per default or optionally use the user
supplied lport if we have one.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Cc: James Smart <james.smart at broadcom.com>
--
Changes to v1:
- Both laddr.pn and laddr.nn must be present _if_ we take the laddr into
  account (Hannes)
---
 drivers/nvme/host/fc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 7ab0be55c7d0..063b9c3438ce 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3328,15 +3328,19 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
 	if (ret || !raddr.nn || !raddr.pn)
 		return ERR_PTR(-EINVAL);
 
-	ret = nvme_fc_parse_traddr(&laddr, opts->host_traddr, NVMF_TRADDR_SIZE);
-	if (ret || !laddr.nn || !laddr.pn)
-		return ERR_PTR(-EINVAL);
+	if (opts->mask & NVMF_OPT_HOST_TRADDR) {
+		ret = nvme_fc_parse_traddr(&laddr, opts->host_traddr,
+					   NVMF_TRADDR_SIZE);
+		if (ret || !laddr.nn || !laddr.pn)
+			return ERR_PTR(-EINVAL);
+	}
 
 	/* find the host and remote ports to connect together */
 	spin_lock_irqsave(&nvme_fc_lock, flags);
 	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
-		if (lport->localport.node_name != laddr.nn ||
-		    lport->localport.port_name != laddr.pn)
+		if (!(laddr.nn && laddr.pn) &&
+		    (lport->localport.node_name != laddr.nn ||
+		     lport->localport.port_name != laddr.pn))
 			continue;
 
 		list_for_each_entry(rport, &lport->endp_list, endp_list) {
@@ -3364,8 +3368,9 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
 
 static struct nvmf_transport_ops nvme_fc_transport = {
 	.name		= "fc",
-	.required_opts	= NVMF_OPT_TRADDR | NVMF_OPT_HOST_TRADDR,
-	.allowed_opts	= NVMF_OPT_RECONNECT_DELAY | NVMF_OPT_CTRL_LOSS_TMO,
+	.required_opts	= NVMF_OPT_TRADDR,
+	.allowed_opts	= NVMF_OPT_RECONNECT_DELAY | NVMF_OPT_CTRL_LOSS_TMO
+				| NVMF_OPT_HOST_TRADDR,
 	.create_ctrl	= nvme_fc_create_ctrl,
 };
 
-- 
2.13.6
