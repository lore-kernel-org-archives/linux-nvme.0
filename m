From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 19 Mar 2017 00:42:20 +0200
Subject: [PATCH 2/3] nvme-fabrics: Allow ctrl loss timeout configuration
In-Reply-To: <1489876941-6401-1-git-send-email-sagi@grimberg.me>
References: <1489876941-6401-1-git-send-email-sagi@grimberg.me>
Message-ID: <1489876941-6401-3-git-send-email-sagi@grimberg.me>

When a host sense that its controller session is damaged,
it tries to re-establish it periodically (reconnect every
reconnect_delay). It may very well be that the controller
is gone and never coming back, in this case the host will
try to reconnect forever.

Add a ctrl_loss_tmo to bound the number of reconnect attempts
to a specific controller (default to a reasonable 10 minutes).
The timeout configuration is actually translated into number of
reconnect attempts and not a schedule on its own but rather
divided with reconnect_delay. This is useful to prevent
racing flows of remove and reconnect, and it doesn't really
matter if we remove slightly sooner than what the user requested.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.c | 28 ++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h | 10 ++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5b7386f69f4d..990e6fb32a63 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -471,6 +471,16 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 }
 EXPORT_SYMBOL_GPL(nvmf_connect_io_queue);
 
+bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->opts->max_reconnects != -1 &&
+	    ctrl->opts->nr_reconnects < ctrl->opts->max_reconnects)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(nvmf_should_reconnect);
+
 /**
  * nvmf_register_transport() - NVMe Fabrics Library registration function.
  * @ops:	Transport ops instance to be registered to the
@@ -533,6 +543,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_QUEUE_SIZE,		"queue_size=%d"		},
 	{ NVMF_OPT_NR_IO_QUEUES,	"nr_io_queues=%d"	},
 	{ NVMF_OPT_RECONNECT_DELAY,	"reconnect_delay=%d"	},
+	{ NVMF_OPT_CTRL_LOSS_TMO,	"ctrl_loss_tmo=%d"	},
 	{ NVMF_OPT_KATO,		"keep_alive_tmo=%d"	},
 	{ NVMF_OPT_HOSTNQN,		"hostnqn=%s"		},
 	{ NVMF_OPT_HOST_TRADDR,		"host_traddr=%s"	},
@@ -546,6 +557,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	char *options, *o, *p;
 	int token, ret = 0;
 	size_t nqnlen  = 0;
+	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
 
 	/* Set defaults */
 	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
@@ -655,6 +667,16 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->kato = token;
 			break;
+		case NVMF_OPT_CTRL_LOSS_TMO:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+
+			if (token < 0)
+				pr_warn("ctrl_loss_tmo < 0 will reconnect forever\n");
+			ctrl_loss_tmo = token;
+			break;
 		case NVMF_OPT_HOSTNQN:
 			if (opts->host) {
 				pr_err("hostnqn already user-assigned: %s\n",
@@ -710,6 +732,12 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		}
 	}
 
+	if (ctrl_loss_tmo < 0)
+		opts->max_reconnects = -1;
+	else
+		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
+						opts->reconnect_delay);
+
 	if (!opts->host) {
 		kref_get(&nvmf_default_host->ref);
 		opts->host = nvmf_default_host;
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 156018182ce4..f5a9c1fb186f 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -21,6 +21,8 @@
 #define NVMF_MAX_QUEUE_SIZE	1024
 #define NVMF_DEF_QUEUE_SIZE	128
 #define NVMF_DEF_RECONNECT_DELAY	10
+/* default to 600 seconds of reconnect attempts before giving up */
+#define NVMF_DEF_CTRL_LOSS_TMO		600
 
 /*
  * Define a host as seen by the target.  We allocate one at boot, but also
@@ -53,6 +55,7 @@ enum {
 	NVMF_OPT_HOSTNQN	= 1 << 8,
 	NVMF_OPT_RECONNECT_DELAY = 1 << 9,
 	NVMF_OPT_HOST_TRADDR	= 1 << 10,
+	NVMF_OPT_CTRL_LOSS_TMO	= 1 << 11,
 };
 
 /**
@@ -77,6 +80,10 @@ enum {
  * @discovery_nqn: indicates if the subsysnqn is the well-known discovery NQN.
  * @kato:	Keep-alive timeout.
  * @host:	Virtual NVMe host, contains the NQN and Host ID.
+ * @nr_reconnects: number of reconnect attempted since the last ctrl failure
+ * @max_reconnects: maximum number of allowed reconnect attempts before removing
+ *              the controller, (-1) means reconnect forever, zero means remove
+ *              immediately;
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -91,6 +98,8 @@ struct nvmf_ctrl_options {
 	bool			discovery_nqn;
 	unsigned int		kato;
 	struct nvmf_host	*host;
+	int			nr_reconnects;
+	int			max_reconnects;
 };
 
 /*
@@ -133,5 +142,6 @@ void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
 void nvmf_free_options(struct nvmf_ctrl_options *opts);
 const char *nvmf_get_subsysnqn(struct nvme_ctrl *ctrl);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
+bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 
 #endif /* _NVME_FABRICS_H */
-- 
2.7.4
