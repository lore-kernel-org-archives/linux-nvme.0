Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CEDCD98ED
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2026 03:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q5FljJTkLzanMtIwojN4NJNx13VGB3c74Ir8/UyUrpQ=; b=pgznJPY0hEPS/AQe7dawrsBMYm
	elv/NKupCnV22C9Zlv5YBbtFAD4MsPunKcvB4SMZ0w9d4xEXkqXUUeUXQMBh34zoGnPfCHTcXYvEz
	bREzbhRySPxBfhxHpwnzFd7u3DG1688R+l5XJoR7Zwdu+1YklCckI9dSwUveLYTT343vrH3tj3qoo
	OQDUxmjoHiezkfF1SQL+mmq8PwvA4+ZAxdQaSW43Kqhx7H+akDOFAGPD195wVOdegL3wrMrlX13M4
	prIn/eSOs97aYvZYcFevxjCA4iYrype2s/7wlLFIRAHcxK7WhjfSUV+r4HYiccI6THmTm6yUf3CKy
	FQBXmYNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa3BA-00000000YA1-3HC7;
	Thu, 18 Jun 2026 03:12:32 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa3B8-00000000Y95-0dvD
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jun 2026 03:12:32 +0000
X-UUID: 8404cf2c6ac311f1aa26b74ffac11d73-20260618
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ae154d61-4504-46d0-9c6c-33b1d29992d6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:d5c6ddccdf59f239f013cf741158bf1c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8404cf2c6ac311f1aa26b74ffac11d73-20260618
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1970628627; Thu, 18 Jun 2026 11:12:19 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, kbusch@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 1/1] nvmet: implement discovery Get Log indexing and LID 0x00
Date: Thu, 18 Jun 2026 11:03:36 +0800
Message-ID: <114869d16a1f.1781751816.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.1781751816.git.liuxixin@kylinos.cn>
References: <cover.1781751816.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: nvme-ecn124/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_201231_038861_ACCA3B90 
X-CRM114-Status: GOOD (  17.48  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Per NVM Express Base Specification 2.3, Discovery controllers must
expose Supported Log Pages (LID 0x00) and, for the Discovery log (LID
0x70), advertise Index Offset Supported so hosts may use Get Log CDW14
Offset Type to supply a structure index in LPO instead of a byte offset.

Implement LID 0x00 for the Discovery controller with LSUPP set for the
Supported log itself and LSUPP|IOS for the Discovery log.  When OT is
set, translate LPO from index to byte offset (index 0 maps to the
header at byte 0; index N>=1 maps to entry N-1).  Reject OT=1 with
Invalid Field when IOS is clear for the requested LID.

Keep the existing OT=0 path: dword-aligned byte offsets, partial copy,
and zero-fill within the log page.  Reject indices whose byte offset
would overflow u64 before the existing offset > alloc_len validation;
otherwise a wrapped offset could fall inside the log and return wrong
data.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/nvme/target/discovery.c | 101 +++++++++++++++++++++++++++++++++++++--
 include/linux/nvme.h            |  18 ++++++-
 2 files changed, 113 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 114869d16a1f..430a197243da 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -158,12 +158,96 @@ static size_t discovery_log_entries(struct nvmet_req *req)
 	return entries;
 }
 
+/*
+ * LID Supported and Effects for log pages served by this controller.
+ * Must match Supported Log Pages (LID 0x00) lids[] contents.
+ */
+static u32 nvmet_disc_lid_support_effects(u8 lid)
+{
+	switch (lid) {
+	case NVME_LOG_SUPPORTED:
+		return NVME_LIDS_LSUPP;
+	case NVME_LOG_DISC:
+		return NVME_LIDS_LSUPP | NVME_LIDS_IOS;
+	default:
+		return 0;
+	}
+}
+
+static bool nvmet_disc_lid_ios(u8 lid)
+{
+	return nvmet_disc_lid_support_effects(lid) & NVME_LIDS_IOS;
+}
+
+static u16 nvmet_execute_disc_get_supported_log_pages(struct nvmet_req *req)
+{
+	struct nvme_supported_log *logs;
+	u16 status;
+
+	logs = kzalloc_obj(*logs);
+	if (!logs)
+		return NVME_SC_INTERNAL;
+
+	logs->lids[NVME_LOG_SUPPORTED] =
+		cpu_to_le32(nvmet_disc_lid_support_effects(NVME_LOG_SUPPORTED));
+	logs->lids[NVME_LOG_DISC] =
+		cpu_to_le32(nvmet_disc_lid_support_effects(NVME_LOG_DISC));
+
+	status = nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
+	kfree(logs);
+	return status;
+}
+
+static bool nvmet_disc_get_log_ot(struct nvme_command *cmd)
+{
+	return le32_to_cpu(cmd->common.cdw14) & NVME_LOG_CDW14_OT;
+}
+
+static u64 nvmet_disc_get_log_offset(struct nvme_command *cmd, u8 lid,
+				     u32 entry_size, u16 *error_loc)
+{
+	u64 lpo = nvmet_get_log_page_offset(cmd);
+
+	if (nvmet_disc_get_log_ot(cmd)) {
+		u64 byte_off;
+
+		if (!nvmet_disc_lid_ios(lid)) {
+			*error_loc = offsetof(struct nvme_common_command, cdw14);
+			return U64_MAX;
+		}
+
+		if (lpo == 0)
+			return 0;
+		/*
+		 * byte_off = sizeof(hdr) + (index - 1) * entry_size.
+		 * Reject if that would overflow u64: a wrapped offset could
+		 * otherwise pass offset > alloc_len below.
+		 */
+		if (lpo - 1 > (U64_MAX - sizeof(struct nvmf_disc_rsp_page_hdr)) /
+			    entry_size) {
+			*error_loc = offsetof(struct nvme_get_log_page_command,
+					      lpo);
+			return U64_MAX;
+		}
+		byte_off = sizeof(struct nvmf_disc_rsp_page_hdr) +
+			   (lpo - 1) * entry_size;
+		return byte_off;
+	}
+
+	if (lpo & 0x3) {
+		*error_loc = offsetof(struct nvme_get_log_page_command, lpo);
+		return U64_MAX;
+	}
+
+	return lpo;
+}
+
 static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 {
 	const int entry_size = sizeof(struct nvmf_disc_rsp_page_entry);
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmf_disc_rsp_page_hdr *hdr;
-	u64 offset = nvmet_get_log_page_offset(req->cmd);
+	u64 offset;
 	size_t data_len = nvmet_get_log_page_len(req->cmd);
 	size_t alloc_len;
 	size_t copy_len;
@@ -177,6 +261,14 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	if (!nvmet_check_transfer_len(req, data_len))
 		return;
 
+	if (req->cmd->get_log_page.lid == NVME_LOG_SUPPORTED) {
+		u16 status;
+
+		status = nvmet_execute_disc_get_supported_log_pages(req);
+		nvmet_req_complete(req, status);
+		return;
+	}
+
 	if (req->cmd->get_log_page.lid != NVME_LOG_DISC) {
 		req->error_loc =
 			offsetof(struct nvme_get_log_page_command, lid);
@@ -184,10 +276,9 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 		goto out;
 	}
 
-	/* Spec requires dword aligned offsets */
-	if (offset & 0x3) {
-		req->error_loc =
-			offsetof(struct nvme_get_log_page_command, lpo);
+	offset = nvmet_disc_get_log_offset(req->cmd, NVME_LOG_DISC, entry_size,
+					   &req->error_loc);
+	if (offset == U64_MAX) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out;
 	}
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 041f30931a90..269136cda485 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1427,8 +1427,15 @@ struct nvme_supported_log {
 	__le32	lids[256];
 };
 
+/*
+ * LID Supported and Effects (Supported Log Pages log, LID 0x00):
+ *
+ * @NVME_LIDS_LSUPP: LID Supported
+ * @NVME_LIDS_IOS:   Index Offset Supported
+ */
 enum {
-	NVME_LIDS_LSUPP	= 1 << 0,
+	NVME_LIDS_LSUPP	= (1 << 0),
+	NVME_LIDS_IOS	= (1 << 1),
 };
 
 struct nvme_supported_features_log {
@@ -1583,6 +1590,15 @@ struct nvme_get_log_page_command {
 	__u32			rsvd15;
 };
 
+/*
+ * Get Log Page Command Dword 14:
+ *
+ * @NVME_LOG_CDW14_OT: Offset Type (0 = byte offset, 1 = structure index)
+ */
+enum {
+	NVME_LOG_CDW14_OT	= (1 << 23),
+};
+
 struct nvme_directive_cmd {
 	__u8			opcode;
 	__u8			flags;
-- 
2.43.0


