Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4F4C3601E
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 07:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A54hFqG1YHUmRqlcCLeycHpyGbXkmJr5nGxBKw3VGcA=; b=YgtoWloSbN3uf1yIrRhlW3VaUo
	4Q9mzXgd0K552gaGOPedvKgDYWrZ9BIiy20In3qhMFty6nEmmZOh+H8iVTAAg/MdvUFeQD4rc9HkA
	YFVYcVwZcj3hwoNyQDcfSkC5o8jj5Sc5KOTuJ5VlvJELsEJwjWFUwjTWaZfRXVky2pIw7XqeivcXi
	JNJMgN6RAITcMY+gUIe3p/yCrnfdFKTMTaPYVcJ2E1NPaaRtrSm+Xyo+w90T7Z44TT+EggdFtnRE7
	UyTT4HFR2ZBnZIop42qhhFwe8Een7WphN6ZeyW+a6GH+Z0VZpcx351iEAZpFy4GagMAAp9KV4Em16
	L2I/zCyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Ea5-00000008109-0RuZ;
	Thu, 03 Apr 2025 07:01:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0EUG-00000007zce-2Kll
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 06:55:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 811524379D;
	Thu,  3 Apr 2025 06:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E70C4CEE8;
	Thu,  3 Apr 2025 06:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743663339;
	bh=92qyfWtRFB/r8WaktAhNocZ9xPt+T5UoD9tNlwdqYdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hq+H2V6U1JIq/4WYb/ISiXVjrdMqITCPsj2xAEazTU0VJarxDtURzI9adTyxXHqNQ
	 Mv3QXBFlQs0NdRgU49BFE/TMNvvj5pwTI+DAtLjvuxbJT7Ic2hmOGCtylX+Tk4DyxI
	 J3SpNehrdyTI2p2xPil0/MD+AxuOlLhq7sPgkHgfmka7QPVlJRqYr5vXdD6+dRoF+F
	 TCBGc+7Vgd2ZopVLGiAnyVOBpLMUMaWsUr1dctza+UcqVd/Pt7dG+RpUkw0IoH8Mkp
	 gCQd+/4xkZ7tpprWZB9MdbPv6b7YAuDwyj74PozFeTeO52i59zcJezfKoJuZOu2hLF
	 LM0c0dMy3GgRQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/3] nvme-tcp: sanitize request list handling
Date: Thu,  3 Apr 2025 08:55:21 +0200
Message-Id: <20250403065522.90807-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250403065522.90807-1-hare@kernel.org>
References: <20250403065522.90807-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_235540_631154_DFF70954 
X-CRM114-Status: GOOD (  11.53  )
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


