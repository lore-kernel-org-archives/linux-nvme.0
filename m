Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C1EC36010
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Mar 2025 15:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A54hFqG1YHUmRqlcCLeycHpyGbXkmJr5nGxBKw3VGcA=; b=WWLBJmZ1rXPN3nJqM+blArf86y
	5ZEtq679fRybF1SeGxbxqjc9/PYuWwBNBpcWEIhDJ9onx+yBLVy3/1pTZXw7ogD9BicRMuA06OeRt
	bSLtx66NIaFjS8bMYwD67M4p1U2i7uSFSmfoX8xkaoIaAM5FYUXbK3t2zEX8L080TLd4GKEIx957K
	Sp2LMOgxL7ic3SJAPJJ0iaxTsYxKNPywTyUwtF/zaNTNUmavF5z+yG+pUzRob70xFlMgI23DmqLuj
	2UtYPesoqmi4Am8Vrd7h2KNK9NdHBLWPiYLSx+09goVDZNs1pI9uyXvAUcmxwV408m7AiRQgtcIFp
	T/wXQ1Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txpTr-0000000BPMs-2fAJ;
	Thu, 27 Mar 2025 15:49:19 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txpTo-0000000BPKW-0IB0
	for linux-nvme@lists.infradead.org;
	Thu, 27 Mar 2025 15:49:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2BDD6614BC;
	Thu, 27 Mar 2025 15:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A57C4CEDD;
	Thu, 27 Mar 2025 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743090555;
	bh=92qyfWtRFB/r8WaktAhNocZ9xPt+T5UoD9tNlwdqYdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVceB7qPg2ltzxZq3rNiX0/VgJ1JkM1BG895sIdDq9DJPogOUA/yfX6tA7kFJhzgk
	 NjYvvC38Dh3c4U0wrVlN9o1vZ730zrICu9FsKrarZv8BwdX7zBmmX3ZPLb8Q7Jl9Pg
	 KSlcGPb6gcl3AYImzwIK0iBzKzD04ls3NN3WpftvJVI+d3JfjSfhPnDPzqWai5QHzQ
	 e76Tu+vgs180dMsKjVr+2Yh3cAIBvvQPhyIeRLP7zZq4GkCqBiWoOse5sorzYuGsva
	 IVxmSDsAqddMXUWHiZkRzbXrmm1ncOp9WEIhJk1cNKSBo2Y2MJV4fWYL4ehjQ3j5rf
	 TvU3naAXR2wPA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/5] nvme-tcp: sanitize request list handling
Date: Thu, 27 Mar 2025 16:48:51 +0100
Message-Id: <20250327154854.85521-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250327154854.85521-1-hare@kernel.org>
References: <20250327154854.85521-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Validate the request in nvme_tcp_handle_r2t() to ensure it's not
part of any list, otherwise a malicious R2T PDU might inject a
loop in request list processing.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b2f2aef2e2f2..1a319cb86453 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -454,6 +454,7 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 	}
 
 	list_del(&req->entry);
+	init_llist_node(&req->lentry);
 	return req;
 }
 
@@ -561,6 +562,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	req->queue = queue;
 	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	nvme_req(rq)->cmd = &pdu->cmd;
+	init_llist_node(&req->lentry);
+	INIT_LIST_HEAD(&req->entry);
 
 	return 0;
 }
@@ -765,6 +768,15 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
+	if (queue->request == req ||
+	    llist_on_list(&req->lentry) ||
+	    !list_empty(&req->entry)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t while processing request\n",
+			rq->tag);
+		return -EPROTO;
+	}
+
 	req->pdu_len = 0;
 	req->h2cdata_left = r2t_length;
 	req->h2cdata_offset = r2t_offset;
@@ -773,7 +785,8 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	nvme_tcp_setup_h2c_data_pdu(req);
 
 	llist_add(&req->lentry, &queue->req_list);
-	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	if (list_empty(&queue->send_list))
+		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 
 	return 0;
 }
@@ -2558,6 +2571,8 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	ctrl->async_req.offset = 0;
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
+	init_llist_node(&ctrl->async_req.lentry);
+	INIT_LIST_HEAD(&ctrl->async_req.entry);
 
 	nvme_tcp_queue_request(&ctrl->async_req, true);
 }
-- 
2.35.3


