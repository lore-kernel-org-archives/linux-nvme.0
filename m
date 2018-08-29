From: sshah@solarflare.com (Shradha Shah)
Date: Wed, 29 Aug 2018 10:57:18 +0100
Subject: [PATCH 1/3] nvme-tcp: TLS encryption support-Introduce boolean flag
 in the header file
In-Reply-To: <697ba799-b8b4-c7b5-734d-09e898295a4f@solarflare.com>
References: <697ba799-b8b4-c7b5-734d-09e898295a4f@solarflare.com>
Message-ID: <362355aa-a1f0-0559-3fce-8f309ad44f70@solarflare.com>

Signed-off-by: Shradha Shah <sshah at solarflare.com>
---
 drivers/nvme/host/fabrics.c | 8 +++++++-
 drivers/nvme/host/fabrics.h | 3 +++
 drivers/nvme/host/nvme.h    | 1 +
 drivers/nvme/host/tcp.c     | 4 +++-
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 8f0f34d06d46..cc693aeb44f2 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -550,6 +550,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_HOST_TRADDR,		"host_traddr=%s"	},
 	{ NVMF_OPT_HOST_ID,		"hostid=%s"		},
 	{ NVMF_OPT_DUP_CONNECT,		"duplicate_connect"	},
+	{ NVMF_OPT_TLS_ENABLE,              "tls_enable"      },
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -569,6 +570,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
 	opts->kato = NVME_DEFAULT_KATO;
 	opts->duplicate_connect = false;
+	opts->tls_enable = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -756,6 +758,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		case NVMF_OPT_DUP_CONNECT:
 			opts->duplicate_connect = true;
 			break;
+		case NVMF_OPT_TLS_ENABLE:
+			opts->tls_enable = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -837,7 +842,8 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 #define NVMF_REQUIRED_OPTS	(NVMF_OPT_TRANSPORT | NVMF_OPT_NQN)
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
-				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT)
+				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT | \
+				 NVMF_OPT_TLS_ENABLE)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a3145d90c1d2..bb9c61db8891 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -58,6 +58,7 @@ enum {
 	NVMF_OPT_CTRL_LOSS_TMO	= 1 << 11,
 	NVMF_OPT_HOST_ID	= 1 << 12,
 	NVMF_OPT_DUP_CONNECT	= 1 << 13,
+	NVMF_OPT_TLS_ENABLE   = 1 << 14,
 };
 
 /**
@@ -80,6 +81,7 @@ enum {
  * @nr_io_queues: Number of controller IO queues that will be established.
  * @reconnect_delay: Time between two consecutive reconnect attempts.
  * @discovery_nqn: indicates if the subsysnqn is the well-known discovery NQN.
+ * @tls_enable: Indicates if connection needs a TLS handshake via AF_KTLS socket
  * @kato:	Keep-alive timeout.
  * @host:	Virtual NVMe host, contains the NQN and Host ID.
  * @max_reconnects: maximum number of allowed reconnect attempts before removing
@@ -98,6 +100,7 @@ struct nvmf_ctrl_options {
 	unsigned int		reconnect_delay;
 	bool			discovery_nqn;
 	bool			duplicate_connect;
+	bool                  tls_enable;
 	unsigned int		kato;
 	struct nvmf_host	*host;
 	int			max_reconnects;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d0f6008577d9..06ebc7302aed 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -206,6 +206,7 @@ struct nvme_ctrl {
 	u16 icdoff;
 	u16 maxcmd;
 	int nr_reconnects;
+	bool tls_enable;
 	struct nvmf_ctrl_options *opts;
 	struct delayed_work reconnect_work;
 	struct work_struct err_work;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ad77c75e286d..a1e16457b74e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1908,6 +1908,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	ctrl->ctrl.queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
+	ctrl->ctrl.tls_enable = opts->tls_enable;
 
 	INIT_DELAYED_WORK(&ctrl->ctrl.reconnect_work,
 			nvmf_reconnect_ctrl_work);
@@ -1976,7 +1977,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 	.module		= THIS_MODULE,
 	.required_opts	= NVMF_OPT_TRADDR,
 	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
-			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
+			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
+			  NVMF_OPT_TLS_ENABLE,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
-- 
2.14.4
