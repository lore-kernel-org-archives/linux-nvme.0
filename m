From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  7 Aug 2016 15:19:23 +0300
Subject: [PATCH nvme-cli 2/4] fabrics: stringify discover output.
In-Reply-To: <1470572365-20674-1-git-send-email-sagi@grimberg.me>
References: <1470572365-20674-1-git-send-email-sagi@grimberg.me>
Message-ID: <1470572365-20674-3-git-send-email-sagi@grimberg.me>

Just so we have a nice readable output.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 107 insertions(+), 8 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 221e34e5e39b..9f99e6175428 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -63,6 +63,106 @@ static const match_table_t opt_tokens = {
 	{ OPT_ERR,		NULL		},
 };
 
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+static const char * const trtypes[] = {
+	[NVMF_TRTYPE_RDMA]	= "rdma",
+	[NVMF_TRTYPE_FC]	= "fibre-channel",
+	[NVMF_TRTYPE_LOOP]	= "loop",
+};
+
+static inline const char *trtype_str(__u8 trtype)
+{
+	size_t idx = trtype;
+
+	return (idx < ARRAY_SIZE(trtypes) && trtypes[idx]) ?
+			trtypes[idx] : "unrecognized";
+}
+
+static const char * const adrfams[] = {
+	[NVMF_ADDR_FAMILY_PCI]	= "pci",
+	[NVMF_ADDR_FAMILY_IP4]	= "ipv4",
+	[NVMF_ADDR_FAMILY_IP6]	= "ipv6",
+	[NVMF_ADDR_FAMILY_IB]	= "infiniband",
+	[NVMF_ADDR_FAMILY_FC]	= "fibre-channel",
+};
+
+static inline const char *adrfam_str(__u8 adrfam)
+{
+	size_t idx = adrfam;
+
+	return (idx < ARRAY_SIZE(adrfams) && adrfams[idx]) ?
+			adrfams[idx] : "unrecognized";
+}
+
+static const char * const nqntypes[] = {
+	[NVME_NQN_DISC]		= "discovery subsystem",
+	[NVME_NQN_NVME]		= "nvme subsystem",
+};
+
+static inline const char *nqntype_str(__u8 nqntype)
+{
+	size_t idx = nqntype;
+
+	return (idx < ARRAY_SIZE(nqntypes) && nqntypes[idx]) ?
+			nqntypes[idx] : "unrecognized";
+}
+
+static const char * const treqs[] = {
+	[NVMF_TREQ_NOT_SPECIFIED]	= "unspecified transport requirements",
+	[NVMF_TREQ_REQUIRED]		= "required",
+	[NVMF_TREQ_NOT_REQUIRED]	= "not required",
+};
+
+static inline const char *treq_str(__u8 treq)
+{
+	size_t idx = treq;
+
+	return (idx < ARRAY_SIZE(treqs) && treqs[idx]) ?
+			treqs[idx] : "unrecognized";
+}
+
+static const char * const prtypes[] = {
+	[NVMF_RDMA_PRTYPE_NOT_SPECIFIED]	= "not specified",
+	[NVMF_RDMA_PRTYPE_IB]			= "infiniband",
+	[NVMF_RDMA_PRTYPE_ROCE]			= "roce",
+	[NVMF_RDMA_PRTYPE_ROCEV2]		= "roce-v2",
+	[NVMF_RDMA_PRTYPE_IWARP]		= "iwarp",
+};
+
+static inline const char *prtype_str(__u8 prtype)
+{
+	size_t idx = prtype;
+
+	return (idx < ARRAY_SIZE(prtypes) && prtypes[idx]) ?
+			prtypes[idx] : "unrecognized";
+}
+
+static const char * const qptypes[] = {
+	[NVMF_RDMA_QPTYPE_CONNECTED]	= "connected",
+	[NVMF_RDMA_QPTYPE_DATAGRAM]	= "datagram",
+};
+
+static inline const char *qptype_str(__u8 qptype)
+{
+	size_t idx = qptype;
+
+	return (idx < ARRAY_SIZE(qptypes) && qptypes[idx]) ?
+			qptypes[idx] : "unrecognized";
+}
+
+static const char * const cms[] = {
+	[NVMF_RDMA_CMS_RDMA_CM]	= "rdma-cm",
+};
+
+static const char *cms_str(__u8 cm)
+{
+	size_t idx = cm;
+
+	return (idx < ARRAY_SIZE(cms) && cms[idx]) ?
+			cms[idx] : "unrecognized";
+}
+
 static int do_discover(char *argstr, bool connect);
 
 static int add_ctrl(const char *argstr)
@@ -270,10 +370,10 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 		struct nvmf_disc_rsp_page_entry *e = &log->entries[i];
 
 		printf("=====Discovery Log Entry %d======\n", i);
-		printf("trtype:  %d\n", e->trtype);
-		printf("adrfam:  %d\n", e->adrfam);
-		printf("nqntype: %d\n", e->nqntype);
-		printf("treq:    %d\n", e->treq);
+		printf("trtype:  %s\n", trtype_str(e->trtype));
+		printf("adrfam:  %s\n", adrfam_str(e->adrfam));
+		printf("nqntype: %s\n", nqntype_str(e->nqntype));
+		printf("treq:    %s\n", treq_str(e->treq));
 		printf("portid:  %d\n", e->portid);
 		printf("trsvcid: %s\n", e->trsvcid);
 		printf("subnqn:  %s\n", e->subnqn);
@@ -281,10 +381,9 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 
 		switch (e->trtype) {
 		case NVMF_TRTYPE_RDMA:
-			printf("rdma_prtype: %d\n", e->tsas.rdma.prtype);
-			printf("rdma_qptype: %d\n", e->tsas.rdma.qptype);
-			printf("rdma_cms:    %d\n", e->tsas.rdma.cms);
-			printf("rdma_pkey: 0x%04x\n", e->tsas.rdma.pkey);
+			printf("rdma_prtype: %s\n", prtype_str(e->tsas.rdma.prtype));
+			printf("rdma_qptype: %s\n", qptype_str(e->tsas.rdma.qptype));
+			printf("rdma_cms:    %s\n", cms_str(e->tsas.rdma.cms));
 			break;
 		}
 	}
-- 
1.9.1
