Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD76CD1297
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 05:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IQPTPAnUTnsq8SU1Ll5ysTpUC6Iiqck3kOGPsF5WSyM=; b=asrmFzXcatEN3cvwQkQImwrYvX
	jQkg57JmcZe6B4sLlM2slL8D1mF7eSMYBOgttI1DSFrB0lrbU/GOIX1zM6/A1W/aa1sePsZhgKz0o
	Vbp7hV2aAb+RswxUNrV5A7f5TRnyFvVBgtZFqi7xLEZKFLDKCDRG3LxYzAXKbTcgBbZLYjZ956IqG
	KT2WpQ1lvWZ4UfbtlqRBeL5VB2cBPdrYFVDFfn0V+Asp7cTLRIaCUoEYynTamU7Nb0elMFYGPgKfl
	kDEpCEdeqGbGMBR/KH8aZE8JQcUkjhfudMEIlSA/yM0v0vWhzLUstBWfbOTwrGuWFTtnj0vE7vs0w
	0mR3jNIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscSX-00000005LSl-29jD;
	Fri, 05 Apr 2024 05:49:53 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbPY-00000005BIX-2x7I
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 04:42:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 21226CE35F4;
	Fri,  5 Apr 2024 04:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA7CC43390;
	Fri,  5 Apr 2024 04:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712292163;
	bh=iziYpzXvYEHu2nCN/JikIgPE5N7UOGj+TVBZ2NBKtZo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g+ysEPSf6P85YC1wbQxx7JcAExqRiFpzoKuE6C3lpkIx/SEc5q0as67MdGS+E03Kp
	 u1fmnFnMI/8PrDIrD8FuCzd9WUcIPXs4/rhUJ2wvjgVegy9VZRwUQxDkvP7V4IDC4W
	 3fES56DjIIhciknkTGzGV4zQz9HtMgk0HD/anBzzR2EyliECRBHyiaBNNA8apgYJ11
	 BXuzeMWFzqohjhR45SsCwJS49kRHWkMsLfqSPdpFhIsYntReCH8ykaLTPx2kHg9DGW
	 zqBEqHfEwJrkCRozgI2DTfFbRov2+t7mHgX+cKSSYQT0gt8b6CnELF5OU9hGe7i30n
	 Wsm/W7ogZmm5g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 23/28] block: Do not check zone type in blk_check_zone_append()
Date: Fri,  5 Apr 2024 13:42:02 +0900
Message-ID: <20240405044207.1123462-24-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405044207.1123462-1-dlemoal@kernel.org>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_214245_951184_4F189C07 
X-CRM114-Status: GOOD (  13.64  )
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

Zone append operations are only allowed to target sequential write
required zones. blk_check_zone_append() uses bio_zone_is_seq() to check
this. However, this check is not necessary because:
1) For NVMe ZNS namespace devices, only sequential write required zones
   exist, making the zone type check useless.
2) For null_blk, the driver will fail the request anyway, thus notifying
   the user that a conventional zone was targeted.
3) For all other zoned devices, zone append is now emulated using zone
   write plugging, which checks that a zone append operation does not
   target a conventional zone.

In preparation for the removal of zone write locking and its
conventional zone bitmap (used by bio_zone_is_seq()), remove the
bio_zone_is_seq() call from blk_check_zone_append().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 block/blk-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3bf28149e104..e1a5344c2257 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -589,8 +589,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 		return BLK_STS_NOTSUPP;
 
 	/* The bio sector must point to the start of a sequential zone */
-	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector) ||
-	    !bio_zone_is_seq(bio))
+	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector))
 		return BLK_STS_IOERR;
 
 	/*
-- 
2.44.0


