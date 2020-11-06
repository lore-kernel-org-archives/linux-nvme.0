Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A604C55178
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:05:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C8F20882
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X0i3cPWL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SSYTvNNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C8F20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pOUBVJ5mF5HBgqYSuB4/p682DxcKZ+V0Ize7xiQD//g=; b=X0i3cPWL6CVInikqFD4HGzZPY
	jPIKyqyB2I1JmTgt3i9QOEC+HK/qnADmn06qoVQ3yhX8Hpvj8RJpFa9INZv+jNknUrcnl0CTB1+LI
	pAlrIt2/9e3PIY+TNWfuFHLjOU6H4khT1wFmIA7OEoNegdrxWPaP7ba3KjNzByoN6W/SthAXFtPU3
	HW60FvP5eEPOfSEuYFyqc8mo+2TIRTKMgpWpo0OBMhzkZjfu7VCSMeo516TJEZ3sEptRag4GiNRnD
	etPAaLDgH1qVtV9QJ29s2zbFuDdURmV8ToLLYvmN5swXknsssYigv/awmIGjfuZ6aInae/qtZfGbl
	eCXBHn0iw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb73K-0001wY-DJ; Fri, 06 Nov 2020 19:05:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb729-0001HZ-TZ
 for linux-nvme@merlin.infradead.org; Fri, 06 Nov 2020 19:04:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=PHuhBTY1ouZHYZght48HNcRnOQ9ETUZCJ1FQTXf/EwQ=; b=SSYTvNNJNXE2eq2vgVj6+p7+Gh
 FYbkDj8JGnpdrmz5g60TezXk1nZ8IK6aSEC63V47GcMNDVRD2b07nZboOupLzX5aEBbXOf1qNk/q1
 85ByLUNa/iIkjS2bTnTwLGX4qg1UIhlVWKfoDdV2GRo/nM9hbu38kygTHxbko2gZVtT2bUrzYPu48
 BSOQzEY1WiSKBkKLQhDgeyv8+72t+hzcZogXCmIx1Wruxn/wT/qwIItixospXcqe+3ImMT6BtwjcV
 45CMr1jmOsAd8Z/iT1swy0pwYtf88g1VIvuMcKaCvasjmy8HQRqOo3zeFNgUjbePxjiAerJHobf4V
 AcdZg19g==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb727-00012z-Nb; Fri, 06 Nov 2020 19:04:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/24] rnbd: use set_capacity_and_notify
Date: Fri,  6 Nov 2020 20:03:30 +0100
Message-Id: <20201106190337.1973127-19-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106190337.1973127-1-hch@lst.de>
References: <20201106190337.1973127-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use set_capacity_and_notify to set the size of both the disk and block
device.  This also gets the uevent notifications for the resize for free.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rnbd/rnbd-clt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 8b2411ccbda97c..bb13d7dd195a08 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -100,8 +100,7 @@ static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
 	rnbd_clt_info(dev, "Device size changed from %zu to %zu sectors\n",
 		       dev->nsectors, new_nsectors);
 	dev->nsectors = new_nsectors;
-	set_capacity(dev->gd, dev->nsectors);
-	revalidate_disk_size(dev->gd, true);
+	set_capacity_and_notify(dev->gd, dev->nsectors);
 	return 0;
 }
 
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
