Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8EBC433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 14:31:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13194613BC
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 14:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13194613BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ppMC3DE3o/ebCXvi/AgRIdK7hTKdHqTiMZmac9FtisE=; b=T+7GIWIfcYrGneq+KZpbpFha14
	qnLmrQgaoOXQvNqRTdlFnoavO4kQQpR7RdBCxG40GFs9SiJuJIzBCVUAt1mS6t4pQVAyavofn0ceS
	HNjJsLNLHtylsx1bNbZxHuRnvPlEIfx6QK2MLJfumz63rkV0nl1oUFj2uDdGeXQ2uK83/IfcTMLMq
	iVo7VuM/g+9aSngGTllSN/haM2L3tljF5h92jXbfRvLlszi0580WmGju0eie670UHXpR/C8b5JmOb
	8DvHJFpxP9kAS0NIgN5ZRFHQ5qGvNeBSATrkPkgXXPrG53FOo7H/g75lUWdwZI5n1HEJiKzgn+WGg
	0CWNTrFQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leIXx-001RCG-Ef; Wed, 05 May 2021 14:30:41 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leIXs-001RBW-Uz
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 14:30:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=3GseHQCOIbUNnOllumCqVN6wzm81HRtZY3U8DLA8vK8=; b=0q3ayFBPZRmm5iiVN6hai3Y7eX
 H/tfUGyEXJ52CtHw7EEUYpLPlYZdMDbU+7v+lp8Z3Ia04SPr213t/Idc/G9c9HJgATeLoTOa6nBkm
 YmEoK01qUBJF4V0jvE7BsGVffqW8Lvi2aQKDjEGaierW4E9nStpjtmVH3Zqpf7/eo5z3SUkNfNeHe
 7PhMPRFTScxlFqWvXOXZrHGWI5R/K8wr4IgxWk9sKqvKjmb21O9pfBJQV22zW2bCcPFHvAvhuIvYY
 mDjpHLdqxGXVnhJ9r7bn/TEbO6HmTO0Ka6NTtMr/CGToFVnN0zIyR5d+v/GYvTTRgmsnHVWY8Jmew
 WIAIUVhQ==;
Received: from [2001:4bb8:180:9479:fe4f:f2b:7c56:307a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1leIXr-004pM9-0Z; Wed, 05 May 2021 14:30:35 +0000
Date: Wed, 5 May 2021 16:30:32 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.13
Message-ID: <YJKsCBgfk5vjsUiQ@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

The following changes since commit cd2c7545ae1beac3b6aae033c7f31193b3255946:

  bio: limit bio max size (2021-05-03 11:00:11 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.13-2021-05-05

for you to fetch changes up to 4a20342572f66c5b20a1ee680f5ac0a13703748f:

  nvmet: remove unsupported command noise (2021-05-04 09:39:26 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.13

 - reset the bdev to ns head when failover (Daniel Wagner)
 - remove unsupported command noise (Keith Busch)
 - misc passthrough improvements (Kanchan Joshi)
 - fix controller ioctl through ns_head (Minwoo Im)
 - fix controller timeouts during reset (Tao Chiu)

----------------------------------------------------------------
Daniel Wagner (1):
      nvme-multipath: reset bdev to ns head when failover

Kanchan Joshi (2):
      nvme: add nvme_get_ns helper
      nvme: avoid memset for passthrough requests

Keith Busch (1):
      nvmet: remove unsupported command noise

Minwoo Im (1):
      nvme: fix controller ioctl through ns_head

Tao Chiu (2):
      nvme: move the fabrics queue ready check routines to core
      nvme-pci: fix controller reset hang when racing with nvme_timeout

 drivers/nvme/host/core.c        | 98 +++++++++++++++++++++++++++++------------
 drivers/nvme/host/fabrics.c     | 57 ------------------------
 drivers/nvme/host/fabrics.h     | 13 ------
 drivers/nvme/host/fc.c          |  4 +-
 drivers/nvme/host/ioctl.c       | 65 +++++++++++++++++----------
 drivers/nvme/host/multipath.c   |  3 ++
 drivers/nvme/host/nvme.h        | 16 ++++++-
 drivers/nvme/host/pci.c         |  3 ++
 drivers/nvme/host/rdma.c        |  4 +-
 drivers/nvme/host/tcp.c         |  4 +-
 drivers/nvme/target/admin-cmd.c |  6 +--
 drivers/nvme/target/loop.c      |  4 +-
 12 files changed, 143 insertions(+), 134 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
