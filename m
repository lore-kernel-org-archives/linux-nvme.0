From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 12 Jul 2019 11:02:09 -0700
Subject: [PATCH v2 1/3] nvme-fabrics: allow discovery subsystems accept a kato
In-Reply-To: <20190712180211.26333-1-sagi@grimberg.me>
References: <20190712180211.26333-1-sagi@grimberg.me>
Message-ID: <20190712180211.26333-2-sagi@grimberg.me>

This modifies the behavior of discovery subsystems to accept
a kato as a preparation to support discovery log change
events. This also means that now every discovery controller
will have a default kato value, and for non-persistent connections
the host needs to pass in a zero kato value (keep_alive_tmo=0).

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 1994d5b42f94..d0d066307bb4 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -381,8 +381,8 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	 * Set keep-alive timeout in seconds granularity (ms * 1000)
 	 * and add a grace period for controller kato enforcement
 	 */
-	cmd.connect.kato = ctrl->opts->discovery_nqn ? 0 :
-		cpu_to_le32((ctrl->kato + NVME_KATO_GRACE) * 1000);
+	cmd.connect.kato = ctrl->kato ?
+		cpu_to_le32((ctrl->kato + NVME_KATO_GRACE) * 1000) : 0;
 
 	if (ctrl->opts->disable_sqflow)
 		cmd.connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
@@ -738,13 +738,6 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
@@ -865,7 +858,6 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	}
 
 	if (opts->discovery_nqn) {
-		opts->kato = 0;
 		opts->nr_io_queues = 0;
 		opts->nr_write_queues = 0;
 		opts->nr_poll_queues = 0;
-- 
2.17.1
