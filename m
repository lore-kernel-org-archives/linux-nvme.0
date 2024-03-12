Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FCCC54E5D
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 14:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pn7Anh9njmnmAu3L5gNvV/rJYKFjcYmEsb1l8Are5AM=; b=dC1jHaTZVSyxpe9qJTgiIw3G84
	3K3nl8EsDXFyohRbnQxvS50iwvHjFG7Y9BMpTyV9ls4rHPF5Rkhsem2+UcA7avILSZqWziuMUpJc3
	sp8Ivu7gAVwjJKjk51zWw9bFFd72Ev4imKaXuhD9mzW41gh3RMbla6YmlMkTBWWW52foRoYaZ87Fq
	r4pUFRV29bhKfbLBBicXQBbycuW9dxQVOctx0aror0qaZ1wNrZNnxiZsLRNR8KXsaVM3cUCOq08ag
	fjum/umYM6OCoOJ3mWVyHGCL+emjATGSQIVUr48NZNfsrdyT+gIPnXBHU7xLPVjzQlLsr9XjDjx7S
	Heg0Y7Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3Qb-00000006D7R-0ERf;
	Tue, 12 Mar 2024 14:48:29 +0000
Received: from [50.226.187.238] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3QZ-00000006D6R-1cGg;
	Tue, 12 Mar 2024 14:48:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: RFCv2: fix fatal signal handling in __blkdev_issue_discard
Date: Tue, 12 Mar 2024 08:48:21 -0600
Message-Id: <20240312144826.1045212-1-hch@lst.de>
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

[sorry for the resend, the hotel wifi just broke down]

Hi all,

this tries to address the block for-next oops Chandan reported on XFS.
I can't actually reproduce it unfortunately, but this series should
sort it out by movign the fatal_signal_pending check out of all but
the ioctl path.  The write_zeroes and secure_erase path will need
similar treatment eventually.

Tested with blktests and the xfstests discard group for xfs only.

Changes since v1:
 - open code the fatal signal logic in the ioctl handler
 - better bio-level helpers
 - drop the file system cleanups for now

Diffstat:
 block/bio.c         |   48 +++++++++++++++++++++++----
 block/blk-lib.c     |   90 +++++++++++++++-------------------------------------
 block/blk.h         |    1 
 block/ioctl.c       |   35 +++++++++++++++++---
 include/linux/bio.h |    4 ++
 5 files changed, 102 insertions(+), 76 deletions(-)

