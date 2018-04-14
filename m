From: cgxu519@gmx.com (Chengguang Xu)
Date: Sat, 14 Apr 2018 20:06:19 +0800
Subject: [PATCH] nvme: fix potential memory leak in option parsing
Message-ID: <1523707579-31583-1-git-send-email-cgxu519@gmx.com>

When specifying same string type option several times,
current option parsing may cause memory leak. Hence,
call kfree for previous one in this case.

Signed-off-by: Chengguang Xu <cgxu519 at gmx.com>
---
 drivers/nvme/host/fabrics.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 124c458..7ae732a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -668,6 +668,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -ENOMEM;
 				goto out;
 			}
+			kfree(opts->transport);
 			opts->transport = p;
 			break;
 		case NVMF_OPT_NQN:
@@ -676,6 +677,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -ENOMEM;
 				goto out;
 			}
+			kfree(opts->subsysnqn);
 			opts->subsysnqn = p;
 			nqnlen = strlen(opts->subsysnqn);
 			if (nqnlen >= NVMF_NQN_SIZE) {
@@ -698,6 +700,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -ENOMEM;
 				goto out;
 			}
+			kfree(opts->traddr);
 			opts->traddr = p;
 			break;
 		case NVMF_OPT_TRSVCID:
@@ -706,6 +709,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -ENOMEM;
 				goto out;
 			}
+			kfree(opts->trsvcid);
 			opts->trsvcid = p;
 			break;
 		case NVMF_OPT_QUEUE_SIZE:
@@ -792,6 +796,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -EINVAL;
 				goto out;
 			}
+			nvmf_host_put(opts->host);
 			opts->host = nvmf_host_add(p);
 			kfree(p);
 			if (!opts->host) {
@@ -817,6 +822,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -ENOMEM;
 				goto out;
 			}
+			kfree(opts->host_traddr);
 			opts->host_traddr = p;
 			break;
 		case NVMF_OPT_HOST_ID:
-- 
1.8.3.1
