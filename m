From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 16 Jan 2018 13:06:31 +0800
Subject: [PATCH 1/3] nvmf: fix memory leak for parsing hostid option
Message-ID: <1516079193-13772-1-git-send-email-guanjunxiong@huawei.com>

If we fail to parse uuid of hostid option, we need to
free the memory allocated by _match_strdup_.

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
---
 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 894c2cc..4ced176 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -741,6 +741,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			if (uuid_parse(p, &hostid)) {
 				pr_err("Invalid hostid %s\n", p);
+				kfree(p);
 				ret = -EINVAL;
 				goto out;
 			}
-- 
2.6.4.windows.1
