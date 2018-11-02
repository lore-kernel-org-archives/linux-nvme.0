From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri,  2 Nov 2018 16:12:21 -0700
Subject: [PATCH] nvmet: don't try to add ns to p2p map unless it actually uses
 it
Message-ID: <20181102231221.26410-1-sagi@grimberg.me>

Even without CONFIG_P2PDMA this results in a error print:
nvmet: no peer-to-peer memory is available that's supported by rxe0 and /dev/nullb0

Fixes: c6925093d0b2 ("nvmet: Optionally use PCI P2P memory")
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 0454fec46261..ae05afa19b4b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -422,7 +422,7 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
 	struct pci_dev *p2p_dev;
 	int ret;
 
-	if (!ctrl->p2p_client)
+	if (!ctrl->p2p_client || !ns->use_p2pmem)
 		return;
 
 	if (ns->p2p_dev) {
-- 
2.17.1
