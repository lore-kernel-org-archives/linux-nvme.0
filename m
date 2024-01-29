Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91412C48285
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 06:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1U8Rcg91W/rs6L/YyJCpewWG/7cXrRAWtHu3lOXvuR0=; b=nRIlEXFQRJxBND6W366eyq3NjG
	LdXRz55ukCecipvduOIr/GwPqcnVBpT5OPRH3pDh/UpR9OyC9xR+w2FwJ7tQC8fJ6WT7YMCJHmj2e
	G8kp3yvmmXS3XTlzBB/1iXKBd8ehJCYiGFPg6Nsb5bkgojT43r/uMcMwVlkO2LIb0hdvR/l2RaKYp
	6fd50bZJTZQqFxHdgQ2VuROdFreW4xXUxHQ2Tdf7W4s+4W32BMLayLAM0tSEuuoefCcayh1oHWbhQ
	kKZqVZsqO8+dm3Id+4nURjPj8Dd1c9WST/A2qAzOJ8MYL9bmWj0pS/tE+Bq1l6j9bNhQtXtzpH9kk
	oyx0ahaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rULJc-0000000BWck-0O3A;
	Mon, 29 Jan 2024 06:40:20 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rULJX-0000000BWao-3XFo
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 06:40:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E45EACE0EBF;
	Mon, 29 Jan 2024 06:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3557AC433C7;
	Mon, 29 Jan 2024 06:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706510411;
	bh=0v2e7AUWtJyhp4kd3TP71lWDOk6HBsLg+mB7WBFmdyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slYoUmWzqc3eL2UfJn+B4UpHxx//Dqm0TpyZFDpH7sFcKLBRQG0Vy/uoE8zPpuBYu
	 FI3YDnv3K2/PEn7tsGtViQ7C6RKjuLgYYGQWBosMCJZ34oKc1gunP1tTxvLU8uB8ra
	 b8AdIFU82PKqpoZB1jQms50LBUoWEk6ruvO6/dlljnPjfaWY/OfHK8xIjbq77N28j5
	 jdEmiIn7MZOhmRZrNIm3jaTuIiKbCVqhwDz4DwLhmK1LiZGZahdQvhXH05qa0wz7YH
	 o58wN3Eh0hpNhCN2Z1sbNAiCw1jACCYXj7AGZvj4BMuznNInCWYobavy+AAAWT+6aQ
	 ibGO6M9+D/W3Q==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Martin George <marting@netapp.com>
Subject: [PATCH 3/3] nvme: enable retries for authentication commands
Date: Mon, 29 Jan 2024 07:39:48 +0100
Message-Id: <20240129063948.3105-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240129063948.3105-1-hare@kernel.org>
References: <20240129063948.3105-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_224016_111167_EB177517 
X-CRM114-Status: GOOD (  14.75  )
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

From: Hannes Reinecke <hare@suse.de>

Authentication commands might trigger a lengthy computation on the
controller or even a callout to an external entity.
In these cases the controller might return a status without the DNR
bit set, indicating that the command should be retried.
This patch enables retries for authentication commands  by setting
NVME_SUBMIT_RETRY for __nvme_submit_sync_cmd().

Reported-by: Martin George <marting@netapp.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c | 2 +-
 drivers/nvme/host/core.c | 2 ++
 drivers/nvme/host/nvme.h | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index fd026832d285..ce0366f72fc5 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -58,7 +58,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 			    void *data, size_t data_len, bool auth_send)
 {
 	struct nvme_command cmd = {};
-	nvme_submit_flags_t flags = 0;
+	nvme_submit_flags_t flags = NVME_SUBMIT_RETRY;
 	struct request_queue *q = ctrl->fabrics_q;
 	int ret;
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9e140d9d9d48..2acb6e2ff6e3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1068,6 +1068,8 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	nvme_init_request(req, cmd);
+	if (flags & NVME_SUBMIT_RETRY)
+		req->cmd_flags &= ~REQ_FAILFAST_DRIVER;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f842e5e8694d..741377b51b79 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -837,6 +837,8 @@ enum {
 	NVME_SUBMIT_NOWAIT = (__force nvme_submit_flags_t)(1 << 1),
 	/* Set BLK_MQ_REQ_RESERVED when allocating request */
 	NVME_SUBMIT_RESERVED = (__force nvme_submit_flags_t)(1 << 2),
+	/* Retry command when NVME_SC_DNR is not set in the result */
+	NVME_SUBMIT_RETRY = (__force nvme_submit_flags_t)(1 << 3),
 };
 
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-- 
2.35.3


