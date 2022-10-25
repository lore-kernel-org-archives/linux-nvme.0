Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D564ECDFA1
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Mo0I4vEOLvvjk8gjEeiZhK4hGLEZ8BanpX5CwiA8f8A=; b=NOZ/6QLNzYba6H1J2CZediBZit
	wXxrRc9A0yTR2VBQfABrtJYpdiBxXWUvUarK009pxmUhrmLQFD0w9KlpnmKQ55W1LSxOerqXV6ABK
	gTotkUYv2vT50zBEaeTY94lKiELHAkqcd90otzWOpG3XRubvdOB2Pf8+ddK/cDNdz94y3PBrfrk/4
	oTQ53vCBUfHCO+fh7mPDjswReu1shYy6sO4bK1+CJdkQtIubhhhWGs7+IjjZoO6TQdAdYRwLBtTyR
	7m4xN4chAzEbrBLIFvmam7Pc8Hjr19zyGsTwzSiEuf8bpotEoLw+3N3GrOpsiUH/WNyhrHi26tjYW
	XvOcBlbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL6Y-005psl-6S; Tue, 25 Oct 2022 14:40:34 +0000
Received: from [12.47.128.130] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL6K-005plu-JM; Tue, 25 Oct 2022 14:40:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: per-tagset SRCU struct and quiesce v2
Date: Tue, 25 Oct 2022 07:40:03 -0700
Message-Id: <20221025144020.260458-1-hch@lst.de>
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

this series moves the SRCU struct used for quiescing to the tag_set
as the SRCU critical sections for dispatch take about the same time
on all queues anyway, and then adopts the series from Chao that provides
tagset-wide quiesce to use that infrastructure.

To do so it does a fair amount of cleanups in how nvme quiesces queues.
Even with that nvme is still a bit of a mess in how it quiesces queues,
so further work is probably needed later.

Note: testing is a bit limited as I'm travelling.  Before this proceeds
it should get surprise removal testing for nvme-pci.

Changes since v1:
 - a whole bunch of new nvme cleanups
 - use the notify version of set_capacity in blk_mark_disk_dead
 - improve the documentation for blk_mq_wait_quiesce_done
 - dynamically allocate the srcu_struct in struct blk_mq_tag_set
 - minor spelling fixes

