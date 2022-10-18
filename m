Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EE4C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Mr4DfIpBvotAuVVudNix3c7JoZHD1w7ur0X4aAHNKkg=; b=a5e3TiwtP1CIbiJYMAZAznzjb2
	9NFDeS9GF5F9vpe8AIjW1KiCZnC/1rfHRFMMoktdcFIJHbfsEd4Z0pq0bIVxlnEbQmaOnCz7bheo6
	+zLw34+WI6b2mUstdx7NNQMnHfxIGTYkRfOgQAdqynNLJmlQK0lNbwqp+Zv8RUrUin9AJ1j26J0e8
	LTnf+aJb5eU/GCk+qJ2Q6+lgi18B5+CFqCbozwN3W0xqRNmX8ni9fcthKIOSijgNVAHRvHP1sqb/w
	E0xo/i+bdW1SHwBEPCy7K2yvZV7jGk4jhrisSI47PRzQNUHAt6Zy7E9VTXm2swr9Yac5NVxicpT9k
	oObcsPgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okn61-007C6W-2w; Tue, 18 Oct 2022 13:57:29 +0000
Received: from [2001:4bb8:199:ad84:3a05:173d:d0f5:e725] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okn5y-007C4y-Ef; Tue, 18 Oct 2022 13:57:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: don't drop the queue reference in blk_mq_destroy_queue
Date: Tue, 18 Oct 2022 15:57:16 +0200
Message-Id: <20221018135720.670094-1-hch@lst.de>
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

currently blk_mq_destroy_queue not only shuts down the queue, but also
drops a queue references, which leads to the NVMe PCIe/Apple drivers and
scsi grabbing an extra references. Fix this to help with unifying more
code between the various NVMe drivers (and to make the code a little saner
even on it's own).

Diffstat:
 block/blk-mq.c            |    4 +---
 block/bsg-lib.c           |    2 ++
 drivers/nvme/host/apple.c |    8 --------
 drivers/nvme/host/core.c  |   10 ++++++++--
 drivers/nvme/host/pci.c   |    5 -----
 drivers/scsi/scsi_scan.c  |    1 -
 drivers/ufs/core/ufshcd.c |    2 ++
 7 files changed, 13 insertions(+), 19 deletions(-)

