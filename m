Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1828AC369D9
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 06:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wp0WRqeAKKhYtvQSXRuDCAHWP5X3CZtbx2hyLwbSJJQ=; b=ovwi4ME38anAJ1XudUWWI5ZDJV
	0rLBeqgDLFDNvBdGd/r3UxRwAEowxPfcVKswn0OvpWBV5c2AKzAcyADgIuUqrXBIc3V8+egmFFBH8
	QzGYSPJ5vrEBR7t7nwuh4OPRtHySRca5pWMKOpI67PgHck8HAYH4rAkZIzX6gBXrMqjw/RjxsMRFQ
	MaPCtkluS9RxClg/D/OwSgYwASCPw/ow6sBwuqje0B3t9Q+2ttq66HnT2L9zRD2EWCBOlqgqjn6Ja
	HRf/vkybupCqM1D2Z2JMXXcI2c4zjUfmSQk36vNpLKTud/vitXxrETMjMX2k9jDozhV25yK5fsE8r
	jSzagLdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9IKP-000000059Lu-2GT2;
	Mon, 28 Apr 2025 06:50:57 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9IKN-000000059K5-1gok
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 06:50:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C8D64A49CE3;
	Mon, 28 Apr 2025 06:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E357BC4CEEC;
	Mon, 28 Apr 2025 06:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745823054;
	bh=h1hga+uAnYTMxUNYVH06sZMgedRMo7iam/6sEwQCmfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FdbYHx9LyeS8ie7kBjGbzEwUsA0vE+zhPVP0hub0o+Evk79Mg+Iha2XjDa8nvyom0
	 K85NIDf5jvw6wVaQjCCpG0MyFgVa6Gmp7HHePRIt7mBRWpX2FrkYi5/hHUQlPPLb0o
	 Ft/fZ6hJZ/sZB/QU8FoXY7Tmrh3mIrOcYEG86DqyX6JwZ1rSpl5cvtCLNfQYPZxHeB
	 ytWX1NlFcF6DBeClZQsoIURQb6D6oUTnDQWomenRaDzpVJhZmPK18+fZ1XvV9tHhkB
	 gVOJYPleUGlJVrTR2nKo8OgviCl2f68fiSOAg5KIAjQiIkfOkZ2T6q1ya6aAGELGUu
	 YA4N3ouCQ72eQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Kamaljit Singh <kamaljit.singh@wdc.com>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/2] nvme-tcp: sanitize request list handling
Date: Mon, 28 Apr 2025 08:50:39 +0200
Message-Id: <20250428065040.32663-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250428065040.32663-1-hare@kernel.org>
References: <20250428065040.32663-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250427_235055_506392_B30C391D 
X-CRM114-Status: GOOD (  11.11  )
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
 drivers/nvme/host/tcp.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a9d455c39652..10ccd7cf5b8c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -452,7 +452,8 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 			return NULL;
 	}
 
-	list_del(&req->entry);
+	list_del_init(&req->entry);
+	init_llist_node(&req->lentry);
 	return req;
 }
 
@@ -560,6 +561,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	req->queue = queue;
 	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	nvme_req(rq)->cmd = &pdu->cmd;
+	init_llist_node(&req->lentry);
+	INIT_LIST_HEAD(&req->entry);
 
 	return 0;
 }
@@ -764,6 +767,15 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
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
@@ -772,7 +784,8 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	nvme_tcp_setup_h2c_data_pdu(req);
 
 	llist_add(&req->lentry, &queue->req_list);
-	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	if (list_empty(&queue->send_list))
+		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 
 	return 0;
 }
@@ -2611,6 +2624,8 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	ctrl->async_req.offset = 0;
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
+	init_llist_node(&ctrl->async_req.lentry);
+	INIT_LIST_HEAD(&ctrl->async_req.entry);
 
 	nvme_tcp_queue_request(&ctrl->async_req, true);
 }
-- 
2.35.3


