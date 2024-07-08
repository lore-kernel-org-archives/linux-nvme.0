Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B243C3DA45
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 07:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KByJ5y+5nV9+n1XV9Q/N+xRPLpArgQJnMvTfswttdRw=; b=fXqFxTcq4e7XcnssQMwO09uGfn
	T+9cX4/LiVLyj+CkajRDh9hpfTL7aHkrezSXJ8crRmQRpOdVX7+XD+LvKge+gNw4oxf65nvDodSrh
	ClY9/wGkihtCmCz0kKzE2HI3FjFGdmk+jjlz+tT9waIfc7H/t1vysve2Xz7GerMpG6J19Cupz7FYO
	gwBSAX2yTanZscpTpeDmZ9VP+3gbdpq1rv8lwkXrjvsOQWpFIItUns01UAPJ9nyGDKpOmv6IlIHlm
	CTYeV3JUUQiE2UbkQD0TsBWncBchAnWvVfAflfJJbaICZTnXsuJ/bu0wa34fm8QFibqCqe4xLgsd6
	r7Qo1TNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQiW6-00000002z6Q-1kDa;
	Mon, 08 Jul 2024 07:10:30 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQiVy-00000002z4T-0ZLA
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 07:10:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0DD6CCE0A7C;
	Mon,  8 Jul 2024 07:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DEDC116B1;
	Mon,  8 Jul 2024 07:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720422619;
	bh=ncS9j2xtSGs89Ss6UeFv7gXes7BrNhe8Fb9llLLGPu4=;
	h=From:To:Cc:Subject:Date:From;
	b=E0QPRRjAzaDuLL5NW1XCsZNqhkWPRymOXTbQMLD4D99HKu0G1YaC6TF5z7g4YEndE
	 NJA1/8kkR2wGlyQJrKsB32FFa5rqFKF+6Fb6mKtai3BH2EhXPlb7QUb+L4jkJkorJJ
	 fOmeKdufFxGpsIu/jhTt8kPcVoICaYR+y8DjmJ7KwzrOeqc1VaTOfcJ+/m85RKW1j9
	 yGVKKmQQdtOPkdjYmxkdfJYWTEr4ZFz1YURUAlJAK5je3NEjnvM90byFS97C6qlw+w
	 6HDMLdykXdEAqDD47d4vUznDU6LOkS7x/M7iEqruXTT37RPIUqdbS44hHOXJNUH2SQ
	 qN9dbgfEzv7zw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2 0/3] nvme-tcp: improve scalability
Date: Mon,  8 Jul 2024 09:10:10 +0200
Message-Id: <20240708071013.69984-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_001022_704695_D29B65C8 
X-CRM114-Status: UNSURE (   9.36  )
X-CRM114-Notice: Please train this message.
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

Hi all,

for workloads with a lot of controllers we run into workqueue contention,
where the single workqueue is not able to service requests fast enough,
leading to spurious I/O errors and connect resets during high load.
This patchset improves the situation by improve the fairness between
rx and tx scheduling, introducing per-controller workqueues,
and distribute the load accoring to the blk-mq cpu mapping.
With this we reduce the spurious I/O errors and improve the overall
performance for highly contended workloads.

All performance number are derived from the 'tiobench-example.fio'
sample from the fio sources, running on a 96 core machine with one
subsystem and two paths, each path exposing 32 queues.
Backend is nvmet using an Intel DC P3700 NVMe SSD.

Changes to the initial submission:
- Make the changes independent from the 'wq_unbound' parameter
- Drop changes to the workqueue
- Add patch to improve rx/tx fairness

Hannes Reinecke (3):
  nvme-tcp: improve rx/tx fairness
  nvme-tcp: align I/O cpu with blk-mq mapping
  nvme-tcp: per-controller I/O workqueues

 drivers/nvme/host/tcp.c | 135 ++++++++++++++++++++++++++++------------
 1 file changed, 95 insertions(+), 40 deletions(-)

-- 
2.35.3


