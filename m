Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6011BC4363A
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 14:10:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E312184D
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 14:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nGDrUuYQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EOUcsIXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E312184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ynYXdwlge63KR/nFqO6dcPUVp4+RSRmpub63SFlVib0=; b=nGDrUuYQRRLQ6xu0YrGqDzyJzX
	tq1HNQwIABCOdfcC6DZsYTGkEZCxf5pRYzaJ8LlkBUocZKSyPBFM8q0O0TEPva2h5wjt1RlIcK0Ol
	8L4JhxiaHkWGCrlaAwjfwj+mN2C3UjiPHbxTTI+Li56zUU1zikk8k4yY7ipBxlXOmxFVVUe5PUgza
	7qJuuWLQVsXzc4oMN6jRt/PimRqBoePA3GaaLvHAdyecd46uqxdmPlPQHmkcDo+JmsaQCCNfYnb+a
	C5hqb/WHGpLFBK7u166ICBz9X5enzZwG3NF6t9CymFjvmbZFY+z5zsxWATepjR5LgrbiSjgJlPMAb
	GixJGBKQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQWd4-0005dW-Ej; Thu, 08 Oct 2020 14:10:46 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQWd2-0005dN-7x
 for linux-nvme@merlin.infradead.org; Thu, 08 Oct 2020 14:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=psVJD4cX5Dld0gcqx4NR9RbkRdJ9SwKhV3v6QRu0tYc=; b=EOUcsIXr+R6N19SiVE3Lp9d+t/
 h+/+U49P2cacq7SvEUGZ865GeriMTXuQ8REbdXNpdy1SRClOoXY6YCG5vLOc69ZXxWBgHLfFf/TSW
 IqUVyCQRQVbSqFiOrBC/Gx8JAeGHZycI/iKp9tBFxk11+G2M10TPUNvuwHJoWJm8WJKj2HGhK+MWc
 NUccOXtp4jfBvZ4MMvMRV5vDaFcB7lYwHpEfFUdYD4EbfB4RJq9iBKyk05Tkobh0c/6IFxCyc+Dsa
 iI/K9AQeT82F7UNb1pQHowz/GcpEv/x1C1z1eXUuOffvsaGnRd+X1FYN35T6CQBmd90RFGLKNw9h7
 A+PXAU+Q==;
Received: from [2001:4bb8:184:92a2:cbfa:206d:64ea:205c] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQWd0-0003Pg-DD; Thu, 08 Oct 2020 14:10:42 +0000
Date: Thu, 8 Oct 2020 16:10:41 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme updates for 5.10
Message-ID: <20201008141041.GA1493538@infradead.org>
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

The following changes since commit 103fbf8e4020845e4fcf63819288cedb092a3c91:

  scsi: megaraid_sas: Added support for shared host tagset for cpuhotplug (2020-10-06 08:33:44 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-08

for you to fetch changes up to c4485252cf36ae62c8bf12c4aede72345cad0d2b:

  nvme-core: remove extra condition for vwc (2020-10-07 07:56:20 +0200)

----------------------------------------------------------------
nvme update for 5.8:

 - fix a controller refcount leak on init failure (Chaitanya Kulkarni)
 - misc cleanups (Chaitanya Kulkarni)
 - major refactoring of the scanning code (me)

----------------------------------------------------------------
Chaitanya Kulkarni (3):
      nvme-loop: don't put ctrl on nvme_init_ctrl error
      nvme-core: remove extra variable
      nvme-core: remove extra condition for vwc

Christoph Hellwig (20):
      block: optimize blk_queue_zoned_model for !CONFIG_BLK_DEV_ZONED
      nvme: fix initialization of the zone bitmaps
      nvme: remove the disk argument to nvme_update_zone_info
      nvme: rename nvme_validate_ns to nvme_validate_or_alloc_ns
      nvme: rename _nvme_revalidate_disk
      nvme: rename __nvme_revalidate_disk
      nvme: lift the check for an unallocated namespace into nvme_identify_ns
      nvme: call nvme_identify_ns as the first thing in nvme_alloc_ns_block
      nvme: factor out a nvme_configure_metadata helper
      nvme: freeze the queue over ->lba_shift updates
      nvme: clean up the check for too large logic block sizes
      nvme: remove the 0 lba_shift check in nvme_update_ns_info
      nvme: set the queue limits in nvme_update_ns_info
      nvme: update the known admin effects
      nvme: remove nvme_update_formats
      nvme: revalidate zone bitmaps in nvme_update_ns_info
      nvme: query namespace identifiers before adding the namespace
      nvme: move nvme_validate_ns
      nvme: refactor nvme_validate_ns
      nvme: remove nvme_identify_ns_list

 drivers/nvme/host/core.c   | 455 ++++++++++++++++++++-------------------------
 drivers/nvme/host/nvme.h   |   9 +-
 drivers/nvme/host/zns.c    |  16 +-
 drivers/nvme/target/loop.c |   4 +-
 include/linux/blkdev.h     |   4 +-
 5 files changed, 220 insertions(+), 268 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
