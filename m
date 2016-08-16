From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 16 Aug 2016 12:46:25 +0300
Subject: [PATCH v3 nvme-cli 2/4] fabrics: stringify discover output.
In-Reply-To: <1471340787-26922-1-git-send-email-sagi@grimberg.me>
References: <1471340787-26922-1-git-send-email-sagi@grimberg.me>
Message-ID: <1471340787-26922-3-git-send-email-sagi@grimberg.me>

Just so we have a nice readable output.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 common.h  |   2 +
 fabrics.c | 133 +++++++++++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 94 insertions(+), 41 deletions(-)

diff --git a/common.h b/common.h
index 639186d520b1..f0a94de57061 100644
--- a/common.h
+++ b/common.h
@@ -6,4 +6,6 @@
 #define __round_mask(x, y) ((__typeof__(x))((y)-1))
 #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
 
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 #endif
diff --git a/fabrics.c b/fabrics.c
index 461e126cc56f..1bcd6fc8cf17 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -69,6 +69,91 @@ static const match_table_t opt_tokens = {
 	{ OPT_ERR,		NULL		},
 };
 
+static const char *arg_str(const char * const *strings,
+		size_t array_size, size_t idx)
+{
+	if (idx < array_size && strings[idx])
+		return strings[idx];
+	return "unrecognized";
+}
+
+static const char * const trtypes[] = {
+	[NVMF_TRTYPE_RDMA]	= "rdma",
+	[NVMF_TRTYPE_FC]	= "fibre-channel",
+	[NVMF_TRTYPE_LOOP]	= "loop",
+};
+
+static const char *trtype_str(__u8 trtype)
+{
+	return arg_str(trtypes, ARRAY_SIZE(trtypes), trtype);
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
+	return arg_str(adrfams, ARRAY_SIZE(adrfams), adrfam);
+}
+
+static const char * const nqntypes[] = {
+	[NVME_NQN_DISC]		= "discovery subsystem",
+	[NVME_NQN_NVME]		= "nvme subsystem",
+};
+
+static inline const char *nqntype_str(__u8 nqntype)
+{
+	return arg_str(nqntypes, ARRAY_SIZE(nqntypes), nqntype);
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
+	return arg_str(treqs, ARRAY_SIZE(treqs), treq);
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
+	return arg_str(prtypes, ARRAY_SIZE(prtypes), prtype);
+}
+
+static const char * const qptypes[] = {
+	[NVMF_RDMA_QPTYPE_CONNECTED]	= "connected",
+	[NVMF_RDMA_QPTYPE_DATAGRAM]	= "datagram",
+};
+
+static inline const char *qptype_str(__u8 qptype)
+{
+	return arg_str(qptypes, ARRAY_SIZE(qptypes), qptype);
+}
+
+static const char * const cms[] = {
+	[NVMF_RDMA_CMS_RDMA_CM]	= "rdma-cm",
+};
+
+static const char *cms_str(__u8 cm)
+{
+	return arg_str(cms, ARRAY_SIZE(cms), cm);
+}
+
 static int do_discover(char *argstr, bool connect);
 
 static int add_ctrl(const char *argstr)
@@ -276,44 +361,10 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 		struct nvmf_disc_rsp_page_entry *e = &log->entries[i];
 
 		printf("=====Discovery Log Entry %d======\n", i);
-
-		printf("trtype:  ");
-		switch(e->trtype) {
-		case NVMF_ADDR_FAMILY_IP4:
-			printf("ipv4\n");
-			break;
-		case NVMF_ADDR_FAMILY_IP6:
-			printf("ipv6\n");
-			break;
-		case NVMF_ADDR_FAMILY_IB:
-			printf("ib\n");
-			break;
-		case NVMF_ADDR_FAMILY_FC:
-			printf("fc\n");
-			break;
-		default:
-			printf("unknown\n");
-			break;
-		}
-
-		printf("adrfam:  ");
-		switch(e->adrfam) {
-		case NVMF_TRTYPE_RDMA:
-			printf("rdma\n");
-			break;
-		case NVMF_TRTYPE_FC:
-			printf("fc\n");
-			break;
-		case NVMF_TRTYPE_LOOP:
-			printf("loop\n");
-			break;
-		default:
-			printf("unknown\n");
-			break;
-		}
-
-		printf("nqntype: %d\n", e->nqntype);
-		printf("treq:    %d\n", e->treq);
+		printf("trtype:  %s\n", trtype_str(e->trtype));
+		printf("adrfam:  %s\n", adrfam_str(e->adrfam));
+		printf("nqntype: %s\n", nqntype_str(e->nqntype));
+		printf("treq:    %s\n", treq_str(e->treq));
 		printf("portid:  %d\n", e->portid);
 		printf("trsvcid: %s\n", e->trsvcid);
 		printf("subnqn:  %s\n", e->subnqn);
@@ -321,9 +372,9 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 
 		switch (e->trtype) {
 		case NVMF_TRTYPE_RDMA:
-			printf("rdma_prtype: %d\n", e->tsas.rdma.prtype);
-			printf("rdma_qptype: %d\n", e->tsas.rdma.qptype);
-			printf("rdma_cms:    %d\n", e->tsas.rdma.cms);
+			printf("rdma_prtype: %s\n", prtype_str(e->tsas.rdma.prtype));
+			printf("rdma_qptype: %s\n", qptype_str(e->tsas.rdma.qptype));
+			printf("rdma_cms:    %s\n", cms_str(e->tsas.rdma.cms));
 			printf("rdma_pkey: 0x%04x\n", e->tsas.rdma.pkey);
 			break;
 		}
-- 
1.9.1
