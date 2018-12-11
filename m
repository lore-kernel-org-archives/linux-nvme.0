From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 15:36:48 -0800
Subject: [PATCH RFC 1/4] nvme-fabrics: allow user to pass in nr_poll_queues
In-Reply-To: <20181211233652.9705-1-sagi@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
Message-ID: <20181211233652.9705-2-sagi@grimberg.me>

This argument will specify how many polling I/O queues
to connect when creating the controller. These I/O queues
will host I/O that is set with REQ_HIPRI.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.c | 16 +++++++++++++++-
 drivers/nvme/host/fabrics.h |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 066c3a02e08b..f43bd1eada1c 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -617,6 +617,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_HDR_DIGEST,		"hdr_digest"		},
 	{ NVMF_OPT_DATA_DIGEST,		"data_digest"		},
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
+	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -850,6 +851,18 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->nr_write_queues = token;
 			break;
+		case NVMF_OPT_NR_POLL_QUEUES:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (token <= 0) {
+				pr_err("Invalid nr_poll_queues %d\n", token);
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->nr_poll_queues = token;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -967,7 +980,8 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
-				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_NR_WRITE_QUEUES)
+				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_NR_WRITE_QUEUES | \
+				 NVMF_OPT_NR_POLL_QUEUES)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 81b8fd1c0c5d..36f5daf05f08 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -62,6 +62,7 @@ enum {
 	NVMF_OPT_HDR_DIGEST	= 1 << 15,
 	NVMF_OPT_DATA_DIGEST	= 1 << 16,
 	NVMF_OPT_NR_WRITE_QUEUES = 1 << 17,
+	NVMF_OPT_NR_POLL_QUEUES = 1 << 18,
 };
 
 /**
@@ -93,6 +94,7 @@ enum {
  * @hdr_digest: generate/verify header digest (TCP)
  * @data_digest: generate/verify data digest (TCP)
  * @nr_write_queues: number of queues for write I/O
+ * @nr_poll_queues: number of queues for polling I/O
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -113,6 +115,7 @@ struct nvmf_ctrl_options {
 	bool			hdr_digest;
 	bool			data_digest;
 	unsigned int		nr_write_queues;
+	unsigned int		nr_poll_queues;
 };
 
 /*
-- 
2.17.1
