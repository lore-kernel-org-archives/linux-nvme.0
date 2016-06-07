From: hch@lst.de (Christoph Hellwig)
Date: Tue,  7 Jun 2016 17:19:19 +0200
Subject: [PATCH 03/11] Add NVMeoF definition to nvme.h
In-Reply-To: <1465312767-10070-1-git-send-email-hch@lst.de>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
Message-ID: <1465312767-10070-4-git-send-email-hch@lst.de>

From: Ming Lin <ming.l@ssi.samsung.com>

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-and-tested-by: Sagi Grimberg <sagi at grimberg.me>
Tested-by: Armen Baloyan <armenx.baloyan at intel.com>
---
 linux/nvme.h | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/linux/nvme.h b/linux/nvme.h
index 7220b43..d05304b 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -17,6 +17,71 @@
 
 #include <linux/types.h>
 
+/* NQN names in commands fields specified one size */
+#define NVMF_NQN_FIELD_LEN	256
+
+/* However the max length of a qualified name is another size */
+#define NVMF_NQN_SIZE		223
+#define NVMF_TRSVCID_SIZE	32
+#define NVMF_TRADDR_SIZE	256
+#define NVMF_TSAS_SIZE		256
+
+#define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
+
+enum nvme_subsys_type {
+	NVME_NQN_DISC	= 1,		/* Discovery type target subsystem */
+	NVME_NQN_NVME	= 2,		/* NVME type target subsystem */
+};
+
+/* Transport Type codes for Discovery Log Page entry TRTYPE field */
+enum {
+	NVMF_TRTYPE_RDMA	= 1,	/* RDMA */
+	NVMF_TRTYPE_FC		= 2,	/* Fibre Channel */
+	NVMF_TRTYPE_LOOP	= 254,  /* Reserved for host usage */
+};
+
+/* Transport Requirements codes for Discovery Log Page entry TREQ field */
+enum {
+	NVMF_TREQ_NOT_SPECIFIED	= 0,	/* Not specified */
+	NVMF_TREQ_REQUIRED	= 1,	/* Required */
+	NVMF_TREQ_NOT_REQUIRED	= 2,	/* Not Required */
+};
+
+/* RDMA QP Service Type codes for Discovery Log Page entry TSAS
+ * RDMA_QPTYPE field
+ */
+enum {
+	NVMF_RDMA_QPTYPE_CONNECTED	= 0, /* Reliable Connected */
+	NVMF_RDMA_QPTYPE_DATAGRAM	= 1, /* Reliable Datagram */
+};
+
+/* RDMA QP Service Type codes for Discovery Log Page entry TSAS
+ * RDMA_QPTYPE field
+ */
+enum {
+	NVMF_RDMA_PRTYPE_NOT_SPECIFIED	= 0, /* No Provider Specified */
+	NVMF_RDMA_PRTYPE_IB		= 1, /* InfiniBand */
+	NVMF_RDMA_PRTYPE_ROCE		= 2, /* InfiniBand RoCE */
+	NVMF_RDMA_PRTYPE_ROCEV2		= 3, /* InfiniBand RoCEV2 */
+	NVMF_RDMA_PRTYPE_IWARP		= 4, /* IWARP */
+};
+
+/* RDMA Connection Management Service Type codes for Discovery Log Page
+ * entry TSAS RDMA_CMS field
+ */
+enum {
+	NVMF_RDMA_CMS_RDMA_CM	= 0, /* Sockets based enpoint addressing */
+};
+
+/* Address Family codes for Discovery Log Page entry ADRFAM field */
+enum {
+	NVMF_ADDR_FAMILY_PCI	= 0,	/* PCIe */
+	NVMF_ADDR_FAMILY_IP4	= 1,	/* IP4 */
+	NVMF_ADDR_FAMILY_IP6	= 2,	/* IP6 */
+	NVMF_ADDR_FAMILY_IB	= 3,	/* InfiniBand */
+	NVMF_ADDR_FAMILY_FC	= 4,	/* Fibre Channel */
+};
+
 struct nvme_error_log_page {
 	__u64	error_count;
 	__u16	sqid;
@@ -397,6 +462,7 @@ enum {
 	NVME_LOG_ERROR		= 0x01,
 	NVME_LOG_SMART		= 0x02,
 	NVME_LOG_FW_SLOT	= 0x03,
+	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
 	NVME_FWACT_REPL		= (0 << 3),
 	NVME_FWACT_REPL_ACTV	= (1 << 3),
@@ -520,6 +586,43 @@ struct nvme_bar {
 	__u32			cmbsz;	/* Controller Memory Buffer Size */
 };
 
+#define NVME_CNTLID_DYNAMIC	0xFFFF
+
+/* Discovery log page entry */
+struct nvmf_disc_rsp_page_entry {
+	__u8	trtype;
+	__u8	adrfam;
+	__u8	nqntype;
+	__u8	treq;
+	__le16	portid;
+	__le16	cntlid;
+	__u8	resv8[24];
+	char	trsvcid[NVMF_TRSVCID_SIZE];
+	__u8	resv64[192];
+	char	subnqn[NVMF_NQN_FIELD_LEN];
+	char	traddr[NVMF_TRADDR_SIZE];
+	union tsas {
+		char		common[NVMF_TSAS_SIZE];
+		struct rdma {
+			__u8	qptype;
+			__u8	prtype;
+			__u8	cms;
+			__u8	resv3[5];
+			__u16	pkey;
+			__u8	resv10[246];
+		} rdma;
+	} tsas;
+};
+
+/* Discovery log page header */
+struct nvmf_disc_rsp_page_hdr {
+	__le64	genctr;
+	__le64	numrec;
+	__le16	recfmt;
+	__u8	resv14[1006];
+	struct nvmf_disc_rsp_page_entry entries[0];
+};
+
 #define nvme_admin_cmd nvme_passthru_cmd
 
 #define NVME_VS(major, minor) (((major) << 16) | ((minor) << 8))
-- 
2.1.4
