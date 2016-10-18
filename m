From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Tue, 18 Oct 2016 13:10:46 -0700
Subject: [PATCH 3/6] nvme-fabrics: Fix memory leaks in nvmf_parse_options()
In-Reply-To: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
Message-ID: <52b8f1ef-2f20-c7cb-957d-dd4444f82d37@sandisk.com>

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
---
 drivers/nvme/host/fabrics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 716d9e2..3e37efa 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -666,10 +666,12 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			if (nqnlen >= NVMF_NQN_SIZE) {
 				pr_err("%s needs to be < %d bytes\n",
 				       p, NVMF_NQN_SIZE);
+				kfree(p);
 				ret = -EINVAL;
 				goto out;
 			}
 			opts->host = nvmf_host_add(p);
+			kfree(p);
 			if (!opts->host) {
 				ret = -ENOMEM;
 				goto out;
-- 
2.10.1
