From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Nov 2018 17:56:14 -0800
Subject: [PATCH nvme-cli v3 16/13] fabrics: add tcp port tsas decoding
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Message-ID: <20181122015615.15763-17-sagi@grimberg.me>

From: Sagi Grimberg <sagi@lightbitslabs.com>

tcp tsas include sectype indication for unsecured/tls ports.

Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 fabrics.c    | 14 ++++++++++++++
 linux/nvme.h | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 86f6f992b14f..f8e03de46632 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -140,6 +140,16 @@ static inline const char *treq_str(__u8 treq)
 	return arg_str(treqs, ARRAY_SIZE(treqs), treq);
 }
 
+static const char * const sectypes[] = {
+	[NVMF_TCP_SECTYPE_NONE]		= "none",
+	[NVMF_TCP_SECTYPE_TLS]		= "tls",
+};
+
+static inline const char *sectype_str(__u8 sectype)
+{
+	return arg_str(sectypes, ARRAY_SIZE(sectypes), sectype);
+}
+
 static const char * const prtypes[] = {
 	[NVMF_RDMA_PRTYPE_NOT_SPECIFIED]	= "not specified",
 	[NVMF_RDMA_PRTYPE_IB]			= "infiniband",
@@ -436,6 +446,10 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 			printf("rdma_pkey: 0x%04x\n",
 				e->tsas.rdma.pkey);
 			break;
+		case NVMF_TRTYPE_TCP:
+			printf("sectype: %s\n",
+				sectype_str(e->tsas.tcp.sectype));
+			break;
 		}
 	}
 }
diff --git a/linux/nvme.h b/linux/nvme.h
index 7a600c791877..68000eb8c1dc 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -91,6 +91,13 @@ enum {
 	NVMF_RDMA_CMS_RDMA_CM	= 1, /* Sockets based endpoint addressing */
 };
 
+/* TCP port security type for  Discovery Log Page entry TSAS
+ */
+enum {
+	NVMF_TCP_SECTYPE_NONE	= 0, /* No Security */
+	NVMF_TCP_SECTYPE_TLS	= 1, /* Transport Layer Security */
+};
+
 #define NVME_AQ_DEPTH		32
 #define NVME_NR_AEN_COMMANDS	1
 #define NVME_AQ_BLK_MQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AEN_COMMANDS)
@@ -1184,6 +1191,9 @@ struct nvmf_disc_rsp_page_entry {
 			__u16	pkey;
 			__u8	resv10[246];
 		} rdma;
+		struct tcp {
+			__u8	sectype;
+		} tcp;
 	} tsas;
 };
 
-- 
2.17.1
