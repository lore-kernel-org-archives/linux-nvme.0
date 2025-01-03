Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6170DE7718F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 07:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YMdPlpNXgCMaksxcreVbW0oQ3YoG3YbUI3RMdbhf/xY=; b=W/+BDJwmhqJ6aiOnmt019ioM4P
	6bJAcmQ70uiaQFkeVptRBtLjAode9nwjJJ7nPom/jDnD9IrbvSrV+PN+Sp9A+262iz0Gc8dEl888t
	c1DosIJETk3nVD5K5XIOieEBPN1MEAfNr4T3a0zpNcKZhgRJebDKIfF15OX1vYrpImkniRmlom9nv
	UKUUnrbG8cber3JmTu8SjfuiOY8Wnp+LHtI5LJEzkBC+eI2xkACS1jgiDmTJTS4t21GP71G628gsk
	AHw1NgAYlvhJA5Vk/KrYkMJpAMjRZ9usDEb7JIUIHWYePqG6ulhnwc7lkVqd22V32VLdDA4Hx6Its
	x0I9r28w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTcH3-0000000CMx9-0Rz8;
	Fri, 03 Jan 2025 07:39:13 +0000
Received: from [2001:4bb8:2dc:484c:63c3:48c7:ceee:8370] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tTcCK-0000000CM56-162F;
	Fri, 03 Jan 2025 07:34:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: simplify passthrough bio handling
Date: Fri,  3 Jan 2025 08:33:56 +0100
Message-ID: <20250103073417.459715-1-hch@lst.de>
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

this series removes the special casing when adding pages to passthrough
bios in favor of simply checking that they match the queue limits once
before submissions.  This mirrors where the zone append users have been
moving and a recent doing the same for a single optimizes passthrough
user.

Diffstat:
 block/bio.c                        |  107 +-----------------------------
 block/blk-map.c                    |  128 ++++++++++---------------------------
 block/blk-mq.c                     |    4 -
 block/blk.h                        |    8 --
 drivers/nvme/target/passthru.c     |   18 +++--
 drivers/nvme/target/zns.c          |    3 
 drivers/target/target_core_pscsi.c |    6 -
 include/linux/bio.h                |    2 
 include/linux/blk-mq.h             |    8 --
 9 files changed, 57 insertions(+), 227 deletions(-)

