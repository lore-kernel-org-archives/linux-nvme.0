From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Tue, 29 Aug 2017 19:03:46 -0300
Subject: [PATCH v2] nvme-fabrics: Prevent KATO to be set as 0
Message-ID: <20170829220346.19424-1-gpiccoli@linux.vnet.ibm.com>

Since the debug feature of setting KATO to 0 is not working
anymore, remove it from code. If user sets it to 0, default
value will be explicitly used.

Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
---
 drivers/nvme/host/fabrics.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5f5cd306f76d..5055a61e3a34 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -565,6 +565,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
 	opts->nr_io_queues = num_online_cpus();
 	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
+	opts->kato = NVME_DEFAULT_KATO;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -666,9 +667,10 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -EINVAL;
 				goto out;
 			} else if (token == 0) {
-				/* Allowed for debug */
-				pr_warn("keep_alive_tmo 0 won't execute keep alives!!!\n");
+				pr_info("Default value used for keep_alive_tmo\n");
+				break;
 			}
+
 			opts->kato = token;
 			break;
 		case NVMF_OPT_CTRL_LOSS_TMO:
@@ -761,8 +763,6 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	uuid_copy(&opts->host->id, &hostid);
 
 out:
-	if (!opts->discovery_nqn && !opts->kato)
-		opts->kato = NVME_DEFAULT_KATO;
 	kfree(options);
 	return ret;
 }
-- 
2.14.1
