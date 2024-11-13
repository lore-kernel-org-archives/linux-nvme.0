Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30C2D462B9
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 15:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=q8dgTHK6/kDNMr//ddeMG12Og5G3zPkIrgOfI02e9nU=; b=HkjOzrZS2Gfat2tNp8cPVzoRYd
	/IoaheKC14T6hk9V8+TmCt4Mm1/PsQi0Zme5HONDD70BSt+Zp1MjVxT6tW7X2jtqA5mSrzO21R8Dx
	xLzoLBwcMHg3rcQBgZtRnJOXhnLQTnvxRUle2fQMNCkhqszfk0wF3GID9yyM9IJ12shUpRvYQZgty
	BRP3D4082F3AEI0guscWq/D1Ehr46NSE2G/H0bhTPKlHO5BYlEWz6q/xsBlWN/qwxIurvl37B2h2L
	OlKi/PYQjjSQJxnMtCnSuHwbY3L1rf3K8RM93/ua5qIjK8IxRurnmcD57btvT4ED6G7PJoadTYA4b
	W1HMt5hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFAu-00000007HKC-3g5A;
	Wed, 13 Nov 2024 15:20:56 +0000
Received: from 2a02-8389-2341-5b80-9e61-c6cf-2f07-a796.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9e61:c6cf:2f07:a796] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFAs-00000007HJX-0EfT;
	Wed, 13 Nov 2024 15:20:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org
Subject: don't reorder requests passed to ->queue_rqs
Date: Wed, 13 Nov 2024 16:20:40 +0100
Message-ID: <20241113152050.157179-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
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

Hi Jens,

currently blk-mq reorders requests when adding them to the plug because
the request list can't do efficient tail appends.  When the plug is
directly issued using ->queue_rqs that means reordered requests are
passed to the driver, which can lead to very bad I/O patterns when
not corrected, especially on rotational devices (e.g. NVMe HDD) or
when using zone append.

This series first adds two easily backportable workarounds to reverse
the reording in the virtio_blk and nvme-pci ->queue_rq implementations
similar to what the non-queue_rqs path does, and then adds a rq_list
type that allows for efficient tail insertions and uses that to fix
the reordering for real and then does the same for I/O completions as
well.

Diffstat:
 block/blk-core.c              |    6 +-
 block/blk-merge.c             |    2 
 block/blk-mq.c                |   42 ++++++++---------
 block/blk-mq.h                |    2 
 drivers/block/null_blk/main.c |    9 +--
 drivers/block/virtio_blk.c    |   53 ++++++++++------------
 drivers/nvme/host/apple.c     |    2 
 drivers/nvme/host/pci.c       |   46 ++++++++-----------
 include/linux/blk-mq.h        |   99 ++++++++++++++++++++----------------------
 include/linux/blkdev.h        |   11 +++-
 io_uring/rw.c                 |    4 -
 11 files changed, 133 insertions(+), 143 deletions(-)

