From: roland@kernel.org (Roland Dreier)
Date: Fri,  2 Mar 2018 09:45:01 -0800
Subject: [PATCH] nvme-fabrics: Ignore nr_io_queues option for discovery
 controllers
Message-ID: <20180302174501.31228-1-roland@kernel.org>

From: Roland Dreier <roland@purestorage.com>

This removes a dependency on the order options are passed when creating
a fabrics controller.  With the old code, if "nr_io_queues" appears before
an "nqn" option specifying the discovery controller, then nr_io_queues
is overridden with zero.  If "nr_io_queues" appears after specifying the
discovery controller, then the nr_io_queues option is used to set the
number of queues, and the driver attempts to establish IO connections
to the discovery controller (which doesn't work).

It seems better to ignore (and warn about) the "nr_io_queues" option
if userspace has already asked to connect to the discovery controller.

Signed-off-by: Roland Dreier <roland at purestorage.com>
---
 drivers/nvme/host/fabrics.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5dd4ceefed8f..acb6ee90d026 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -650,6 +650,11 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -EINVAL;
 				goto out;
 			}
+			if (opts->discovery_nqn) {
+				pr_warn("Ignoring nr_io_queues value for discovery controller\n");
+				break;
+			}
+
 			opts->nr_io_queues = min_t(unsigned int,
 					num_online_cpus(), token);
 			break;
-- 
2.15.1
