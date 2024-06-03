Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3EAC25B75
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dHsRUNPX7Cx/MnLSy0fP34bq6fJLXf7e8GWQjvZdZC4=; b=yJOxSKL0LGfdnHHQvmxNswvkuf
	DumAMsXwGYVin5S3wpXfdPzGlKRKe5mwdFFvxyWNSFgr49h2MrtpcCMd2hj4cm9Vj6X/twa0rkOfG
	U6jBf5+fdr4bm11+D3j64fdKvbFSFvj34yiP3WnkTD0CF4njLyMVMgqhgxKc9MHcJPsgdh4juBKgO
	OdhDS2IyeMqHx2Oq28KIIFFPC9S79gZsKMkoYP+Tsl2AbborY+TS/GxyJyuZr/PcvF8cZX9qhduBu
	1XdP746tDIAWliP6AJqaB+tSnk0SEBgO2lERQyIC6u13PU4CndtlU/z01/afITCn7yNc2A38MS7rh
	MbCLsX6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE7GU-0000000GmHq-3j1X;
	Mon, 03 Jun 2024 12:58:18 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE7GM-0000000GmDq-32Aj
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 12:58:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717419481; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dHsRUNPX7Cx/MnLSy0fP34bq6fJLXf7e8GWQjvZdZC4=;
	b=Qk5WmR1xS0bwILlhkJbT2Tu1XpQHfp0DL7mPSBjMSFopGGdM4dms1TdYuv4wLiROoC4Rm69bfTqIzVKQ099866no7qjZMWqSA/QHPJU6Agad+yEpwhmLZeAsNa9lPGcpR4v9V+7Fr+7+pUz8V76g5p5Q8Fh0siPhEtgS71FBq9Y=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=huweiwen@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W7nmJ8a_1717419477;
Received: from localhost.localdomain(mailfrom:huweiwen@linux.alibaba.com fp:SMTPD_---0W7nmJ8a_1717419477)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 20:57:58 +0800
From: Weiwen Hu <huweiwen@linux.alibaba.com>
To: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Mike Christie <michael.christie@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Weiwen Hu <huweiwen@linux.alibaba.com>
Subject: [PATCH v2 2/4] nvme: fix status magic numbers
Date: Mon,  3 Jun 2024 20:57:00 +0800
Message-ID: <20240603125702.97368-3-huweiwen@linux.alibaba.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603125702.97368-1-huweiwen@linux.alibaba.com>
References: <20240603125702.97368-1-huweiwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_055811_175352_1D8E90B2 
X-CRM114-Status: GOOD (  14.39  )
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

Replaced some magic numbers about SC and SCT with enum and macro.

Signed-off-by: Weiwen Hu <huweiwen@linux.alibaba.com>
---
 drivers/nvme/host/constants.c |  2 +-
 drivers/nvme/host/core.c      | 18 +++++++++---------
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  4 ++--
 drivers/nvme/host/pr.c        |  2 +-
 include/linux/nvme.h          | 14 ++++++++++++--
 6 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 6f2ebb5fcdb0..2b9e6cfaf2a8 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -173,7 +173,7 @@ static const char * const nvme_statuses[] = {
 
 const char *nvme_get_error_status_str(u16 status)
 {
-	status &= 0x7ff;
+	status &= NVME_SCT_SC_MASK;
 	if (status < ARRAY_SIZE(nvme_statuses) && nvme_statuses[status])
 		return nvme_statuses[status];
 	return "Unknown";
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5d150c62955..47abc2732191 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -261,7 +261,7 @@ void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 
 static blk_status_t nvme_error_status(u16 status)
 {
-	switch (status & 0x7ff) {
+	switch (status & NVME_SCT_SC_MASK) {
 	case NVME_SC_SUCCESS:
 		return BLK_STS_OK;
 	case NVME_SC_CAP_EXCEEDED:
@@ -329,8 +329,8 @@ static void nvme_log_error(struct request *req)
 		       nvme_sect_to_lba(ns->head, blk_rq_pos(req)),
 		       blk_rq_bytes(req) >> ns->head->lba_shift,
 		       nvme_get_error_status_str(nr->status),
-		       nr->status >> 8 & 7,	/* Status Code Type */
-		       nr->status & 0xff,	/* Status Code */
+		       NVME_SCT(nr->status),		/* Status Code Type */
+		       nr->status & NVME_SC_MASK,	/* Status Code */
 		       nr->status & NVME_SC_MORE ? "MORE " : "",
 		       nr->status & NVME_SC_DNR  ? "DNR "  : "");
 		return;
@@ -341,8 +341,8 @@ static void nvme_log_error(struct request *req)
 			   nvme_get_admin_opcode_str(nr->cmd->common.opcode),
 			   nr->cmd->common.opcode,
 			   nvme_get_error_status_str(nr->status),
-			   nr->status >> 8 & 7,	/* Status Code Type */
-			   nr->status & 0xff,	/* Status Code */
+			   NVME_SCT(nr->status),	/* Status Code Type */
+			   nr->status & NVME_SC_MASK,	/* Status Code */
 			   nr->status & NVME_SC_MORE ? "MORE " : "",
 			   nr->status & NVME_SC_DNR  ? "DNR "  : "");
 }
@@ -359,8 +359,8 @@ static void nvme_log_err_passthru(struct request *req)
 		     nvme_get_admin_opcode_str(nr->cmd->common.opcode),
 		nr->cmd->common.opcode,
 		nvme_get_error_status_str(nr->status),
-		nr->status >> 8 & 7,	/* Status Code Type */
-		nr->status & 0xff,	/* Status Code */
+		NVME_SCT(nr->status),		/* Status Code Type */
+		nr->status & NVME_SC_MASK,	/* Status Code */
 		nr->status & NVME_SC_MORE ? "MORE " : "",
 		nr->status & NVME_SC_DNR  ? "DNR "  : "",
 		nr->cmd->common.cdw10,
@@ -388,7 +388,7 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
 
-	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
+	if ((nvme_req(req)->status & NVME_SCT_SC_MASK) == NVME_SC_AUTH_REQUIRED)
 		return AUTHENTICATE;
 
 	if (req->cmd_flags & REQ_NVME_MPATH) {
@@ -1223,7 +1223,7 @@ EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
 
 /*
  * Recommended frequency for KATO commands per NVMe 1.4 section 7.12.1:
- * 
+ *
  *   The host should send Keep Alive commands at half of the Keep Alive Timeout
  *   accounting for transport roundtrip times [..].
  */
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d8b6b4648eaf..03a6868f4dbc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -83,7 +83,7 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
-	u16 status = nvme_req(req)->status & 0x7ff;
+	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
 	unsigned long flags;
 	struct bio *bio;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f3a41133ac3f..88b9dfadc0e2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -689,7 +689,7 @@ static inline u32 nvme_bytes_to_numd(size_t len)
 
 static inline bool nvme_is_ana_error(u16 status)
 {
-	switch (status & 0x7ff) {
+	switch (status & NVME_SCT_SC_MASK) {
 	case NVME_SC_ANA_TRANSITION:
 	case NVME_SC_ANA_INACCESSIBLE:
 	case NVME_SC_ANA_PERSISTENT_LOSS:
@@ -702,7 +702,7 @@ static inline bool nvme_is_ana_error(u16 status)
 static inline bool nvme_is_path_error(u16 status)
 {
 	/* check for a status code type of 'path related status' */
-	return (status & 0x700) == 0x300;
+	return (status & NVME_SCT_MASK) == NVME_SCT_PATH;
 }
 
 /*
diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index a6db5edfab03..7347ddf85f00 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -77,7 +77,7 @@ static int nvme_status_to_pr_err(int status)
 	if (nvme_is_path_error(status))
 		return PR_STS_PATH_FAILED;
 
-	switch (status & 0x7ff) {
+	switch (status & NVME_SCT_SC_MASK) {
 	case NVME_SC_SUCCESS:
 		return PR_STS_SUCCESS;
 	case NVME_SC_RESERVATION_CONFLICT:
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 425573202295..c8d7fdd095a1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1846,6 +1846,7 @@ enum {
 	/*
 	 * Generic Command Status:
 	 */
+	NVME_SCT_GENERIC		= 0x0,
 	NVME_SC_SUCCESS			= 0x0,
 	NVME_SC_INVALID_OPCODE		= 0x1,
 	NVME_SC_INVALID_FIELD		= 0x2,
@@ -1893,6 +1894,7 @@ enum {
 	/*
 	 * Command Specific Status:
 	 */
+	NVME_SCT_COMMAND_SPECIFIC	= 0x100,
 	NVME_SC_CQ_INVALID		= 0x100,
 	NVME_SC_QID_INVALID		= 0x101,
 	NVME_SC_QUEUE_SIZE		= 0x102,
@@ -1966,6 +1968,7 @@ enum {
 	/*
 	 * Media and Data Integrity Errors:
 	 */
+	NVME_SCT_MEDIA_ERROR		= 0x200,
 	NVME_SC_WRITE_FAULT		= 0x280,
 	NVME_SC_READ_ERROR		= 0x281,
 	NVME_SC_GUARD_CHECK		= 0x282,
@@ -1978,6 +1981,7 @@ enum {
 	/*
 	 * Path-related Errors:
 	 */
+	NVME_SCT_PATH			= 0x300,
 	NVME_SC_INTERNAL_PATH_ERROR	= 0x300,
 	NVME_SC_ANA_PERSISTENT_LOSS	= 0x301,
 	NVME_SC_ANA_INACCESSIBLE	= 0x302,
@@ -1986,11 +1990,17 @@ enum {
 	NVME_SC_HOST_PATH_ERROR		= 0x370,
 	NVME_SC_HOST_ABORTED_CMD	= 0x371,
 
-	NVME_SC_CRD			= 0x1800,
+	NVME_SC_MASK			= 0x00ff, /* Status Code */
+	NVME_SCT_MASK			= 0x0700, /* Status Code Type */
+	NVME_SCT_SC_MASK		= NVME_SCT_MASK | NVME_SC_MASK,
+
+	NVME_SC_CRD			= 0x1800, /* Command Retry Delayed */
 	NVME_SC_MORE			= 0x2000,
-	NVME_SC_DNR			= 0x4000,
+	NVME_SC_DNR			= 0x4000, /* Do Not Retry */
 };
 
+#define NVME_SCT(status) ((status) >> 8 & 7)
+
 struct nvme_completion {
 	/*
 	 * Used by Admin and Fabrics commands to return data:
-- 
2.45.1


