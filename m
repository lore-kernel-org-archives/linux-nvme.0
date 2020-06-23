Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCADC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 14:55:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C45420723
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 14:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hfQ12YpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C45420723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d85ol/gDWRv7oBWFdKM5Womp39+c6ddJdHhoJBnl/6E=; b=hfQ12YpTEHcs7JCUwuFJ8Lo343
	lGUbCCNFQnPgCZRLh72xPp2tj4xNiWnhH1r5fUlhyV1Rz2frKzYG5IO/xkJ+Z4mbVuwQXIWyX/end
	r3uccMYdo2jTznq2/yQJpnbtETrU9u6fBeied/6PS0RixVU3GuQhJsH4w4hI07Ai9KJR1Kj13JOj2
	x/4X2t0e+Zt0tga4pS/sB1e+5CzGaJELpoyoCYN3VvzH6OJew6dS5QFfPnCBC1JPj4EuBWg7WEfJ/
	Tm37K5mtaoL5/ZZvlL4wm/ekOyKsexsW20/yWa5rppgDLiPq9hBHET4sgWmdFa5S/iW158EZI+C6p
	k51FYd8Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnkKz-00033G-NX; Tue, 23 Jun 2020 14:55:50 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnkKk-0002z3-Ml
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 14:55:36 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com) with SMTP; 23 Jun 2020 17:55:26 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 05NEtP7g026949;
 Tue, 23 Jun 2020 17:55:25 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de
Subject: [PATCH 0/3] NVMe/RDMA patches for 5.8
Date: Tue, 23 Jun 2020 17:55:22 +0300
Message-Id: <20200623145525.1586-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: yaminf@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 shlomin@mellanox.com, jgg@nvidia.com, Max Gurtovoy <maxg@mellanox.com>,
 ogerlitz@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This series include 2 patches from Yamin that were removed from the
merge window since it caused conflicts between RDMA and Block trees.
It uses a shared CQ API that was merged to RDMA core layer to improve
performance and reduce resource allocation.

The last patch is a fix for the RDMA host.

The series applies cleanly on top of Linus master, since I couldn't fetch
nvme-5.8 branch.

Tests were run on top of Linus master + my fix to mlx5 driver:
"RDMA/mlx5: Fix integrity enabled QP creation".

Max Gurtovoy (1):
  nvme-rdma: assign completion vector correctly

Yamin Friedman (2):
  nvme-rdma: use new shared CQ mechanism
  nvmet-rdma: use new shared CQ mechanism

 drivers/nvme/host/rdma.c   | 77 ++++++++++++++++++++++++++++++----------------
 drivers/nvme/target/rdma.c | 14 ++++-----
 2 files changed, 58 insertions(+), 33 deletions(-)

-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
