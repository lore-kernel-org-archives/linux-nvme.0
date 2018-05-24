From: hare@suse.de (Hannes Reinecke)
Date: Thu, 24 May 2018 16:18:15 +0200
Subject: [PATCH 1/3] nvme: centralize discovery controller defaults
In-Reply-To: <20180524141817.127576-1-hare@suse.de>
References: <20180524141817.127576-1-hare@suse.de>
Message-ID: <20180524141817.127576-2-hare@suse.de>

When connecting to the discovery controller we have certain defaults
to observe, so centralize them to avoid inconsistencies due to argument
ordering.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fabrics.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 13c5d3155c41..d25aa4322d16 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -698,10 +698,6 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			opts->discovery_nqn =
 				!(strcmp(opts->subsysnqn,
 					 NVME_DISC_SUBSYS_NAME));
-			if (opts->discovery_nqn) {
-				opts->kato = 0;
-				opts->nr_io_queues = 0;
-			}
 			break;
 		case NVMF_OPT_TRADDR:
 			p = match_strdup(args);
@@ -856,6 +852,10 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		}
 	}
 
+	if (opts->discovery_nqn) {
+		opts->kato = 0;
+		opts->nr_io_queues = 0;
+	}
 	if (ctrl_loss_tmo < 0)
 		opts->max_reconnects = -1;
 	else
-- 
2.12.3
