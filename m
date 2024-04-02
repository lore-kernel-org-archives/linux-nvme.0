Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D18CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FV5eAOodbAF2or/ukhXrK1xeZSws/u8PRcersuVvC68=; b=SmSrr4zI9RumWfzFZ+Leg6UPA4
	SmlHGojqGb1OouGqU9jhoqUDOPLkyFZHZWEdHNqnrf+iWyTpqRXLPHqVGpl8HPyRRaF912BdXRhXl
	5qWsYUSE67GR4IFhsOltoVY475SIl6L3g4yAEfeKY0EUO3g1lo8RZM8tGRVeR4N5ZuXOd3+vV9DYq
	JJStRiD9Kc4wGEI8NoSYgflNEu5bfBEn75FfU8VgPWfe25csGABSEB4uzg/IeFZMvMjq9x6GJi+u5
	k93BczVhAXGW0Xop/LYs6gtkvsn6Umvz1q1grDuNLkn9Gwj8NtHX8sflJZOM/D2qKhvWrBTeQS68X
	zux3KpHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rreVR-0000000BQYN-0VYg;
	Tue, 02 Apr 2024 13:48:53 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQV-0000000B6HD-3iSj
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 12:39:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4DB15CE1B74;
	Tue,  2 Apr 2024 12:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67723C43399;
	Tue,  2 Apr 2024 12:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061582;
	bh=swSQmLVcxXZAAaPOdJC4n8okb3JMRstty8OESc7Mb0Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A5hURzzeQGcd+l1ymrBhuHcqB81VC0dBnQICFZmfrNYI1uHlRt0t5rwh86uP4KULJ
	 uGgHvHi1nAsYbEqd+ehowcO499P5J1zqiz0roQ+p2ZqRzTnwYlHOA/WOKh+sUpvRA6
	 zSNPopUHbKeY41OxZqYLfdXFgHEtGJfOmTNNk0eT2Dpu0HGC3zegiFjQn0lwZtuOFa
	 N3lZBla8TrhdqMdJJJD0K9AoFeChcctDN61/bmL4EEyOeE1bE7R4Ig7nNeNLoFSoSx
	 XupKrehgtA6oBWzzy6B5fVuogPLCQq3EQmSV8UoT7Va8c9xXB43AJzIzsKySUwAgn9
	 kpqpRaefmA1YA==
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
Subject: [PATCH v4 23/28] block: Do not check zone type in blk_check_zone_append()
Date: Tue,  2 Apr 2024 21:39:02 +0900
Message-ID: <20240402123907.512027-24-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402123907.512027-1-dlemoal@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_053944_309896_A19E2121 
X-CRM114-Status: GOOD (  13.97  )
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


