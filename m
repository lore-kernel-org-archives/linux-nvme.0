Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5CBC3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 07:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k6rfX5xoz/Krm/0Qiz4MzvyqTrd1KUiBnPwf01qXJgA=; b=Uv2kWN/3eNVHlGDkfX2hbIVt7j
	B9cfb2QbqPrGlRvYduttkIpD4PZjzC4o5FODg48VHAtkkC/M87eUfg90qMhPphyPgegqbXwn1h1xF
	5j6O++RIV8WoscNH39utvUvNK/XX1JUZU3lSFhpa3MFXpmjGhXWtt/hS3VGpgBM0sQMLgGqzo0j5Y
	DXbGtgZxfUAE5BiBz3Uph2LVa9ONv2fbWCrfMiQCJMf8g1s08UX/NA4eR6zlsweKavgTDS+Pl4iDD
	lnUjHu/maSRsJe/qMDHznKMMcdjLiNV1BG6901IoSVyCJ9BxhljJzBaa3MLNpEWScDWLyQkNoUtNn
	bmpK0omg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Ea5-0000000810f-3DQl;
	Thu, 03 Apr 2025 07:01:41 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0EUI-00000007zdA-3Mo9
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 06:55:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 22A0D68424;
	Thu,  3 Apr 2025 06:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACEFC4CEE8;
	Thu,  3 Apr 2025 06:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743663341;
	bh=JY2hqLwKFAWaqgIGwVbQ63KHiFU602HpIvQkyIqYJ2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oV87Lf+++xDrJFDoPChjlWcRx4e0nv3HGYNfIieKMgbvoD23VNQwY+zFZLWYA2bJ3
	 4AnaJkSkPI/Tv3s226We8jqeMdy9YihrXxW1vLtDqJM/VWQRuZLVdlP4E3v0K51CaQ
	 KHDdPC5YK/+YOi8WLm8x7EaRu7sKnAi62naXeQNuqTFF9FvYmm1WcMp4eP/8/K+5a9
	 cFO2zW9AeMePvqPGf1UiaNg7QOjkTnZZNwrUId/uHP9Y1sYftN34GOvhBgPvezE2hT
	 I0IWF/O2Q5n6YYxC6WKjzM3Ld77B9Hdfd97zjH1RPFdbPdVHPQ2jhiBOFJeVFH0KsH
	 Sh3fuOLmvL06w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Chris Leech <cleech@redhat.com>
Subject: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Date: Thu,  3 Apr 2025 08:55:22 +0200
Message-Id: <20250403065522.90807-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250403065522.90807-1-hare@kernel.org>
References: <20250403065522.90807-1-hare@kernel.org>
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
 drivers/nvme/host/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1a319cb86453..87f1d7a4ea06 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1389,9 +1389,12 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		result = nvme_tcp_try_recv(queue);
 		if (result > 0)
 			pending = true;
-		else if (unlikely(result < 0))
+		else if (unlikely(result < 0) && result != -EAGAIN)
 			return;
 
+		if (nvme_tcp_queue_has_pending(queue))
+			pending = true;
+
 		if (!pending || !queue->rd_enabled)
 			return;
 
-- 
2.35.3


