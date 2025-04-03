Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D56C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 14:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gSE7GJVWf4cmSbl79yMqGrCNx4UrLb338sPwPp92sPs=; b=FqLDYN1hJ5x4PTj9scOlN6kpDk
	bBbSZEn/DXA1mzHrvYLHhkGplyT1KErw1pWJijGNxMpYjxBmfg+x0v4J0IUyyY5Olj/3HCBTeZ8UD
	ML/PaRdJb9efgaqAW2mAkUYk6UnHVARjRDrYxy4Uc+uBY4zrfK5xATB4W+SpNSVo5ktlRJmdbw/4m
	bFvp8jf0bSU+31Q409WgH/ay0q6wf8CJ6GN7xfReigK346TC4MIW6FfeXkCpF2hA1pesoSe+1eS/D
	JaNuuoEB3AMLvrxy88b7Agh4ZeEdslMCHv1KMPS+F/vr12U1ra3mYstjOwRX3W07O9DV/IYK62vXM
	nTbrH5hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0LrH-000000097n5-0WJQ;
	Thu, 03 Apr 2025 14:47:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0LrE-000000097m2-1Mub
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 14:47:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 350E04423C;
	Thu,  3 Apr 2025 14:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56312C4CEE5;
	Thu,  3 Apr 2025 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743691671;
	bh=7ufmNtAuRnokjX1rMEKEkGDWvQ2XVI6ThbHz/lIR2Eg=;
	h=From:To:Cc:Subject:Date:From;
	b=o3CeJY/4wIBde6/shSz9QqXwLZNeGvMWt4auNAP6I9RAPSc17qoeLD8BxgAllxTpM
	 5YRCdfzPoata4Q8sGJE679BeYJZZ5YuufsxLZBPIAFyrtLsD9k6Xq+Iy4dUKcZPcD2
	 xzm40dG1sbJa3MjDod12R9jaX5k6kdLock8u7GZoKJ5NV2gdfjpODKqXZCpTSqKCJP
	 UMly0bvjHHzIyjq+GYohylX1+w+84bU0yPfHEVRz7iPpXMUjs7iKDx+HwW2TZle2/t
	 mXMjE1qCyWppMss5vxUeu2B4CyjWRpK3S7dHbR2g9c+Kvgg1j3vlBtR8I3zImBH6C4
	 GDvCNlBt+ZVKA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 0/2] nvmet: improve 'read-only' handling
Date: Thu,  3 Apr 2025 16:47:45 +0200
Message-Id: <20250403144747.43043-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_074752_422586_EDBED3C3 
X-CRM114-Status: UNSURE (   8.17  )
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

there was a request (Hi Lennart) to implement 'readonly' handling
for nvme target. Turns out to be relatively easy as we already have
a 'readonly' flag for the namespace.
So all what's left is to make this flag settable via a new configfs
attribute. And while at it we can as well check if the underlying
device/file is read-only, and implement a 'persistent_ro' flag to
mark them as persistently read-only.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  nvmet: make 'readonly' setting configurable
  nvmet: implement persistent read-only namespace feature

 drivers/nvme/target/admin-cmd.c   | 15 +++++++++++----
 drivers/nvme/target/configfs.c    | 32 +++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        |  2 ++
 drivers/nvme/target/io-cmd-bdev.c | 11 +++++++++++
 drivers/nvme/target/io-cmd-file.c | 21 ++++++++++++++++----
 drivers/nvme/target/nvmet.h       |  1 +
 6 files changed, 74 insertions(+), 8 deletions(-)

-- 
2.35.3


