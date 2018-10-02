From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  1 Oct 2018 17:14:22 -0700
Subject: [PATCH rfc 4/4] nvme: Ask for fabrics SQ flow control disable by
 default
In-Reply-To: <20181002001422.9111-1-sagi@grimberg.me>
References: <20181002001422.9111-1-sagi@grimberg.me>
Message-ID: <20181002001422.9111-5-sagi@grimberg.me>

As for now, we don't care about sq_head pointer updates anyway, so
at least allow the controller to micro-optimize by omiting this update.

Note that we will probably need to support it when a controller
that requires this comes along.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 38cf9d371953..ce61c3e1c22b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -392,6 +392,9 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	cmd.connect.kato = ctrl->opts->discovery_nqn ? 0 :
 		cpu_to_le32((ctrl->kato + NVME_KATO_GRACE) * 1000);
 
+	/* Ask to disable SQ head pointer updates */
+	cmd.connect.cattr |= NVME_CONNECT_SQ_FC_DISABLED;
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -451,6 +454,9 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	cmd.connect.qid = cpu_to_le16(qid);
 	cmd.connect.sqsize = cpu_to_le16(ctrl->sqsize);
 
+	/* Ask to disable SQ head pointer updates */
+	cmd.connect.cattr |= NVME_CONNECT_SQ_FC_DISABLED;
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-- 
2.17.1
