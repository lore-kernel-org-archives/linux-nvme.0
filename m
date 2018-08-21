From: hare@suse.de (Hannes Reinecke)
Date: Tue, 21 Aug 2018 15:43:27 +0200
Subject: [PATCH 2/4] nvme: implement 'async_connect' cli option
In-Reply-To: <20180821134329.69577-1-hare@suse.de>
References: <20180821134329.69577-1-hare@suse.de>
Message-ID: <20180821134329.69577-3-hare@suse.de>

Implement an option 'async_connect' to make the CLI return immediately
without waiting for the actual connect to complete.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fabrics.c | 7 ++++++-
 drivers/nvme/host/fabrics.h | 6 ++++++
 drivers/nvme/host/fc.c      | 3 ++-
 drivers/nvme/host/rdma.c    | 3 ++-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 206d63cb1afc..e484205b4cad 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -604,6 +604,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_HOST_TRADDR,		"host_traddr=%s"	},
 	{ NVMF_OPT_HOST_ID,		"hostid=%s"		},
 	{ NVMF_OPT_DUP_CONNECT,		"duplicate_connect"	},
+	{ NVMF_OPT_ASYNC_CONNECT,	"async_connect"		},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -814,6 +815,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		case NVMF_OPT_DUP_CONNECT:
 			opts->duplicate_connect = true;
 			break;
+		case NVMF_OPT_ASYNC_CONNECT:
+			opts->async_connect = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -900,7 +904,8 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 #define NVMF_REQUIRED_OPTS	(NVMF_OPT_TRANSPORT | NVMF_OPT_NQN)
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
-				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT)
+				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT | \
+				 NVMF_OPT_ASYNC_CONNECT)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index aa2fdb2a2e8f..930305a17b88 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -58,6 +58,7 @@ enum {
 	NVMF_OPT_CTRL_LOSS_TMO	= 1 << 11,
 	NVMF_OPT_HOST_ID	= 1 << 12,
 	NVMF_OPT_DUP_CONNECT	= 1 << 13,
+	NVMF_OPT_ASYNC_CONNECT	= 1 << 14,
 };
 
 /**
@@ -80,6 +81,10 @@ enum {
  * @nr_io_queues: Number of controller IO queues that will be established.
  * @reconnect_delay: Time between two consecutive reconnect attempts.
  * @discovery_nqn: indicates if the subsysnqn is the well-known discovery NQN.
+ * @duplicate_connect: indicates if the controller supports duplicate
+ *		connections.
+ * @async_connect: indicates if the connection should be established
+ *		asynchronously via a workqueue.
  * @kato:	Keep-alive timeout.
  * @host:	Virtual NVMe host, contains the NQN and Host ID.
  * @max_reconnects: maximum number of allowed reconnect attempts before removing
@@ -98,6 +103,7 @@ struct nvmf_ctrl_options {
 	unsigned int		reconnect_delay;
 	bool			discovery_nqn;
 	bool			duplicate_connect;
+	bool			async_connect;
 	unsigned int		kato;
 	struct nvmf_host	*host;
 	int			max_reconnects;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 611e70cae754..90b4d8df275b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3081,7 +3081,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		goto fail_ctrl;
 	}
 
-	flush_delayed_work(&ctrl->connect_work);
+	if (!opts->async_connect)
+		flush_delayed_work(&ctrl->connect_work);
 
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0906acbb800e..82917dba9452 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2003,7 +2003,8 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		goto out_uninit_ctrl;
 	}
 
-	flush_delayed_work(&ctrl->reconnect_work);
+	if (!opts->async_connect)
+		flush_delayed_work(&ctrl->reconnect_work);
 
 	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
 		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
-- 
2.16.4
