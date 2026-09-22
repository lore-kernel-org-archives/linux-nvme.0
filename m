Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F86C982FA
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 13:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PCJLpRfxtct7DbafgSfwq4uII75Mlz+xgFX95QdMSj8=; b=geNBi+sGq82JZRGd1RxrR6jP8N
	XSZR5Y7XM8X3gM1b7VUEaP5wse5kqD/pnrnW2SliKEXnm0INp7kiOwuh95z/wqX8r+qVCK/0FIDXW
	nqs/zF9L2F/fEHtGvq7Vyo/66Q6qOS0ledznQiBdKY70bsZOwurrInmJAJCMMXTFFVUHQLrcnTdNY
	eqs4KuNe+sNv6IT7Hr3luKu654VonH7PXk2HbCREYjCqoO9pGI758B/C1zmQX/Y++Y0IvqMSvq1cH
	haQdoswBpSU7s/+W5pm7KMhpgP71Cj8J55SsMRV8LTPWdjr3GKSfgHgvq0dSnYhu1q7CSNUvKLZ6D
	Lj2Vk33g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90gW-00000005YA1-0ATM;
	Tue, 22 Sep 2026 13:37:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90gU-00000005Y8c-1Ckj
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 13:37:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B63CA60E19;
	Tue, 22 Sep 2026 13:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D941F00898;
	Tue, 22 Sep 2026 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084241;
	bh=PCJLpRfxtct7DbafgSfwq4uII75Mlz+xgFX95QdMSj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHYQDAeaZmEPkGZUIYDYbz8ItZVCEMU1kf5ewfwNr7Pr4kAtXOIY89sTbMDNDKmEs
	 dke1qMWCtITm+rq4aIBUT9OZi7gsQAmUEeCQYjYA8VqcW46LlkagFpSx+3oJKW82T7
	 PvhTSq2So11dmhiNu6bGA+03Dg6TcWfykM/IghSA0qUw+RIy9WXH6QxiONhJ6gOPUL
	 S5nIU/cwaBK13Y24a6LVBGg8xFzzZT3iQBnfj5TtEa60seHq4H6vgsTidLRmUdsEGZ
	 L6Y/WXAek8A++k5uQfo4BKTdxOOUb4HSzWkMDJguYzc82Ms920eDtLAnpijHL9nnAJ
	 tkhfjrkvV8OzA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	Martin Belanger <martin.belanger@dell.com>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/2] nvme-tcp: start error recovery when read_sock fails
Date: Tue, 22 Sep 2026 15:37:07 +0200
Message-ID: <20260922133708.84522-2-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260922133708.84522-1-hare@kernel.org>
References: <20260922133708.84522-1-hare@kernel.org>
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

From: Martin Belanger <martin.belanger@dell.com>

nvme_tcp_recv_skb() disables the queue and starts error recovery on any
errors. But if the transport encounters an error before ->read_sock()
is called (and hence before nvme_tcp_recv_skb() is called) no further
action is taken. This causes nvme_tcp_io_work() to stall until a command
times out.

This patch checks for any error returned from ->read_sock(), and starts
error recovery when the queue is still enabled (ie if nvme_tcp_recv_skb()
has not detected the error).

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7eec983c0ead..2f1ae3968678 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1422,7 +1422,23 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	queue->nr_cqe = 0;
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
 	release_sock(sk);
-	return consumed == -EAGAIN ? 0 : consumed;
+	if (consumed == -EAGAIN)
+		return 0;
+
+	/*
+	 * read_sock() might encounter an error before calling
+	 * nvme_tcp_recv_skb(), so we need to check if we need
+	 * to start error recovery here.
+	 */
+	if (unlikely(consumed < 0 && queue->rd_enabled)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d: receive failed: %d\n",
+			nvme_tcp_queue_id(queue), consumed);
+		queue->rd_enabled = false;
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+	}
+
+	return consumed;
 }
 
 static void nvme_tcp_io_work(struct work_struct *w)
-- 
2.51.0


