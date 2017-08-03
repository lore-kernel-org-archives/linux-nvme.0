From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Thu, 3 Aug 2017 21:40:26 +0800
Subject: [PATCH] nvme-fabrics: output erros if hostid is invalid
Message-ID: <1501767626-13372-1-git-send-email-guanjunxiong@huawei.com>

This helps users to quickly spot the reason of why connection fails
if the hostid is not compliant with the uuid format.

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
---
 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 2e582a240943..cf8c6163db9e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -735,6 +735,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				goto out;
 			}
 			if (uuid_parse(p, &hostid)) {
+				pr_err("Invalid hostid %s\n", p);
 				ret = -EINVAL;
 				goto out;
 			}
-- 
2.11.1
