Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5749C47082
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 07:05:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497B9613DE
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 07:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497B9613DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Kz0pwIgSh0yHmh7pkf5+h6ux+Isg12j9QKlbXt6B8Hg=; b=TGq1I5i0epHS02
	GbcOXBmMnXXwNpJ/aiEmlux1M7alEdjhVODFy13WR220htkUxo5q/zn3qAGrvsNWsfYk0vuZ+tSxz
	Z7AVie39/BdCXhjq0iQUfMD302OYAAIr6+/TujJooo/oLAzzb+qp/V3qb8bchDX0NQ9YKNnfXZXHc
	uSlFHKE4QnlJHmlZS3Z5YxCvW/hVNzyKB6VX2cxV8AQl7XqHmt5OUQ7Ub7Le7E54qDpdppBkxMY+q
	DSQqWWW7rT0xrBTGC4aFOnxXaItDEu4xKkff2skDgIQ2zEjQ1DwH4UrkkojqH3vQv0yWF8xr+Hroo
	wcqqwy+8MPyaf+XbYB9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lohPx-007Ome-0r; Thu, 03 Jun 2021 07:05:25 +0000
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lohPs-007OWW-2k; Thu, 03 Jun 2021 07:05:20 +0000
Date: Thu, 3 Jun 2021 10:05:15 +0300
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.13
Message-ID: <YLh/K7UbJFnA2HPa@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
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

The following changes since commit a4b58f1721eb4d7d27e0fdcaba60d204248dcd25:

  Merge tag 'nvme-5.13-2021-05-27' of git://git.infradead.org/nvme into block-5.13 (2021-05-27 07:38:12 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.13-2021-06-03

for you to fetch changes up to bcd9a0797d73eeff659582f23277e7ab6e5f18f3:

  nvmet: fix freeing unallocated p2pmem (2021-06-02 10:10:38 +0300)

----------------------------------------------------------------
nvme fixes for Linux 5.13:

 - fix corruption in RDMA in-capsule SGLs (Sagi Grimberg)
 - nvme-loop reset fixes (Hannes Reinecke)
 - nvmet fix for freeing unallocated p2pmem (Max Gurtovoy)

----------------------------------------------------------------
Hannes Reinecke (4):
      nvme-loop: reset queue count to 1 in nvme_loop_destroy_io_queues()
      nvme-loop: clear NVME_LOOP_Q_LIVE when nvme_loop_configure_admin_queue() fails
      nvme-loop: check for NVME_LOOP_Q_LIVE in nvme_loop_destroy_admin_queue()
      nvme-loop: do not warn for deleted controllers during reset

Max Gurtovoy (1):
      nvmet: fix freeing unallocated p2pmem

Sagi Grimberg (1):
      nvme-rdma: fix in-casule data send for chained sgls

 drivers/nvme/host/rdma.c   |  5 +++--
 drivers/nvme/target/core.c | 33 ++++++++++++++++-----------------
 drivers/nvme/target/loop.c | 11 ++++++++---
 3 files changed, 27 insertions(+), 22 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
