Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DA0C4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Dec 2022 09:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rH8MM7ztjz32yvM18t1XgQUk0Ikrcd9m0/ls9NFDjpk=; b=Q5e+EzI4GAYKJSwNrf1Z7LJusr
	UtdheuBCD0i0NaPe1wodJnIDdTlYgHZSNeQoISodIEgvDvPkg3oYq9N4rdORYSVLcitDIZnxKzbeN
	Z2Wdd/XGN3RLWTxMkBZiW3rMaX0T/bvT6r8HY/lJGZYvcvuGNxIPTtOpu7VwUNZ+khjdYCaHLb38+
	oTCw7CXjykgtuN8AQieXdSi357SAEJGKXwOOEPHDJaoGFWXd9XD1Vv1wKD+K7aZdIfx+LPcUN6gaS
	LBdURJ6epBdWOJ/xh3Wv1FRT2d4rXEQBCaSeWH9+Jctb4b4n/4zicPVOwEjBUbbNTvOpN4JtEIpAI
	Fm6OXsXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p12SL-00F1Ph-6g; Fri, 02 Dec 2022 09:35:41 +0000
Received: from [2001:4bb8:192:26e7:bcd3:7e81:e7de:56fd] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p12SJ-00F1P3-KY; Fri, 02 Dec 2022 09:35:40 +0000
Date: Fri, 2 Dec 2022 10:35:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.1
Message-ID: <Y4nG6f7QDhcmbldD@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit 7d4a93176e0142ce16d23c849a47d5b00b856296:

  ublk_drv: don't forward io commands in reserve order (2022-11-23 20:36:57 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-01-02

for you to fetch changes up to 899d2a05dc14733cfba6224083c6b0dd5a738590:

  nvme: fix SRCU protection of nvme_ns_head list (2022-11-30 14:37:46 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - fix SRCU protection of nvme_ns_head list (Caleb Sander)
 - clear the prp2 field when not used (Lei Rao)

----------------------------------------------------------------
Caleb Sander (1):
      nvme: fix SRCU protection of nvme_ns_head list

Lei Rao (1):
      nvme-pci: clear the prp2 field when not used

 drivers/nvme/host/core.c      | 2 +-
 drivers/nvme/host/multipath.c | 3 +++
 drivers/nvme/host/pci.c       | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

