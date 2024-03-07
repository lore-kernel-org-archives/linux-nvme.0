Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1172C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 15:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K02DG2I21K2ObYxemDxzBjU+AOxsGZACg52CFCT18Zw=; b=GvWSpo/LXR0Gt7+yY/D6byWYED
	KBp7gXP98hhOWtEIkCSq6y4vy9AUJ5NQ1OzjwLwyAP8hRoXYcQqnZWKIt+GiAEe7KZPMIMFo4yNwv
	+9WNbNCRYWy2BtuPKm5+Z6Uq8TjGV4SqyC9+VLAxC+1tnATo5kOXGad34s9lMTxH+hAGBkBRReBZK
	/ijNDmTtdcqR4E8EUrDAAcgVEWjftzfJOmaOf8i7LqePZ/9uhBfHZJWmFf8xu5lLl1T3IWoXet+rv
	6OLcYaRIMkEWAGlUGR/FkyrAp5GFNRNAks+Sa9TRpPZfgyFLI4QZ3C73DFRL7KAdpH6/aKOSZzPbI
	SYNU6yaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPc-00000005D6n-0X9c;
	Thu, 07 Mar 2024 15:12:00 +0000
Received: from [66.60.99.14] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPa-00000005D6F-388x;
	Thu, 07 Mar 2024 15:11:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: RFC: untangle and fix __blkdev_issue_discard
Date: Thu,  7 Mar 2024 08:11:47 -0700
Message-Id: <20240307151157.466013-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

Hi all,

this tries to address the block for-next oops Chandan reported on XFS.
I can't actually reproduce it unfortunately, but this series should
sort it out by movign the fatal_signal_pending check out of all but
the ioctl path.  The write_zeroes and secure_erase path will need
similar treatment eventually.

Test with blktests and the xfstests discard group for xfs only. Note that
the latter has a pre-existing regression in generic/500 that I'll look
into in a bit.

Diffstat:
 block/blk-lib.c                   |   78 +++++++++++++-------------------------
 block/ioctl.c                     |   13 ++++--
 drivers/md/dm-thin.c              |    5 +-
 drivers/md/md.c                   |    6 +-
 drivers/nvme/target/io-cmd-bdev.c |   16 ++-----
 fs/ext4/mballoc.c                 |   16 ++++---
 fs/f2fs/segment.c                 |   10 ++--
 fs/xfs/xfs_discard.c              |   47 +++++++---------------
 fs/xfs/xfs_discard.h              |    2 
 include/linux/blkdev.h            |    4 -
 10 files changed, 84 insertions(+), 113 deletions(-)

