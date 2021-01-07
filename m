Return-Path: <SRS0=rRT3=GK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B23C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 17:47:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02AA92076E
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 17:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AA92076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nraLgg8BFDZBmigrXLdckxHbcGmg3q4fCoOvJn3xGE4=; b=Xq1/BxOSGcPl6n4OEiaCCy70Gr
	kUu2jMt0axzioItakLC7il6R+UiL3cHDLncfDm1KsfXa6BGvVHDpCBN3ewrUTc6IkHk/SGjybmNSv
	uFNYg1Wt+29kf/3Fl4iypEI7/ghB9UgpCdlIvzpsJkeB2+FcuHaMuojWdN86vcM/P9Qrl6Ec61AK6
	zA8SWtakWcHv5zcZoXtF9ztVmB2QMa9gzw2kwKFbiCXz0bBowNLO0vItOkzOURbn9hQTNmCSRsKuB
	Ngcbs193nkRDXv0EzB+yrovRiReObb7IwQDy3sZIktplzgECp73EHH5zl5BwRim0BgOqDAlLGOv3w
	A17oWIqg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxZMd-0007tK-AI; Thu, 07 Jan 2021 17:46:23 +0000
Received: from casper.infradead.org ([90.155.50.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxZMb-0007ss-J0
 for linux-nvme@merlin.infradead.org; Thu, 07 Jan 2021 17:46:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=ZjYLRPMvHaT9Jek8mcD0b2kBL6w1IQg5zbFqtKQ8NdQ=; b=vYe0tl/oadyBwcF9GOeXoXFBIP
 xmN7hOZyyOUdfqiC9IbXSvgSdxQ8xNu63QsTwwFNBHZXSbmile/SfgilunIT/FT9jIoaHq1R+UmUg
 fXpT7Iy/6BhaePm1Q68lxn64o0h1fKPh0WsGrcD/RLJ85WumaAIRq4YEzFN+i9UbpEPHb7Rs9ytGG
 alNzO3uKg7WA68AwkUcuzFXmi7XULxdMufBdeaaLl9aDq3N0paypiFZk+pTLXSjGqU+MkVh/wOXfS
 aVtF6GOAkjWkRwKEnDESOm+baQ003321LyqmUNRm7q5xt5JJJyO553oJsUrt7PD8zTVef+tI8AGaN
 k+ShU4HA==;
Received: from 213-225-33-181.nat.highway.a1.net ([213.225.33.181]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1kxZLK-000HxI-LA; Thu, 07 Jan 2021 17:45:27 +0000
Date: Thu, 7 Jan 2021 18:42:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fixes for 5.11
Message-ID: <X/dIG7478C6ahGvo@infradead.org>
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

The following changes since commit aebf5db917055b38f4945ed6d621d9f07a44ff30:

  block: fix use-after-free in disk_part_iter_next (2021-01-05 11:35:17 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.11-2021-01-07

for you to fetch changes up to 2b59787a223b79228fed9ade1bf6936194ddb8cd:

  nvme: remove the unused status argument from nvme_trace_bio_complete (2021-01-06 10:30:37 +0100)

----------------------------------------------------------------
nvme updates for 5.11:

 - fix a race in the nvme-tcp send code (Sagi Grimberg)
 - fix a list corruption in an nvme-rdma error path (Israel Rukshin)
 - avoid a possible double fetch in nvme-pci (Lalithambika Krishnakumar)
 - add the susystem NQN quirk for a Samsung driver (Gopal Tiwari)
 - fix two compiler warnings in nvme-fcloop (James Smart)
 - don't call sleeping functions from irq context in nvme-fc (James Smart)
 - remove an unused argument (Max Gurtovoy)
 - remove unused exports (Minwoo Im)

----------------------------------------------------------------
Gopal Tiwari (1):
      nvme-pci: mark Samsung PM1725a as IGNORE_DEV_SUBNQN

Israel Rukshin (1):
      nvmet-rdma: Fix list_del corruption on queue establishment failure

James Smart (2):
      nvme-fc: avoid calling _nvme_fc_abort_outstanding_ios from interrupt context
      nvme-fcloop: Fix sscanf type and list_first_entry_or_null warnings

Lalithambika Krishnakumar (1):
      nvme: avoid possible double fetch in handling CQE

Max Gurtovoy (1):
      nvme: remove the unused status argument from nvme_trace_bio_complete

Minwoo Im (1):
      nvme: unexport functions with no external caller

Sagi Grimberg (1):
      nvme-tcp: Fix possible race of io_work and direct send

 drivers/nvme/host/core.c     |  8 +++-----
 drivers/nvme/host/fc.c       | 15 ++++++++++++++-
 drivers/nvme/host/nvme.h     |  9 ++-------
 drivers/nvme/host/pci.c      | 10 ++++++----
 drivers/nvme/host/tcp.c      | 12 +++++++++++-
 drivers/nvme/target/fcloop.c |  7 ++++---
 drivers/nvme/target/rdma.c   | 10 ++++++++++
 7 files changed, 50 insertions(+), 21 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
