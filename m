From: sagi@lightbitslabs.com (Sagi Grimberg)
Date: Thu, 15 Nov 2018 09:16:20 -0800
Subject: [PATCH 08/11] nvme-fabrics: allow user passing data digest
In-Reply-To: <20181115171626.9306-1-sagi@lightbitslabs.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
Message-ID: <20181115171626.9306-9-sagi@lightbitslabs.com>

Data digest is a nvme-tcp specific feature, but nothing prevents other
transports reusing the concept so do not associate with tcp transport
solely.

Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 drivers/nvme/host/fabrics.c | 5 +++++
 drivers/nvme/host/fabrics.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 9a8b57b3b2c1..97855a12364e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -615,6 +615,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_DUP_CONNECT,		"duplicate_connect"	},
 	{ NVMF_OPT_DISABLE_SQFLOW,	"disable_sqflow"	},
 	{ NVMF_OPT_HDR_DIGEST,		"hdr_digest"		},
+	{ NVMF_OPT_DATA_DIGEST,		"data_digest"		},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -635,6 +636,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->kato = NVME_DEFAULT_KATO;
 	opts->duplicate_connect = false;
 	opts->hdr_digest = false;
+	opts->data_digest = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -832,6 +834,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		case NVMF_OPT_HDR_DIGEST:
 			opts->hdr_digest = true;
 			break;
+		case NVMF_OPT_DATA_DIGEST:
+			opts->data_digest = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a6127f1a9e8e..524a02a67817 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -60,6 +60,7 @@ enum {
 	NVMF_OPT_DUP_CONNECT	= 1 << 13,
 	NVMF_OPT_DISABLE_SQFLOW = 1 << 14,
 	NVMF_OPT_HDR_DIGEST	= 1 << 15,
+	NVMF_OPT_DATA_DIGEST	= 1 << 16,
 };
 
 /**
@@ -105,6 +106,7 @@ struct nvmf_ctrl_options {
 	int			max_reconnects;
 	bool			disable_sqflow;
 	bool			hdr_digest;
+	bool			data_digest;
 };
 
 /*
-- 
2.17.1
