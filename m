From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  7 Jan 2019 23:54:23 -0800
Subject: [PATCH] nvme-fabrics: unset write/poll queues for discovery
 controllers
Message-ID: <20190108075423.3970-1-sagi@grimberg.me>

Even if user-space sent it to us, it got it wrong so lets
help by disallowing it.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index b2ab213f43de..3eb908c50e1a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -874,6 +874,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	if (opts->discovery_nqn) {
 		opts->kato = 0;
 		opts->nr_io_queues = 0;
+		opts->nr_write_queues = 0;
+		opts->nr_poll_queues = 0;
 		opts->duplicate_connect = true;
 	}
 	if (ctrl_loss_tmo < 0)
-- 
2.17.1
