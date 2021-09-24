Return-Path: <SRS0=ODQg=OO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6642C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 21:09:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790746140A
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 21:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 790746140A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ll/ylDR3wcto8fxvHkY6IYaNaV8Bwrbp0V28mCzJHis=; b=XoVbyZQlJKJlmx
	sBUNqDO5ScFLydj0SDRMPAbrihlFw6MIvmALRFKJCGJWdanQCsnmxWVTcGXqgKYaEeGSltzZEQ1ug
	veDrPDv6yponljjIIPEPRMwTE0bAO5LcKpvKlQwI5NLtR34jRLR4Vlb4NVmDrH+yBwUBtol++IKyh
	TlDh1zhC3yt0o9p9b7J7d9L3uwPsm2+bHY27ZyMAg3FiCf2YpVXerWjmDCoX5p4Mq4i86Vg2+ihkH
	FldQ0FrrLHsXsUetR6l5A/CRkNdhUz6G7EM22gy0U67QElbww3F7n0E2TpC+tiI8zW3y3sryPTNos
	/KP5cnQADVEWytpArXZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTsQz-00FXME-BJ; Fri, 24 Sep 2021 21:08:41 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTsQl-00FXGb-KK
 for linux-nvme@lists.infradead.org; Fri, 24 Sep 2021 21:08:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1632517708; x=1664053708;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T8rOMitR+XWv+4tkBgb2Gs29CLbzQPz172Cn+ghEDvk=;
 b=dJyDcwiUSguV6rZOIfgd8TTIiPxlBl6STyUYofm8Qg95Q9S737NsT6v+
 iowgrs/ctAT6WtWwvMY0OdHcCVeLRD4VndNLDqItL+me4dkMyEQeKz4Co
 OEpCug6buz9qrOS40CWACs8h06bDfvwd8buzn8tfe3b27IspI7AlUDPu3 M=;
X-IronPort-AV: E=Sophos;i="5.85,321,1624320000"; d="scan'208";a="139997639"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 email-inbound-relay-pdx-2a-11a39b7d.us-west-2.amazon.com) ([10.43.8.2])
 by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 24 Sep 2021 21:08:25 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
 by email-inbound-relay-pdx-2a-11a39b7d.us-west-2.amazon.com (Postfix) with
 ESMTPS id 7D06441A66; Fri, 24 Sep 2021 21:08:24 +0000 (UTC)
Received: from EX13D04UWA003.ant.amazon.com (10.43.160.212) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Fri, 24 Sep 2021 21:08:23 +0000
Received: from dev-dsk-nikitina-1d-36de5be9.us-east-1.amazon.com
 (10.43.162.216) by EX13D04UWA003.ant.amazon.com (10.43.160.212) with
 Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 24 Sep 2021 21:08:22 +0000
From: Andrey Nikitin <nikitina@amazon.com>
To: <linux-nvme@lists.infradead.org>
CC: <benh@kernel.crashing.org>, <davebuch@amazon.com>, Andrey Nikitin
 <nikitina@amazon.com>
Subject: [RFC PATCH 2/3] nvme: add NVM set structures
Date: Fri, 24 Sep 2021 21:08:08 +0000
Message-ID: <20210924210809.14536-3-nikitina@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210924210809.14536-1-nikitina@amazon.com>
References: <20210924210809.14536-1-nikitina@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.43.162.216]
X-ClientProxiedBy: EX13D44UWC003.ant.amazon.com (10.43.162.138) To
 EX13D04UWA003.ant.amazon.com (10.43.160.212)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210924_140827_840140_392BD567 
X-CRM114-Status: GOOD (  14.88  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch adds NVM set and SQ association structure as defined by
NVMe 1.4 specification along with a helper function to check for
NVM sets and SQ associations support presented by the controller.

Signed-off-by: Andrey Nikitin <nikitina@amazon.com>
---
 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/nvme.h |  8 ++++++++
 include/linux/nvme.h     | 11 +++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8679a108f571..63d6a2162e72 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2889,6 +2889,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->kas = le16_to_cpu(id->kas);
 	ctrl->max_namespaces = le32_to_cpu(id->mnan);
 	ctrl->ctratt = le32_to_cpu(id->ctratt);
+	ctrl->nsetidmax = le16_to_cpu(id->nsetidmax);
 
 	if (id->rtd3e) {
 		/* us -> s */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a2e1f298b217..03be6c913216 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -290,6 +290,7 @@ struct nvme_ctrl {
 	u32 oaes;
 	u32 aen_result;
 	u32 ctratt;
+	u16 nsetidmax;
 	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;
@@ -630,6 +631,13 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
 		nvme_tag_from_cid(command_id) >= NVME_AQ_BLK_MQ_DEPTH;
 }
 
+static inline bool nvme_is_qassoc_supported(struct nvme_ctrl *ctrl)
+{
+	return (ctrl->ctratt & NVME_CTRL_ATTR_NVM_SETS) &&
+		(ctrl->ctratt & NVME_CTRL_ATTR_SQ_ASSOC) &&
+		ctrl->nsetidmax > 0;
+}
+
 void nvme_complete_rq(struct request *req);
 blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data, bool reserved);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b7c4c4130b65..04aaeb937c94 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -25,6 +25,7 @@
 #define NVME_RDMA_IP_PORT	4420
 
 #define NVME_NSID_ALL		0xffffffff
+#define NVME_MAX_QID		0xffff
 
 enum nvme_subsys_type {
 	NVME_NQN_DISC	= 1,		/* Discovery type target subsystem */
@@ -225,7 +226,9 @@ enum {
 
 enum nvme_ctrl_attr {
 	NVME_CTRL_ATTR_HID_128_BIT	= (1 << 0),
+	NVME_CTRL_ATTR_NVM_SETS		= (1 << 2),
 	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
+	NVME_CTRL_ATTR_SQ_ASSOC		= (1 << 8),
 };
 
 struct nvme_id_ctrl {
@@ -276,7 +279,8 @@ struct nvme_id_ctrl {
 	__le32			sanicap;
 	__le32			hmminds;
 	__le16			hmmaxd;
-	__u8			rsvd338[4];
+	__le16			nsetidmax;
+	__le16			endgidmax;
 	__u8			anatt;
 	__u8			anacap;
 	__le32			anagrpmax;
@@ -420,6 +424,7 @@ enum {
 	NVME_ID_CNS_CTRL		= 0x01,
 	NVME_ID_CNS_NS_ACTIVE_LIST	= 0x02,
 	NVME_ID_CNS_NS_DESC_LIST	= 0x03,
+	NVME_ID_CNS_NVMSET_LIST		= 0x04,
 	NVME_ID_CNS_CS_NS		= 0x05,
 	NVME_ID_CNS_CS_CTRL		= 0x06,
 	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
@@ -1166,7 +1171,9 @@ struct nvme_create_sq {
 	__le16			qsize;
 	__le16			sq_flags;
 	__le16			cqid;
-	__u32			rsvd12[4];
+	__le16			nvmsetid;
+	__u16			rsvd3;
+	__u32			rsvd13[3];
 };
 
 struct nvme_delete_queue {
-- 
2.32.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
