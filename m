From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 19 Nov 2018 15:16:39 -0800
Subject: [PATCH] nvmet: fix the structure member indentation
Message-ID: <20181119231639.15790-1-chaitanya.kulkarni@wdc.com>

This is a cleanup patch which fixes the structure member indentation
introduced by the p2p:

commit c6925093d0b2 ("nvmet: Optionally use PCI P2P memory").
We don't change any functionality in this patch.

This is needed so that any future members will also follow the uniform
indentation.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/nvmet.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 03988fe9d915..ac2f7e58552c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -199,8 +199,8 @@ struct nvmet_ctrl {
 	char			subsysnqn[NVMF_NQN_FIELD_LEN];
 	char			hostnqn[NVMF_NQN_FIELD_LEN];
 
-	struct device *p2p_client;
-	struct radix_tree_root p2p_ns_map;
+	struct device		*p2p_client;
+	struct radix_tree_root	p2p_ns_map;
 };
 
 struct nvmet_subsys {
@@ -313,8 +313,8 @@ struct nvmet_req {
 	void (*execute)(struct nvmet_req *req);
 	const struct nvmet_fabrics_ops *ops;
 
-	struct pci_dev *p2p_dev;
-	struct device *p2p_client;
+	struct pci_dev		*p2p_dev;
+	struct device		*p2p_client;
 };
 
 extern struct workqueue_struct *buffered_io_wq;
-- 
2.17.0
