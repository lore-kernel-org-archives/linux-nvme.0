Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4DDC5AE59
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 06:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VvLwkK4otcguYAXMLUCxXH2qARsJA1yWtcxe/AtPxJM=; b=KUx2NSFhkuszA0bHywBap8e1aa
	5asefA4PXOymlOScnLWR/68FAx2emAow4+7fqd3mQrRgeIrXIqocS2EAW+SgO8hYVFZ8R+A7lYyut
	1upbO76gjwh10waPM+EZUeh8YylaMXD1Z7w+W4P/f/G4x56aL6hwa5QHy53r/pmcIbjLJvTZx/gvY
	k9GYczikcFTV9aTJ8mY5TR3ruFwdSaAKw03U5MAVUjFHFk6bAopeygtcF89ZugTZ66Xwa2ry8Fz2j
	0SYf9PXLZSTbU55go0K/yqzU6FUhIan08i5a9i91vlSeJFXhoNqsWDjVnHm9BMda0iuFMT350N4b2
	I4KR/Rjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKAg8-0000000CMBV-2PiL;
	Wed, 28 May 2025 06:54:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKAXy-0000000CL3P-0SDH
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 06:45:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8DE0B5C4A01;
	Wed, 28 May 2025 06:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BE2C4CEF0;
	Wed, 28 May 2025 06:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748414753;
	bh=hCMo5euR4Bml1DowA0rA+3VnqB6oeuoW8dBMfuYx1qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QIQqYbiLMivQvUIQn9P9mIn9F8CCvA8xdfLqsbxpL6EwdC/GGxf5FVo9TuQx3Bquw
	 zHz8wh8FpD1djBkS6Uqo89fYcTOuOszyi9ZEjCxcs0WaCuettbEIIglM544Ei3o5tF
	 SdKiAwyLnAEZLa8cjv66AIxTz/YThZ0VyR/1ndxATT3ZBJhedst7y9zitZ4xz54KDI
	 Xj0RPtqYtow1ug3/XHHCujAK/g+ye6Vu1uQbCNihSpWMwTPLzsmWmZx+bYA9B8rCpf
	 Wvm0Rah3kEaQy3bskcMeI0kow1bYH21+9FUX+DimPFpWgOBVQ4XjThMINrZK0nsL2B
	 59zjyY/t7yBKg==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Kamaljit Singh <kamaljit.singh1@wdc.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Chris Leech <cleech@redhat.com>
Subject: [PATCH 2/3] nvme-tcp: fix I/O stalls on congested sockets
Date: Wed, 28 May 2025 08:45:34 +0200
Message-Id: <20250528064535.135653-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250528064535.135653-1-hare@kernel.org>
References: <20250528064535.135653-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_234554_190854_6F160061 
X-CRM114-Status: GOOD (  13.71  )
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

When the socket is busy processing nvme_tcp_try_recv() might
return -EAGAIN, but this doesn't automatically imply that
the sending side is blocked, too.
So check if there are pending requests once nvme_tcp_try_recv()
returns -EAGAIN and continue with the sending loop to avoid
I/O stalls.

Acked-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69b89a3c09a1..0e178115dc04 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1361,7 +1361,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	queue->nr_cqe = 0;
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
 	release_sock(sk);
-	return consumed;
+	return consumed == -EAGAIN ? 0 : consumed;
 }
 
 static void nvme_tcp_io_work(struct work_struct *w)
@@ -1389,6 +1389,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		else if (unlikely(result < 0))
 			return;
 
+		/* did we get some space after spending time in recv? */
+		if (nvme_tcp_queue_has_pending(queue) &&
+		    sk_stream_is_writeable(queue->sock->sk))
+			pending = true;
+
 		if (!pending || !queue->rd_enabled)
 			return;
 
-- 
2.35.3


