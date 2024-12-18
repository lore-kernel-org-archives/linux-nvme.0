Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B568E77187
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 02:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3kstiw8DGy+LZqa+lbGlsyzzHfy0quVH0jm/EBxZMLU=; b=v6GE3SPCNVTBE1lp70StimCz2e
	5AasdwzikINDi8Xm3NwDMrfJ1Y9uI3C70cnO1OCTcOXMhd3YSKCHqtghcr/a3z5y4UtTBXd4RjPEW
	mlAXHP5mx8Z5wNDyz0SR7p2Qk5CWVIjjWe/Fmgu3rK/GdDpNJnusynD+g/RRx2OS9XWfJYqf40h9f
	V21FaVaou6pCtRvazxmg6xqBBdYYOcIEkF6vO1AfMeQi95/6iZNLFepuQwz5C02UbhkNHWFYP15m1
	X/h6zKOIy8OZIWFT7tA60LhSdSDXUduDgn74hJtltcrT/A/y0Doq/IEl28ixtWAv6hm1jqQE9/H0Z
	1KgCzTiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjOD-0000000FLP0-3wjd;
	Wed, 18 Dec 2024 02:02:17 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjO9-0000000FLOF-1AAW;
	Wed, 18 Dec 2024 02:02:13 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk,
	hch@lst.de,
	hare@suse.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH 0/2] block size limit cleanups
Date: Tue, 17 Dec 2024 18:02:10 -0800
Message-ID: <20241218020212.3657139-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This spins off two change which introduces no functional changes from the
bs > ps block device patch series [0]. These are just cleanups.

[0] https://lkml.kernel.org/r/20241214031050.1337920-1-mcgrof@kernel.org

Luis Chamberlain (2):
  block/bdev: use helper for max block size check
  nvme: use blk_validate_block_size() for max LBA check

 block/bdev.c             | 3 +--
 drivers/nvme/host/core.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.43.0


