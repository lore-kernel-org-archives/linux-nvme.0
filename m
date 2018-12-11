From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 02:49:33 -0800
Subject: [PATCH 3/5] nvme-fabrics: allow user to set nr_write_queues for
 separate queue maps
In-Reply-To: <20181211104936.25333-1-sagi@grimberg.me>
References: <20181211104936.25333-1-sagi@grimberg.me>
Message-ID: <20181211104936.25333-4-sagi@grimberg.me>

This argument will specify how many I/O queues will be connected
in create_ctrl in addition to nr_io_queues. With this configuration,
I/O that carries payload from the host to the target, will use
the default hctx queue map, and I/O that involves target to host
transfers will use the read hctx queue map.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.c | 15 ++++++++++++++-
 drivers/nvme/host/fabrics.h |  3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 9c62c6838b76..066c3a02e08b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -616,6 +616,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_DISABLE_SQFLOW,	"disable_sqflow"	},
 	{ NVMF_OPT_HDR_DIGEST,		"hdr_digest"		},
 	{ NVMF_OPT_DATA_DIGEST,		"data_digest"		},
+	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -837,6 +838,18 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		case NVMF_OPT_DATA_DIGEST:
 			opts->data_digest = true;
 			break;
+		case NVMF_OPT_NR_WRITE_QUEUES:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (token <= 0) {
+				pr_err("Invalid nr_write_queues %d\n", token);
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->nr_write_queues = token;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -954,7 +967,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
-				 NVMF_OPT_DISABLE_SQFLOW)
+				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_NR_WRITE_QUEUES)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 28dc916ef26b..81b8fd1c0c5d 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -61,6 +61,7 @@ enum {
 	NVMF_OPT_DISABLE_SQFLOW = 1 << 14,
 	NVMF_OPT_HDR_DIGEST	= 1 << 15,
 	NVMF_OPT_DATA_DIGEST	= 1 << 16,
+	NVMF_OPT_NR_WRITE_QUEUES = 1 << 17,
 };
 
 /**
@@ -91,6 +92,7 @@ enum {
  * @disable_sqflow: disable controller sq flow control
  * @hdr_digest: generate/verify header digest (TCP)
  * @data_digest: generate/verify data digest (TCP)
+ * @nr_write_queues: number of queues for write I/O
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -110,6 +112,7 @@ struct nvmf_ctrl_options {
 	bool			disable_sqflow;
 	bool			hdr_digest;
 	bool			data_digest;
+	unsigned int		nr_write_queues;
 };
 
 /*
-- 
2.17.1
