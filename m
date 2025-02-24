Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A4CC021A6
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 11:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HSgVjV66P5MI4y+TRideCR9wzQSngZ+rXdQjlBKD+N0=; b=Mkg3VNk+VX/+66sADMPYFt+nHQ
	Me9MoXtVVHDGqtIfS4//7hl4J7ge/vNxHLCgyZeg7HCIFsiU3Dw4G/otbNHMPcsonc5O/z3XLTAYr
	GGOfpO7IHE6R+XeZHbGnnX0u8VajRZjqCeeb2iWBNbVxmTW8Oh2g7y4EU3Z8snqlnfS9KwRooVhxn
	fdekLxfIfERxVRauJc8bLYcMI6dMBkuOR+EhlTll1PUy3yITvCAbhMbk5Cu/XE+Xv+x9X9ZaOthQZ
	mPg7pWYjAECW7+YrJrTAzT9Jma02BZTnxTc6ba9u7LqmbSA0QNTO/+p+lh1zg5vQ1y2McSD6X97vB
	E0bxW0aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWjQ-0000000DQOq-2hI8;
	Mon, 24 Feb 2025 11:34:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWVg-0000000DKPa-0R00
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 11:20:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8A8905C690A;
	Mon, 24 Feb 2025 11:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6DCC4CEE8;
	Mon, 24 Feb 2025 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396027;
	bh=WhZhiJFmlviInd25I00iuuq/F/ZpFPymnJWovYMggBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOjvUXUu9ZTIO7G/dgvA0obQaOWwbJ6LbOpub9/LRiTOjZTTPAe2plh/ZS4//HcUr
	 a4cfs9uP4p939slsU863zONMCr/gn7XUB2ZW+kfwLcPU6D3k1ehLzIG5XM6DZK7M8h
	 DAlk2k2bqqIJCS2dDRF/7s8iMarDrnTm5UsIicdVdF/OAFhTMVW8/bC+tqOKPu2me4
	 5TFglBpySyrLcYz8TC3cIcjMYio71PWKWA3sAewhbMgsgNeICwWWLsml+PSYIcZFpC
	 3uQ1165uga8nz8dUB4/CXasdTNqWCRt0zb0vC+TY9o1A47g/091i36P8MvqM8yPJ49
	 zVlgZDfnUqLVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ruozhu Li <david.li@jaguarmicro.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 10/12] nvmet-rdma: recheck queue state is LIVE in state lock in recv done
Date: Mon, 24 Feb 2025 06:19:58 -0500
Message-Id: <20250224112002.2214613-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112002.2214613-1-sashal@kernel.org>
References: <20250224112002.2214613-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.129
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_032028_189725_E6BB5E75 
X-CRM114-Status: GOOD (  11.89  )
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

From: Ruozhu Li <david.li@jaguarmicro.com>

[ Upstream commit 3988ac1c67e6e84d2feb987d7b36d5791174b3da ]

The queue state checking in nvmet_rdma_recv_done is not in queue state
lock.Queue state can transfer to LIVE in cm establish handler between
state checking and state lock here, cause a silent drop of nvme connect
cmd.
Recheck queue state whether in LIVE state in state lock to prevent this
issue.

Signed-off-by: Ruozhu Li <david.li@jaguarmicro.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/rdma.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index a6d55ebb82382..298c46834a539 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -997,6 +997,27 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 	nvmet_req_complete(&cmd->req, status);
 }
 
+static bool nvmet_rdma_recv_not_live(struct nvmet_rdma_queue *queue,
+		struct nvmet_rdma_rsp *rsp)
+{
+	unsigned long flags;
+	bool ret = true;
+
+	spin_lock_irqsave(&queue->state_lock, flags);
+	/*
+	 * recheck queue state is not live to prevent a race condition
+	 * with RDMA_CM_EVENT_ESTABLISHED handler.
+	 */
+	if (queue->state == NVMET_RDMA_Q_LIVE)
+		ret = false;
+	else if (queue->state == NVMET_RDMA_Q_CONNECTING)
+		list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
+	else
+		nvmet_rdma_put_rsp(rsp);
+	spin_unlock_irqrestore(&queue->state_lock, flags);
+	return ret;
+}
+
 static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvmet_rdma_cmd *cmd =
@@ -1038,17 +1059,9 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	rsp->req.port = queue->port;
 	rsp->n_rdma = 0;
 
-	if (unlikely(queue->state != NVMET_RDMA_Q_LIVE)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&queue->state_lock, flags);
-		if (queue->state == NVMET_RDMA_Q_CONNECTING)
-			list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
-		else
-			nvmet_rdma_put_rsp(rsp);
-		spin_unlock_irqrestore(&queue->state_lock, flags);
+	if (unlikely(queue->state != NVMET_RDMA_Q_LIVE) &&
+	    nvmet_rdma_recv_not_live(queue, rsp))
 		return;
-	}
 
 	nvmet_rdma_handle_command(queue, rsp);
 }
-- 
2.39.5


