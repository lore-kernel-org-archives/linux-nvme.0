Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01F9C021B5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 11:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W04sOKSB4tfbwH23Lt9NXJT3GSaiLvNywtnxHWMIFY4=; b=gybgAoXxJ4e67XRAbSoq6uraxY
	YLxKbvlk/pyPxtrQjuzY4cEMmEEC6RB4BAMo+4SwUpx2QX7bH3nKZGp3aCLVyvMp+yrXN73BSsV4X
	pqlG1rldL3A2dkWBGfj0xEFljnt/OgVQYH2Ekmvlcf1Kyrxjz/k6l6fN8Y+On8MGzNYTfU+SA7vON
	jtQCWkK8Gm0oQCOdtoAv7u4z57B3Y0bvRMHIdqSkwJwwpKoyYkvJ7tZ3HH79DLl4RvXkRdmzD3svn
	4WTKsL/dd5W9M+FGGo7g2qNqBj4/YUfcWkARG2+FJGmqBHOiaRiSuei7Fd3GehJzYAqQtbLD0adzB
	8nDD5I2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWjp-0000000DQi7-2yiI;
	Mon, 24 Feb 2025 11:35:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWWL-0000000DKjN-38T8
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 11:21:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2EF985C6BC7;
	Mon, 24 Feb 2025 11:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB76BC4CEE9;
	Mon, 24 Feb 2025 11:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396068;
	bh=/E2QqV7A3vjV6X81vD4GzrcUSl4Kz6h5Z2XtJ3vL/GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwJgc76KKjFBLpAICJkRBeGRyChCQOSvE2iw0og6FZy4FkABzuiKHNriR82E11Nv0
	 jxa2JAoykSDK3WhYXkJvzSdzGv1zWHupIZ27G8yn2IlONqU5o3d7AXqeIqWbGTRanl
	 JKD6+dKbLfO0ck3alCj3Uiw0FkR6iaQa/SaFbaeVY0UqBQLoXeu3UJJxSA9PBwh4Km
	 JFXo16TkXc1t5T01TYwUVDJr8U69Pz6nmzeSKqfcpI9MhG5k/LmoQaVqAjxEHxVYKy
	 NntrI2FRKZCzYcIJHth3l2QqhfNkDP15ZJ5NLG/nPqpBg3ja59za4FcfBFbPFtCxpF
	 G8TFbJzbPpk8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ruozhu Li <david.li@jaguarmicro.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 5/7] nvmet-rdma: recheck queue state is LIVE in state lock in recv done
Date: Mon, 24 Feb 2025 06:20:48 -0500
Message-Id: <20250224112051.2215017-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112051.2215017-1-sashal@kernel.org>
References: <20250224112051.2215017-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_032109_840583_B8CD8A54 
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
index 944e8a2766630..503e1f59013c9 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -996,6 +996,27 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
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
@@ -1037,17 +1058,9 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
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


