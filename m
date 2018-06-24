From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 24 Jun 2018 18:49:12 +0300
Subject: [PATCH 1/1] nvme-fabrics: use default value for nr_io_queues setting
Message-ID: <1529855352-29356-1-git-send-email-maxg@mellanox.com>

We set default value for nr_io_queues to be num_online_cpus(). No need
to call num_online_cpus() again since we can use the default value we
set earlier.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 903eb45..fbfb1ba 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -708,7 +708,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 
 			opts->nr_io_queues = min_t(unsigned int,
-					num_online_cpus(), token);
+					opts->nr_io_queues, token);
 			break;
 		case NVMF_OPT_KATO:
 			if (match_int(args, &token)) {
-- 
1.8.3.1
