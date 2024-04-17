Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6960C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OonwXfTqbRE5xHs7yCXn8Qw04I3Vx9SubZoYJzxgtBc=; b=NjAQRh8fSb0rmnYHCMQsEF1+tv
	tBdXQzKkuOEt3/17hT4RMuXPwyF6KUXDMH2pBRrgJlj+XHxjtI8JjT2qZPs1eASn6xfxrJdRvbvKQ
	gnKIzhH5pb61pNiezHFIcNd/oNTb4haeV2v9tK3W1BT9Ct1e0EwY1FQYvRncWh7dFIvkhqeCyDBFd
	1BI51XYc37OLZwmta9V64k9cpjV7j46d881M+gaA2OA35vkfweaF8aiSSdXpaTNtL8sm0WCuRdEw6
	Mm5GodVGLdHzO63rait2aM24vIhzNv7W7x8V9npSOlDwLGZZd7ZNjhPfj8Ak3SV4HStzjKsYk/IFu
	wK6bJUpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx7Nq-0000000Ge6I-3Uzs;
	Wed, 17 Apr 2024 15:39:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx7Nk-0000000Ge2d-2ezI
	for linux-nvme@lists.infradead.org;
	Wed, 17 Apr 2024 15:39:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D0BDC615D9;
	Wed, 17 Apr 2024 15:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DB3C072AA;
	Wed, 17 Apr 2024 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713368370;
	bh=b5Q9TMdDtlErN7X56SL+6tJhPMswxyZL+BC7ZS4O/Xs=;
	h=From:To:Cc:Subject:Date:From;
	b=FTOExqTposeFri39qS/raF7ueBu2XhC3Im03/IJ1CyeDlSGs+GK+G7JfycEb8CONm
	 63tOx+EaUOoHTG5CosWVWcjGGs8ATK5Q27C34vKRiTMbTluH6WYd38o97Xh6QYa9Bi
	 DPNDsQkBLAUkRKbQwUD/zICZu1S9cyfVEI+KsEQy9mWOS/Qx97Kr63ZxVAEkX7fbtv
	 QxqjAyhjnUeL8A8630PJCT5VtwrDrvEVG9srXmJVIMzbJyQ8qDGhkvwkYWVx3jgjKx
	 uknLyz+nD+CopTXmjgvkOZqUcSPTNQ39vTwRwy/yGkllD2+emMGapmBBJnWuhZKXfN
	 8OUS9FxXBwWVg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvme-tcp: strict pdu pacing to avoid send stalls on TLS
Date: Wed, 17 Apr 2024 17:39:23 +0200
Message-Id: <20240417153923.100342-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_083932_759092_EF7F60E3 
X-CRM114-Status: GOOD (  14.11  )
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

TLS requires a strict pdu pacing via MSG_EOR to signal the end
of a record and subsequent encryption. If we do not set MSG_EOR
at the end of a sequence the record won't be closed, encryption
doesn't start, and we end up with a send stall as the message
will never be passed on to the TCP layer.
So do not check for the queue status when figuring out whether
MSG_MORE should be set but rather make it dependent on the current
command only.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2b821cbbdf1f..b460ebf72a1a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1049,7 +1049,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		int req_data_sent = req->data_sent;
 		int ret;
 
-		if (last && !queue->data_digest && !nvme_tcp_queue_more(queue))
+		if (last && !queue->data_digest)
 			msg.msg_flags |= MSG_EOR;
 		else
 			msg.msg_flags |= MSG_MORE;
@@ -1105,7 +1105,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	int len = sizeof(*pdu) + hdgst - req->offset;
 	int ret;
 
-	if (inline_data || nvme_tcp_queue_more(queue))
+	if (inline_data)
 		msg.msg_flags |= MSG_MORE;
 	else
 		msg.msg_flags |= MSG_EOR;
@@ -1175,17 +1175,12 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 	size_t offset = req->offset;
 	u32 h2cdata_left = req->h2cdata_left;
 	int ret;
-	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
+	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_EOR };
 	struct kvec iov = {
 		.iov_base = (u8 *)&req->ddgst + req->offset,
 		.iov_len = NVME_TCP_DIGEST_LENGTH - req->offset
 	};
 
-	if (nvme_tcp_queue_more(queue))
-		msg.msg_flags |= MSG_MORE;
-	else
-		msg.msg_flags |= MSG_EOR;
-
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
 	if (unlikely(ret <= 0))
 		return ret;
-- 
2.35.3


