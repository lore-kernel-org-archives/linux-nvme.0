From: hch@lst.de (Christoph Hellwig)
Date: Thu, 15 Jun 2017 18:35:00 +0200
Subject: [PATCH 4/6] nvme-fabrics: verify that a controller returns the
 correct NQN
In-Reply-To: <20170615163502.10548-1-hch@lst.de>
References: <20170615163502.10548-1-hch@lst.de>
Message-ID: <20170615163502.10548-5-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fabrics.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 4798a8a425e0..87038a017fb9 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -862,6 +862,15 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 		goto out_unlock;
 	}
 
+	if (strcmp(ctrl->subnqn, opts->subsysnqn)) {
+		dev_warn(ctrl->device,
+			"controller returned incorrect NQN: \"%s\".\n",
+			ctrl->subnqn);
+		mutex_unlock(&nvmf_transports_mutex);
+		ctrl->ops->delete_ctrl(ctrl);
+		return ERR_PTR(-EINVAL);
+	}
+
 	mutex_unlock(&nvmf_transports_mutex);
 	return ctrl;
 
-- 
2.11.0
