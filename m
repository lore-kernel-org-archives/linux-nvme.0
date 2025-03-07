Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAB5C28B23
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Mar 2025 13:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wCzYHOyi6iu7wuoChi9/4/zx02wdubmTPa/DGy2mgNA=; b=GUq1kcy3Jw1OmiZsiNlk7Br5yG
	MME1bhL/F5/wSEn9L/KnRufwYCN6E7OVWJCEGWQOj6/W7rB/G5ffmZDYJrod7aRVZYaYGtkb4sgRf
	QbD7OUCPYJ1z0BM/x3SIRBqPCkS/3izrd4eBbvAyhaVLbVDselDGz1uq7zA5Q8qR+HBfEu2s13W1W
	lp0rmigps/OP1GnF+PXxJCr2N6Ghqd5a/sSD3CppVOU8LLoDR07Uy3CHkhWcuosG63uC0hnOu4/eQ
	zFS/f+KVdsn3y0ekAdaseDTMKOpKeOhIV2Kbb9sFhlZa5t+nJtMlS1mtOBAqf57I9K101VwDKlxfC
	ThjI4VPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqXlf-0000000EKe0-1S0v;
	Fri, 07 Mar 2025 13:29:35 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqXkO-0000000EKQ2-1iDT
	for linux-nvme@lists.infradead.org;
	Fri, 07 Mar 2025 13:28:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 06EDCA457BB;
	Fri,  7 Mar 2025 13:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005A6C4CEE8;
	Fri,  7 Mar 2025 13:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741354095;
	bh=+Hpz0Eo+k7Fbvt8KER5CldKZa+0NRfy8mJFRWCznkAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MgpGwAAmPrW9+go4p6JKYMIBTLg01WkBffhVLQX4egFyeXGS/Zav1RBgRL2ntIb4X
	 YsxlvDJcc73pNx7tiTea4T97dLORhB6SNgr7VpeaOS9c5fZpwDQWVMeCQh0b8QMu/A
	 drrPzMD340f9SXAIZ8v2FNrfGKx9ENqUizmp/s2VEty67XQtQ50/K4K7B1AO19FTBD
	 yeltUxTlPRUJ6n7BKzjG5quWgHfMEJLJKtKf8afgjpVCZEnOxujBXG4pf72cnxUvei
	 GYdroaG6tXjhxxoEHCllNNThe3/brLNoRE5UZsqxaMbzf5XEiYelZqlQjFAJdrX0R8
	 9O0Nl8n8bPO2g==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/3] nvme-tcp: sanitize request list handling
Date: Fri,  7 Mar 2025 14:28:01 +0100
Message-Id: <20250307132802.111513-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250307132802.111513-1-hare@kernel.org>
References: <20250307132802.111513-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_052816_531381_786D95D8 
X-CRM114-Status: GOOD (  12.13  )
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
 drivers/nvme/host/tcp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 034edf852878..073c8c3538fd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -441,6 +441,7 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 	}
 
 	list_del(&req->entry);
+	init_llist_node(&req->lentry);
 	return req;
 }
 
@@ -548,6 +549,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	req->queue = queue;
 	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	nvme_req(rq)->cmd = &pdu->cmd;
+	init_llist_node(&req->lentry);
+	INIT_LIST_HEAD(&req->entry);
 
 	return 0;
 }
@@ -759,8 +762,12 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 
 	nvme_tcp_setup_h2c_data_pdu(req);
 
+	WARN_ON(queue->request == req);
+	WARN_ON(llist_on_list(&req->lentry));
+	WARN_ON(!list_empty(&req->entry));
 	llist_add(&req->lentry, &queue->req_list);
-	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	if (list_empty(&queue->send_list))
+		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 
 	return 0;
 }
@@ -2532,6 +2539,8 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	ctrl->async_req.offset = 0;
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
+	init_llist_node(&ctrl->async_req.lentry);
+	INIT_LIST_HEAD(&ctrl->async_req.entry);
 
 	nvme_tcp_queue_request(&ctrl->async_req, true);
 }
-- 
2.35.3


