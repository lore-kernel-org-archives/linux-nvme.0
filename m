Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B5AC5B553
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 06:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UB8vxMQZ9JOTMg7vL9dybBf3+tclfGWx+Z6WQ809gyQ=; b=hJB1y3AJ8Peif7A+H8oG4vv+nh
	O39QgFo+Rjj5jAL0uLP8gKAwhMzvRIa0U/g190ZdL8M5X4ElMzg0CR9GqasKSoVaOg4tJAbQX3rut
	iznVS9DPVal4erk96JdTCc5g/Mq6Vi68IMdigM2o++COglxLY/Ppj15SBuN3SrW1UTnlTXt92B2D0
	DvVLG8WcUob3l+/KLJPNFuWeexy6zz3yEuLLsTuSy+HLgUrdRFIHXyGkihcbqo0JZT3zE0v+V+Vps
	+IXlFulLG/0GnvZ6YdD2LrLbEqy7c7kBAiUC+DKfYBnOSL9ybYMs/k/RLf48b6yO6P1v/+5OdbnwE
	rPLakiTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKAg9-0000000CMCQ-1dBP;
	Wed, 28 May 2025 06:54:21 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKAY0-0000000CL4h-138T
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 06:45:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7B3B9A4EE75;
	Wed, 28 May 2025 06:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD361C4CEE7;
	Wed, 28 May 2025 06:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748414755;
	bh=Fx+mEzm8btbf+fcfJeqVKnBsMOt9RViEog7SkzNshzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gqBqQUfI1oP4495BLK8SUzhDyACAXF4s4FxW2ZM27tGbBY0xbLwdkgSOkgH0Fl9JZ
	 DYj+Kb8fXqYYBMmVz5Nb0ozvL6cLZy/lFRL7qRoOqwzulfBbxcfzVXM47QjXkwSzzO
	 hpO3s3iGQtY9F6crpVdkzzNLx3cXQZOag8HVuoY6r9lSe6GmMKvohXojTyPlQuNg0/
	 +ehj2XJt6Shv+RkChCSBKFL2PQsY1xxFLa4gFaob0vxVy858wrAg/WXoBkVikjpsyj
	 X4xHuvNNlqUjNx4Niq5Lr1CeesPemmMTXNz8QbEvE8amo/NjdWwL4cnlelT4i/LlV1
	 M+cONIXI/Nygg==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Kamaljit Singh <kamaljit.singh1@wdc.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/3] nvme-tcp: do not queue io_work on a full socket
Date: Wed, 28 May 2025 08:45:35 +0200
Message-Id: <20250528064535.135653-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250528064535.135653-1-hare@kernel.org>
References: <20250528064535.135653-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_234556_365990_68968CBE 
X-CRM114-Status: GOOD (  16.41  )
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

There really is no point in scheduling io_work from ->queue_rq()
if the socket is full; we'll be notified by the ->write_space()
callback once space on the socket becomes available.
Consequently we also need to remove the check for 'sk_stream_is_writeable()'
in the ->write_space() callback as we need to schedule io_work
to receive packets even if the sending side is blocked.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0e178115dc04..e4dd1620dc28 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -411,6 +411,9 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	empty = llist_add(&req->lentry, &queue->req_list) &&
 		list_empty(&queue->send_list) && !queue->request;
 
+	if (!sk_stream_is_writeable(queue->sock->sk))
+		empty = false;
+
 	/*
 	 * if we're the first on the send_list and we can try to send
 	 * directly, otherwise queue io_work. Also, only do that if we
@@ -422,7 +425,8 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		mutex_unlock(&queue->send_mutex);
 	}
 
-	if (last && nvme_tcp_queue_has_pending(queue))
+	if (last && nvme_tcp_queue_has_pending(queue) &&
+	    sk_stream_is_writeable(queue->sock->sk))
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 }
 
@@ -1074,7 +1078,7 @@ static void nvme_tcp_write_space(struct sock *sk)
 
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
-	if (likely(queue && sk_stream_is_writeable(sk))) {
+	if (likely(queue)) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 	}
-- 
2.35.3


