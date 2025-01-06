Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60206E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 10:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qZv24j8F2g6J/b5MqylaQJhK6N+YiXOrkM+eWYXeu38=; b=L+1m2efdYH6+g0vGJeip+BHad0
	poUyRthjhxKPtu6h0kC3j16TVItRfCJ9zXToQRmk/IbegPvjAnYF1JVJ6oJI20MpFXxbvE+HAPLoD
	m2HR6YIpVhOiQlA7iF4BSG3V63mWy/JXT8t21UszBtwYUPdaM3dcGDHIPb1+kSVP6lUT6ylGPxp95
	Vv1QUZIawoPpNm2N2nnmgYjZFF2n1ipvfEiSJ2NpoL/nCPYkks0NOlpHuegUZ2eH4BtuEQ+GAyBhK
	MpUgxZvTQUS+ZzrlgQem+Ze0EH94XzpnR2IoaY/HkN4MQsXpxA+ZSgMGEkparOWWoae2/aQSrZLwT
	wJiyKbyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUk0e-00000000nPN-1GsX;
	Mon, 06 Jan 2025 10:06:56 +0000
Received: from 2a02-8389-2341-5b80-db6b-99e8-3feb-3b4e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:db6b:99e8:3feb:3b4e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tUk0W-00000000nNn-0ZWj;
	Mon, 06 Jan 2025 10:06:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nbd@other.debian.org,
	virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: RFC: fix queue freeze and limit locking order (alt take)
Date: Mon,  6 Jan 2025 11:06:13 +0100
Message-ID: <20250106100645.850445-1-hch@lst.de>
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

Hi all,

this is my version of Damien's "Fix queue freeze and limit locking order".
A lot looks very similar, but it was done independently based on the
previous discussion.

The changelogs are very sparse as the moment as I started it before the
holidays and just finished it enough to send it out as a RFC today.

Diffstat:
 block/blk-core.c               |   14 +++-
 block/blk-integrity.c          |    4 -
 block/blk-mq.c                 |   19 ------
 block/blk-mq.h                 |    6 +
 block/blk-settings.c           |   27 ++++++++
 block/blk-sysfs.c              |  128 +++++++++++++++++++----------------------
 block/blk-zoned.c              |    7 --
 drivers/block/loop.c           |    7 ++
 drivers/block/nbd.c            |   17 -----
 drivers/block/virtio_blk.c     |    4 -
 drivers/nvme/host/core.c       |    9 +-
 drivers/scsi/sd.c              |   17 +----
 drivers/scsi/sr.c              |    5 -
 drivers/usb/storage/scsiglue.c |    5 -
 include/linux/blkdev.h         |    5 -
 15 files changed, 133 insertions(+), 141 deletions(-)

