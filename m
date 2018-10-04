From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 Oct 2018 14:23:24 -0700
Subject: [PATCH rfc 1/3] nvme-fabrics: allow discovery subsystems accept a kato
In-Reply-To: <20181004212328.30205-1-sagi@grimberg.me>
References: <20181004212328.30205-1-sagi@grimberg.me>
Message-ID: <20181004212328.30205-2-sagi@grimberg.me>

This modifies the behavior of discovery subsystems to accept
a kato as a preparation to support discovery log change
events. This also means that now every discovery controller
will have a default kato value, and for non-persistent connections
the host needs to pass in a zero kato value (keep_alive_tmo=0).

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 40f7e6feeadc..863f83052c95 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -389,8 +389,8 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	 * Set keep-alive timeout in seconds granularity (ms * 1000)
 	 * and add a grace period for controller kato enforcement
 	 */
-	cmd.connect.kato = ctrl->opts->discovery_nqn ? 0 :
-		cpu_to_le32((ctrl->kato + NVME_KATO_GRACE) * 1000);
+	cmd.connect.kato = ctrl->kato ?
+		cpu_to_le32((ctrl->kato + NVME_KATO_GRACE) * 1000) : 0;
 
 	if (ctrl->opts->disable_sqflow)
 		cmd.connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
@@ -743,13 +743,6 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				pr_warn("keep_alive_tmo 0 won't execute keep alives!!!\n");
 			}
 			opts->kato = token;
-
-			if (opts->discovery_nqn && opts->kato) {
-				pr_err("Discovery controllers cannot accept KATO != 0\n");
-				ret = -EINVAL;
-				goto out;
-			}
-
 			break;
 		case NVMF_OPT_CTRL_LOSS_TMO:
 			if (match_int(args, &token)) {
@@ -845,11 +838,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		}
 	}
 
-	if (opts->discovery_nqn) {
-		opts->kato = 0;
+	if (opts->discovery_nqn)
 		opts->nr_io_queues = 0;
-		opts->duplicate_connect = true;
-	}
 	if (ctrl_loss_tmo < 0)
 		opts->max_reconnects = -1;
 	else
-- 
2.17.1
