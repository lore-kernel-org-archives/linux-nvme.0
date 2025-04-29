Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BA4C3ABA9
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 08:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X57M1LWC2gr1ctDX+GLigE7+LGO+/gJDvHDm3WHaEuw=; b=aU+w4n/6p12bou/eRU4TgCQ8mP
	3+laggM7xecWBuGlthThtNA5bsPw+ZSNQ1+ZPO91zFNqm163BjMFrt1qePlGqcoDXyQI5Zz8ux0tq
	FCQ8cL2dr+gmBfweVv+Pct+W9NFktFoHrRm4SleCeIQmJR3NiUw3A1eo8YzzeRhoCinYs+Nawiifx
	xR/sLohP5zGCeb6eZXCn5ljzoelWES4hqrR2bpK+ZVGJhiFWWOFVqhAd90Io9ZofH4w+bfrORNuFv
	vcoZrhiB3PaTdD/j23NmWA06QEV8u4JHfJXmu9bvhYkQP8c1s3hYFNMx6Eqz77xUAUUhytsxL4cYT
	OUI5ZtRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9gA8-00000008tlS-3jFs;
	Tue, 29 Apr 2025 08:17:56 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9gA7-00000008tji-0Pf3
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 08:17:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 85061A4BF05;
	Tue, 29 Apr 2025 08:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FEEC4CEEA;
	Tue, 29 Apr 2025 08:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745914674;
	bh=edJSsMhUqr4cisTaFnSZ1H0bjTz5DkQL6fFWSMFyh8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohmpvakUpztX5HESh2BE4gKM+/a3CLFqkazhxxMOmkYsQsxkzS34yDn8ZCGjMAsvv
	 BBGsee94EF86TKc7VZSPEc4d8kesD7BH+UuvjTVE77Su/ngPAv1wOq3x+MQyLhM6mX
	 hJ4rSXGM+pPCUubbE+OI/qHObhfVr190gQ4QLDQCC6wSXDiiE+ufTjdaMNeS/PGdlQ
	 3ywmY4qLheb4ybZQwxl3lH37LYVhSVEULWTbv994aJ/LorxztkhX3BW1V0zOTOrh2M
	 +YBqN8/SsbIEe1jjpoycE28nqT2UJQG34AkA7bFgdrAd+3bPFbGpsS8b4p2EDmdLsc
	 aI8d4Si7N3NNw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Chris Leech <cleech@redhat.com>
Subject: [PATCH 2/2] nvme-tcp: fix I/O stalls on congested sockets
Date: Tue, 29 Apr 2025 10:17:39 +0200
Message-Id: <20250429081739.44820-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250429081739.44820-1-hare@kernel.org>
References: <20250429081739.44820-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_011755_205937_664D44D1 
X-CRM114-Status: GOOD (  12.59  )
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
index 1c39a307456c..eb4222c5a77a 100644
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


