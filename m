From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 23:38:56 -0800
Subject: [PATCH v3 3/5] nvme-fabrics: allow user to set nr_write_queues for
 separate queue maps
In-Reply-To: <20181212073858.7102-1-sagi@grimberg.me>
References: <20181212073858.7102-1-sagi@grimberg.me>
Message-ID: <20181212073858.7102-4-sagi@grimberg.me>

This argument will specify how many I/O queues will be connected
in create_ctrl in addition to nr_io_queues. With this configuration,
I/O that carries payload from the host to the target, will use
the default hctx queue map, and I/O that involves target to host
transfers will use the read hctx queue map.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.c | 13 +++++++++++++
 drivers/nvme/host/fabrics.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 9c62c6838b76..19ff0eae4582 100644
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
