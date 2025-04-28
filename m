Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF61DC369D3
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 06:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ha2q7ENjcOol2cZ6J28FpewXXQPD2/ri+PDV0U8UBac=; b=cartLAja2LjeYDaaN6RHtaafU8
	JbYv4oanjnxgYE99965x56rsieBfgQ/RLmp0D0KX6YSU1jzMPGSfxXGQ7aWllzYr4b/qKfZnNYLvx
	wKBu+dtHHYwWMVP7fDckOfRfBr0YN64EBI/APQJgmOkHw1zV3Xj5JJFH/jELpQ3oB/pAxjwWoFvAZ
	ir/VwSKlwJ2CK8Sfs0zAFJg/liyguN8TVvi2sXjhakGjPPZ4R+vAA6UqmofA1aqlf3bKOkVahM/75
	/nL/XsT4aZ9LWLiPX9bVW4ReUfTD+mmTou7sS9MW7zwDYsYe+FUZEdDaUkK0y1h4nty5HA/jA8mQ0
	U2OnlI8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9IKQ-000000059MN-191E;
	Mon, 28 Apr 2025 06:50:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9IKP-000000059LS-0zTP
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 06:50:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0E88561156;
	Mon, 28 Apr 2025 06:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32D0C4CEEC;
	Mon, 28 Apr 2025 06:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745823056;
	bh=vDp9/WG8RyahFUQFSOVnfzGiMm8bLCgzRkeyEZE47BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFvtSbcklqI0OvQTuwQubhBcx9bLbiOTXIr4hXI+++nDK7btMQAlB1yWPilnbHcwB
	 fkRkKQtNurxJrfMY3/Gl5vpnOYHWrzmoqEZclhFPkXBEqx0gjq7rwHhhZymMpKI9wi
	 9Lt0d786dWH70KYQzVXGT2j4JzqEsJpsnxroQlv4umw3M0IssTox/98iZMZoCIN73l
	 NQrJfXPbDDFIMu4JYBUr1YeVjcOUyyjwE9MeWcNV9gX10h2zIAL7XI4309IWjN66Z/
	 nHWIJFOPvbRqxGfMQkPnsxRH5taxNbRwpnrLclbYHJlm3t/wzzVytocT2ehVFz50/I
	 T4aqkb0hYLONA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Kamaljit Singh <kamaljit.singh@wdc.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chris Leech <cleech@redhat.com>
Subject: [PATCH 2/2] nvme-tcp: fix I/O stalls on congested sockets
Date: Mon, 28 Apr 2025 08:50:40 +0200
Message-Id: <20250428065040.32663-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250428065040.32663-1-hare@kernel.org>
References: <20250428065040.32663-1-hare@kernel.org>
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
index 10ccd7cf5b8c..5c73af022273 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1363,7 +1363,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	queue->nr_cqe = 0;
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
 	release_sock(sk);
-	return consumed;
+	return consumed == -EAGAIN ? 0 : consumed;
 }
 
 static void nvme_tcp_io_work(struct work_struct *w)
@@ -1391,6 +1391,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
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


