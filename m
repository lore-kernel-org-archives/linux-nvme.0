Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9C8C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 07:13:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB7C64DBA
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 07:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB7C64DBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ivHWhGfCPH3tkVeIjcj2Ml+7bpa10XB+Cn0nPbd3VC8=; b=aKRC4QZl3BBTfJph3qGbtai9f
	T3XjLPDgqKMFT8vHAM8eWLjOFtb9sCuDwr8I4z2mQ0ugUrX7Mq46ZUELvQMww0dj+w68y1qceytBd
	NLUwwWTnFnDdG+7RXDFEf1BcnHFsH/bW8HPxKDD3nAdarQQKR/5wcnSQ9NVb7RCKt5E3g85VYc7D6
	aZ9ct6bCCGt2o4Agz0Ve8GGQsCTLK9X8KSMS29fP1MJQe/k+ySDvIK3ZoUela5IU1oZrHavESn1YC
	V572N59yXAM1RkPDhgi5GivEkC9zZn3cPqjCGlJZ1sFgpDPaLUQsAEINXFvbmlFjEOyaTd1OuscIv
	KxE26by2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lASdm-0005il-TZ; Fri, 12 Feb 2021 07:13:22 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lASdj-0005hh-ON
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 07:13:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613114151; x=1644650151;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=InnOwFhAAGCza8gcI5KYgVzPtIpwjGiv06YAP03dK2Q=;
 b=ZFxDmnZNGT99DerfxE16nvTzbUEq8KQLPzc5LcENDtEftaaw2xBVdx6j
 ChFVM6ZdmcgQa7eQwazNgBzS8j+UyqOOb2aOA87VleRof++oLs4/7URGQ
 qUuCTXL7VZ1dhtwy/oPDD+Y5aJKUMvgE5kwsJTvkm7b55xh4a3CCGbMd+
 hDY2kGEO0JHKRU9gx89RYDmsV0OsVG7Q2KORAfYLKc4DelM0JTaHfQUtz
 xaAxHb+hfMainWsAnDr26HunDm/WXipP68Ki/qXlVtesD75mwfegX81pA
 jjGQ8Tu7XmFfgtxyrP4WLYcW5kLUM9O2FHYQYqncXTCtcEEnmLKF9AY8h w==;
IronPort-SDR: f6s3ZUZuNnyIen5GDcUC+BAd32N+d753vGdcfqnl9yz6WjXvldrclLS2zS7uNey+rzMa5sWzia
 Gn9SvYXcj988gu4rvTocfQ/h+r+8N5jEhBM38yTY6MzxGd2n/8890Jbs8frjbC4OgQvDPugJO4
 g0gXi9GQ4+2WdXW0iNo8BFqAANe+hJ3vKb3L8xePs/71fXvsi5qHNifIq3qd34jgQ9NGuEwr4E
 3fD94ES7KvhQTc99uXM9rq4sbOjv+J9p22qxt0ZR/o2v7l0cXFSLLtZIvGB+fV9mUC6YVD9Di2
 JCA=
X-IronPort-AV: E=Sophos;i="5.81,173,1610380800"; d="scan'208";a="263951418"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2021 15:15:48 +0800
IronPort-SDR: FA/QVorQw7dncJmUT9RYIviANzn7fQNi6+KcfpcgeNyZda5X6VvELi5Xn3jP1Tj0IZ2CzW3k8t
 nLLoKMc3DvHAWQ3nnqgjg0jYshWU+qzNdGq6fEHGERBiFn3Ai8OGIkVuZhdhocPqDAZ1NuXXBJ
 vNIRbZm+IH+WPf2ULeXkHfOJk+UUR3V3ZqcD7ouw4TRWxF61MaxZnfp24htCxBS7k9PXUChIFq
 HR5hV9IpYy7ci49K6c2LBa6Ok9BJdt7v6nr+zlZMfoQRzwJoaIdF88soBeGwiw93QBgAvfXS7d
 e6YaFvkQ1hlyhNOE2DcnjpCG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2021 22:55:07 -0800
IronPort-SDR: H1XQAS2iApf6kZc5zlmGo0lqVll0/1otoyIpczV96Iqho296y3i31F5veO1OA0MpmDqm9SzqR2
 9of472Uec0lsry2Dye9pJRKj7JXmxPBw8EWNhcsGttEsfaukFa0Uz+6MBWSDsvepYatRfUBGxm
 HyM+Seq45Cwbwetxf5u4V85UOSjacEeNOryH0d66OBRktKKi3m2K9SIUnoU00bn5Kf9Nkvztzi
 cvo6yV5k/tqq90zldJxk4BAm2C+N/KXOULSlFaGh8SDoCIpoEzTPGzWLSpfawthVwiuKhHx1Lu
 O+Q=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2021 23:13:18 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme: resync header file with common nvme-cli tool
Date: Thu, 11 Feb 2021 23:13:04 -0800
Message-Id: <20210212071305.39901-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210212071305.39901-1-chaitanya.kulkarni@wdc.com>
References: <20210212071305.39901-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_021320_215578_48A29102 
X-CRM114-Status: GOOD (  13.94  )
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
Cc: mgurtovoy@nvidia.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Max Gurtovoy <mgurtovoy@nvidia.com>

Import constant definitions that were added to nvme-cli and were not
added to Linux. This is the first step to align nvme.h files from Linux
kernel include/linux/nvme.h and nvme-cli linux/nvme.h.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
[ Shorten the comments for PMR and CMB which are common shortforms ]
---
 include/linux/nvme.h | 73 ++++++++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 19 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b08787cd0881..3f162e34a2c0 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -113,21 +113,16 @@ enum {
 	NVME_REG_CMBSZ	= 0x003c,	/* Controller Memory Buffer Size */
 	NVME_REG_BPINFO	= 0x0040,	/* Boot Partition Information */
 	NVME_REG_BPRSEL	= 0x0044,	/* Boot Partition Read Select */
-	NVME_REG_BPMBL	= 0x0048,	/* Boot Partition Memory Buffer
-					 * Location
-					 */
-	NVME_REG_CMBMSC = 0x0050,	/* Controller Memory Buffer Memory
-					 * Space Control
-					 */
+	NVME_REG_BPMBL	= 0x0048,	/* Boot Partition Memory Buffer Location */
+	NVME_REG_CMBMSC	= 0x0050,	/* CMB Memory Space Control */
+	NVME_REG_CMBSTS	= 0x0058,	/* CMB Status */
+
 	NVME_REG_PMRCAP	= 0x0e00,	/* Persistent Memory Capabilities */
-	NVME_REG_PMRCTL	= 0x0e04,	/* Persistent Memory Region Control */
-	NVME_REG_PMRSTS	= 0x0e08,	/* Persistent Memory Region Status */
-	NVME_REG_PMREBS	= 0x0e0c,	/* Persistent Memory Region Elasticity
-					 * Buffer Size
-					 */
-	NVME_REG_PMRSWTP = 0x0e10,	/* Persistent Memory Region Sustained
-					 * Write Throughput
-					 */
+	NVME_REG_PMRCTL	= 0x0e04,	/* PMR Control */
+	NVME_REG_PMRSTS	= 0x0e08,	/* PMR Status */
+	NVME_REG_PMREBS	= 0x0e0c,	/* PMR Elasticity Buffer Size */
+	NVME_REG_PMRSWTP = 0x0e10,	/* PMR Sustained Write Throughput */
+	NVME_REG_PMRMSC = 0x0e14,	/* PMR Controller Memory Space Control */
 	NVME_REG_DBS	= 0x1000,	/* SQ 0 Tail Doorbell */
 };
 
@@ -142,6 +137,14 @@ enum {
 
 #define NVME_CMB_BIR(cmbloc)	((cmbloc) & 0x7)
 #define NVME_CMB_OFST(cmbloc)	(((cmbloc) >> 12) & 0xfffff)
+#define NVME_CMB_SZ(cmbsz)	(((cmbsz) >> 12) & 0xfffff)
+#define NVME_CMB_SZU(cmbsz)	(((cmbsz) >> 8) & 0xf)
+
+#define NVME_CMB_WDS(cmbsz)	((cmbsz) & 0x10)
+#define NVME_CMB_RDS(cmbsz)	((cmbsz) & 0x8)
+#define NVME_CMB_LISTS(cmbsz)	((cmbsz) & 0x4)
+#define NVME_CMB_CQS(cmbsz)	((cmbsz) & 0x2)
+#define NVME_CMB_SQS(cmbsz)	((cmbsz) & 0x1)
 
 enum {
 	NVME_CMBSZ_SQS		= 1 << 0,
@@ -244,7 +247,10 @@ struct nvme_id_ctrl {
 	__le32			rtd3e;
 	__le32			oaes;
 	__le32			ctratt;
-	__u8			rsvd100[28];
+	__le16			rrls;
+	__u8			rsvd102[9];
+	__u8			cntrltype;
+	char			fguid[16];
 	__le16			crdt1;
 	__le16			crdt2;
 	__le16			crdt3;
@@ -276,12 +282,14 @@ struct nvme_id_ctrl {
 	__le32			sanicap;
 	__le32			hmminds;
 	__le16			hmmaxd;
-	__u8			rsvd338[4];
+	__le16			nsetidmax;
+	__le16			endgidmax;
 	__u8			anatt;
 	__u8			anacap;
 	__le32			anagrpmax;
 	__le32			nanagrpid;
-	__u8			rsvd352[160];
+	__le32			pels;
+	__u8			rsvd356[156];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;
@@ -295,7 +303,7 @@ struct nvme_id_ctrl {
 	__u8			nvscc;
 	__u8			nwpc;
 	__le16			acwu;
-	__u8			rsvd534[2];
+	__le16			ocfs;
 	__le32			sgls;
 	__le32			mnan;
 	__u8			rsvd544[224];
@@ -368,7 +376,10 @@ struct nvme_id_ns {
 	__le16			npdg;
 	__le16			npda;
 	__le16			nows;
-	__u8			rsvd74[18];
+	__le16			mssrl;
+	__le32			mcl;
+	__u8			msrc;
+	__u8			rsvd81[11];
 	__le32			anagrpid;
 	__u8			rsvd96[3];
 	__u8			nsattr;
@@ -410,8 +421,10 @@ enum {
 	NVME_ID_CNS_CTRL		= 0x01,
 	NVME_ID_CNS_NS_ACTIVE_LIST	= 0x02,
 	NVME_ID_CNS_NS_DESC_LIST	= 0x03,
+	NVME_ID_CNS_NVMSET_LIST		= 0x04,
 	NVME_ID_CNS_CS_NS		= 0x05,
 	NVME_ID_CNS_CS_CTRL		= 0x06,
+	NVME_ID_CNS_CS_NS_ACTIVE_LIST	= 0x07,
 	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
 	NVME_ID_CNS_NS_PRESENT		= 0x11,
 	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
@@ -419,6 +432,10 @@ enum {
 	NVME_ID_CNS_SCNDRY_CTRL_LIST	= 0x15,
 	NVME_ID_CNS_NS_GRANULARITY	= 0x16,
 	NVME_ID_CNS_UUID_LIST		= 0x17,
+	NVME_ID_CNS_CSI_NS_PRESENT_LIST	= 0x1a,
+	NVME_ID_CNS_CSI_NS_PRESENT	= 0x1b,
+	NVME_ID_CNS_CSI			= 0x1c,
+
 };
 
 enum {
@@ -679,6 +696,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_copy		= 0x19,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -1052,6 +1070,7 @@ enum {
 	NVME_FEAT_PLM_WINDOW	= 0x14,
 	NVME_FEAT_HOST_BEHAVIOR	= 0x16,
 	NVME_FEAT_SANITIZE	= 0x17,
+	NVME_FEAT_IOCS_PROFILE	= 0x19,
 	NVME_FEAT_SW_PROGRESS	= 0x80,
 	NVME_FEAT_HOST_ID	= 0x81,
 	NVME_FEAT_RESV_MASK	= 0x82,
@@ -1068,9 +1087,14 @@ enum {
 	NVME_LOG_TELEMETRY_HOST = 0x07,
 	NVME_LOG_TELEMETRY_CTRL = 0x08,
 	NVME_LOG_ENDURANCE_GROUP = 0x09,
+	NVME_LOG_PRELAT_PER_NVMSET	= 0x0a,
+	NVME_LOG_PRELAT_EVENT_AGG	= 0x0b,
 	NVME_LOG_ANA		= 0x0c,
+	NVME_LOG_PERSISTENT_EVENT   = 0x0d,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
+	NVME_LOG_SANITIZE	= 0x81,
+	NVME_LOG_ZONE_CHANGED_LIST = 0xbf,
 	NVME_FWACT_REPL		= (0 << 3),
 	NVME_FWACT_REPL_ACTV	= (1 << 3),
 	NVME_FWACT_ACTV		= (2 << 3),
@@ -1310,6 +1334,9 @@ struct nvmf_disc_rsp_page_entry {
 			__u16	pkey;
 			__u8	resv10[246];
 		} rdma;
+		struct tcp {
+			__u8	sectype;
+		} tcp;
 	} tsas;
 };
 
@@ -1542,6 +1569,14 @@ enum {
 	NVME_SC_ANA_GROUP_ID_INVALID	= 0x124,
 	NVME_SC_ANA_ATTACH_FAILED	= 0x125,
 
+	/*
+	 * Command Set Specific - Namespace Types commands:
+	 */
+	NVME_SC_IOCS_NOT_SUPPORTED	= 0x129,
+	NVME_SC_IOCS_NOT_ENABLED	= 0x12a,
+	NVME_SC_IOCS_COMBINATION_REJ	= 0x12b,
+	NVME_SC_INVALID_IOCS		= 0x12c,
+
 	/*
 	 * I/O Command Set Specific - NVM commands:
 	 */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
