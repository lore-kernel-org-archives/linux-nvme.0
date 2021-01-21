Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EAAC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:10:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C24D23602
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C24D23602
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YISwfK0XciUAUDnNN2HBzFlNT0SMf57Xn05rX8EVCKE=; b=VDn3NPQcpo07s9rkvNGoDVg7u
	5F/RfIJdN/SCE9iUYYuiI4C1MAL1j82crNCUSqhsSYrpK7CAyDLs9hN6sq3y8SYw+WCMer/LgY5QV
	eaHZcO271S14a2zcG4Z7Ox/JO6egq51AlobIGMNAOSz+jLM1trteaR8iPfHC6hjME9eO5mnBjWw0X
	mjO/6EquwoCEPaPJeLl0PzZWQqvOcRetppnpMEVa4a279IxMPB4EX/ciFsrURSET5yDIi7X7s4Udr
	70vdiTZHM8RRtlqzjqYAso8ShVL+TfbNY7lHtAXGrZbIb3HpQgboSaVlF37kdY28EH7t3g/gfJ7ZM
	hRky1qi+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2Vyk-0003Pu-6H; Thu, 21 Jan 2021 09:10:10 +0000
Received: from hqnvemgate24.nvidia.com ([216.228.121.143])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2VyW-0003L5-6G
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 09:10:04 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B600944e20001>; Thu, 21 Jan 2021 01:09:54 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Jan
 2021 09:09:53 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 21 Jan 2021 09:09:51 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>
Subject: [PATCH nvme-cli 1/1] align Linux kernel nvme.h to nvme-cli
Date: Thu, 21 Jan 2021 09:09:46 +0000
Message-ID: <20210121090948.8027-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210121090948.8027-1-mgurtovoy@nvidia.com>
References: <20210121090948.8027-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611220194; bh=NEenJ4iTz183PFic5k+diXoYpyo2ZTSYLwTmfdSC4mU=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=QewZnD9H9uLZj9kLPyT5GEU+uTTiFRs7+yJIFUQSTIUuZFQ7H+QYw1YlWy261IIbv
 zjYwy74se/IfCDW7h6nEzPxQI88P21D3+aAMAwtJIsbdIRsVeDpvPWGJVmEWh4vEb2
 0mpWX2Jzi/IjUl4YOKIZZJBqkPfc791sL+0CjMkQDOZGWD+ZDo+YqQcfTlzwooem7U
 5z2p8KpufdYqG+mARIjzHP8OlF3+Ld8iLBhwxH9ovmCq6FP/GXKUMB++HKnS/OD73e
 8PRizIoRw0/TaQHpLTkZNCTCBoxBRWfTIkeA7QbUSXic6aiBNcHT8GQtsgdCowBU6W
 0TuCzaVKkWlfw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_040956_453008_5E559763 
X-CRM114-Status: GOOD (  15.81  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is the first step to align nvme.h files from Linux kernel
include/linux/nvme.h and nvme-cli linux/nvme.h.

Internally divide linux/nvme.h into 2 parts:
 - nvme-cli specific code
 - identical copy of the content of include/linux/nvme.h

The next step might be reducing the first part to be as minimal as
possible and have a version that is in sync with kernel header. In this
way it will be easier to maintain the code and the sync process will be
fast copy/paste to part 2 of the linux/nvme.h file.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 linux/nvme.h                   | 2274 ++++++++++++++++++++------------
 nvme-ioctl.c                   |   12 +-
 nvme-print.c                   |   70 +-
 nvme-print.h                   |    6 +-
 nvme-status.c                  |   14 +-
 nvme.h                         |   23 +
 plugins/shannon/shannon-nvme.c |    4 +-
 plugins/virtium/virtium-nvme.c |    2 +-
 plugins/zns/zns.c              |    6 +-
 9 files changed, 1475 insertions(+), 936 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index 025f638..85fd4a4 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -31,6 +31,13 @@ typedef struct {
 #define __force
 #endif
 
+#ifndef likely
+#define likely(x)   __builtin_expect(!!(x), 1)
+#endif
+#ifndef unlikely
+#define unlikely(x)   __builtin_expect(!!(x), 0)
+#endif
+
 static inline __le16 cpu_to_le16(uint16_t x)
 {
 	return (__force __le16)htole16(x);
@@ -57,161 +64,763 @@ static inline uint64_t le64_to_cpu(__le64 x)
 	return le64toh((__force __u64)x);
 }
 
-/* NQN names in commands fields specified one size */
-#define NVMF_NQN_FIELD_LEN	256
+/******************** nvme-cli specific ********************************/
 
-/* However the max length of a qualified name is another size */
-#define NVMF_NQN_SIZE		223
+#define NVME_DISC_IP_PORT	8009
 
-#define NVMF_TRSVCID_SIZE	32
-#define NVMF_TRADDR_SIZE	256
-#define NVMF_TSAS_SIZE		256
+/* TCP port security type for  Discovery Log Page entry TSAS
+ */
+enum {
+	NVMF_TCP_SECTYPE_NONE	= 0, /* No Security */
+	NVMF_TCP_SECTYPE_TLS	= 1, /* Transport Layer Security */
+};
 
-#define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
+/* I/O Command Sets
+ */
+enum {
+	NVME_IOCS_NVM   = 0x00,
+	NVME_IOCS_ZONED = 0x02,
+};
 
-#define NVME_RDMA_IP_PORT	4420
-#define NVME_DISC_IP_PORT	8009
+struct nvme_id_iocs {
+	__le64 iocs[512];
+};
 
-#define NVME_NSID_ALL		0xffffffff
+/* idle and active power scales occupy the last 2 bits of the field */
+#define POWER_SCALE(s) ((s) >> 6)
 
-enum nvme_subsys_type {
-	NVME_NQN_DISC	= 1,		/* Discovery type target subsystem */
-	NVME_NQN_NVME	= 2,		/* NVME type target subsystem */
+#define NVME_MAX_NVMSET		31
+
+struct nvme_nvmset_attr_entry {
+	__le16			id;
+	__le16			endurance_group_id;
+	__u8			rsvd4[4];
+	__le32			random_4k_read_typical;
+	__le32			opt_write_size;
+	__u8			total_nvmset_cap[16];
+	__u8			unalloc_nvmset_cap[16];
+	__u8			rsvd48[80];
 };
 
-/* Address Family codes for Discovery Log Page entry ADRFAM field */
-enum {
-	NVMF_ADDR_FAMILY_PCI	= 0,	/* PCIe */
-	NVMF_ADDR_FAMILY_IP4	= 1,	/* IP4 */
-	NVMF_ADDR_FAMILY_IP6	= 2,	/* IP6 */
-	NVMF_ADDR_FAMILY_IB	= 3,	/* InfiniBand */
-	NVMF_ADDR_FAMILY_FC	= 4,	/* Fibre Channel */
-	NVMF_ADDR_FAMILY_LOOP	= 254,	/* Reserved for host usage */
-	NVMF_ADDR_FAMILY_MAX,
+struct nvme_id_nvmset {
+	__u8				nid;
+	__u8				rsvd1[127];
+	struct nvme_nvmset_attr_entry	ent[NVME_MAX_NVMSET];
 };
 
-/* Transport Type codes for Discovery Log Page entry TRTYPE field */
-enum {
-	NVMF_TRTYPE_RDMA	= 1,	/* RDMA */
-	NVMF_TRTYPE_FC		= 2,	/* Fibre Channel */
-	NVMF_TRTYPE_TCP		= 3,	/* TCP */
-	NVMF_TRTYPE_LOOP	= 254,	/* Reserved for host usage */
-	NVMF_TRTYPE_MAX,
+struct nvme_id_ns_granularity_list_entry {
+	__le64			namespace_size_granularity;
+	__le64			namespace_capacity_granularity;
 };
 
-/* Transport Requirements codes for Discovery Log Page entry TREQ field */
-enum {
-	NVMF_TREQ_NOT_SPECIFIED	= 0,		/* Not specified */
-	NVMF_TREQ_REQUIRED	= 1,		/* Required */
-	NVMF_TREQ_NOT_REQUIRED	= 2,		/* Not Required */
-	NVMF_TREQ_DISABLE_SQFLOW = (1 << 2),	/* SQ flow control disable supported */
+struct nvme_id_ns_granularity_list {
+	__le32			attributes;
+	__u8			num_descriptors;
+	__u8			rsvd[27];
+	struct nvme_id_ns_granularity_list_entry entry[16];
 };
 
-/* RDMA QP Service Type codes for Discovery Log Page entry TSAS
- * RDMA_QPTYPE field
- */
-enum {
-	NVMF_RDMA_QPTYPE_CONNECTED	= 1, /* Reliable Connected */
-	NVMF_RDMA_QPTYPE_DATAGRAM	= 2, /* Reliable Datagram */
+#define NVME_MAX_UUID_ENTRIES	128
+struct nvme_id_uuid_list_entry {
+	__u8			header;
+	__u8			rsvd1[15];
+	__u8			uuid[16];
 };
 
-/* RDMA QP Service Type codes for Discovery Log Page entry TSAS
- * RDMA_QPTYPE field
- */
-enum {
-	NVMF_RDMA_PRTYPE_NOT_SPECIFIED	= 1, /* No Provider Specified */
-	NVMF_RDMA_PRTYPE_IB		= 2, /* InfiniBand */
-	NVMF_RDMA_PRTYPE_ROCE		= 3, /* InfiniBand RoCE */
-	NVMF_RDMA_PRTYPE_ROCEV2		= 4, /* InfiniBand RoCEV2 */
-	NVMF_RDMA_PRTYPE_IWARP		= 5, /* IWARP */
+struct nvme_id_uuid_list {
+	struct nvme_id_uuid_list_entry	entry[NVME_MAX_UUID_ENTRIES];
 };
 
-/* RDMA Connection Management Service Type codes for Discovery Log Page
- * entry TSAS RDMA_CMS field
+/**
+ * struct nvme_telemetry_log_page_hdr - structure for telemetry log page
+ * @lpi: Log page identifier
+ * @iee_oui: IEEE OUI Identifier
+ * @dalb1: Data area 1 last block
+ * @dalb2: Data area 2 last block
+ * @dalb3: Data area 3 last block
+ * @ctrlavail: Controller initiated data available
+ * @ctrldgn: Controller initiated telemetry Data Generation Number
+ * @rsnident: Reason Identifier
+ * @telemetry_dataarea: Contains telemetry data block
+ *
+ * This structure can be used for both telemetry host-initiated log page
+ * and controller-initiated log page.
  */
-enum {
-	NVMF_RDMA_CMS_RDMA_CM	= 1, /* Sockets based endpoint addressing */
+struct nvme_telemetry_log_page_hdr {
+	__u8	lpi;
+	__u8	rsvd[4];
+	__u8	iee_oui[3];
+	__le16	dalb1;
+	__le16	dalb2;
+	__le16	dalb3;
+	__u8	rsvd1[368];
+	__u8	ctrlavail;
+	__u8	ctrldgn;
+	__u8	rsnident[128];
+	__u8	telemetry_dataarea[0];
 };
 
-/* TCP port security type for  Discovery Log Page entry TSAS
- */
-enum {
-	NVMF_TCP_SECTYPE_NONE	= 0, /* No Security */
-	NVMF_TCP_SECTYPE_TLS	= 1, /* Transport Layer Security */
+struct nvme_endurance_group_log {
+	__u8	critical_warning;
+	__u8	rsvd1[2];
+	__u8	avl_spare;
+	__u8	avl_spare_threshold;
+	__u8	percent_used;
+	__u8	rsvd6[26];
+	__u8	endurance_estimate[16];
+	__u8	data_units_read[16];
+	__u8	data_units_written[16];
+	__u8	media_units_written[16];
+	__u8	host_read_cmds[16];
+	__u8	host_write_cmds[16];
+	__u8	media_data_integrity_err[16];
+	__u8	num_err_info_log_entries[16];
+	__u8	rsvd160[352];
 };
 
-/* I/O Command Sets
- */
+struct nvme_self_test_res {
+	__u8 			dsts;
+	__u8			seg;
+	__u8			vdi;
+	__u8			rsvd3;
+	__le64			poh;
+	__le32			nsid;
+	__le64			flba;
+	__u8			sct;
+	__u8			sc;
+	__u8			vs[2];
+} __attribute__((packed));
+
 enum {
-	NVME_IOCS_NVM   = 0x00,
-	NVME_IOCS_ZONED = 0x02,
+	NVME_ST_CODE_SHIFT    		= 4,
+	NVME_ST_CODE_SHORT_OP 		= 0x1,
+	NVME_ST_CODE_EXT_OP   		= 0x2,
+	NVME_ST_CODE_VS	      		= 0xe,
+	NVME_ST_RES_MASK      		= 0xf,
+	NVME_ST_RES_NO_ERR    		= 0x0,
+	NVME_ST_RES_ABORTED   		= 0x1,
+	NVME_ST_RES_CLR	      		= 0x2,
+	NVME_ST_RES_NS_REMOVED		= 0x3,
+	NVME_ST_RES_ABORTED_FORMAT	= 0x4,
+	NVME_ST_RES_FATAL_ERR		= 0x5,
+	NVME_ST_RES_UNKNOWN_SEG_FAIL	= 0x6,
+	NVME_ST_RES_KNOWN_SEG_FAIL	= 0x7,
+	NVME_ST_RES_ABORTED_UNKNOWN	= 0x8,
+	NVME_ST_RES_ABORTED_SANITIZE	= 0x9,
+	NVME_ST_RES_NOT_USED		= 0xf,
+	NVME_ST_VALID_NSID		= 1 << 0,
+	NVME_ST_VALID_FLBA		= 1 << 1,
+	NVME_ST_VALID_SCT		= 1 << 2,
+	NVME_ST_VALID_SC		= 1 << 3,
+	NVME_ST_REPORTS			= 20,
 };
 
-#define NVME_AQ_DEPTH		32
-#define NVME_NR_AEN_COMMANDS	1
-#define NVME_AQ_BLK_MQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AEN_COMMANDS)
-
-/*
- * Subtract one to leave an empty queue entry for 'Full Queue' condition. See
- * NVM-Express 1.2 specification, section 4.1.2.
- */
-#define NVME_AQ_MQ_TAG_DEPTH	(NVME_AQ_BLK_MQ_DEPTH - 1)
+struct nvme_self_test_log {
+	__u8                      crnt_dev_selftest_oprn;
+	__u8                      crnt_dev_selftest_compln;
+	__u8                      rsvd[2];
+	struct nvme_self_test_res result[20];
+} __attribute__((packed));
 
-enum {
-	NVME_REG_CAP	= 0x0000,	/* Controller Capabilities */
-	NVME_REG_VS	= 0x0008,	/* Version */
-	NVME_REG_INTMS	= 0x000c,	/* Interrupt Mask Set */
-	NVME_REG_INTMC	= 0x0010,	/* Interrupt Mask Clear */
-	NVME_REG_CC	= 0x0014,	/* Controller Configuration */
-	NVME_REG_CSTS	= 0x001c,	/* Controller Status */
-	NVME_REG_NSSR	= 0x0020,	/* NVM Subsystem Reset */
-	NVME_REG_AQA	= 0x0024,	/* Admin Queue Attributes */
-	NVME_REG_ASQ	= 0x0028,	/* Admin SQ Base Address */
-	NVME_REG_ACQ	= 0x0030,	/* Admin CQ Base Address */
-	NVME_REG_CMBLOC = 0x0038,	/* Controller Memory Buffer Location */
-	NVME_REG_CMBSZ	= 0x003c,	/* Controller Memory Buffer Size */
-	NVME_REG_BPINFO	= 0x0040,	/* Boot Partition Information */
-	NVME_REG_BPRSEL	= 0x0044,	/* Boot Partition Read Select */
-	NVME_REG_BPMBL	= 0x0048,	/* Boot Partition Memory Buffer Location */
-	NVME_REG_CMBMSC	= 0x0050,	/* Controller Memory Buffer Memory Space Control */
-	NVME_REG_CMBSTS	= 0x0058,	/* Controller Memory Buffer Status */
-	NVME_REG_PMRCAP = 0x0e00,	/* Persistent Memory Capabilities */
-	NVME_REG_PMRCTL = 0x0e04,	/* Persistent Memory Region Control */
-	NVME_REG_PMRSTS = 0x0e08,	/* Persistent Memory Region Status */
-	NVME_REG_PMREBS = 0x0e0c,	/* Persistent Memory Region Elasticity Buffer Size */
-	NVME_REG_PMRSWTP= 0x0e10,	/* Persistent Memory Region Sustained Write Throughput */
-	NVME_REG_PMRMSC = 0x0e14,	/* Persistent Memory Region Controller Memory Space Control */
-	NVME_REG_DBS	= 0x1000,	/* SQ 0 Tail Doorbell */
+struct nvme_lba_status_desc {
+	__u64 dslba;
+	__u32 nlb;
+	__u8 rsvd_12;
+	__u8 status;
+	__u8 rsvd_15_14[2];
 };
 
-#define NVME_CAP_MQES(cap)	((cap) & 0xffff)
-#define NVME_CAP_TIMEOUT(cap)	(((cap) >> 24) & 0xff)
-#define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
-#define NVME_CAP_NSSRC(cap)	(((cap) >> 36) & 0x1)
-#define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
-#define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
+struct nvme_lba_status {
+	__u32 nlsd;
+	__u8 cmpc;
+	__u8 rsvd_7_5[3];
+	struct nvme_lba_status_desc descs[0];
+};
 
-#define NVME_CMB_BIR(cmbloc)	((cmbloc) & 0x7)
-#define NVME_CMB_OFST(cmbloc)	(((cmbloc) >> 12) & 0xfffff)
-#define NVME_CMB_SZ(cmbsz)	(((cmbsz) >> 12) & 0xfffff)
-#define NVME_CMB_SZU(cmbsz)	(((cmbsz) >> 8) & 0xf)
+#define NVME_MAX_CHANGED_NAMESPACES     1024
 
-#define NVME_CMB_WDS(cmbsz)	((cmbsz) & 0x10)
-#define NVME_CMB_RDS(cmbsz)	((cmbsz) & 0x8)
-#define NVME_CMB_LISTS(cmbsz)	((cmbsz) & 0x4)
-#define NVME_CMB_CQS(cmbsz)	((cmbsz) & 0x2)
-#define NVME_CMB_SQS(cmbsz)	((cmbsz) & 0x1)
+struct nvme_changed_ns_list_log {
+	__le32			log[NVME_MAX_CHANGED_NAMESPACES];
+};
 
-/*
- * Submission and Completion Queue Entry Sizes for the NVM command set.
+/* persistent event type 02h */
+struct nvme_fw_commit_event {
+    __le64	old_fw_rev;
+    __le64 	new_fw_rev;
+    __u8 	fw_commit_action;
+    __u8 	fw_slot;
+    __u8 	sct_fw;
+    __u8 	sc_fw;
+    __le16 	vndr_assign_fw_commit_rc;
+} __attribute__((packed));
+
+/* persistent event type 03h */
+struct nvme_time_stamp_change_event {
+    __le64 	previous_timestamp;
+    __le64 	ml_secs_since_reset;
+};
+
+/* persistent event type 04h */
+struct nvme_power_on_reset_info_list {
+    __le16   cid;
+    __u8     fw_act;
+    __u8     op_in_prog;
+    __u8     rsvd4[12];
+    __le32   ctrl_power_cycle;
+    __le64   power_on_ml_seconds;
+    __le64   ctrl_time_stamp;
+} __attribute__((packed));
+
+/* persistent event type 05h */
+struct nvme_nss_hw_err_event {
+    __le16 	nss_hw_err_event_code;
+    __u8 	rsvd2[2];
+    __u8 	*add_hw_err_info;
+};
+
+/* persistent event type 06h */
+struct nvme_change_ns_event {
+	__le32	nsmgt_cdw10;
+	__u8	rsvd4[4];
+	__le64	nsze;
+	__u8	nscap[16];
+	__u8	flbas;
+	__u8	dps;
+	__u8	nmic;
+	__u8	rsvd35;
+	__le32	ana_grp_id;
+	__le16	nvmset_id;
+	__le16	rsvd42;
+	__le32	nsid;
+};
+
+/* persistent event type 07h */
+struct nvme_format_nvm_start_event {
+    __le32 	nsid;
+    __u8 	fna;
+    __u8 	rsvd5[3];
+    __le32 	format_nvm_cdw10;
+};
+
+/* persistent event type 08h */
+struct nvme_format_nvm_compln_event {
+    __le32 	nsid;
+    __u8 	smallest_fpi;
+    __u8 	format_nvm_status;
+    __le16 	compln_info;
+    __le32 	status_field;
+};
+
+/* persistent event type 09h */
+struct nvme_sanitize_start_event {
+    __le32 	sani_cap;
+    __le32 	sani_cdw10;
+    __le32 	sani_cdw11;
+};
+
+/* persistent event type 0Ah */
+struct nvme_sanitize_compln_event {
+    __le16 	sani_prog;
+    __le16 	sani_status;
+    __le16 	cmpln_info;
+	__u8 	rsvd6[2];
+};
+
+/* persistent event type 0Dh */
+struct nvme_thermal_exc_event {
+    __u8 	over_temp;
+    __u8 	threshold;
+};
+
+/* persistent event entry head */
+struct nvme_persistent_event_entry_head {
+	__u8	etype;
+	__u8	etype_rev;
+	__u8	ehl;
+	__u8	rsvd3;
+	__le16	ctrl_id;
+	__le64	etimestamp;
+	__u8	rsvd14[6];
+	__le16	vsil;
+	__le16	el;
+} __attribute__((packed));
+
+/* persistent event log head */
+struct nvme_persistent_event_log_head {
+	__u8	log_id;
+	__u8	rsvd1[3];
+	__le32	tnev;
+	__le64	tll;
+	__u8	log_rev;
+	__u8	rsvd17;
+	__le16	head_len;
+	__le64	timestamp;
+	__u8	poh[16];
+	__le64	pcc;
+	__le16	vid;
+	__le16	ssvid;
+	__u8	sn[20];
+	__u8	mn[40];
+	__u8	subnqn[256];
+	__u8    rsvd372[108];
+	__u8	supp_event_bm[32];
+} __attribute__((packed));
+
+enum nvme_persistent_event_types {
+    NVME_SMART_HEALTH_EVENT         = 0x01,
+    NVME_FW_COMMIT_EVENT            = 0x02,
+    NVME_TIMESTAMP_EVENT            = 0x03,
+    NVME_POWER_ON_RESET_EVENT       = 0x04,
+    NVME_NSS_HW_ERROR_EVENT         = 0x05,
+    NVME_CHANGE_NS_EVENT            = 0x06,
+    NVME_FORMAT_START_EVENT         = 0x07,
+    NVME_FORMAT_COMPLETION_EVENT    = 0x08,
+    NVME_SANITIZE_START_EVENT       = 0x09,
+    NVME_SANITIZE_COMPLETION_EVENT  = 0x0a,
+    NVME_THERMAL_EXCURSION_EVENT    = 0x0d
+};
+
+enum nvme_persistent_event_log_actions {
+	NVME_PEVENT_LOG_READ				= 0x0,
+	NVME_PEVENT_LOG_EST_CTX_AND_READ	= 0x1,
+	NVME_PEVENT_LOG_RELEASE_CTX			= 0x2,
+};
+
+struct nvme_predlat_event_agg_log_page {
+	__le64	num_entries;
+	__le16	entries[];
+};
+
+struct nvme_predlat_per_nvmset_log_page {
+	__u8	status;
+	__u8	rsvd1;
+	__le16	event_type;
+	__u8	rsvd4[28];
+	__le64	dtwin_rtyp;
+	__le64	dtwin_wtyp;
+	__le64	dtwin_timemax;
+	__le64	ndwin_timemin_high;
+	__le64	ndwin_timemin_low;
+	__u8	rsvd72[56];
+	__le64	dtwin_restimate;
+	__le64	dtwin_westimate;
+	__le64	dtwin_testimate;
+	__u8	rsvd152[360];
+};
+
+/* Predictable Latency Mode - Deterministic Threshold Configuration Data */
+struct nvme_plm_config {
+	__le16	enable_event;
+	__u8	rsvd2[30];
+	__le64	dtwin_reads_thresh;
+	__le64	dtwin_writes_thresh;
+	__le64	dtwin_time_thresh;
+	__u8	rsvd56[456];
+};
+
+struct nvme_reservation_status_ext {
+	__le32	gen;
+	__u8	rtype;
+	__u8	regctl[2];
+	__u8	resv5[2];
+	__u8	ptpls;
+	__u8	resv10[14];
+	__u8	resv24[40];
+	struct {
+		__le16	cntlid;
+		__u8	rcsts;
+		__u8	resv3[5];
+		__le64	rkey;
+		__u8	hostid[16];
+		__u8	resv32[32];
+	} regctl_eds[];
+};
+
+enum {
+	NVME_RW_DEAC			= 1 << 9,
+};
+
+struct nvme_copy_range {
+	__u8			rsvd0[8];
+	__le64			slba;
+	__le16			nlb;
+	__u8			rsvd18[6];
+	__le32			eilbrt;
+	__le16			elbatm;
+	__le16			elbat;
+};
+
+enum {
+	NVME_NO_LOG_LSP       = 0x0,
+	NVME_NO_LOG_LPO       = 0x0,
+	NVME_LOG_ANA_LSP_RGO  = 0x1,
+	NVME_TELEM_LSP_CREATE = 0x1,
+};
+
+/* Sanitize and Sanitize Monitor/Log */
+enum {
+	/* Sanitize */
+	NVME_SANITIZE_NO_DEALLOC	= 0x00000200,
+	NVME_SANITIZE_OIPBP		= 0x00000100,
+	NVME_SANITIZE_OWPASS_SHIFT	= 0x00000004,
+	NVME_SANITIZE_AUSE		= 0x00000008,
+	NVME_SANITIZE_ACT_CRYPTO_ERASE	= 0x00000004,
+	NVME_SANITIZE_ACT_OVERWRITE	= 0x00000003,
+	NVME_SANITIZE_ACT_BLOCK_ERASE	= 0x00000002,
+	NVME_SANITIZE_ACT_EXIT		= 0x00000001,
+
+	/* Sanitize Monitor/Log */
+	NVME_SANITIZE_LOG_DATA_LEN		= 0x0014,
+	NVME_SANITIZE_LOG_GLOBAL_DATA_ERASED	= 0x0100,
+	NVME_SANITIZE_LOG_NUM_CMPLTED_PASS_MASK	= 0x00F8,
+	NVME_SANITIZE_LOG_STATUS_MASK		= 0x0007,
+	NVME_SANITIZE_LOG_NEVER_SANITIZED	= 0x0000,
+	NVME_SANITIZE_LOG_COMPLETED_SUCCESS	= 0x0001,
+	NVME_SANITIZE_LOG_IN_PROGESS		= 0x0002,
+	NVME_SANITIZE_LOG_COMPLETED_FAILED	= 0x0003,
+	NVME_SANITIZE_LOG_ND_COMPLETED_SUCCESS	= 0x0004,
+};
+
+/* Sanitize Log Page */
+struct nvme_sanitize_log_page {
+	__le16			progress;
+	__le16			status;
+	__le32			cdw10_info;
+	__le32			est_ovrwrt_time;
+	__le32			est_blk_erase_time;
+	__le32			est_crypto_erase_time;
+	__le32			est_ovrwrt_time_with_no_deallocate;
+	__le32			est_blk_erase_time_with_no_deallocate;
+	__le32			est_crypto_erase_time_with_no_deallocate;
+};
+
+struct nvme_effects_log_page {
+	__le32 acs[256];
+	__le32 iocs[256];
+	__u8   resv[2048];
+};
+
+struct nvme_error_log_page {
+	__le64	error_count;
+	__le16	sqid;
+	__le16	cmdid;
+	__le16	status_field;
+	__le16	parm_error_location;
+	__le64	lba;
+	__le32	nsid;
+	__u8	vs;
+	__u8	trtype;
+	__u8	resv[2];
+	__le64	cs;
+	__le16	trtype_spec_info;
+	__u8	resv2[22];
+};
+
+struct nvme_firmware_log_page {
+	__u8	afi;
+	__u8	resv[7];
+	__u64	frs[7];
+	__u8	resv2[448];
+};
+
+struct nvme_host_mem_buffer {
+	__u32			hsize;
+	__u32			hmdlal;
+	__u32			hmdlau;
+	__u32			hmdlec;
+	__u8			rsvd16[4080];
+};
+
+struct nvme_auto_pst {
+	__u32	data;
+	__u32	rsvd32;
+};
+
+struct nvme_timestamp {
+	__u8 timestamp[6];
+	__u8 attr;
+	__u8 rsvd;
+};
+
+struct nvme_controller_list {
+	__le16 num;
+	__le16 identifier[2047];
+};
+
+struct nvme_secondary_controller_entry {
+	__le16 scid;	/* Secondary Controller Identifier */
+	__le16 pcid;	/* Primary Controller Identifier */
+	__u8   scs;	/* Secondary Controller State */
+	__u8   rsvd5[3];
+	__le16 vfn;	/* Virtual Function Number */
+	__le16 nvq;	/* Number of VQ Flexible Resources Assigned */
+	__le16 nvi;	/* Number of VI Flexible Resources Assigned */
+	__u8   rsvd14[18];
+};
+
+struct nvme_secondary_controllers_list {
+	__u8   num;
+	__u8   rsvd[31];
+	struct nvme_secondary_controller_entry sc_entry[127];
+};
+
+struct nvme_bar_cap {
+	__u16	mqes;
+	__u8	ams_cqr;
+	__u8	to;
+	__u16	bps_css_nssrs_dstrd;
+	__u8	mpsmax_mpsmin;
+	__u8	rsvd_cmbs_pmrs;
+};
+
+enum {
+	NVME_SCT_GENERIC		= 0x0,
+	NVME_SCT_CMD_SPECIFIC		= 0x1,
+	NVME_SCT_MEDIA			= 0x2,
+};
+
+/**
+ * struct nvme_zns_id_ctrl -
+ * @zasl:
+ */
+struct nvme_zns_id_ctrl {
+	__u8	zasl;
+	__u8	rsvd1[4095];
+};
+
+#define NVME_ZNS_CHANGED_ZONES_MAX	511
+
+/**
+ * struct nvme_zns_changed_zone_log - ZNS Changed Zone List log
+ * @nrzid:
+ * @zid:
+ */
+struct nvme_zns_changed_zone_log {
+	__le16		nrzid;
+	__u8		rsvd2[6];
+	__le64		zid[NVME_ZNS_CHANGED_ZONES_MAX];
+};
+
+/**
+ * enum nvme_zns_za -
+ */
+enum nvme_zns_za {
+	NVME_ZNS_ZA_ZFC			= 1 << 0,
+	NVME_ZNS_ZA_FZR			= 1 << 1,
+	NVME_ZNS_ZA_RZR			= 1 << 2,
+	NVME_ZNS_ZA_ZDEV		= 1 << 7,
+};
+
+/**
+ * enum nvme_zns_zs -
+ */
+enum nvme_zns_zs {
+	NVME_ZNS_ZS_EMPTY		= 0x1,
+	NVME_ZNS_ZS_IMPL_OPEN		= 0x2,
+	NVME_ZNS_ZS_EXPL_OPEN		= 0x3,
+	NVME_ZNS_ZS_CLOSED		= 0x4,
+	NVME_ZNS_ZS_READ_ONLY		= 0xd,
+	NVME_ZNS_ZS_FULL		= 0xe,
+	NVME_ZNS_ZS_OFFLINE		= 0xf,
+};
+
+enum nvme_zns_send_action {
+	NVME_ZNS_ZSA_CLOSE		= 0x1,
+	NVME_ZNS_ZSA_FINISH		= 0x2,
+	NVME_ZNS_ZSA_OPEN		= 0x3,
+	NVME_ZNS_ZSA_RESET		= 0x4,
+	NVME_ZNS_ZSA_OFFLINE		= 0x5,
+	NVME_ZNS_ZSA_SET_DESC_EXT	= 0x10,
+};
+
+enum nvme_zns_recv_action {
+	NVME_ZNS_ZRA_REPORT_ZONES		= 0x0,
+	NVME_ZNS_ZRA_EXTENDED_REPORT_ZONES	= 0x1,
+};
+
+enum nvme_zns_report_options {
+	NVME_ZNS_ZRAS_REPORT_ALL		= 0x0,
+	NVME_ZNS_ZRAS_REPORT_EMPTY		= 0x1,
+	NVME_ZNS_ZRAS_REPORT_IMPL_OPENED	= 0x2,
+	NVME_ZNS_ZRAS_REPORT_EXPL_OPENED	= 0x3,
+	NVME_ZNS_ZRAS_REPORT_CLOSED		= 0x4,
+	NVME_ZNS_ZRAS_REPORT_FULL		= 0x5,
+	NVME_ZNS_ZRAS_REPORT_READ_ONLY		= 0x6,
+	NVME_ZNS_ZRAS_REPORT_OFFLINE		= 0x7,
+};
+
+/******************** nvme-cli specific end ****************************/
+
+/*
+ * Below is the content from Linux include/linux/nvme.h.
+ * Please don't add nothing to this section unless you intend to sync it with
+ * Linux.
+ * Needed changes that are relevant to both Linux and nvme-cli will go through
+ * Linux and then will be synced in nvme-cli.
+ * Needed changes for nvme-cli can go above this comment.
+ */
+
+/******************** include/linux/nvme.h. ********************************/
+
+/* NQN names in commands fields specified one size */
+#define NVMF_NQN_FIELD_LEN	256
+
+/* However the max length of a qualified name is another size */
+#define NVMF_NQN_SIZE		223
+
+#define NVMF_TRSVCID_SIZE	32
+#define NVMF_TRADDR_SIZE	256
+#define NVMF_TSAS_SIZE		256
+
+#define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
+
+#define NVME_RDMA_IP_PORT	4420
+
+#define NVME_NSID_ALL		0xffffffff
+
+enum nvme_subsys_type {
+	NVME_NQN_DISC	= 1,		/* Discovery type target subsystem */
+	NVME_NQN_NVME	= 2,		/* NVME type target subsystem */
+};
+
+/* Address Family codes for Discovery Log Page entry ADRFAM field */
+enum {
+	NVMF_ADDR_FAMILY_PCI	= 0,	/* PCIe */
+	NVMF_ADDR_FAMILY_IP4	= 1,	/* IP4 */
+	NVMF_ADDR_FAMILY_IP6	= 2,	/* IP6 */
+	NVMF_ADDR_FAMILY_IB	= 3,	/* InfiniBand */
+	NVMF_ADDR_FAMILY_FC	= 4,	/* Fibre Channel */
+	NVMF_ADDR_FAMILY_LOOP	= 254,	/* Reserved for host usage */
+	NVMF_ADDR_FAMILY_MAX,
+};
+
+/* Transport Type codes for Discovery Log Page entry TRTYPE field */
+enum {
+	NVMF_TRTYPE_RDMA	= 1,	/* RDMA */
+	NVMF_TRTYPE_FC		= 2,	/* Fibre Channel */
+	NVMF_TRTYPE_TCP		= 3,	/* TCP/IP */
+	NVMF_TRTYPE_LOOP	= 254,	/* Reserved for host usage */
+	NVMF_TRTYPE_MAX,
+};
+
+/* Transport Requirements codes for Discovery Log Page entry TREQ field */
+enum {
+	NVMF_TREQ_NOT_SPECIFIED	= 0,		/* Not specified */
+	NVMF_TREQ_REQUIRED	= 1,		/* Required */
+	NVMF_TREQ_NOT_REQUIRED	= 2,		/* Not Required */
+#define NVME_TREQ_SECURE_CHANNEL_MASK \
+	(NVMF_TREQ_REQUIRED | NVMF_TREQ_NOT_REQUIRED)
+
+	NVMF_TREQ_DISABLE_SQFLOW = (1 << 2),	/* Supports SQ flow control disable */
+};
+
+/* RDMA QP Service Type codes for Discovery Log Page entry TSAS
+ * RDMA_QPTYPE field
+ */
+enum {
+	NVMF_RDMA_QPTYPE_CONNECTED	= 1, /* Reliable Connected */
+	NVMF_RDMA_QPTYPE_DATAGRAM	= 2, /* Reliable Datagram */
+};
+
+/* RDMA QP Service Type codes for Discovery Log Page entry TSAS
+ * RDMA_QPTYPE field
+ */
+enum {
+	NVMF_RDMA_PRTYPE_NOT_SPECIFIED	= 1, /* No Provider Specified */
+	NVMF_RDMA_PRTYPE_IB		= 2, /* InfiniBand */
+	NVMF_RDMA_PRTYPE_ROCE		= 3, /* InfiniBand RoCE */
+	NVMF_RDMA_PRTYPE_ROCEV2		= 4, /* InfiniBand RoCEV2 */
+	NVMF_RDMA_PRTYPE_IWARP		= 5, /* IWARP */
+};
+
+/* RDMA Connection Management Service Type codes for Discovery Log Page
+ * entry TSAS RDMA_CMS field
+ */
+enum {
+	NVMF_RDMA_CMS_RDMA_CM	= 1, /* Sockets based endpoint addressing */
+};
+
+#define NVME_AQ_DEPTH		32
+#define NVME_NR_AEN_COMMANDS	1
+#define NVME_AQ_BLK_MQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AEN_COMMANDS)
+
+/*
+ * Subtract one to leave an empty queue entry for 'Full Queue' condition. See
+ * NVM-Express 1.2 specification, section 4.1.2.
+ */
+#define NVME_AQ_MQ_TAG_DEPTH	(NVME_AQ_BLK_MQ_DEPTH - 1)
+
+enum {
+	NVME_REG_CAP	= 0x0000,	/* Controller Capabilities */
+	NVME_REG_VS	= 0x0008,	/* Version */
+	NVME_REG_INTMS	= 0x000c,	/* Interrupt Mask Set */
+	NVME_REG_INTMC	= 0x0010,	/* Interrupt Mask Clear */
+	NVME_REG_CC	= 0x0014,	/* Controller Configuration */
+	NVME_REG_CSTS	= 0x001c,	/* Controller Status */
+	NVME_REG_NSSR	= 0x0020,	/* NVM Subsystem Reset */
+	NVME_REG_AQA	= 0x0024,	/* Admin Queue Attributes */
+	NVME_REG_ASQ	= 0x0028,	/* Admin SQ Base Address */
+	NVME_REG_ACQ	= 0x0030,	/* Admin CQ Base Address */
+	NVME_REG_CMBLOC	= 0x0038,	/* Controller Memory Buffer Location */
+	NVME_REG_CMBSZ	= 0x003c,	/* Controller Memory Buffer Size */
+	NVME_REG_BPINFO	= 0x0040,	/* Boot Partition Information */
+	NVME_REG_BPRSEL	= 0x0044,	/* Boot Partition Read Select */
+	NVME_REG_BPMBL	= 0x0048,	/* Boot Partition Memory Buffer Location */
+	NVME_REG_CMBMSC	= 0x0050,	/* Controller Memory Buffer Memory Space Control */
+	NVME_REG_CMBSTS	= 0x0058,	/* Controller Memory Buffer Status */
+
+	NVME_REG_PMRCAP	= 0x0e00,	/* Persistent Memory Capabilities */
+	NVME_REG_PMRCTL	= 0x0e04,	/* Persistent Memory Region Control */
+	NVME_REG_PMRSTS	= 0x0e08,	/* Persistent Memory Region Status */
+	NVME_REG_PMREBS	= 0x0e0c,	/* Persistent Memory Region Elasticity Buffer Size */
+	NVME_REG_PMRSWTP = 0x0e10,	/* Persistent Memory Region Sustained Write Throughput */
+	NVME_REG_PMRMSC = 0x0e14,	/* Persistent Memory Region Controller Memory Space Control */
+	NVME_REG_DBS	= 0x1000,	/* SQ 0 Tail Doorbell */
+};
+
+#define NVME_CAP_MQES(cap)	((cap) & 0xffff)
+#define NVME_CAP_TIMEOUT(cap)	(((cap) >> 24) & 0xff)
+#define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
+#define NVME_CAP_NSSRC(cap)	(((cap) >> 36) & 0x1)
+#define NVME_CAP_CSS(cap)	(((cap) >> 37) & 0xff)
+#define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
+#define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
+
+#define NVME_CMB_BIR(cmbloc)	((cmbloc) & 0x7)
+#define NVME_CMB_OFST(cmbloc)	(((cmbloc) >> 12) & 0xfffff)
+#define NVME_CMB_SZ(cmbsz)	(((cmbsz) >> 12) & 0xfffff)
+#define NVME_CMB_SZU(cmbsz)	(((cmbsz) >> 8) & 0xf)
+
+#define NVME_CMB_WDS(cmbsz)	((cmbsz) & 0x10)
+#define NVME_CMB_RDS(cmbsz)	((cmbsz) & 0x8)
+#define NVME_CMB_LISTS(cmbsz)	((cmbsz) & 0x4)
+#define NVME_CMB_CQS(cmbsz)	((cmbsz) & 0x2)
+#define NVME_CMB_SQS(cmbsz)	((cmbsz) & 0x1)
+
+enum {
+	NVME_CMBSZ_SQS		= 1 << 0,
+	NVME_CMBSZ_CQS		= 1 << 1,
+	NVME_CMBSZ_LISTS	= 1 << 2,
+	NVME_CMBSZ_RDS		= 1 << 3,
+	NVME_CMBSZ_WDS		= 1 << 4,
+
+	NVME_CMBSZ_SZ_SHIFT	= 12,
+	NVME_CMBSZ_SZ_MASK	= 0xfffff,
+
+	NVME_CMBSZ_SZU_SHIFT	= 8,
+	NVME_CMBSZ_SZU_MASK	= 0xf,
+};
+
+/*
+ * Submission and Completion Queue Entry Sizes for the NVM command set.
  * (In bytes and specified as a power of two (2^n)).
  */
+#define NVME_ADM_SQES       6
 #define NVME_NVM_IOSQES		6
 #define NVME_NVM_IOCQES		4
 
 enum {
 	NVME_CC_ENABLE		= 1 << 0,
-	NVME_CC_CSS_NVM		= 0 << 4,
 	NVME_CC_EN_SHIFT	= 0,
 	NVME_CC_CSS_SHIFT	= 4,
 	NVME_CC_MPS_SHIFT	= 7,
@@ -219,6 +828,9 @@ enum {
 	NVME_CC_SHN_SHIFT	= 14,
 	NVME_CC_IOSQES_SHIFT	= 16,
 	NVME_CC_IOCQES_SHIFT	= 20,
+	NVME_CC_CSS_NVM		= 0 << NVME_CC_CSS_SHIFT,
+	NVME_CC_CSS_CSI		= 6 << NVME_CC_CSS_SHIFT,
+	NVME_CC_CSS_MASK	= 7 << NVME_CC_CSS_SHIFT,
 	NVME_CC_AMS_RR		= 0 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_WRRU	= 1 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_VS		= 7 << NVME_CC_AMS_SHIFT,
@@ -228,6 +840,8 @@ enum {
 	NVME_CC_SHN_MASK	= 3 << NVME_CC_SHN_SHIFT,
 	NVME_CC_IOSQES		= NVME_NVM_IOSQES << NVME_CC_IOSQES_SHIFT,
 	NVME_CC_IOCQES		= NVME_NVM_IOCQES << NVME_CC_IOCQES_SHIFT,
+	NVME_CAP_CSS_NVM	= 1 << 0,
+	NVME_CAP_CSS_CSI	= 1 << 6,
 	NVME_CSTS_RDY		= 1 << 0,
 	NVME_CSTS_CFS		= 1 << 1,
 	NVME_CSTS_NSSRO		= 1 << 4,
@@ -256,14 +870,16 @@ struct nvme_id_power_state {
 	__u8			rsvd23[9];
 };
 
-/* idle and active power scales occupy the last 2 bits of the field */
-#define POWER_SCALE(s) ((s) >> 6)
-
 enum {
 	NVME_PS_FLAGS_MAX_POWER_SCALE	= 1 << 0,
 	NVME_PS_FLAGS_NON_OP_STATE	= 1 << 1,
 };
 
+enum nvme_ctrl_attr {
+	NVME_CTRL_ATTR_HID_128_BIT	= (1 << 0),
+	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
+};
+
 struct nvme_id_ctrl {
 	__le16			vid;
 	__le16			ssvid;
@@ -333,7 +949,7 @@ struct nvme_id_ctrl {
 	__u8			vwc;
 	__le16			awun;
 	__le16			awupf;
-	__u8			icsvscc;
+	__u8			nvscc;
 	__u8			nwpc;
 	__le16			acwu;
 	__le16			ocfs;
@@ -353,10 +969,13 @@ struct nvme_id_ctrl {
 };
 
 enum {
+	NVME_CTRL_CMIC_MULTI_CTRL		= 1 << 1,
+	NVME_CTRL_CMIC_ANA			= 1 << 3,
 	NVME_CTRL_ONCS_COMPARE			= 1 << 0,
 	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
 	NVME_CTRL_ONCS_DSM			= 1 << 2,
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
+	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
@@ -422,8 +1041,28 @@ struct nvme_id_ns {
 	__u8			vs[3712];
 };
 
-struct nvme_id_iocs {
-	__le64 iocs[512];
+struct nvme_zns_lbafe {
+	__le64			zsze;
+	__u8			zdes;
+	__u8			rsvd9[7];
+};
+
+struct nvme_id_ns_zns {
+	__le16			zoc;
+	__le16			ozcs;
+	__le32			mar;
+	__le32			mor;
+	__le32			rrl;
+	__le32			frl;
+	__u8			rsvd20[2796];
+	struct nvme_zns_lbafe	lbafe[16];
+	__u8			rsvd3072[768];
+	__u8			vs[256];
+};
+
+struct nvme_id_ctrl_zns {
+	__u8	zasl;
+	__u8	rsvd1[4095];
 };
 
 enum {
@@ -432,9 +1071,9 @@ enum {
 	NVME_ID_CNS_NS_ACTIVE_LIST	= 0x02,
 	NVME_ID_CNS_NS_DESC_LIST	= 0x03,
 	NVME_ID_CNS_NVMSET_LIST		= 0x04,
-	NVME_ID_CNS_CSI_ID_NS		= 0x05,
-	NVME_ID_CNS_CSI_ID_CTRL		= 0x06,
-	NVME_ID_CNS_CSI_NS_ACTIVE_LIST = 0x07,
+	NVME_ID_CNS_CS_NS		= 0x05,
+	NVME_ID_CNS_CS_CTRL		= 0x06,
+	NVME_ID_CNS_CS_NS_ACTIVE_LIST	= 0x07,
 	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
 	NVME_ID_CNS_NS_PRESENT		= 0x11,
 	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
@@ -442,9 +1081,15 @@ enum {
 	NVME_ID_CNS_SCNDRY_CTRL_LIST	= 0x15,
 	NVME_ID_CNS_NS_GRANULARITY	= 0x16,
 	NVME_ID_CNS_UUID_LIST		= 0x17,
-	NVME_ID_CNS_CSI_NS_PRESENT_LIST = 0x1a,
-	NVME_ID_CNS_CSI_NS_PRESENT  = 0x1b,
-	NVME_ID_CNS_CSI             = 0x1c,
+	NVME_ID_CNS_CSI_NS_PRESENT_LIST	= 0x1a,
+	NVME_ID_CNS_CSI_NS_PRESENT	= 0x1b,
+	NVME_ID_CNS_CSI			= 0x1c,
+
+};
+
+enum {
+	NVME_CSI_NVM			= 0,
+	NVME_CSI_ZNS			= 2,
 };
 
 enum {
@@ -461,130 +1106,51 @@ enum {
 };
 
 enum {
-	NVME_NS_FEAT_THIN	= 1 << 0,
-	NVME_NS_FLBAS_LBA_MASK	= 0xf,
-	NVME_NS_FLBAS_META_EXT	= 0x10,
-	NVME_LBAF_RP_BEST	= 0,
-	NVME_LBAF_RP_BETTER	= 1,
-	NVME_LBAF_RP_GOOD	= 2,
-	NVME_LBAF_RP_DEGRADED	= 3,
-	NVME_NS_DPC_PI_LAST	= 1 << 4,
-	NVME_NS_DPC_PI_FIRST	= 1 << 3,
-	NVME_NS_DPC_PI_TYPE3	= 1 << 2,
-	NVME_NS_DPC_PI_TYPE2	= 1 << 1,
-	NVME_NS_DPC_PI_TYPE1	= 1 << 0,
-	NVME_NS_DPS_PI_FIRST	= 1 << 3,
-	NVME_NS_DPS_PI_MASK	= 0x7,
-	NVME_NS_DPS_PI_TYPE1	= 1,
-	NVME_NS_DPS_PI_TYPE2	= 2,
-	NVME_NS_DPS_PI_TYPE3	= 3,
-};
-
-struct nvme_ns_id_desc {
-	__u8 nidt;
-	__u8 nidl;
-	__le16 reserved;
-};
-
-#define NVME_NIDT_EUI64_LEN	8
-#define NVME_NIDT_NGUID_LEN	16
-#define NVME_NIDT_UUID_LEN	16
-#define NVME_NIDT_CSI_LEN	1
-
-enum {
-	NVME_NIDT_EUI64		= 0x01,
-	NVME_NIDT_NGUID		= 0x02,
-	NVME_NIDT_UUID		= 0x03,
-	NVME_NIDT_CSI		= 0x04,
-};
-
-#define NVME_MAX_NVMSET		31
-
-struct nvme_nvmset_attr_entry {
-	__le16			id;
-	__le16			endurance_group_id;
-	__u8			rsvd4[4];
-	__le32			random_4k_read_typical;
-	__le32			opt_write_size;
-	__u8			total_nvmset_cap[16];
-	__u8			unalloc_nvmset_cap[16];
-	__u8			rsvd48[80];
-};
-
-struct nvme_id_nvmset {
-	__u8				nid;
-	__u8				rsvd1[127];
-	struct nvme_nvmset_attr_entry	ent[NVME_MAX_NVMSET];
-};
-
-struct nvme_id_ns_granularity_list_entry {
-	__le64			namespace_size_granularity;
-	__le64			namespace_capacity_granularity;
-};
-
-struct nvme_id_ns_granularity_list {
-	__le32			attributes;
-	__u8			num_descriptors;
-	__u8			rsvd[27];
-	struct nvme_id_ns_granularity_list_entry entry[16];
+	NVME_NS_FEAT_THIN	= 1 << 0,
+	NVME_NS_FEAT_ATOMICS	= 1 << 1,
+	NVME_NS_FEAT_IO_OPT	= 1 << 4,
+	NVME_NS_ATTR_RO		= 1 << 0,
+	NVME_NS_FLBAS_LBA_MASK	= 0xf,
+	NVME_NS_FLBAS_META_EXT	= 0x10,
+	NVME_NS_NMIC_SHARED	= 1 << 0,
+	NVME_LBAF_RP_BEST	= 0,
+	NVME_LBAF_RP_BETTER	= 1,
+	NVME_LBAF_RP_GOOD	= 2,
+	NVME_LBAF_RP_DEGRADED	= 3,
+	NVME_NS_DPC_PI_LAST	= 1 << 4,
+	NVME_NS_DPC_PI_FIRST	= 1 << 3,
+	NVME_NS_DPC_PI_TYPE3	= 1 << 2,
+	NVME_NS_DPC_PI_TYPE2	= 1 << 1,
+	NVME_NS_DPC_PI_TYPE1	= 1 << 0,
+	NVME_NS_DPS_PI_FIRST	= 1 << 3,
+	NVME_NS_DPS_PI_MASK	= 0x7,
+	NVME_NS_DPS_PI_TYPE1	= 1,
+	NVME_NS_DPS_PI_TYPE2	= 2,
+	NVME_NS_DPS_PI_TYPE3	= 3,
 };
 
-#define NVME_MAX_UUID_ENTRIES	128
-struct nvme_id_uuid_list_entry {
-	__u8			header;
-	__u8			rsvd1[15];
-	__u8			uuid[16];
+/* Identify Namespace Metadata Capabilities (MC): */
+enum {
+	NVME_MC_EXTENDED_LBA	= (1 << 0),
+	NVME_MC_METADATA_PTR	= (1 << 1),
 };
 
-struct nvme_id_uuid_list {
-	struct nvme_id_uuid_list_entry	entry[NVME_MAX_UUID_ENTRIES];
+struct nvme_ns_id_desc {
+	__u8 nidt;
+	__u8 nidl;
+	__le16 reserved;
 };
 
-/**
- * struct nvme_telemetry_log_page_hdr - structure for telemetry log page
- * @lpi: Log page identifier
- * @iee_oui: IEEE OUI Identifier
- * @dalb1: Data area 1 last block
- * @dalb2: Data area 2 last block
- * @dalb3: Data area 3 last block
- * @ctrlavail: Controller initiated data available
- * @ctrldgn: Controller initiated telemetry Data Generation Number
- * @rsnident: Reason Identifier
- * @telemetry_dataarea: Contains telemetry data block
- *
- * This structure can be used for both telemetry host-initiated log page
- * and controller-initiated log page.
- */
-struct nvme_telemetry_log_page_hdr {
-	__u8	lpi;
-	__u8	rsvd[4];
-	__u8	iee_oui[3];
-	__le16	dalb1;
-	__le16	dalb2;
-	__le16	dalb3;
-	__u8	rsvd1[368];
-	__u8	ctrlavail;
-	__u8	ctrldgn;
-	__u8	rsnident[128];
-	__u8	telemetry_dataarea[0];
-};
+#define NVME_NIDT_EUI64_LEN	8
+#define NVME_NIDT_NGUID_LEN	16
+#define NVME_NIDT_UUID_LEN	16
+#define NVME_NIDT_CSI_LEN	1
 
-struct nvme_endurance_group_log {
-	__u8	critical_warning;
-	__u8	rsvd1[2];
-	__u8	avl_spare;
-	__u8	avl_spare_threshold;
-	__u8	percent_used;
-	__u8	rsvd6[26];
-	__u8	endurance_estimate[16];
-	__u8	data_units_read[16];
-	__u8	data_units_written[16];
-	__u8	media_units_written[16];
-	__u8	host_read_cmds[16];
-	__u8	host_write_cmds[16];
-	__u8	media_data_integrity_err[16];
-	__u8	num_err_info_log_entries[16];
-	__u8	rsvd160[352];
+enum {
+	NVME_NIDT_EUI64		= 0x01,
+	NVME_NIDT_NGUID		= 0x02,
+	NVME_NIDT_UUID		= 0x03,
+	NVME_NIDT_CSI		= 0x04,
 };
 
 struct nvme_smart_log {
@@ -615,50 +1181,6 @@ struct nvme_smart_log {
 	__u8			rsvd232[280];
 };
 
-struct nvme_self_test_res {
-	__u8 			dsts;
-	__u8			seg;
-	__u8			vdi;
-	__u8			rsvd3;
-	__le64			poh;
-	__le32			nsid;
-	__le64			flba;
-	__u8			sct;
-	__u8			sc;
-	__u8			vs[2];
-} __attribute__((packed));
-
-enum {
-	NVME_ST_CODE_SHIFT    		= 4,
-	NVME_ST_CODE_SHORT_OP 		= 0x1,
-	NVME_ST_CODE_EXT_OP   		= 0x2,
-	NVME_ST_CODE_VS	      		= 0xe,
-	NVME_ST_RES_MASK      		= 0xf,
-	NVME_ST_RES_NO_ERR    		= 0x0,
-	NVME_ST_RES_ABORTED   		= 0x1,
-	NVME_ST_RES_CLR	      		= 0x2,
-	NVME_ST_RES_NS_REMOVED		= 0x3,
-	NVME_ST_RES_ABORTED_FORMAT	= 0x4,
-	NVME_ST_RES_FATAL_ERR		= 0x5,
-	NVME_ST_RES_UNKNOWN_SEG_FAIL	= 0x6,
-	NVME_ST_RES_KNOWN_SEG_FAIL	= 0x7,
-	NVME_ST_RES_ABORTED_UNKNOWN	= 0x8,
-	NVME_ST_RES_ABORTED_SANITIZE	= 0x9,
-	NVME_ST_RES_NOT_USED		= 0xf,
-	NVME_ST_VALID_NSID		= 1 << 0,
-	NVME_ST_VALID_FLBA		= 1 << 1,
-	NVME_ST_VALID_SCT		= 1 << 2,
-	NVME_ST_VALID_SC		= 1 << 3,
-	NVME_ST_REPORTS			= 20,
-};
-
-struct nvme_self_test_log {
-	__u8                      crnt_dev_selftest_oprn;
-	__u8                      crnt_dev_selftest_compln;
-	__u8                      rsvd[2];
-	struct nvme_self_test_res result[20];
-} __attribute__((packed));
-
 struct nvme_fw_slot_info_log {
 	__u8			afi;
 	__u8			rsvd1[7];
@@ -666,240 +1188,67 @@ struct nvme_fw_slot_info_log {
 	__u8			rsvd64[448];
 };
 
-struct nvme_lba_status_desc {
-	__u64 dslba;
-	__u32 nlb;
-	__u8 rsvd_12;
-	__u8 status;
-	__u8 rsvd_15_14[2];
-};
-
-struct nvme_lba_status {
-	__u32 nlsd;
-	__u8 cmpc;
-	__u8 rsvd_7_5[3];
-	struct nvme_lba_status_desc descs[0];
-};
-
-/* NVMe Namespace Write Protect State */
-enum {
-	NVME_NS_NO_WRITE_PROTECT = 0,
-	NVME_NS_WRITE_PROTECT,
-	NVME_NS_WRITE_PROTECT_POWER_CYCLE,
-	NVME_NS_WRITE_PROTECT_PERMANENT,
-};
-
-#define NVME_MAX_CHANGED_NAMESPACES     1024
-
-struct nvme_changed_ns_list_log {
-	__le32			log[NVME_MAX_CHANGED_NAMESPACES];
-};
-
 enum {
 	NVME_CMD_EFFECTS_CSUPP		= 1 << 0,
 	NVME_CMD_EFFECTS_LBCC		= 1 << 1,
 	NVME_CMD_EFFECTS_NCC		= 1 << 2,
-	NVME_CMD_EFFECTS_NIC		= 1 << 3,
-	NVME_CMD_EFFECTS_CCC		= 1 << 4,
-	NVME_CMD_EFFECTS_CSE_MASK	= 3 << 16,
-	NVME_CMD_EFFECTS_UUID_SEL	= 1 << 19,
-};
-
-struct nvme_effects_log {
-	__le32 acs[256];
-	__le32 iocs[256];
-	__u8   resv[2048];
-};
-
-enum nvme_ana_state {
-	NVME_ANA_OPTIMIZED		= 0x01,
-	NVME_ANA_NONOPTIMIZED		= 0x02,
-	NVME_ANA_INACCESSIBLE		= 0x03,
-	NVME_ANA_PERSISTENT_LOSS	= 0x04,
-	NVME_ANA_CHANGE			= 0x0f,
-};
-
-struct nvme_ana_group_desc {
-	__le32  grpid;
-	__le32  nnsids;
-	__le64  chgcnt;
-	__u8    state;
-	__u8    rsvd17[15];
-	__le32  nsids[];
-};
-
-/* flag for the log specific field of the ANA log */
-#define NVME_ANA_LOG_RGO   (1 << 0)
-
-struct nvme_ana_rsp_hdr {
-	__le64  chgcnt;
-	__le16  ngrps;
-	__le16  rsvd10[3];
-};
-
-/* persistent event type 02h */
-struct nvme_fw_commit_event {
-    __le64	old_fw_rev;
-    __le64 	new_fw_rev;
-    __u8 	fw_commit_action;
-    __u8 	fw_slot;
-    __u8 	sct_fw;
-    __u8 	sc_fw;
-    __le16 	vndr_assign_fw_commit_rc;
-} __attribute__((packed));
-
-/* persistent event type 03h */
-struct nvme_time_stamp_change_event {
-    __le64 	previous_timestamp;
-    __le64 	ml_secs_since_reset;
-};
-
-/* persistent event type 04h */
-struct nvme_power_on_reset_info_list {
-    __le16   cid;
-    __u8     fw_act;
-    __u8     op_in_prog;
-    __u8     rsvd4[12];
-    __le32   ctrl_power_cycle;
-    __le64   power_on_ml_seconds;
-    __le64   ctrl_time_stamp;
-} __attribute__((packed));
-
-/* persistent event type 05h */
-struct nvme_nss_hw_err_event {
-    __le16 	nss_hw_err_event_code;
-    __u8 	rsvd2[2];
-    __u8 	*add_hw_err_info;
-};
-
-/* persistent event type 06h */
-struct nvme_change_ns_event {
-	__le32	nsmgt_cdw10;
-	__u8	rsvd4[4];
-	__le64	nsze;
-	__u8	nscap[16];
-	__u8	flbas;
-	__u8	dps;
-	__u8	nmic;
-	__u8	rsvd35;
-	__le32	ana_grp_id;
-	__le16	nvmset_id;
-	__le16	rsvd42;
-	__le32	nsid;
-};
-
-/* persistent event type 07h */
-struct nvme_format_nvm_start_event {
-    __le32 	nsid;
-    __u8 	fna;
-    __u8 	rsvd5[3];
-    __le32 	format_nvm_cdw10;
-};
-
-/* persistent event type 08h */
-struct nvme_format_nvm_compln_event {
-    __le32 	nsid;
-    __u8 	smallest_fpi;
-    __u8 	format_nvm_status;
-    __le16 	compln_info;
-    __le32 	status_field;
-};
-
-/* persistent event type 09h */
-struct nvme_sanitize_start_event {
-    __le32 	sani_cap;
-    __le32 	sani_cdw10;
-    __le32 	sani_cdw11;
+	NVME_CMD_EFFECTS_NIC		= 1 << 3,
+	NVME_CMD_EFFECTS_CCC		= 1 << 4,
+	NVME_CMD_EFFECTS_CSE_MASK	= 3 << 16,
+	NVME_CMD_EFFECTS_UUID_SEL	= 1 << 19,
 };
 
-/* persistent event type 0Ah */
-struct nvme_sanitize_compln_event {
-    __le16 	sani_prog;
-    __le16 	sani_status;
-    __le16 	cmpln_info;
-	__u8 	rsvd6[2];
+struct nvme_effects_log {
+	__le32 acs[256];
+	__le32 iocs[256];
+	__u8   resv[2048];
 };
 
-/* persistent event type 0Dh */
-struct nvme_thermal_exc_event {
-    __u8 	over_temp;
-    __u8 	threshold;
+enum nvme_ana_state {
+	NVME_ANA_OPTIMIZED		= 0x01,
+	NVME_ANA_NONOPTIMIZED		= 0x02,
+	NVME_ANA_INACCESSIBLE		= 0x03,
+	NVME_ANA_PERSISTENT_LOSS	= 0x04,
+	NVME_ANA_CHANGE			= 0x0f,
 };
 
-/* persistent event entry head */
-struct nvme_persistent_event_entry_head {
-	__u8	etype;
-	__u8	etype_rev;
-	__u8	ehl;
-	__u8	rsvd3;
-	__le16	ctrl_id;
-	__le64	etimestamp;
-	__u8	rsvd14[6];
-	__le16	vsil;
-	__le16	el;
-} __attribute__((packed));
+struct nvme_ana_group_desc {
+	__le32	grpid;
+	__le32	nnsids;
+	__le64	chgcnt;
+	__u8	state;
+	__u8	rsvd17[15];
+	__le32	nsids[];
+};
 
-/* persistent event log head */
-struct nvme_persistent_event_log_head {
-	__u8	log_id;
-	__u8	rsvd1[3];
-	__le32	tnev;
-	__le64	tll;
-	__u8	log_rev;
-	__u8	rsvd17;
-	__le16	head_len;
-	__le64	timestamp;
-	__u8	poh[16];
-	__le64	pcc;
-	__le16	vid;
-	__le16	ssvid;
-	__u8	sn[20];
-	__u8	mn[40];
-	__u8	subnqn[256];
-	__u8    rsvd372[108];
-	__u8	supp_event_bm[32];
-} __attribute__((packed));
+/* flag for the log specific field of the ANA log */
+#define NVME_ANA_LOG_RGO	(1 << 0)
 
-enum nvme_persistent_event_types {
-    NVME_SMART_HEALTH_EVENT         = 0x01,
-    NVME_FW_COMMIT_EVENT            = 0x02,
-    NVME_TIMESTAMP_EVENT            = 0x03,
-    NVME_POWER_ON_RESET_EVENT       = 0x04,
-    NVME_NSS_HW_ERROR_EVENT         = 0x05,
-    NVME_CHANGE_NS_EVENT            = 0x06,
-    NVME_FORMAT_START_EVENT         = 0x07,
-    NVME_FORMAT_COMPLETION_EVENT    = 0x08,
-    NVME_SANITIZE_START_EVENT       = 0x09,
-    NVME_SANITIZE_COMPLETION_EVENT  = 0x0a,
-    NVME_THERMAL_EXCURSION_EVENT    = 0x0d
+struct nvme_ana_rsp_hdr {
+	__le64	chgcnt;
+	__le16	ngrps;
+	__le16	rsvd10[3];
 };
 
-enum nvme_persistent_event_log_actions {
-	NVME_PEVENT_LOG_READ				= 0x0,
-	NVME_PEVENT_LOG_EST_CTX_AND_READ	= 0x1,
-	NVME_PEVENT_LOG_RELEASE_CTX			= 0x2,
+struct nvme_zone_descriptor {
+	__u8		zt;
+	__u8		zs;
+	__u8		za;
+	__u8		rsvd3[5];
+	__le64		zcap;
+	__le64		zslba;
+	__le64		wp;
+	__u8		rsvd32[32];
 };
 
-struct nvme_predlat_event_agg_log_page {
-	__le64	num_entries;
-	__le16	entries[];
+enum {
+	NVME_ZONE_TYPE_SEQWRITE_REQ	= 0x2,
 };
 
-struct nvme_predlat_per_nvmset_log_page {
-	__u8	status;
-	__u8	rsvd1;
-	__le16	event_type;
-	__u8	rsvd4[28];
-	__le64	dtwin_rtyp;
-	__le64	dtwin_wtyp;
-	__le64	dtwin_timemax;
-	__le64	ndwin_timemin_high;
-	__le64	ndwin_timemin_low;
-	__u8	rsvd72[56];
-	__le64	dtwin_restimate;
-	__le64	dtwin_westimate;
-	__le64	dtwin_testimate;
-	__u8	rsvd152[360];
+struct nvme_zone_report {
+	__le64		nr_zones;
+	__u8		resv8[56];
+	struct nvme_zone_descriptor entries[];
 };
 
 enum {
@@ -913,10 +1262,32 @@ enum {
 enum {
 	NVME_AER_ERROR			= 0,
 	NVME_AER_SMART			= 1,
+	NVME_AER_NOTICE			= 2,
 	NVME_AER_CSS			= 6,
 	NVME_AER_VS			= 7,
 };
 
+enum {
+	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
+	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
+	NVME_AER_NOTICE_ANA		= 0x03,
+	NVME_AER_NOTICE_DISC_CHANGED	= 0xf0,
+};
+
+enum {
+	NVME_AEN_BIT_NS_ATTR		= 8,
+	NVME_AEN_BIT_FW_ACT		= 9,
+	NVME_AEN_BIT_ANA_CHANGE		= 11,
+	NVME_AEN_BIT_DISC_CHANGE	= 31,
+};
+
+enum {
+	NVME_AEN_CFG_NS_ATTR		= 1 << NVME_AEN_BIT_NS_ATTR,
+	NVME_AEN_CFG_FW_ACT		= 1 << NVME_AEN_BIT_FW_ACT,
+	NVME_AEN_CFG_ANA_CHANGE		= 1 << NVME_AEN_BIT_ANA_CHANGE,
+	NVME_AEN_CFG_DISC_CHANGE	= 1 << NVME_AEN_BIT_DISC_CHANGE,
+};
+
 struct nvme_lba_range_type {
 	__u8			type;
 	__u8			attributes;
@@ -937,16 +1308,6 @@ enum {
 	NVME_LBART_ATTRIB_HIDE	= 1 << 1,
 };
 
-/* Predictable Latency Mode - Deterministic Threshold Configuration Data */
-struct nvme_plm_config {
-	__le16	enable_event;
-	__u8	rsvd2[30];
-	__le64	dtwin_reads_thresh;
-	__le64	dtwin_writes_thresh;
-	__le64	dtwin_time_thresh;
-	__u8	rsvd56[456];
-};
-
 struct nvme_reservation_status {
 	__le32	gen;
 	__u8	rtype;
@@ -963,24 +1324,6 @@ struct nvme_reservation_status {
 	} regctl_ds[];
 };
 
-struct nvme_reservation_status_ext {
-	__le32	gen;
-	__u8	rtype;
-	__u8	regctl[2];
-	__u8	resv5[2];
-	__u8	ptpls;
-	__u8	resv10[14];
-	__u8	resv24[40];
-	struct {
-		__le16	cntlid;
-		__u8	rcsts;
-		__u8	resv3[5];
-		__le64	rkey;
-		__u8	hostid[16];
-		__u8	resv32[32];
-	} regctl_eds[];
-};
-
 enum nvme_async_event_type {
 	NVME_AER_TYPE_ERROR	= 0,
 	NVME_AER_TYPE_SMART	= 1,
@@ -1003,10 +1346,26 @@ enum nvme_opcode {
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
 	nvme_cmd_copy		= 0x19,
-	nvme_zns_cmd_mgmt_send	= 0x79,
-	nvme_zns_cmd_mgmt_recv	= 0x7a,
-	nvme_zns_cmd_append	= 0x7d,
-};
+	nvme_cmd_zone_mgmt_send	= 0x79,
+	nvme_cmd_zone_mgmt_recv	= 0x7a,
+	nvme_cmd_zone_append	= 0x7d,
+};
+
+#define nvme_opcode_name(opcode)	{ opcode, #opcode }
+#define show_nvm_opcode_name(val)				\
+	__print_symbolic(val,					\
+		nvme_opcode_name(nvme_cmd_flush),		\
+		nvme_opcode_name(nvme_cmd_write),		\
+		nvme_opcode_name(nvme_cmd_read),		\
+		nvme_opcode_name(nvme_cmd_write_uncor),		\
+		nvme_opcode_name(nvme_cmd_compare),		\
+		nvme_opcode_name(nvme_cmd_write_zeroes),	\
+		nvme_opcode_name(nvme_cmd_dsm),			\
+		nvme_opcode_name(nvme_cmd_resv_register),	\
+		nvme_opcode_name(nvme_cmd_resv_report),		\
+		nvme_opcode_name(nvme_cmd_resv_acquire),	\
+		nvme_opcode_name(nvme_cmd_resv_release))
+
 
 /*
  * Descriptor subtype - lower 4 bits of nvme_(keyed_)sgl_desc identifier
@@ -1092,10 +1451,43 @@ enum {
 	NVME_CMD_SGL_ALL	= NVME_CMD_SGL_METABUF | NVME_CMD_SGL_METASEG,
 };
 
+struct nvme_common_command {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__le32			cdw2[2];
+	__le64			metadata;
+	union nvme_data_ptr	dptr;
+	__le32			cdw10;
+	__le32			cdw11;
+	__le32			cdw12;
+	__le32			cdw13;
+	__le32			cdw14;
+	__le32			cdw15;
+};
+
+struct nvme_rw_command {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2;
+	__le64			metadata;
+	union nvme_data_ptr	dptr;
+	__le64			slba;
+	__le16			length;
+	__le16			control;
+	__le32			dsmgmt;
+	__le32			reftag;
+	__le16			apptag;
+	__le16			appmask;
+};
+
 enum {
 	NVME_RW_LR			= 1 << 15,
 	NVME_RW_FUA			= 1 << 14,
-	NVME_RW_DEAC			= 1 << 9,
+	NVME_RW_APPEND_PIREMAP		= 1 << 9,
 	NVME_RW_DSM_FREQ_UNSPEC		= 0,
 	NVME_RW_DSM_FREQ_TYPICAL	= 1,
 	NVME_RW_DSM_FREQ_RARE		= 2,
@@ -1118,6 +1510,18 @@ enum {
 	NVME_RW_DTYPE_STREAMS		= 1 << 4,
 };
 
+struct nvme_dsm_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__le32			nr;
+	__le32			attributes;
+	__u32			rsvd12[4];
+};
+
 enum {
 	NVME_DSMGMT_IDR		= 1 << 0,
 	NVME_DSMGMT_IDW		= 1 << 1,
@@ -1132,17 +1536,78 @@ struct nvme_dsm_range {
 	__le64			slba;
 };
 
-struct nvme_copy_range {
-	__u8			rsvd0[8];
+struct nvme_write_zeroes_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2;
+	__le64			metadata;
+	union nvme_data_ptr	dptr;
 	__le64			slba;
-	__le16			nlb;
-	__u8			rsvd18[6];
-	__le32			eilbrt;
-	__le16			elbatm;
-	__le16			elbat;
+	__le16			length;
+	__le16			control;
+	__le32			dsmgmt;
+	__le32			reftag;
+	__le16			apptag;
+	__le16			appmask;
+};
+
+enum nvme_zone_mgmt_action {
+	NVME_ZONE_CLOSE		= 0x1,
+	NVME_ZONE_FINISH	= 0x2,
+	NVME_ZONE_OPEN		= 0x3,
+	NVME_ZONE_RESET		= 0x4,
+	NVME_ZONE_OFFLINE	= 0x5,
+	NVME_ZONE_SET_DESC_EXT	= 0x10,
+};
+
+struct nvme_zone_mgmt_send_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__le32			cdw2[2];
+	__le64			metadata;
+	union nvme_data_ptr	dptr;
+	__le64			slba;
+	__le32			cdw12;
+	__u8			zsa;
+	__u8			select_all;
+	__u8			rsvd13[2];
+	__le32			cdw14[2];
+};
+
+struct nvme_zone_mgmt_recv_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__le64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__le64			slba;
+	__le32			numd;
+	__u8			zra;
+	__u8			zrasf;
+	__u8			pr;
+	__u8			rsvd13;
+	__le32			cdw14[2];
+};
+
+enum {
+	NVME_ZRA_ZONE_REPORT		= 0,
+	NVME_ZRASF_ZONE_REPORT_ALL	= 0,
+	NVME_REPORT_ZONE_PARTIAL	= 1,
 };
 
 /* Features */
+
+enum {
+	NVME_TEMP_THRESH_MASK		= 0xffff,
+	NVME_TEMP_THRESH_SELECT_SHIFT	= 16,
+	NVME_TEMP_THRESH_TYPE_UNDER	= 0x100000,
+};
+
 struct nvme_feat_auto_pst {
 	__le64 entries[32];
 };
@@ -1152,6 +1617,15 @@ enum {
 	NVME_HOST_MEM_RETURN	= (1 << 1),
 };
 
+struct nvme_feat_host_behavior {
+	__u8 acre;
+	__u8 resv1[511];
+};
+
+enum {
+	NVME_ENABLE_ACRE	= 1,
+};
+
 /* Admin commands */
 
 enum nvme_admin_opcode {
@@ -1182,7 +1656,35 @@ enum nvme_admin_opcode {
 	nvme_admin_security_recv	= 0x82,
 	nvme_admin_sanitize_nvm		= 0x84,
 	nvme_admin_get_lba_status	= 0x86,
-};
+	nvme_admin_vendor_start		= 0xC0,
+};
+
+#define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
+#define show_admin_opcode_name(val)					\
+	__print_symbolic(val,						\
+		nvme_admin_opcode_name(nvme_admin_delete_sq),		\
+		nvme_admin_opcode_name(nvme_admin_create_sq),		\
+		nvme_admin_opcode_name(nvme_admin_get_log_page),	\
+		nvme_admin_opcode_name(nvme_admin_delete_cq),		\
+		nvme_admin_opcode_name(nvme_admin_create_cq),		\
+		nvme_admin_opcode_name(nvme_admin_identify),		\
+		nvme_admin_opcode_name(nvme_admin_abort_cmd),		\
+		nvme_admin_opcode_name(nvme_admin_set_features),	\
+		nvme_admin_opcode_name(nvme_admin_get_features),	\
+		nvme_admin_opcode_name(nvme_admin_async_event),		\
+		nvme_admin_opcode_name(nvme_admin_ns_mgmt),		\
+		nvme_admin_opcode_name(nvme_admin_activate_fw),		\
+		nvme_admin_opcode_name(nvme_admin_download_fw),		\
+		nvme_admin_opcode_name(nvme_admin_ns_attach),		\
+		nvme_admin_opcode_name(nvme_admin_keep_alive),		\
+		nvme_admin_opcode_name(nvme_admin_directive_send),	\
+		nvme_admin_opcode_name(nvme_admin_directive_recv),	\
+		nvme_admin_opcode_name(nvme_admin_dbbuf),		\
+		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
+		nvme_admin_opcode_name(nvme_admin_security_send),	\
+		nvme_admin_opcode_name(nvme_admin_security_recv),	\
+		nvme_admin_opcode_name(nvme_admin_sanitize_nvm),	\
+		nvme_admin_opcode_name(nvme_admin_get_lba_status))
 
 enum {
 	NVME_QUEUE_PHYS_CONTIG	= (1 << 0),
@@ -1191,30 +1693,6 @@ enum {
 	NVME_SQ_PRIO_HIGH	= (1 << 1),
 	NVME_SQ_PRIO_MEDIUM	= (2 << 1),
 	NVME_SQ_PRIO_LOW	= (3 << 1),
-	NVME_LOG_ERROR		= 0x01,
-	NVME_LOG_SMART		= 0x02,
-	NVME_LOG_FW_SLOT	= 0x03,
-	NVME_LOG_CHANGED_NS	= 0x04,
-	NVME_LOG_CMD_EFFECTS	= 0x05,
-	NVME_LOG_DEVICE_SELF_TEST = 0x06,
-	NVME_LOG_TELEMETRY_HOST = 0x07,
-	NVME_LOG_TELEMETRY_CTRL = 0x08,
-	NVME_LOG_ENDURANCE_GROUP = 0x09,
-	NVME_LOG_PRELAT_PER_NVMSET	= 0x0a,
-	NVME_LOG_ANA		= 0x0c,
-	NVME_LOG_PRELAT_EVENT_AGG	= 0x0b,
-	NVME_LOG_PERSISTENT_EVENT   = 0x0d,
-	NVME_LOG_DISC		= 0x70,
-	NVME_LOG_RESERVATION	= 0x80,
-	NVME_LOG_SANITIZE	= 0x81,
-	NVME_LOG_ZONE_CHANGED_LIST = 0xbf,
-	NVME_FWACT_REPL		= (0 << 3),
-	NVME_FWACT_REPL_ACTV	= (1 << 3),
-	NVME_FWACT_ACTV		= (2 << 3),
-};
-
-enum nvme_feat {
-	NVME_FEAT_NONE = 0x0,
 	NVME_FEAT_ARBITRATION	= 0x01,
 	NVME_FEAT_POWER_MGMT	= 0x02,
 	NVME_FEAT_LBA_RANGE	= 0x03,
@@ -1230,8 +1708,8 @@ enum nvme_feat {
 	NVME_FEAT_HOST_MEM_BUF	= 0x0d,
 	NVME_FEAT_TIMESTAMP	= 0x0e,
 	NVME_FEAT_KATO		= 0x0f,
-	NVME_FEAT_HCTM		= 0X10,
-	NVME_FEAT_NOPSC		= 0X11,
+	NVME_FEAT_HCTM		= 0x10,
+	NVME_FEAT_NOPSC		= 0x11,
 	NVME_FEAT_RRL		= 0x12,
 	NVME_FEAT_PLM_CONFIG	= 0x13,
 	NVME_FEAT_PLM_WINDOW	= 0x14,
@@ -1243,58 +1721,187 @@ enum nvme_feat {
 	NVME_FEAT_RESV_MASK	= 0x82,
 	NVME_FEAT_RESV_PERSIST	= 0x83,
 	NVME_FEAT_WRITE_PROTECT	= 0x84,
-} __attribute__ ((__packed__));
+	NVME_FEAT_VENDOR_START	= 0xC0,
+	NVME_FEAT_VENDOR_END	= 0xFF,
+	NVME_LOG_ERROR		= 0x01,
+	NVME_LOG_SMART		= 0x02,
+	NVME_LOG_FW_SLOT	= 0x03,
+	NVME_LOG_CHANGED_NS	= 0x04,
+	NVME_LOG_CMD_EFFECTS	= 0x05,
+	NVME_LOG_DEVICE_SELF_TEST = 0x06,
+	NVME_LOG_TELEMETRY_HOST = 0x07,
+	NVME_LOG_TELEMETRY_CTRL = 0x08,
+	NVME_LOG_ENDURANCE_GROUP = 0x09,
+	NVME_LOG_PRELAT_PER_NVMSET	= 0x0a,
+	NVME_LOG_PRELAT_EVENT_AGG	= 0x0b,
+	NVME_LOG_ANA		= 0x0c,
+	NVME_LOG_PERSISTENT_EVENT   = 0x0d,
+	NVME_LOG_DISC		= 0x70,
+	NVME_LOG_RESERVATION	= 0x80,
+	NVME_LOG_SANITIZE	= 0x81,
+	NVME_LOG_ZONE_CHANGED_LIST = 0xbf,
+	NVME_FWACT_REPL		= (0 << 3),
+	NVME_FWACT_REPL_ACTV	= (1 << 3),
+	NVME_FWACT_ACTV		= (2 << 3),
+};
 
+/* NVMe Namespace Write Protect State */
 enum {
-	NVME_NO_LOG_LSP       = 0x0,
-	NVME_NO_LOG_LPO       = 0x0,
-	NVME_LOG_ANA_LSP_RGO  = 0x1,
-	NVME_TELEM_LSP_CREATE = 0x1,
+	NVME_NS_NO_WRITE_PROTECT = 0,
+	NVME_NS_WRITE_PROTECT,
+	NVME_NS_WRITE_PROTECT_POWER_CYCLE,
+	NVME_NS_WRITE_PROTECT_PERMANENT,
 };
 
-/* Sanitize and Sanitize Monitor/Log */
-enum {
-	/* Sanitize */
-	NVME_SANITIZE_NO_DEALLOC	= 0x00000200,
-	NVME_SANITIZE_OIPBP		= 0x00000100,
-	NVME_SANITIZE_OWPASS_SHIFT	= 0x00000004,
-	NVME_SANITIZE_AUSE		= 0x00000008,
-	NVME_SANITIZE_ACT_CRYPTO_ERASE	= 0x00000004,
-	NVME_SANITIZE_ACT_OVERWRITE	= 0x00000003,
-	NVME_SANITIZE_ACT_BLOCK_ERASE	= 0x00000002,
-	NVME_SANITIZE_ACT_EXIT		= 0x00000001,
+#define NVME_MAX_CHANGED_NAMESPACES	1024
 
-	/* Sanitize Monitor/Log */
-	NVME_SANITIZE_LOG_DATA_LEN		= 0x0014,
-	NVME_SANITIZE_LOG_GLOBAL_DATA_ERASED	= 0x0100,
-	NVME_SANITIZE_LOG_NUM_CMPLTED_PASS_MASK	= 0x00F8,
-	NVME_SANITIZE_LOG_STATUS_MASK		= 0x0007,
-	NVME_SANITIZE_LOG_NEVER_SANITIZED	= 0x0000,
-	NVME_SANITIZE_LOG_COMPLETED_SUCCESS	= 0x0001,
-	NVME_SANITIZE_LOG_IN_PROGESS		= 0x0002,
-	NVME_SANITIZE_LOG_COMPLETED_FAILED	= 0x0003,
-	NVME_SANITIZE_LOG_ND_COMPLETED_SUCCESS	= 0x0004,
+struct nvme_identify {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__u8			cns;
+	__u8			rsvd3;
+	__le16			ctrlid;
+	__u8			rsvd11[3];
+	__u8			csi;
+	__u32			rsvd12[4];
 };
 
 #define NVME_IDENTIFY_DATA_SIZE 4096
 
+struct nvme_features {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__le32			fid;
+	__le32			dword11;
+	__le32                  dword12;
+	__le32                  dword13;
+	__le32                  dword14;
+	__le32                  dword15;
+};
+
 struct nvme_host_mem_buf_desc {
 	__le64			addr;
 	__le32			size;
 	__u32			rsvd;
 };
 
-/* Sanitize Log Page */
-struct nvme_sanitize_log_page {
-	__le16			progress;
-	__le16			status;
-	__le32			cdw10_info;
-	__le32			est_ovrwrt_time;
-	__le32			est_blk_erase_time;
-	__le32			est_crypto_erase_time;
-	__le32			est_ovrwrt_time_with_no_deallocate;
-	__le32			est_blk_erase_time_with_no_deallocate;
-	__le32			est_crypto_erase_time_with_no_deallocate;
+struct nvme_create_cq {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__u32			rsvd1[5];
+	__le64			prp1;
+	__u64			rsvd8;
+	__le16			cqid;
+	__le16			qsize;
+	__le16			cq_flags;
+	__le16			irq_vector;
+	__u32			rsvd12[4];
+};
+
+struct nvme_create_sq {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__u32			rsvd1[5];
+	__le64			prp1;
+	__u64			rsvd8;
+	__le16			sqid;
+	__le16			qsize;
+	__le16			sq_flags;
+	__le16			cqid;
+	__u32			rsvd12[4];
+};
+
+struct nvme_delete_queue {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__u32			rsvd1[9];
+	__le16			qid;
+	__u16			rsvd10;
+	__u32			rsvd11[5];
+};
+
+struct nvme_abort_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__u32			rsvd1[9];
+	__le16			sqid;
+	__u16			cid;
+	__u32			rsvd11[5];
+};
+
+struct nvme_download_firmware {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__u32			rsvd1[5];
+	union nvme_data_ptr	dptr;
+	__le32			numd;
+	__le32			offset;
+	__u32			rsvd12[4];
+};
+
+struct nvme_format_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2[4];
+	__le32			cdw10;
+	__u32			rsvd11[5];
+};
+
+struct nvme_get_log_page_command {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__u8			lid;
+	__u8			lsp; /* upper 4 bits reserved */
+	__le16			numdl;
+	__le16			numdu;
+	__u16			rsvd11;
+	union {
+		struct {
+			__le32 lpol;
+			__le32 lpou;
+		};
+		__le64 lpo;
+	};
+	__u8			rsvd14[3];
+	__u8			csi;
+	__u32			rsvd15;
+};
+
+struct nvme_directive_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__le32			numd;
+	__u8			doper;
+	__u8			dtype;
+	__le16			dspec;
+	__u8			endir;
+	__u8			tdtype;
+	__u16			rsvd15;
+
+	__u32			rsvd16[3];
 };
 
 /*
@@ -1310,6 +1917,32 @@ enum nvmf_capsule_command {
 	nvme_fabrics_type_property_get	= 0x04,
 };
 
+#define nvme_fabrics_type_name(type)   { type, #type }
+#define show_fabrics_type_name(type)					\
+	__print_symbolic(type,						\
+		nvme_fabrics_type_name(nvme_fabrics_type_property_set),	\
+		nvme_fabrics_type_name(nvme_fabrics_type_connect),	\
+		nvme_fabrics_type_name(nvme_fabrics_type_property_get))
+
+/*
+ * If not fabrics command, fctype will be ignored.
+ */
+#define show_opcode_name(qid, opcode, fctype)			\
+	((opcode) == nvme_fabrics_command ?			\
+	 show_fabrics_type_name(fctype) :			\
+	((qid) ?						\
+	 show_nvm_opcode_name(opcode) :				\
+	 show_admin_opcode_name(opcode)))
+
+struct nvmf_common_command {
+	__u8	opcode;
+	__u8	resv1;
+	__u16	command_id;
+	__u8	fctype;
+	__u8	resv2[35];
+	__u8	ts[24];
+};
+
 /*
  * The legal cntlid range a NVMe Target will provide.
  * Note that cntlid of value 0 is considered illegal in the fabrics world.
@@ -1358,7 +1991,27 @@ struct nvmf_disc_rsp_page_hdr {
 	__le64		numrec;
 	__le16		recfmt;
 	__u8		resv14[1006];
-	struct nvmf_disc_rsp_page_entry entries[0];
+	struct nvmf_disc_rsp_page_entry entries[];
+};
+
+enum {
+	NVME_CONNECT_DISABLE_SQFLOW	= (1 << 2),
+};
+
+struct nvmf_connect_command {
+	__u8		opcode;
+	__u8		resv1;
+	__u16		command_id;
+	__u8		fctype;
+	__u8		resv2[19];
+	union nvme_data_ptr dptr;
+	__le16		recfmt;
+	__le16		qid;
+	__le16		sqsize;
+	__u8		cattr;
+	__u8		resv3;
+	__le32		kato;
+	__u8		resv4[12];
 };
 
 struct nvmf_connect_data {
@@ -1370,6 +2023,41 @@ struct nvmf_connect_data {
 	char		resv5[256];
 };
 
+struct nvmf_property_set_command {
+	__u8		opcode;
+	__u8		resv1;
+	__u16		command_id;
+	__u8		fctype;
+	__u8		resv2[35];
+	__u8		attrib;
+	__u8		resv3[3];
+	__le32		offset;
+	__le64		value;
+	__u8		resv4[8];
+};
+
+struct nvmf_property_get_command {
+	__u8		opcode;
+	__u8		resv1;
+	__u16		command_id;
+	__u8		fctype;
+	__u8		resv2[35];
+	__u8		attrib;
+	__u8		resv3[3];
+	__le32		offset;
+	__u8		resv4[16];
+};
+
+struct nvme_dbbuf {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__u32			rsvd1[5];
+	__le64			prp1;
+	__le64			prp2;
+	__u32			rsvd12[6];
+};
+
 struct streams_directive_params {
 	__le16	msl;
 	__le16	nssa;
@@ -1382,113 +2070,62 @@ struct streams_directive_params {
 	__u8	rsvd2[6];
 };
 
-struct nvme_effects_log_page {
-	__le32 acs[256];
-	__le32 iocs[256];
-	__u8   resv[2048];
-};
-
-struct nvme_error_log_page {
-	__le64	error_count;
-	__le16	sqid;
-	__le16	cmdid;
-	__le16	status_field;
-	__le16	parm_error_location;
-	__le64	lba;
-	__le32	nsid;
-	__u8	vs;
-	__u8	trtype;
-	__u8	resv[2];
-	__le64	cs;
-	__le16	trtype_spec_info;
-	__u8	resv2[22];
-};
-
-struct nvme_firmware_log_page {
-	__u8	afi;
-	__u8	resv[7];
-	__u64	frs[7];
-	__u8	resv2[448];
-};
-
-struct nvme_host_mem_buffer {
-	__u32			hsize;
-	__u32			hmdlal;
-	__u32			hmdlau;
-	__u32			hmdlec;
-	__u8			rsvd16[4080];
-};
-
-struct nvme_auto_pst {
-	__u32	data;
-	__u32	rsvd32;
-};
-
-struct nvme_timestamp {
-	__u8 timestamp[6];
-	__u8 attr;
-	__u8 rsvd;
-};
-
-struct nvme_controller_list {
-	__le16 num;
-	__le16 identifier[2047];
-};
-
-struct nvme_secondary_controller_entry {
-	__le16 scid;	/* Secondary Controller Identifier */
-	__le16 pcid;	/* Primary Controller Identifier */
-	__u8   scs;	/* Secondary Controller State */
-	__u8   rsvd5[3];
-	__le16 vfn;	/* Virtual Function Number */
-	__le16 nvq;	/* Number of VQ Flexible Resources Assigned */
-	__le16 nvi;	/* Number of VI Flexible Resources Assigned */
-	__u8   rsvd14[18];
-};
-
-struct nvme_secondary_controllers_list {
-	__u8   num;
-	__u8   rsvd[31];
-	struct nvme_secondary_controller_entry sc_entry[127];
-};
-
-struct nvme_bar_cap {
-	__u16	mqes;
-	__u8	ams_cqr;
-	__u8	to;
-	__u16	bps_css_nssrs_dstrd;
-	__u8	mpsmax_mpsmin;
-	__u8	rsvd_cmbs_pmrs;
+struct nvme_command {
+	union {
+		struct nvme_common_command common;
+		struct nvme_rw_command rw;
+		struct nvme_identify identify;
+		struct nvme_features features;
+		struct nvme_create_cq create_cq;
+		struct nvme_create_sq create_sq;
+		struct nvme_delete_queue delete_queue;
+		struct nvme_download_firmware dlfw;
+		struct nvme_format_cmd format;
+		struct nvme_dsm_cmd dsm;
+		struct nvme_write_zeroes_cmd write_zeroes;
+		struct nvme_zone_mgmt_send_cmd zms;
+		struct nvme_zone_mgmt_recv_cmd zmr;
+		struct nvme_abort_cmd abort;
+		struct nvme_get_log_page_command get_log_page;
+		struct nvmf_common_command fabrics;
+		struct nvmf_connect_command connect;
+		struct nvmf_property_set_command prop_set;
+		struct nvmf_property_get_command prop_get;
+		struct nvme_dbbuf dbbuf;
+		struct nvme_directive_cmd directive;
+	};
 };
 
-/*
- * is_64bit_reg - It checks whether given offset of the controller register is
- *                64bit or not.
- * @offset: offset of controller register field in bytes
- *
- * It gives true if given offset is 64bit register, otherwise it returns false.
- *
- * Notes:  This function does not care about transport so that the offset is
- * not going to be checked inside of this function for the unsupported fields
- * in a specific transport.  For example, BPMBL(Boot Partition Memory Buffer
- * Location) register is not supported by fabrics, but it can be chcked here.
- */
-static inline bool is_64bit_reg(__u32 offset)
+static inline bool nvme_is_fabrics(struct nvme_command *cmd)
 {
-	if (offset == NVME_REG_CAP ||
-			offset == NVME_REG_ASQ ||
-			offset == NVME_REG_ACQ ||
-			offset == NVME_REG_BPMBL)
-		return true;
-
-	return false;
+	return cmd->common.opcode == nvme_fabrics_command;
 }
 
-enum {
-	NVME_SCT_GENERIC		= 0x0,
-	NVME_SCT_CMD_SPECIFIC		= 0x1,
-	NVME_SCT_MEDIA			= 0x2,
-};
+struct nvme_error_slot {
+	__le64		error_count;
+	__le16		sqid;
+	__le16		cmdid;
+	__le16		status_field;
+	__le16		param_error_location;
+	__le64		lba;
+	__le32		nsid;
+	__u8		vs;
+	__u8		resv[3];
+	__le64		cs;
+	__u8		resv2[24];
+};
+
+static inline bool nvme_is_write(struct nvme_command *cmd)
+{
+	/*
+	 * What a mess...
+	 *
+	 * Why can't we simply have a Fabrics In and Fabrics out command?
+	 */
+	if (unlikely(nvme_is_fabrics(cmd)))
+		return cmd->fabrics.fctype & 1;
+	return cmd->common.opcode & 1;
+}
 
 enum {
 	/*
@@ -1514,20 +2151,21 @@ enum {
 	NVME_SC_SGL_INVALID_TYPE	= 0x11,
 	NVME_SC_CMB_INVALID_USE		= 0x12,
 	NVME_SC_PRP_INVALID_OFFSET	= 0x13,
-	NVME_SC_ATOMIC_WRITE_UNIT_EXCEEDED= 0x14,
-	NVME_SC_OPERATION_DENIED	= 0x15,
+	NVME_SC_ATOMIC_WU_EXCEEDED	= 0x14,
+	NVME_SC_OP_DENIED		= 0x15,
 	NVME_SC_SGL_INVALID_OFFSET	= 0x16,
-
-	NVME_SC_INCONSISTENT_HOST_ID= 0x18,
-	NVME_SC_KEEP_ALIVE_EXPIRED	= 0x19,
-	NVME_SC_KEEP_ALIVE_INVALID	= 0x1A,
-	NVME_SC_PREEMPT_ABORT		= 0x1B,
+	NVME_SC_RESERVED		= 0x17,
+	NVME_SC_HOST_ID_INCONSIST	= 0x18,
+	NVME_SC_KA_TIMEOUT_EXPIRED	= 0x19,
+	NVME_SC_KA_TIMEOUT_INVALID	= 0x1A,
+	NVME_SC_ABORTED_PREEMPT_ABORT	= 0x1B,
 	NVME_SC_SANITIZE_FAILED		= 0x1C,
 	NVME_SC_SANITIZE_IN_PROGRESS	= 0x1D,
-
+	NVME_SC_SGL_INVALID_GRANULARITY	= 0x1E,
+	NVME_SC_CMD_NOT_SUP_CMB_QUEUE	= 0x1F,
 	NVME_SC_NS_WRITE_PROTECTED	= 0x20,
 	NVME_SC_CMD_INTERRUPTED		= 0x21,
-	NVME_SC_TRANSIENT_TRANSPORT	= 0x22,	
+	NVME_SC_TRANSIENT_TR_ERR	= 0x22,
 
 	NVME_SC_LBA_RANGE		= 0x80,
 	NVME_SC_CAP_EXCEEDED		= 0x81,
@@ -1566,23 +2204,23 @@ enum {
 	NVME_SC_NS_NOT_ATTACHED		= 0x11a,
 	NVME_SC_THIN_PROV_NOT_SUPP	= 0x11b,
 	NVME_SC_CTRL_LIST_INVALID	= 0x11c,
-	NVME_SC_DEVICE_SELF_TEST_IN_PROGRESS= 0x11d,
+	NVME_SC_SELT_TEST_IN_PROGRESS	= 0x11d,
 	NVME_SC_BP_WRITE_PROHIBITED	= 0x11e,
-	NVME_SC_INVALID_CTRL_ID		= 0x11f,
-	NVME_SC_INVALID_SECONDARY_CTRL_STATE= 0x120,
-	NVME_SC_INVALID_NUM_CTRL_RESOURCE	= 0x121,
-	NVME_SC_INVALID_RESOURCE_ID	= 0x122,
+	NVME_SC_CTRL_ID_INVALID		= 0x11f,
+	NVME_SC_SEC_CTRL_STATE_INVALID	= 0x120,
+	NVME_SC_CTRL_RES_NUM_INVALID	= 0x121,
+	NVME_SC_RES_ID_INVALID		= 0x122,
 	NVME_SC_PMR_SAN_PROHIBITED	= 0x123,
-	NVME_SC_ANA_INVALID_GROUP_ID= 0x124,
-	NVME_SC_ANA_ATTACH_FAIL		= 0x125,
+	NVME_SC_ANA_GROUP_ID_INVALID	= 0x124,
+	NVME_SC_ANA_ATTACH_FAILED	= 0x125,
 
 	/*
 	 * Command Set Specific - Namespace Types commands:
 	 */
-	NVME_SC_IOCS_NOT_SUPPORTED		= 0x129,
-	NVME_SC_IOCS_NOT_ENABLED		= 0x12A,
-	NVME_SC_IOCS_COMBINATION_REJECTED	= 0x12B,
-	NVME_SC_INVALID_IOCS			= 0x12C,
+	NVME_SC_IOCS_NOT_SUPPORTED	= 0x129,
+	NVME_SC_IOCS_NOT_ENABLED	= 0x12a,
+	NVME_SC_IOCS_COMBINATION_REJ	= 0x12b,
+	NVME_SC_INVALID_IOCS		= 0x12c,
 
 	/*
 	 * I/O Command Set Specific - NVM commands:
@@ -1590,7 +2228,7 @@ enum {
 	NVME_SC_BAD_ATTRIBUTES		= 0x180,
 	NVME_SC_INVALID_PI		= 0x181,
 	NVME_SC_READ_ONLY		= 0x182,
-	NVME_SC_CMD_SIZE_LIMIT_EXCEEDED = 0x183,
+	NVME_SC_ONCS_NOT_SUPPORTED	= 0x183,
 
 	/*
 	 * I/O Command Set Specific - Fabrics commands:
@@ -1605,16 +2243,16 @@ enum {
 	NVME_SC_AUTH_REQUIRED		= 0x191,
 
 	/*
-	 * I/O Command Set Specific - Zoned Namespace commands:
+	 * I/O Command Set Specific - Zoned commands:
 	 */
-	NVME_SC_ZONE_BOUNDARY_ERROR		= 0x1B8,
-	NVME_SC_ZONE_IS_FULL			= 0x1B9,
-	NVME_SC_ZONE_IS_READ_ONLY		= 0x1BA,
-	NVME_SC_ZONE_IS_OFFLINE			= 0x1BB,
-	NVME_SC_ZONE_INVALID_WRITE		= 0x1BC,
-	NVME_SC_TOO_MANY_ACTIVE_ZONES		= 0x1BD,
-	NVME_SC_TOO_MANY_OPEN_ZONES		= 0x1BE,
-	NVME_SC_ZONE_INVALID_STATE_TRANSITION	= 0x1BF,
+	NVME_SC_ZONE_BOUNDARY_ERROR	= 0x1b8,
+	NVME_SC_ZONE_FULL		= 0x1b9,
+	NVME_SC_ZONE_READ_ONLY		= 0x1ba,
+	NVME_SC_ZONE_OFFLINE		= 0x1bb,
+	NVME_SC_ZONE_INVALID_WRITE	= 0x1bc,
+	NVME_SC_ZONE_TOO_MANY_ACTIVE	= 0x1bd,
+	NVME_SC_ZONE_TOO_MANY_OPEN	= 0x1be,
+	NVME_SC_ZONE_INVALID_TRANSITION	= 0x1bf,
 
 	/*
 	 * Media and Data Integrity Errors:
@@ -1634,11 +2272,28 @@ enum {
 	NVME_SC_ANA_PERSISTENT_LOSS	= 0x301,
 	NVME_SC_ANA_INACCESSIBLE	= 0x302,
 	NVME_SC_ANA_TRANSITION		= 0x303,
+	NVME_SC_HOST_PATH_ERROR		= 0x370,
+	NVME_SC_HOST_ABORTED_CMD	= 0x371,
 
 	NVME_SC_CRD			= 0x1800,
 	NVME_SC_DNR			= 0x4000,
 };
 
+struct nvme_completion {
+	/*
+	 * Used by Admin and Fabrics commands to return data:
+	 */
+	union nvme_result {
+		__le16	u16;
+		__le32	u32;
+		__le64	u64;
+	} result;
+	__le16	sq_head;	/* how much of this queue may be reclaimed */
+	__le16	sq_id;		/* submission queue that generated this entry */
+	__u16	command_id;	/* of the command which completed */
+	__le16	status;		/* did the command fail, and if so, why? */
+};
+
 #define NVME_VS(major, minor, tertiary) \
 	(((major) << 16) | ((minor) << 8) | (tertiary))
 
@@ -1646,139 +2301,4 @@ enum {
 #define NVME_MINOR(ver)		(((ver) >> 8) & 0xff)
 #define NVME_TERTIARY(ver)	((ver) & 0xff)
 
-
-/**
- * struct nvme_zns_lbafe -
- * zsze:
- * zdes:
- */
-struct nvme_zns_lbafe {
-	__le64	zsze;
-	__u8	zdes;
-	__u8	rsvd9[7];
-};
-
-/**
- * struct nvme_zns_id_ns -
- * @zoc:
- * @ozcs:
- * @mar:
- * @mor:
- * @rrl:
- * @frl:
- * @lbafe:
- * @vs:
- */
-struct nvme_zns_id_ns {
-	__le16			zoc;
-	__le16			ozcs;
-	__le32			mar;
-	__le32			mor;
-	__le32			rrl;
-	__le32			frl;
-	__u8			rsvd20[2796];
-	struct nvme_zns_lbafe	lbafe[16];
-	__u8			rsvd3072[768];
-	__u8			vs[256];
-};
-
-/**
- * struct nvme_zns_id_ctrl -
- * @zasl:
- */
-struct nvme_zns_id_ctrl {
-	__u8	zasl;
-	__u8	rsvd1[4095];
-};
-
-#define NVME_ZNS_CHANGED_ZONES_MAX	511
-
-/**
- * struct nvme_zns_changed_zone_log - ZNS Changed Zone List log
- * @nrzid:
- * @zid:
- */
-struct nvme_zns_changed_zone_log {
-	__le16		nrzid;
-	__u8		rsvd2[6];
-	__le64		zid[NVME_ZNS_CHANGED_ZONES_MAX];
-};
-
-/**
- * enum nvme_zns_zt -
- */
-enum nvme_zns_zt {
-	NVME_ZONE_TYPE_SEQWRITE_REQ	= 0x2,
-};
-
-/**
- * enum nvme_zns_za -
- */
-enum nvme_zns_za {
-	NVME_ZNS_ZA_ZFC			= 1 << 0,
-	NVME_ZNS_ZA_FZR			= 1 << 1,
-	NVME_ZNS_ZA_RZR			= 1 << 2,
-	NVME_ZNS_ZA_ZDEV		= 1 << 7,
-};
-
-/**
- * enum nvme_zns_zs -
- */
-enum nvme_zns_zs {
-	NVME_ZNS_ZS_EMPTY		= 0x1,
-	NVME_ZNS_ZS_IMPL_OPEN		= 0x2,
-	NVME_ZNS_ZS_EXPL_OPEN		= 0x3,
-	NVME_ZNS_ZS_CLOSED		= 0x4,
-	NVME_ZNS_ZS_READ_ONLY		= 0xd,
-	NVME_ZNS_ZS_FULL		= 0xe,
-	NVME_ZNS_ZS_OFFLINE		= 0xf,
-};
-
-/**
- * struct nvme_zns_desc -
- */
-struct nvme_zns_desc {
-	__u8	zt;
-	__u8	zs;
-	__u8	za;
-	__u8	rsvd3[5];
-	__le64	zcap;
-	__le64	zslba;
-	__le64	wp;
-	__u8	rsvd32[32];
-};
-
-/**
- * struct nvme_zone_report -
- */
-struct nvme_zone_report {
-	__le64			nr_zones;
-	__u8			resv8[56];
-	struct nvme_zns_desc	entries[];
-};
-
-enum nvme_zns_send_action {
-	NVME_ZNS_ZSA_CLOSE		= 0x1,
-	NVME_ZNS_ZSA_FINISH		= 0x2,
-	NVME_ZNS_ZSA_OPEN		= 0x3,
-	NVME_ZNS_ZSA_RESET		= 0x4,
-	NVME_ZNS_ZSA_OFFLINE		= 0x5,
-	NVME_ZNS_ZSA_SET_DESC_EXT	= 0x10,
-};
-
-enum nvme_zns_recv_action {
-	NVME_ZNS_ZRA_REPORT_ZONES		= 0x0,
-	NVME_ZNS_ZRA_EXTENDED_REPORT_ZONES	= 0x1,
-};
-
-enum nvme_zns_report_options {
-	NVME_ZNS_ZRAS_REPORT_ALL		= 0x0,
-	NVME_ZNS_ZRAS_REPORT_EMPTY		= 0x1,
-	NVME_ZNS_ZRAS_REPORT_IMPL_OPENED	= 0x2,
-	NVME_ZNS_ZRAS_REPORT_EXPL_OPENED	= 0x3,
-	NVME_ZNS_ZRAS_REPORT_CLOSED		= 0x4,
-	NVME_ZNS_ZRAS_REPORT_FULL		= 0x5,
-	NVME_ZNS_ZRAS_REPORT_READ_ONLY		= 0x6,
-	NVME_ZNS_ZRAS_REPORT_OFFLINE		= 0x7,
-};
 #endif /* _LINUX_NVME_H */
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index a99d490..ba72f4b 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -417,7 +417,7 @@ int nvme_identify_ns_list_csi(int fd, __u32 nsid, __u8 csi, bool all, void *data
 	int cns;
 
 	if (csi) {
-		cns = all ? NVME_ID_CNS_CSI_NS_PRESENT_LIST : NVME_ID_CNS_CSI_NS_ACTIVE_LIST;
+		cns = all ? NVME_ID_CNS_NS_PRESENT_LIST : NVME_ID_CNS_CS_NS_ACTIVE_LIST;
 	} else {
 		cns = all ? NVME_ID_CNS_NS_PRESENT_LIST : NVME_ID_CNS_NS_ACTIVE_LIST;
 	}
@@ -465,12 +465,12 @@ int nvme_identify_uuid(int fd, void *data)
 
 int nvme_zns_identify_ns(int fd, __u32 nsid, void *data)
 {
-	return nvme_identify13(fd, nsid, NVME_ID_CNS_CSI_ID_NS, 2 << 24, data);
+	return nvme_identify13(fd, nsid, NVME_ID_CNS_CS_NS, 2 << 24, data);
 }
 
 int nvme_zns_identify_ctrl(int fd, void *data)
 {
-	return nvme_identify13(fd, 0, NVME_ID_CNS_CSI_ID_CTRL, 2 << 24, data);
+	return nvme_identify13(fd, 0, NVME_ID_CNS_CS_CTRL, 2 << 24, data);
 }
 
 int nvme_identify_iocs(int fd, __u16 cntid, void *data)
@@ -987,7 +987,7 @@ int nvme_zns_mgmt_send(int fd, __u32 nsid, __u64 slba, bool select_all,
 	__u32 cdw13 = zsa | (!!select_all) << 8;
 
 	struct nvme_passthru_cmd cmd = {
-		.opcode		= nvme_zns_cmd_mgmt_send,
+		.opcode		= nvme_cmd_zone_mgmt_send,
 		.nsid		= nsid,
 		.cdw10		= cdw10,
 		.cdw11		= cdw11,
@@ -1009,7 +1009,7 @@ int nvme_zns_mgmt_recv(int fd, __u32 nsid, __u64 slba,
 	__u32 cdw13 = zra | zrasf << 8 | zras_feat << 16;
 
 	struct nvme_passthru_cmd cmd = {
-		.opcode		= nvme_zns_cmd_mgmt_recv,
+		.opcode		= nvme_cmd_zone_mgmt_recv,
 		.nsid		= nsid,
 		.cdw10		= cdw10,
 		.cdw11		= cdw11,
@@ -1049,7 +1049,7 @@ int nvme_zns_append(int fd, __u32 nsid, __u64 zslba, __u16 nlb, __u16 control,
 	__u32 cdw15 = lbat | (lbatm << 16);
 
 	struct nvme_passthru_cmd64 cmd = {
-		.opcode		= nvme_zns_cmd_append,
+		.opcode		= nvme_cmd_zone_append,
 		.nsid		= nsid,
 		.cdw10		= cdw10,
 		.cdw11		= cdw11,
diff --git a/nvme-print.c b/nvme-print.c
index 09ada75..b48caa3 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -301,7 +301,7 @@ static void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode,
 	json_object_add_value_int(root, "vwc", ctrl->vwc);
 	json_object_add_value_int(root, "awun", le16_to_cpu(ctrl->awun));
 	json_object_add_value_int(root, "awupf", le16_to_cpu(ctrl->awupf));
-	json_object_add_value_int(root, "icsvscc", ctrl->icsvscc);
+	json_object_add_value_int(root, "nvscc", ctrl->nvscc);
 	json_object_add_value_int(root, "nwpc", ctrl->nwpc);
 	json_object_add_value_int(root, "acwu", le16_to_cpu(ctrl->acwu));
 	json_object_add_value_int(root, "ocfs", le16_to_cpu(ctrl->ocfs));
@@ -2881,10 +2881,10 @@ static void nvme_show_id_ctrl_vwc(__u8 vwc)
 	printf("\n");
 }
 
-static void nvme_show_id_ctrl_icsvscc(__u8 icsvscc)
+static void nvme_show_id_ctrl_nvscc(__u8 nvscc)
 {
-	__u8 rsvd = (icsvscc & 0xFE) >> 1;
-	__u8 fmt = icsvscc & 0x1;
+	__u8 rsvd = (nvscc & 0xFE) >> 1;
+	__u8 fmt = nvscc & 0x1;
 	if (rsvd)
 		printf("  [7:1] : %#x\tReserved\n", rsvd);
 	printf("  [0:0] : %#x\tNVM Vendor Specific Commands uses %s Format\n",
@@ -3572,9 +3572,9 @@ void __nvme_show_id_ctrl(struct nvme_id_ctrl *ctrl, enum nvme_print_flags flags,
 		nvme_show_id_ctrl_vwc(ctrl->vwc);
 	printf("awun      : %d\n", le16_to_cpu(ctrl->awun));
 	printf("awupf     : %d\n", le16_to_cpu(ctrl->awupf));
-	printf("icsvscc     : %d\n", ctrl->icsvscc);
+	printf("nvscc     : %d\n", ctrl->nvscc);
 	if (human)
-		nvme_show_id_ctrl_icsvscc(ctrl->icsvscc);
+		nvme_show_id_ctrl_nvscc(ctrl->nvscc);
 	printf("nwpc      : %d\n", ctrl->nwpc);
 	if (human)
 		nvme_show_id_ctrl_nwpc(ctrl->nwpc);
@@ -3630,7 +3630,7 @@ void nvme_show_zns_id_ctrl(struct nvme_zns_id_ctrl *ctrl, unsigned int mode)
 	printf("zasl    : %u\n", ctrl->zasl);
 }
 
-void json_nvme_zns_id_ns(struct nvme_zns_id_ns *ns,
+void json_nvme_zns_id_ns(struct nvme_id_ns_zns *ns,
 	struct nvme_id_ns *id_ns, unsigned long flags)
 {
 	struct json_object *root;
@@ -3689,7 +3689,7 @@ static void show_nvme_id_ns_zoned_ozcs(__le16 ns_ozcs)
 		razb, razb ? "Yes" : "No");
 }
 
-void nvme_show_zns_id_ns(struct nvme_zns_id_ns *ns,
+void nvme_show_zns_id_ns(struct nvme_id_ns_zns *ns,
 	struct nvme_id_ns *id_ns, unsigned long flags)
 {
 	int human = flags & VERBOSE, vs = flags & VS;
@@ -3823,7 +3823,7 @@ void nvme_show_zns_report_zones(void *report, __u32 descs,
 	__u8 ext_size, __u32 report_size, unsigned long flags)
 {
 	struct nvme_zone_report *r = report;
-	struct nvme_zns_desc *desc;
+	struct nvme_zone_descriptor *desc;
 	int i;
 
 	__u64 nr_zones = le64_to_cpu(r->nr_zones);
@@ -3836,7 +3836,7 @@ void nvme_show_zns_report_zones(void *report, __u32 descs,
 
 	printf("nr_zones: %"PRIu64"\n", (uint64_t)le64_to_cpu(r->nr_zones));
 	for (i = 0; i < descs; i++) {
-		desc = (struct nvme_zns_desc *)
+		desc = (struct nvme_zone_descriptor *)
 			(report + sizeof(*r) + i * (sizeof(*desc) + ext_size));
 		printf("SLBA: 0x%-8"PRIx64" WP: 0x%-8"PRIx64" Cap: 0x%-8"PRIx64" State: %-12s Type: %-14s Attrs: 0x%-x\n",
 		(uint64_t)le64_to_cpu(desc->zslba), (uint64_t)le64_to_cpu(desc->wp),
@@ -4711,10 +4711,9 @@ void nvme_show_sanitize_log(struct nvme_sanitize_log_page *sanitize,
 		le32_to_cpu(sanitize->est_crypto_erase_time_with_no_deallocate));
 }
 
-const char *nvme_feature_to_string(enum nvme_feat feature)
+const char *nvme_feature_to_string(__u8 feature)
 {
 	switch (feature) {
-	case NVME_FEAT_NONE:		return "None";
 	case NVME_FEAT_ARBITRATION:	return "Arbitration";
 	case NVME_FEAT_POWER_MGMT:	return "Power Management";
 	case NVME_FEAT_LBA_RANGE:	return "LBA Range Type";
@@ -4835,19 +4834,19 @@ const char *nvme_status_to_string(__u32 status)
 		return "CMB_INVALID_USE: The attempted use of the Controller Memory Buffer is not supported by the controller.";
 	case NVME_SC_PRP_INVALID_OFFSET:
 		return "PRP_INVALID_OFFSET: The Offset field for a PRP entry is invalid.";
-	case NVME_SC_ATOMIC_WRITE_UNIT_EXCEEDED:
+	case NVME_SC_ATOMIC_WU_EXCEEDED:
 		return "ATOMIC_WRITE_UNIT_EXCEEDED: The length specified exceeds the atomic write unit size.";
-	case NVME_SC_OPERATION_DENIED:
+	case NVME_SC_OP_DENIED:
 		return "OPERATION_DENIED: The command was denied due to lack of access rights.";
 	case NVME_SC_SGL_INVALID_OFFSET:
 		return "SGL_INVALID_OFFSET: The offset specified in a descriptor is invalid.";
-	case NVME_SC_INCONSISTENT_HOST_ID:
+	case NVME_SC_HOST_ID_INCONSIST:
 		return "INCONSISTENT_HOST_ID: The NVM subsystem detected the simultaneous use of 64-bit and 128-bit Host Identifier values on different controllers.";
-	case NVME_SC_KEEP_ALIVE_EXPIRED:
+	case NVME_SC_KA_TIMEOUT_EXPIRED:
 		return "KEEP_ALIVE_EXPIRED: The Keep Alive Timer expired.";
-	case NVME_SC_KEEP_ALIVE_INVALID:
+	case NVME_SC_KA_TIMEOUT_INVALID:
 		return "KEEP_ALIVE_INVALID: The Keep Alive Timeout value specified is invalid.";
-	case NVME_SC_PREEMPT_ABORT:
+	case NVME_SC_ABORTED_PREEMPT_ABORT:
 		return "PREEMPT_ABORT: The command was aborted due to a Reservation Acquire command with the Reservation Acquire Action (RACQA) set to 010b (Preempt and Abort).";
 	case NVME_SC_SANITIZE_FAILED:
 		return "SANITIZE_FAILED: The most recent sanitize operation failed and no recovery actions has been successfully completed";
@@ -4857,7 +4856,7 @@ const char *nvme_status_to_string(__u32 status)
 		return "IOCS_NOT_SUPPORTED: The I/O command set is not supported";
 	case NVME_SC_IOCS_NOT_ENABLED:
 		return "IOCS_NOT_ENABLED: The I/O command set is not enabled";
-	case NVME_SC_IOCS_COMBINATION_REJECTED:
+	case NVME_SC_IOCS_COMBINATION_REJ:
 		return "IOCS_COMBINATION_REJECTED: The I/O command set combination is rejected";
 	case NVME_SC_INVALID_IOCS:
 		return "INVALID_IOCS: the I/O command set is invalid";
@@ -4865,7 +4864,7 @@ const char *nvme_status_to_string(__u32 status)
 		return "LBA_RANGE: The command references a LBA that exceeds the size of the namespace";
 	case NVME_SC_NS_WRITE_PROTECTED:
 		return "NS_WRITE_PROTECTED: The command is prohibited while the namespace is write protected by the host.";
-	case NVME_SC_TRANSIENT_TRANSPORT:
+	case NVME_SC_TRANSIENT_TR_ERR:
 		return "TRANSIENT_TRANSPORT: A transient transport error was detected.";
 	case NVME_SC_CAP_EXCEEDED:
 		return "CAP_EXCEEDED: The execution of the command has caused the capacity of the namespace to be exceeded";
@@ -4877,19 +4876,19 @@ const char *nvme_status_to_string(__u32 status)
 		return "FORMAT_IN_PROGRESS: A Format NVM command is in progress on the namespace.";
 	case NVME_SC_ZONE_BOUNDARY_ERROR:
 		return "ZONE_BOUNDARY_ERROR: Invalid Zone Boundary crossing";
-	case NVME_SC_ZONE_IS_FULL:
+	case NVME_SC_ZONE_FULL:
 		return "ZONE_IS_FULL: The accessed zone is in ZSF:Full state";
-	case NVME_SC_ZONE_IS_READ_ONLY:
+	case NVME_SC_ZONE_READ_ONLY:
 		return "ZONE_IS_READ_ONLY: The accessed zone is in ZSRO:Read Only state";
-	case NVME_SC_ZONE_IS_OFFLINE:
+	case NVME_SC_ZONE_OFFLINE:
 		return "ZONE_IS_OFFLINE: The access zone is in ZSO:Offline state";
 	case NVME_SC_ZONE_INVALID_WRITE:
 		return "ZONE_INVALID_WRITE: The write to zone was not at the write pointer offset";
-	case NVME_SC_TOO_MANY_ACTIVE_ZONES:
+	case NVME_SC_ZONE_TOO_MANY_ACTIVE:
 		return "TOO_MANY_ACTIVE_ZONES: The controller does not allow additional active zones";
-	case NVME_SC_TOO_MANY_OPEN_ZONES:
+	case NVME_SC_ZONE_TOO_MANY_OPEN:
 		return "TOO_MANY_OPEN_ZONES: The controller does not allow additional open zones";
-	case NVME_SC_ZONE_INVALID_STATE_TRANSITION:
+	case NVME_SC_ZONE_INVALID_TRANSITION:
 		return "INVALID_ZONE_STATE_TRANSITION: The zone state change was invalid";
 	case NVME_SC_CQ_INVALID:
 		return "CQ_INVALID: The Completion Queue identifier specified in the command does not exist";
@@ -4947,26 +4946,24 @@ const char *nvme_status_to_string(__u32 status)
 		return "THIN_PROVISIONING_NOT_SUPPORTED: Thin provisioning is not supported by the controller";
 	case NVME_SC_CTRL_LIST_INVALID:
 		return "CONTROLLER_LIST_INVALID: The controller list provided is invalid";
-	case NVME_SC_DEVICE_SELF_TEST_IN_PROGRESS:
+	case NVME_SC_SELT_TEST_IN_PROGRESS:
 		return "DEVICE_SELF_TEST_IN_PROGRESS: The controller or NVM subsystem already has a device self-test operation in process.";
 	case NVME_SC_BP_WRITE_PROHIBITED:
 		return "BOOT PARTITION WRITE PROHIBITED: The command is trying to modify a Boot Partition while it is locked";
-	case NVME_SC_INVALID_CTRL_ID:
+	case NVME_SC_CTRL_ID_INVALID:
 		return "INVALID_CTRL_ID: An invalid Controller Identifier was specified.";
-	case NVME_SC_INVALID_SECONDARY_CTRL_STATE:
+	case NVME_SC_SEC_CTRL_STATE_INVALID:
 		return "INVALID_SECONDARY_CTRL_STATE: The action requested for the secondary controller is invalid based on the current state of the secondary controller and its primary controller.";
-	case NVME_SC_INVALID_NUM_CTRL_RESOURCE:
+	case NVME_SC_CTRL_RES_NUM_INVALID:
 		return "INVALID_NUM_CTRL_RESOURCE: The specified number of Flexible Resources is invalid";
-	case NVME_SC_INVALID_RESOURCE_ID:
+	case NVME_SC_RES_ID_INVALID:
 		return "INVALID_RESOURCE_ID: At least one of the specified resource identifiers was invalid";
-	case NVME_SC_ANA_INVALID_GROUP_ID:
+	case NVME_SC_ANA_GROUP_ID_INVALID:
 		return "ANA_INVALID_GROUP_ID: The specified ANA Group Identifier (ANAGRPID) is not supported in the submitted command.";
-	case NVME_SC_ANA_ATTACH_FAIL:
+	case NVME_SC_ANA_ATTACH_FAILED:
 		return "ANA_ATTACH_FAIL: The controller is not attached to the namespace as a result of an ANA condition";
 	case NVME_SC_BAD_ATTRIBUTES:
 		return "BAD_ATTRIBUTES: Bad attributes were given";
-	case NVME_SC_CMD_SIZE_LIMIT_EXCEEDED:
-		return "CMD_SIZE_LIMIT_EXCEEDED: Command size limit exceeded";
 	case NVME_SC_WRITE_FAULT:
 		return "WRITE_FAULT: The write data could not be committed to the media";
 	case NVME_SC_READ_ERROR:
@@ -5231,7 +5228,7 @@ static void nvme_show_plm_config(struct nvme_plm_config *plmcfg)
 	printf("\tDTWIN Time Threshold  :%"PRIu64"\n", le64_to_cpu(plmcfg->dtwin_time_thresh));
 }
 
-void nvme_feature_show_fields(enum nvme_feat fid, unsigned int result, unsigned char *buf)
+void nvme_feature_show_fields(__u8 fid, unsigned int result, unsigned char *buf)
 {
 	__u8 field;
 	uint64_t ull;
@@ -5351,7 +5348,6 @@ void nvme_feature_show_fields(enum nvme_feat fid, unsigned int result, unsigned
 	case NVME_FEAT_HOST_BEHAVIOR:
 		printf("\tHost Behavior Support: %s\n", (buf[0] & 0x1) ? "True" : "False");
 		break;
-	case NVME_FEAT_NONE:
 	case NVME_FEAT_SANITIZE:
 	case NVME_FEAT_RRL:
 		printf("\t%s: to be implemented\n", nvme_feature_to_string(fid));
diff --git a/nvme-print.h b/nvme-print.h
index 368434c..cfea19f 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -73,13 +73,13 @@ void nvme_show_id_uuid_list(const struct nvme_id_uuid_list *uuid_list,
 	enum nvme_print_flags flags);
 void nvme_show_id_iocs(struct nvme_id_iocs *iocs);
 
-void nvme_feature_show_fields(enum nvme_feat fid, unsigned int result, unsigned char *buf);
+void nvme_feature_show_fields(__u8 fid, unsigned int result, unsigned char *buf);
 void nvme_directive_show(__u8 type, __u8 oper, __u16 spec, __u32 nsid, __u32 result,
 	void *buf, __u32 len, enum nvme_print_flags flags);
 void nvme_show_select_result(__u32 result);
 
 void nvme_show_zns_id_ctrl(struct nvme_zns_id_ctrl *ctrl, unsigned int mode);
-void nvme_show_zns_id_ns(struct nvme_zns_id_ns *ns,
+void nvme_show_zns_id_ns(struct nvme_id_ns_zns *ns,
 	struct nvme_id_ns *id_ns, unsigned long flags);
 void nvme_show_zns_changed( struct nvme_zns_changed_zone_log *log,
 	unsigned long flags);
@@ -88,7 +88,7 @@ void nvme_show_zns_report_zones(void *report, __u32 descs,
 
 const char *nvme_status_to_string(__u32 status);
 const char *nvme_select_to_string(int sel);
-const char *nvme_feature_to_string(enum nvme_feat feature);
+const char *nvme_feature_to_string(__u8 feature);
 const char *nvme_register_to_string(int reg);
 
 #endif
diff --git a/nvme-status.c b/nvme-status.c
index 7821de2..71f7b50 100644
--- a/nvme-status.c
+++ b/nvme-status.c
@@ -45,7 +45,7 @@ static inline __u8 nvme_generic_status_to_errno(__u16 status)
 		return EREMOTEIO;
 	case NVME_SC_CAP_EXCEEDED:
 		return ENOSPC;
-	case NVME_SC_OPERATION_DENIED:
+	case NVME_SC_OP_DENIED:
 		return EPERM;
 	}
 
@@ -69,11 +69,11 @@ static inline __u8 nvme_cmd_specific_status_to_errno(__u16 status)
 	case NVME_SC_CTRL_LIST_INVALID:
 	case NVME_SC_BAD_ATTRIBUTES:
 	case NVME_SC_INVALID_PI:
-	case NVME_SC_INVALID_CTRL_ID:
-	case NVME_SC_INVALID_SECONDARY_CTRL_STATE:
-	case NVME_SC_INVALID_NUM_CTRL_RESOURCE:
-	case NVME_SC_INVALID_RESOURCE_ID:
-	case NVME_SC_ANA_INVALID_GROUP_ID:
+	case NVME_SC_CTRL_ID_INVALID:
+	case NVME_SC_SEC_CTRL_STATE_INVALID:
+	case NVME_SC_CTRL_RES_NUM_INVALID:
+	case NVME_SC_RES_ID_INVALID:
+	case NVME_SC_ANA_GROUP_ID_INVALID:
 		return EINVAL;
 	case NVME_SC_ABORT_LIMIT:
 	case NVME_SC_ASYNC_LIMIT:
@@ -98,7 +98,7 @@ static inline __u8 nvme_cmd_specific_status_to_errno(__u16 status)
 		return EALREADY;
 	case NVME_SC_THIN_PROV_NOT_SUPP:
 		return EOPNOTSUPP;
-	case NVME_SC_DEVICE_SELF_TEST_IN_PROGRESS:
+	case NVME_SC_SELT_TEST_IN_PROGRESS:
 		return EINPROGRESS;
 	}
 
diff --git a/nvme.h b/nvme.h
index 3fb1060..a2373f5 100644
--- a/nvme.h
+++ b/nvme.h
@@ -26,6 +26,29 @@
 #include "util/argconfig.h"
 #include "linux/nvme.h"
 
+/*
+ * is_64bit_reg - It checks whether given offset of the controller register is
+ *                64bit or not.
+ * @offset: offset of controller register field in bytes
+ *
+ * It gives true if given offset is 64bit register, otherwise it returns false.
+ *
+ * Notes:  This function does not care about transport so that the offset is
+ * not going to be checked inside of this function for the unsupported fields
+ * in a specific transport.  For example, BPMBL(Boot Partition Memory Buffer
+ * Location) register is not supported by fabrics, but it can be chcked here.
+ */
+static inline bool is_64bit_reg(__u32 offset)
+{
+	if (offset == NVME_REG_CAP ||
+	    offset == NVME_REG_ASQ ||
+	    offset == NVME_REG_ACQ ||
+	    offset == NVME_REG_BPMBL)
+		return true;
+
+	return false;
+}
+
 enum nvme_print_flags {
 	NORMAL	= 0,
 	VERBOSE	= 1 << 0,	/* verbosely decode complex values for humans */
diff --git a/plugins/shannon/shannon-nvme.c b/plugins/shannon/shannon-nvme.c
index 46ace75..abcc9e9 100644
--- a/plugins/shannon/shannon-nvme.c
+++ b/plugins/shannon/shannon-nvme.c
@@ -182,7 +182,7 @@ static int get_additional_feature(int argc, char **argv, struct command *cmd, st
 
 	struct config {
 		__u32 namespace_id;
-		enum nvme_feat feature_id;
+		__u8  feature_id;
 		__u8  sel;
 		__u32 cdw11;
 		__u32 data_len;
@@ -192,7 +192,7 @@ static int get_additional_feature(int argc, char **argv, struct command *cmd, st
 
 	struct config cfg = {
 		.namespace_id = 1,
-		.feature_id   = NVME_FEAT_NONE,
+		.feature_id   = 0,
 		.sel          = 0,
 		.cdw11        = 0,
 		.data_len     = 0,
diff --git a/plugins/virtium/virtium-nvme.c b/plugins/virtium/virtium-nvme.c
index a194a5f..f401d1e 100644
--- a/plugins/virtium/virtium-nvme.c
+++ b/plugins/virtium/virtium-nvme.c
@@ -883,7 +883,7 @@ static void vt_parse_detail_identify(const struct nvme_id_ctrl *ctrl)
 	vt_convert_data_buffer_to_hex_string(&buf[528], 2, true, s);
 	printf("    \"Atomic Write Unit Power Fail\":\"%sh\",\n", s);
 
-	temp = ctrl->icsvscc;
+	temp = ctrl->nvscc;
 	printf("    \"NVM Vendor Specific Command Configuration\":{\n");
 	vt_convert_data_buffer_to_hex_string(&buf[530], 1, true, s);
 	printf("        \"Value\":\"%sh\",\n", s);
diff --git a/plugins/zns/zns.c b/plugins/zns/zns.c
index 26b3f90..df2ecec 100644
--- a/plugins/zns/zns.c
+++ b/plugins/zns/zns.c
@@ -68,7 +68,7 @@ static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plug
 	const char *human_readable = "show identify in readable format";
 
 	enum nvme_print_flags flags;
-	struct nvme_zns_id_ns ns;
+	struct nvme_id_ns_zns ns;
 	struct nvme_id_ns id_ns;
 	int fd, err = -1;
 
@@ -199,7 +199,7 @@ close_fd:
 
 static int get_zdes_bytes(int fd, __u32 nsid)
 {
-	struct nvme_zns_id_ns ns;
+	struct nvme_id_ns_zns ns;
 	struct nvme_id_ns id_ns;
 	__u8 lbaf;
 	int err;
@@ -629,7 +629,7 @@ static int report_zones(int argc, char **argv, struct command *cmd, struct plugi
 	}
 
 	report_size = sizeof(struct nvme_zone_report) + cfg.num_descs *
-		(sizeof(struct nvme_zns_desc) + cfg.num_descs * zdes);
+		(sizeof(struct nvme_zone_descriptor) + cfg.num_descs * zdes);
 
 	report = nvme_alloc(report_size, &huge);
 	if (!report) {
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
