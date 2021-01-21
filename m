Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C55C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:10:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F3E23602
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F3E23602
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P57KMZrAqQuNJBc1mY6ZUqSVhc+QTJj6wDVldKYaha8=; b=gWQfzMm2FUVpzsZF3YIWzwbh/
	kZtVc6KMDkrVHYge/AGBfFBkjG9tgoogUvgOf9v1sL4IX8IlYMnWGIUPsd2O5jgweuA1gEjgC2HFx
	yU0rrt7pmfIGjPeUB0ZLWjMQ77qFGX2zpbxN7bESeYEhyJus57oCB75eMLl5TWF+WKfUWr3Mttmk5
	zt+p/XSiCCQ2FsLkW/c+GBj4JbYdbK/Vf86gHe9zzk4fK3B7mz7sPi9sbo9NADCiwS1Y244Tn9+x4
	45fXCHVTEQ0ShWo43dvcGnb7UVsJ4T+gczuBvbC7XcOFtib1VaiKNO0XTd1Vt5pcUIOb5/Iym4wtq
	ANJ+4VM2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2Vyf-0003Oj-EH; Thu, 21 Jan 2021 09:10:05 +0000
Received: from hqnvemgate24.nvidia.com ([216.228.121.143])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2VyZ-0003MR-M1
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 09:10:03 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B600944e60000>; Thu, 21 Jan 2021 01:09:58 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Jan
 2021 09:09:58 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 21 Jan 2021 09:09:56 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/2] nvme: resync header file with common nvme-cli tool
Date: Thu, 21 Jan 2021 09:09:48 +0000
Message-ID: <20210121090948.8027-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210121090948.8027-1-mgurtovoy@nvidia.com>
References: <20210121090948.8027-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611220199; bh=Qsa8bX95Pq1jZo8u/RHWiFE+UMJLomJVYfbuaAo0P2Y=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=DeS+QnbJT+Tfp58AQDfxxuPsBFAcbZcb7Fetu4UtOmciPyhNLo8RfqAIU3AnfCbs0
 fcyFDi/gUiB1EpASxYa3KoX+pF3ijQ0yvXOTmImlwbDGulv3sMSoRGfew6P0FpwCdp
 I2KbOghuaNQTCpxp/yEGggiF7lyXucYgn/gkQz/cRt27I/ngDy4vkaTxbLu3gwcxDi
 wnmo2yDH/3JDr2+6UyHkPAUUWgL4sNK1E8sCRW9uhotzVkEkj+6zwF57Z8YaJZ4+Nf
 hd2R1wns27PzintjGt57mDD13jBvLi5DMscgh5sI2ehfPX68BgCwHOS40RQMpD1nvD
 B1b0FNinmG4vQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_040959_852969_760D4BE0 
X-CRM114-Status: GOOD (  11.31  )
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

Import constant definitions that were added to nvme-cli and were not
added to Linux. This is the first step to align nvme.h files from Linux
kernel include/linux/nvme.h and nvme-cli linux/nvme.h.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 include/linux/nvme.h | 66 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 1c9c34be8194..5d10c4cf3d33 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -113,18 +113,16 @@ enum {
 	NVME_REG_CMBSZ	= 0x003c,	/* Controller Memory Buffer Size */
 	NVME_REG_BPINFO	= 0x0040,	/* Boot Partition Information */
 	NVME_REG_BPRSEL	= 0x0044,	/* Boot Partition Read Select */
-	NVME_REG_BPMBL	= 0x0048,	/* Boot Partition Memory Buffer
-					 * Location
-					 */
+	NVME_REG_BPMBL	= 0x0048,	/* Boot Partition Memory Buffer Location */
+	NVME_REG_CMBMSC	= 0x0050,	/* Controller Memory Buffer Memory Space Control */
+	NVME_REG_CMBSTS	= 0x0058,	/* Controller Memory Buffer Status */
+
 	NVME_REG_PMRCAP	= 0x0e00,	/* Persistent Memory Capabilities */
 	NVME_REG_PMRCTL	= 0x0e04,	/* Persistent Memory Region Control */
 	NVME_REG_PMRSTS	= 0x0e08,	/* Persistent Memory Region Status */
-	NVME_REG_PMREBS	= 0x0e0c,	/* Persistent Memory Region Elasticity
-					 * Buffer Size
-					 */
-	NVME_REG_PMRSWTP = 0x0e10,	/* Persistent Memory Region Sustained
-					 * Write Throughput
-					 */
+	NVME_REG_PMREBS	= 0x0e0c,	/* Persistent Memory Region Elasticity Buffer Size */
+	NVME_REG_PMRSWTP = 0x0e10,	/* Persistent Memory Region Sustained Write Throughput */
+	NVME_REG_PMRMSC = 0x0e14,	/* Persistent Memory Region Controller Memory Space Control */
 	NVME_REG_DBS	= 0x1000,	/* SQ 0 Tail Doorbell */
 };
 
@@ -138,6 +136,14 @@ enum {
 
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
@@ -238,7 +244,10 @@ struct nvme_id_ctrl {
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
@@ -270,12 +279,14 @@ struct nvme_id_ctrl {
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
@@ -289,7 +300,7 @@ struct nvme_id_ctrl {
 	__u8			nvscc;
 	__u8			nwpc;
 	__le16			acwu;
-	__u8			rsvd534[2];
+	__le16			ocfs;
 	__le32			sgls;
 	__le32			mnan;
 	__u8			rsvd544[224];
@@ -362,7 +373,10 @@ struct nvme_id_ns {
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
@@ -404,8 +418,10 @@ enum {
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
@@ -413,6 +429,10 @@ enum {
 	NVME_ID_CNS_SCNDRY_CTRL_LIST	= 0x15,
 	NVME_ID_CNS_NS_GRANULARITY	= 0x16,
 	NVME_ID_CNS_UUID_LIST		= 0x17,
+	NVME_ID_CNS_CSI_NS_PRESENT_LIST	= 0x1a,
+	NVME_ID_CNS_CSI_NS_PRESENT	= 0x1b,
+	NVME_ID_CNS_CSI			= 0x1c,
+
 };
 
 enum {
@@ -673,6 +693,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_copy		= 0x19,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -1042,6 +1063,7 @@ enum {
 	NVME_FEAT_PLM_WINDOW	= 0x14,
 	NVME_FEAT_HOST_BEHAVIOR	= 0x16,
 	NVME_FEAT_SANITIZE	= 0x17,
+	NVME_FEAT_IOCS_PROFILE	= 0x19,
 	NVME_FEAT_SW_PROGRESS	= 0x80,
 	NVME_FEAT_HOST_ID	= 0x81,
 	NVME_FEAT_RESV_MASK	= 0x82,
@@ -1058,9 +1080,14 @@ enum {
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
@@ -1300,6 +1327,9 @@ struct nvmf_disc_rsp_page_entry {
 			__u16	pkey;
 			__u8	resv10[246];
 		} rdma;
+		struct tcp {
+			__u8	sectype;
+		} tcp;
 	} tsas;
 };
 
@@ -1532,6 +1562,14 @@ enum {
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
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
