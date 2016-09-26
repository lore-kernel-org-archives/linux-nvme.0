From: james.smart@broadcom.com (James Smart)
Date: Mon, 26 Sep 2016 07:35:06 -0700
Subject: [PATCH 3/3] nvme-fabrics: Move controller id to opts struct
Message-ID: <57e9321a.e6Pgooc71MbSI4hg%james.smart@broadcom.com>

The FC transport needs the controller ID for transport connect which occur
prior to the fabric connect command.  Currently, it's hardcoded in the
fabrics code for the fabric connect cmd formatting routine.

Reworked to have controller id set in the opts structure. Adds support
for controller id to be specified as an option.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fabrics.c | 19 +++++++++++++++++--
 drivers/nvme/host/fabrics.h |  5 ++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5a3f008..cb90050 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -396,7 +396,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		return -ENOMEM;
 
 	memcpy(&data->hostid, &ctrl->opts->host->id, sizeof(uuid_be));
-	data->cntlid = cpu_to_le16(0xffff);
+	data->cntlid = cpu_to_le16(ctrl->opts->cntlid);
 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
@@ -530,6 +530,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_RECONNECT_DELAY,	"reconnect_delay=%d"	},
 	{ NVMF_OPT_KATO,		"keep_alive_tmo=%d"	},
 	{ NVMF_OPT_HOSTNQN,		"hostnqn=%s"		},
+	{ NVMF_OPT_CNTLID,		"cntlid=%s"		},
 	{ NVMF_OPT_HOST_TRADDR,		"host_traddr=%s"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
@@ -546,6 +547,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
 	opts->nr_io_queues = num_online_cpus();
 	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
+	opts->cntlid = 0xffff;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -687,6 +689,18 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->reconnect_delay = token;
 			break;
+		case NVMF_OPT_CNTLID:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (token <= 0 || token > 0xffff) {
+				pr_err("Invalid cntlid %d\n", token);
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->cntlid = token;
+			break;
 		case NVMF_OPT_HOST_TRADDR:
 			p = match_strdup(args);
 			if (!p) {
@@ -768,7 +782,8 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 
 #define NVMF_REQUIRED_OPTS	(NVMF_OPT_TRANSPORT | NVMF_OPT_NQN)
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
-				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN)
+				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
+				 NVMF_OPT_CNTLID)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 924145c9..5ebdf92 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -52,7 +52,8 @@ enum {
 	NVMF_OPT_KATO		= 1 << 7,
 	NVMF_OPT_HOSTNQN	= 1 << 8,
 	NVMF_OPT_RECONNECT_DELAY = 1 << 9,
-	NVMF_OPT_HOST_TRADDR	= 1 << 10,
+	NVMF_OPT_CNTLID		= 1 << 10,
+	NVMF_OPT_HOST_TRADDR	= 1 << 11,
 };
 
 /**
@@ -76,6 +77,7 @@ enum {
  * @reconnect_delay: Time between two consecutive reconnect attempts.
  * @discovery_nqn: indicates if the subsysnqn is the well-known discovery NQN.
  * @kato:	Keep-alive timeout.
+ * @cntlid:	Controller ID for controller. Default is 0xFFFF.
  * @host:	Virtual NVMe host, contains the NQN and Host ID.
  */
 struct nvmf_ctrl_options {
@@ -90,6 +92,7 @@ struct nvmf_ctrl_options {
 	unsigned int		reconnect_delay;
 	bool			discovery_nqn;
 	unsigned int		kato;
+	unsigned int		cntlid;
 	struct nvmf_host	*host;
 };
 
-- 
2.5.0
