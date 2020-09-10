Return-Path: <SRS0=5LEM=CT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D002C433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 10:01:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFB92075A
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 10:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JHyJxshe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oQlY5YWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFB92075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BdPU2uf9iZSaIQUizpRo/dfAZrqLGIF8yTnjeeopf0o=; b=JHyJxsheTbFQ5Ui14JH2PN13YU
	qqmzbfFzLFT2v8DfbU1B4aYAr3BDDBjkPV84WPx3Nb53cgcHpwcTVHz6JtWxnZ96hx0FneD91iN/g
	AGL2VimMxVHMBtl6NzQP2loYQQuCtqWauXmNB7G3OjoVOb+yHl2GYPN8QLLJTtGGSKKSUAMkqPEQy
	V8wkr+WgoHcJrBauYL/vpcGvyv1wTKt//Tj0bBMj6qShe0SYfs0mYdEiaT5xWN9qoyHrTxnGtQD5+
	qJ0V+z5u/1S7XZNq/rwU8gVRcut/aEdVdWUua+gKhik7+Bfi+TWoS5b0Mho8Lvxa+UzQLQBw0VhlX
	aGsHNEoQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGJOf-0006LH-RK; Thu, 10 Sep 2020 10:01:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGJOc-0006J2-SE
 for linux-nvme@merlin.infradead.org; Thu, 10 Sep 2020 10:01:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=VDRch+SAmJbg4l/+gjTOYbzNgIltiodZ/qPkyx3K78k=; b=oQlY5YWwZYcqr5GafZpFn0w2aP
 bvf8uCWy9zB/dgT7Hvo8p3PTY2VZ8SN6OlR8OSEYZmHka9RYotsMPMYnDxecAEkiXTL0oSXsiwUbP
 2whDmvW94K0mceMpLdfFUdF1Zga+cfYQdK4vh7YGl+iURSnsCO5llm535hyVuGhy+PWOvLDmm/1MM
 0F0Cit5zwBhNzUvv/38onTL9mdjKMdakxGBk6UatxiTCq0bPcyFr7HkwEU4tU5e6zMHzKamB2ZAom
 zyPaCpUq/asNmRz8mZIrGAjgoPg4vRzXPdAMjywocOel4tjOf1q5GrleeEsuaN6/2s4KchVicBh+g
 ELAHrlsA==;
Received: from [2001:4bb8:184:af1:d8d0:3027:a666:4c4e] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGJOZ-0006mm-4C; Thu, 10 Sep 2020 10:01:35 +0000
Date: Thu, 10 Sep 2020 12:01:34 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] nvme fixes for 5.9
Message-ID: <20200910100134.GA613851@infradead.org>
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

The following changes since commit 88ce2a530cc9865a894454b2e40eba5957a60e1a:

  block: restore a specific error code in bdev_del_partition (2020-09-08 08:18:24 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.9-2020-09-10

for you to fetch changes up to 73a5379937ec89b91e907bb315e2434ee9696a2c:

  nvme-fabrics: allow to queue requests for live queues (2020-09-09 08:00:50 +0200)

----------------------------------------------------------------
nvme fixes for 5.9

 - cancel async events before freeing them (David Milburn)
 - revert a broken race fix (James Smart)
 - fix command processing during resets (Sagi Grimberg)

----------------------------------------------------------------
David Milburn (3):
      nvme-fc: cancel async events before freeing event struct
      nvme-rdma: cancel async events before freeing event struct
      nvme-tcp: cancel async events before freeing event struct

James Smart (1):
      nvme: Revert: Fix controller creation races with teardown flow

Sagi Grimberg (1):
      nvme-fabrics: allow to queue requests for live queues

 drivers/nvme/host/core.c    |  5 -----
 drivers/nvme/host/fabrics.c | 12 ++++++++----
 drivers/nvme/host/fc.c      |  1 +
 drivers/nvme/host/nvme.h    |  1 -
 drivers/nvme/host/rdma.c    |  1 +
 drivers/nvme/host/tcp.c     |  1 +
 6 files changed, 11 insertions(+), 10 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
