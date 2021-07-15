Return-Path: <SRS0=3azT=MH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C462FC07E96
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 14:13:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6926136E
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 14:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6926136E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YRA08FEsTe4E+oQ4QcjBB9eKAL+XDSObRKFIsl/6OAQ=; b=LGv2M/yXUvHo1t
	gUhezO4rJHI+lWiJoiFZI9gh7vze3N8KouzrBOb2IgCCj1ygQREuCPoLpdW3tVUswWWxBzRmA55qr
	xHhMqVs30zfrEaVezsJEHjUoWor7L1tWIKPB9z8rsYcVwfudl9wVGobFfIVuJvMCPdKT91QQ7Qto8
	c3FoHiGwbLqCN2+3YQebyopJ5DOresOCi86J9C5HOalmnJovTR749106zFOEAH+oTJmG594XGjDru
	MSMdRYSfHWB/q/4Y4y2d0Vw9vTWiMa3GOvbsTA3rELhZs7F75XVdnmxpUSXPG33/sAKd6vv5GuGcc
	V3Wfpnh89+D01byI/AJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m427Q-0012tX-V8; Thu, 15 Jul 2021 14:13:40 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m427P-0012so-78
 for linux-nvme@bombadil.infradead.org; Thu, 15 Jul 2021 14:13:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=d9XYhqbnZzXlls4a/lVNXnEkJpYRRO5mq5R83zsatt8=; b=KIU+fNCxMnISwjv1MjgkeM7oFA
 TDNNhoR7Ou6An7/nSY5ZhiFhB5B9OtctUxI40lKzk+F1NJrucsitbq3GySSjdAGzkaX8iQ1sVCmad
 wLQmzMkbWD8bVv4sp09O/w6YUvT7zIFXaBlaq6HQG2FELUTK755wDV1qANbkjiZCW3cZ4Tc1DpvXc
 Ud9gc36OkW9mlVE2KKM6/jmHg6Ptr/hUezQAGw3STPTip/0YdtLjteTh23HJsVaTgRrf8PAvwptKY
 qalqnD5qrSEsmJVVY+EfoNHatENYrgVrpF+wg+I0iaegm6T7cx6URegG1YWp4oZOddVLAGj5kzrpW
 tdQRQZCQ==;
Received: from [2001:4bb8:184:8b7c:799f:7892:b8a2:a8] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m426g-003QC4-9u; Thu, 15 Jul 2021 14:13:10 +0000
Date: Thu, 15 Jul 2021 16:12:51 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.14
Message-ID: <YPBCY6IjDBwYTceO@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit a731763fc479a9c64456e0643d0ccf64203100c9:

  blk-cgroup: prevent rcu_sched detected stalls warnings while iterating blkgs (2021-07-07 09:36:36 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.14-2021-07-15

for you to fetch changes up to 251ef6f71be2adfd09546a26643426fe62585173:

  nvme-pci: do not call nvme_dev_remove_admin from nvme_remove (2021-07-13 12:03:20 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.14

 - fix various races in nvme-pci when shutting down just after probing
   (Casey Chen)
 - fix a net_device leak in nvme-tcp (Prabhakar Kushwaha)

----------------------------------------------------------------
Casey Chen (2):
      nvme-pci: fix multiple races in nvme_setup_io_queues
      nvme-pci: do not call nvme_dev_remove_admin from nvme_remove

Prabhakar Kushwaha (1):
      nvme-tcp: use __dev_get_by_name instead dev_get_by_name for OPT_HOST_IFACE

 drivers/nvme/host/pci.c | 67 ++++++++++++++++++++++++++++++++++++++++++-------
 drivers/nvme/host/tcp.c |  4 +--
 2 files changed, 59 insertions(+), 12 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
