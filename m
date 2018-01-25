From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 25 Jan 2018 09:09:25 +0100
Subject: [PATCH] nvme: don't free uuid pointer before printing it
Message-ID: <20180125080925.6019-1-jthumshirn@suse.de>

Commit df351ef73789 ("nvme-fabrics: fix memory leak when parsing host ID
option") fixed the leak of 'p' but in case uuid_parse() fails the memory
is freed before the error print that is using it.

Free it after printing eventual errors.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Fixes: df351ef73789 ("nvme-fabrics: fix memory leak when parsing host ID option")
Reported-by: Dan Carpenter <dan.carpenter at oracle.com>
Cc: Roland Dreier <roland at purestorage.com>
---
 drivers/nvme/host/fabrics.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index eb46967bb0d5..9cee72a80472 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -739,12 +739,13 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				goto out;
 			}
 			ret = uuid_parse(p, &hostid);
-			kfree(p);
 			if (ret) {
 				pr_err("Invalid hostid %s\n", p);
 				ret = -EINVAL;
+				kfree(p);
 				goto out;
 			}
+			kfree(p);
 			break;
 		case NVMF_OPT_DUP_CONNECT:
 			opts->duplicate_connect = true;
-- 
2.13.6
