From: jsmart2021@gmail.com (James Smart)
Date: Fri, 20 Oct 2017 16:17:06 -0700
Subject: [PATCH v2 1/4] nvme: add duplicate_connect option
In-Reply-To: <20171020231709.3183-1-jsmart2021@gmail.com>
References: <20171020231709.3183-1-jsmart2021@gmail.com>
Message-ID: <20171020231709.3183-2-jsmart2021@gmail.com>

Add the "duplicate_connect" boolean option (presence means true).
Default is false.

When false, the transport should validate whether a new controller request
is targeted for the same host transport addressing and target transport
addressing as an existing controller. If so, the new controller request
should be rejected.

When true, the callee is explicitly requesting a duplicate controller
connection to be made and the new request should be attempted.

Signed-off-by: James Smart <james.smart at broadcom.com>

--
v2:
 duplicate_connect option converted to a boolean
---
 drivers/nvme/host/fabrics.c | 7 ++++++-
 drivers/nvme/host/fabrics.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 8bca36a46924..4a83137b0268 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -548,6 +548,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_HOSTNQN,		"hostnqn=%s"		},
 	{ NVMF_OPT_HOST_TRADDR,		"host_traddr=%s"	},
 	{ NVMF_OPT_HOST_ID,		"hostid=%s"		},
+	{ NVMF_OPT_DUP_CONNECT,		"duplicate_connect"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -566,6 +567,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->nr_io_queues = num_online_cpus();
 	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
 	opts->kato = NVME_DEFAULT_KATO;
+	opts->duplicate_connect = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -742,6 +744,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				goto out;
 			}
 			break;
+		case NVMF_OPT_DUP_CONNECT:
+			opts->duplicate_connect = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -823,7 +828,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 #define NVMF_REQUIRED_OPTS	(NVMF_OPT_TRANSPORT | NVMF_OPT_NQN)
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
-				 NVMF_OPT_HOST_ID)
+				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index bf33663218cd..a7590cc59ba2 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -57,6 +57,7 @@ enum {
 	NVMF_OPT_HOST_TRADDR	= 1 << 10,
 	NVMF_OPT_CTRL_LOSS_TMO	= 1 << 11,
 	NVMF_OPT_HOST_ID	= 1 << 12,
+	NVMF_OPT_DUP_CONNECT	= 1 << 13,
 };
 
 /**
@@ -96,6 +97,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_io_queues;
 	unsigned int		reconnect_delay;
 	bool			discovery_nqn;
+	bool			duplicate_connect;
 	unsigned int		kato;
 	struct nvmf_host	*host;
 	int			max_reconnects;
-- 
2.13.1
