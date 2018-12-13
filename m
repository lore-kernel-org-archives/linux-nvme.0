From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 12 Dec 2018 22:38:16 -0800
Subject: [PATCH v2 4/6] nvme-fabrics: allow user to pass in nr_poll_queues
In-Reply-To: <20181213063819.13614-1-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
Message-ID: <20181213063819.13614-5-sagi@grimberg.me>

This argument will specify how many polling I/O queues
to connect when creating the controller. These I/O queues
will host I/O that is set with REQ_HIPRI.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.c | 13 +++++++++++++
 drivers/nvme/host/fabrics.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5ff14f46a8d9..b2ab213f43de 100644
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
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index cad70a9f976a..478343b73e38 100644
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
