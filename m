Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB72C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 04:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tyZKBZElFW6HvHSlv9xeAjIG3dO7xKdX7mIPZUu3++o=; b=tusIWUNA67OW2KNln3mIKbt970
	eFRRJPlAX8t7O2RkxphZ+hJTS76Rq0vJf8ASVSmJoqV7YBEVyngCKnMe55uCe8MGN3Ha4DwLF3JAQ
	RPrG+oBZNbibzFQorvN+rqWiENmli60RF637Dw6EcWuNtt1QW8SezUtfOp8eD/J7wsny8ulmOkex5
	lBnvwB0lNt3S7AnibLDX/g0MZjdrJyQ6Pb5IqqG808Le2ZFJL8n8tWyhRw5Xqtnc/RM+gWnIobdB7
	f5+HnWwe+lnitvX6b9qLX1ELiGJdWYVw0S8RXlU6IGnwptB5//mfaDEzpQ1gb1511dcvFXKgZqgDj
	113YV0cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngJOI-00FYlC-7V; Mon, 18 Apr 2022 04:53:34 +0000
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngJO0-00FYhR-Fv; Mon, 18 Apr 2022 04:53:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>,
 Josef Bacik <josef@toxicpanda.com>,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Mike Snitzer <snitzer@kernel.org>, Song Liu <song@kernel.org>,
 Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-um@lists.infradead.org, linux-block@vger.kernel.org,
 nbd@other.debian.org, virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 dm-devel@redhat.com
Subject: fix and cleanup discard_alignment handling
Date: Mon, 18 Apr 2022 06:53:03 +0200
Message-Id: <20220418045314.360785-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

the somewhat confusing name of the discard_alignment queue limit, that
really is an offset for the discard granularity mislead a lot of driver
authors to set it to an incorrect value.  This series tries to fix up
all these cases.

Diffstat:
 arch/um/drivers/ubd_kern.c         |    1 -
 drivers/block/loop.c               |    1 -
 drivers/block/nbd.c                |    3 ---
 drivers/block/null_blk/main.c      |    1 -
 drivers/block/rnbd/rnbd-srv-dev.h  |    2 +-
 drivers/block/virtio_blk.c         |    7 ++++---
 drivers/block/xen-blkback/xenbus.c |    4 ++--
 drivers/md/dm-zoned-target.c       |    2 +-
 drivers/md/raid5.c                 |    1 -
 drivers/nvme/host/core.c           |    1 -
 drivers/s390/block/dasd_fba.c      |    1 -
 11 files changed, 8 insertions(+), 16 deletions(-)

