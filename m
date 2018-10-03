From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  3 Oct 2018 01:13:22 -0700
Subject: [PATCH v2 4/4] nvme: disable fabrics SQ flow control when asked by
 the user
In-Reply-To: <20181003081323.7504-1-sagi@grimberg.me>
References: <20181003081323.7504-1-sagi@grimberg.me>
Message-ID: <20181003081323.7504-5-sagi@grimberg.me>

As for now, we don't care about sq_head pointer updates anyway, so
at least allow the controller to micro-optimize by omiting this update.

Note that we will probably need to support it when a controller
that requires this comes along.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.c | 13 +++++++++++++
 drivers/nvme/host/fabrics.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 38cf9d371953..d1fffaae94e1 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -392,6 +392,9 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	cmd.connect.kato = ctrl->opts->discovery_nqn ? 0 :
 		cpu_to_le32((ctrl->kato + NVME_KATO_GRACE) * 1000);
 
+	if (ctrl->opts->disable_sqflow)
+		cmd.connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -451,6 +454,9 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	cmd.connect.qid = cpu_to_le16(qid);
 	cmd.connect.sqsize = cpu_to_le16(ctrl->sqsize);
 
+	if (ctrl->opts->disable_sqflow)
+		cmd.connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -607,6 +613,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_HOST_TRADDR,		"host_traddr=%s"	},
 	{ NVMF_OPT_HOST_ID,		"hostid=%s"		},
 	{ NVMF_OPT_DUP_CONNECT,		"duplicate_connect"	},
+	{ NVMF_OPT_DISABLE_SQFLOW,	"disable_sqflow"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -817,6 +824,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		case NVMF_OPT_DUP_CONNECT:
 			opts->duplicate_connect = true;
 			break;
+		case NVMF_OPT_DISABLE_SQFLOW:
+			opts->disable_sqflow = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -890,6 +900,9 @@ EXPORT_SYMBOL_GPL(nvmf_ip_options_match);
 static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
 		unsigned int allowed_opts)
 {
+	/* fabrics parameter, allowed regardless of the transport */
+	allowed_opts |= NVMF_OPT_DISABLE_SQFLOW;
+
 	if (opts->mask & ~allowed_opts) {
 		int i;
 
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 4f5757e5801f..11cb9747fbf9 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -58,6 +58,7 @@ enum {
 	NVMF_OPT_CTRL_LOSS_TMO	= 1 << 11,
 	NVMF_OPT_HOST_ID	= 1 << 12,
 	NVMF_OPT_DUP_CONNECT	= 1 << 13,
+	NVMF_OPT_DISABLE_SQFLOW = 1 << 14,
 };
 
 /**
@@ -101,6 +102,7 @@ struct nvmf_ctrl_options {
 	unsigned int		kato;
 	struct nvmf_host	*host;
 	int			max_reconnects;
+	bool			disable_sqflow;
 };
 
 /*
-- 
2.17.1
