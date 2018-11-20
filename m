From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Nov 2018 19:00:18 -0800
Subject: [PATCH nvme-cli v2 16/14] fabrics: add tcp port tsas decoding
In-Reply-To: <20181120030019.31738-1-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
Message-ID: <20181120030019.31738-18-sagi@grimberg.me>

From: Sagi Grimberg <sagi@lightbitslabs.com>

tcp tsas include sectype indication for unsecured/tls ports.

Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 fabrics.c    | 14 ++++++++++++++
 linux/nvme.h | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index b4fac97253ba..3df273894632 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -141,6 +141,16 @@ static inline const char *treq_str(__u8 treq)
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
@@ -450,6 +460,10 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
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
