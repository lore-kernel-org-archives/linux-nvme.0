Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298D0C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 15:07:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAAD664F42
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 15:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAAD664F42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HHVGN6tN2tiweUV5pf1h6LNU1BAXTkrWC/tdFmBomDk=; b=cabJ+8QyugaksV+ENW2TxwCGxr
	7aLmUCkbxca4VfsgaZNR/vlaW521Aolhvp3GbK3uBA66h3QWNSyEPtyU4PnwcuQgaLwbY3Yxl6WYg
	x2yVuxe9y5n+dd3wZIb5vCooy0P54+k/wMiKBtNkdDw5dxjEd6jN9JjtMj57ysBmBobfdqOjCjV4e
	VMRyGf+Ik9zYo8/vedSJVZLjvlxkw7oNDh7pPQT1Br49HBIS+BYsRt80sh2rSQB1tfemrUtqmCPQl
	HMyDz+LwnBNCUC4NRuDBl4y4isrdUNIPHJgdymegr8yHSXeAq9m97kcfjdCkRYKpNQRdeLF4AviHk
	xbKWijtw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7gEU-0007Nd-3v; Thu, 04 Feb 2021 15:07:46 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7gEQ-0007NS-4E
 for linux-nvme@merlin.infradead.org; Thu, 04 Feb 2021 15:07:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=vc7vRliYes5zaCs8iBxhh34R72R5PPnrfftjwCg4twk=; b=YO8d0D4yNDZTcIzkA7+YUMpPaZ
 kBM17bWol6tL2O47zoifb2czaVrFcBQgoF+jVUY33uQDvLkkFRBWqxCKduYfcE5XutLH0Pym1Lvnn
 gWj8qhT/DeurR+anDvhIb+LDGCDxlt4YVjn8RJr5KpHLUFrgyhszM6uPdHiPJMp00IcmljwHT5GNm
 rlfoa8mYygSsIOIsLar9QOU8yVHZhEQksYo2fhA7tA3WQ3vSqhaPYVd22uvWHWruTdPZ2aOz9lVwN
 lYguah0E+IMVFgXADKAX5Qrhs2FTKxVMGr4xLEU8H9y6Ag/iOqrknbFj4QWFSpMdbapKxQazq10sa
 JQCL9jmg==;
Received: from [2001:4bb8:184:7d04:e998:f47:b9fb:7611] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l7gEN-0011WA-HK; Thu, 04 Feb 2021 15:07:39 +0000
Date: Thu, 4 Feb 2021 16:07:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fixes for 5.11
Message-ID: <YBwNukLwQfsXQL9U@infradead.org>
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

The following changes since commit cd92cdb9c8bcfc27a8f28bcbf7c414a0ea79e5ec:

  null_blk: cleanup zoned mode initialization (2021-01-29 07:49:22 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.11

for you to fetch changes up to cb8563f5c735a042ea2dd7df1ad55ae06d63ffeb:

  nvmet-tcp: fix out-of-bounds access when receiving multiple h2cdata PDUs (2021-02-03 16:57:36 +0100)

----------------------------------------------------------------
Claus Stovgaard (1):
      nvme-pci: ignore the subsysem NQN on Phison E16

Keith Busch (1):
      update the email address for Keith Bush

Sagi Grimberg (1):
      nvmet-tcp: fix out-of-bounds access when receiving multiple h2cdata PDUs

Thorsten Leemhuis (1):
      nvme-pci: avoid the deepest sleep state on Kingston A2000 SSDs

 .mailmap                  | 2 ++
 drivers/nvme/host/pci.c   | 4 ++++
 drivers/nvme/target/tcp.c | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
