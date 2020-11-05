Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF8FC00A89
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 07:58:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C1C2071A
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 07:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cW+i2miO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LPb9G5ww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C1C2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Aqwsia79XLZMPDzi+NEGkCedSVxkEZwk0SYeCOjHdIE=; b=cW+i2miOV6UK2SalMtfUSRBHwI
	aKu0yncOCEwOFAbYq8OFPOGQJpg19Ns00rMweRK4ezbtORZbFZ+J31PGKfWZ59JCJEaDJ3qh6zB+u
	rUtFO58isuSv6cK5zW5cydt6Yp9qyORNHZvn6DGD++PcqrYioco+3gVMiAOWtKnaoiaU9JmT3smpF
	qXREGYqmUtmJbScX0Wd8sm611aRqxoWkRuwPSvqIeiwlJIaOw3DH3Ot4lPvLDiy6gaxW9UumATbgJ
	HO89eNVagsbNukM3GVraPEXBNkr3htUu5jpXEi2+w9WEFI0ML6p6o3Ur9ivdm5A1sspaurtW62x8/
	A/up4zGA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaa9z-0007Ng-HI; Thu, 05 Nov 2020 07:58:19 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaa9w-0007NI-R3
 for linux-nvme@merlin.infradead.org; Thu, 05 Nov 2020 07:58:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=yAaWE6YiBPWxpGMIEhFoF9waXKR3XlNbXx2sWm1BO3Y=; b=LPb9G5wwPQtAT9kuIU5aDlWWlY
 mNSwPGlKpTRw5odKEWu0Riz7GiyWCpwyLzhcCqBBu5qHPW7TBZQqb8f0ZRWi9EpsMIODHyetrO2k+
 AVJtIjIAsaHKvTN1+NQ6cusYqxTbMJCx3oyFHQj72d0U9BaJFxiWHomGVD0RmZ/DfgdtXbGlsDI2L
 LUBwe9E9SBC28oEH+FPuwIIkwOwgPpCqSMn4oWm5jgYwDYq6oTSgFqFcIYzsyv0FpRIlFQekrnJct
 L2kSAiaP6ojaZpN/bKwdFZ2n/c5fo1cSuvEVqslZT2u3JLyf0Ug98Sr5BaHGc8v4KpFyacym5m6F9
 kWP2ZmxA==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaa9v-0005Mi-0B; Thu, 05 Nov 2020 07:58:15 +0000
Date: Thu, 5 Nov 2020 08:56:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fixes for 5.10
Message-ID: <20201105075604.GA1690984@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit 65ff5cd04551daf2c11c7928e48fc3483391c900:

  blk-mq: mark flush request as IDLE in flush_end_io() (2020-10-30 08:33:49 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.10-2020-11-05

for you to fetch changes up to 0a8a2c85b83589a5c10bc5564b796836bf4b4984:

  nvme-tcp: avoid repeated request completion (2020-11-03 10:26:02 +0100)

----------------------------------------------------------------
nvme fixes for 5.10:

 - revert a nvme_queue size optimization (Keith Bush)
 - fabrics timeout races fixes (Chao Leng and Sagi Grimberg)

----------------------------------------------------------------
Chao Leng (3):
      nvme: introduce nvme_sync_io_queues
      nvme-rdma: avoid race between time out and tear down
      nvme-tcp: avoid race between time out and tear down

Keith Busch (1):
      Revert "nvme-pci: remove last_sq_tail"

Sagi Grimberg (2):
      nvme-rdma: avoid repeated request completion
      nvme-tcp: avoid repeated request completion

 drivers/nvme/host/core.c |  8 ++++++--
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 23 +++++++++++++++++++----
 drivers/nvme/host/rdma.c | 14 +++-----------
 drivers/nvme/host/tcp.c  | 16 ++++------------
 5 files changed, 33 insertions(+), 29 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
