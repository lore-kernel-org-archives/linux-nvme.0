From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Thu, 14 Sep 2017 13:59:28 -0300
Subject: [PATCH] nvme-fabrics: Allow 0 as KATO value
Message-ID: <20170914165928.30862-1-gpiccoli@linux.vnet.ibm.com>

Currently, driver code allows user to set 0 as KATO
(Keep Alive TimeOut), but this is not being respected.
This patch enforces the expected behavior.

Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
---
v3: Implemented Sagi's suggestion of setting KATO to default
early and then remove condition on "out" label.

 drivers/nvme/host/fabrics.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 47307752dc65..555c976cc2ee 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -565,6 +565,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
 	opts->nr_io_queues = num_online_cpus();
 	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
+	opts->kato = NVME_DEFAULT_KATO;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -655,21 +656,22 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				goto out;
 			}
 
-			if (opts->discovery_nqn) {
-				pr_err("Discovery controllers cannot accept keep_alive_tmo != 0\n");
-				ret = -EINVAL;
-				goto out;
-			}
-
 			if (token < 0) {
 				pr_err("Invalid keep_alive_tmo %d\n", token);
 				ret = -EINVAL;
 				goto out;
-			} else if (token == 0) {
+			} else if (token == 0 && !opts->discovery_nqn) {
 				/* Allowed for debug */
 				pr_warn("keep_alive_tmo 0 won't execute keep alives!!!\n");
 			}
 			opts->kato = token;
+
+			if (opts->discovery_nqn && opts->kato) {
+				pr_err("Discovery controllers cannot accept KATO != 0\n");
+				ret = -EINVAL;
+				goto out;
+			}
+
 			break;
 		case NVMF_OPT_CTRL_LOSS_TMO:
 			if (match_int(args, &token)) {
@@ -762,8 +764,6 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	uuid_copy(&opts->host->id, &hostid);
 
 out:
-	if (!opts->discovery_nqn && !opts->kato)
-		opts->kato = NVME_DEFAULT_KATO;
 	kfree(options);
 	return ret;
 }
-- 
2.14.1
