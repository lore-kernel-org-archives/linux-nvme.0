Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9AAC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 03:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XD7V9B+TbiGwRl4+2JiG8hf2lwXurCsdXxEwkGLkJBc=; b=JAS1IszAqUfSdMp46VTsWaH5Sn
	aIcGgU/LLz3hbCKQtQvPI4OXmqTyyq2Dby1Qtl947fRr0pR0rNbQugoxhiObaHMES7Bw1M82BbAAu
	aT9Mqu3ePFy4miibw6sG5cnnc7QGt4Ar9tI2Fot7r++fH+HCUwd5GBCRNWUKOc9cnJQW1M7U7HvLq
	Ke99W+23TDOnVTWJJhCIYNkOwEU/6Flcr+tBbw3G9neKV3Vq4TqGOzcjTmy1PLNy0jDhnHaYiJuEu
	vhxRvuMivC7FN6c5cTZ+ndnY5O0hokhtGlhQXOjMin9qtek7pLegGFO6iVP2SDhCki6VfMgnDd0dH
	GSk4Bc3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oENKB-00G3NW-I9; Thu, 21 Jul 2022 03:58:07 +0000
Received: from mta02.start.ca ([162.250.196.96])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oENK7-00G3Gs-GL
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 03:58:04 +0000
Received: from mta02.start.ca (localhost [127.0.0.1])
	by mta02.start.ca (Postfix) with ESMTP id 51210414D0;
	Wed, 20 Jul 2022 23:57:55 -0400 (EDT)
Received: from localhost (dhcp-24-53-241-20.cable.user.start.ca [24.53.241.20])
	by mta02.start.ca (Postfix) with ESMTPS id DD33C412D6;
	Wed, 20 Jul 2022 23:57:54 -0400 (EDT)
From: Nick Bowler <nbowler@draconx.ca>
To: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Guixin Liu <kanie@linux.alibaba.com>
Subject: [PATCH v2] nvme: Define compat_ioctl again to unbreak 32-bit userspace.
Date: Wed, 20 Jul 2022 23:57:35 -0400
Message-Id: <20220721035735.2720-1-nbowler@draconx.ca>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_205803_637727_7E6E94BB 
X-CRM114-Status: GOOD (  11.13  )
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

Commit 89b3d6e60550 ("nvme: simplify the compat ioctl handling") removed
the initialization of compat_ioctl from the nvme block_device_operations
structures.

Presumably the expectation was that 32-bit ioctls would be directed
through the regular handler but this is not the case: failing to assign
.compat_ioctl actually means that the compat case is disabled entirely,
and any attempt to submit nvme ioctls from 32-bit userspace fails
outright with -ENOTTY.

For example:

  % smartctl -x /dev/nvme0n1
  [...]
  Read NVMe Identify Controller failed: NVME_IOCTL_ADMIN_CMD: Inappropriate ioctl for device

The blkdev_compat_ptr_ioctl helper can be used to direct compat calls
through the main ioctl handler and makes things work again.

Fixes: 89b3d6e60550 ("nvme: simplify the compat ioctl handling")
Signed-off-by: Nick Bowler <nbowler@draconx.ca>
---

v2: use blkdev_compat_ptr_ioctl as suggested by Christoph Hellwig

 drivers/nvme/host/core.c      | 1 +
 drivers/nvme/host/multipath.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6a12a906a11e..9c75d7378d31 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2123,6 +2123,7 @@ static int nvme_report_zones(struct gendisk *disk, sector_t sector,
 static const struct block_device_operations nvme_bdev_ops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
+	.compat_ioctl	= blkdev_compat_ptr_ioctl,
 	.open		= nvme_open,
 	.release	= nvme_release,
 	.getgeo		= nvme_getgeo,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d3e2440d8abb..432ea9793a84 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -408,6 +408,7 @@ const struct block_device_operations nvme_ns_head_ops = {
 	.open		= nvme_ns_head_open,
 	.release	= nvme_ns_head_release,
 	.ioctl		= nvme_ns_head_ioctl,
+	.compat_ioctl	= blkdev_compat_ptr_ioctl,
 	.getgeo		= nvme_getgeo,
 	.report_zones	= nvme_ns_head_report_zones,
 	.pr_ops		= &nvme_pr_ops,
-- 
2.35.1


