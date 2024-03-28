Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFDFC47DD9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 00:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zgfOBpxC/xTKCIGJE/+H9oBnJAZDT8yl/7H7VhMdZb8=; b=cyj8xs2cwMXJhDSgmAWU8I+o2/
	E5ujMf7GWREMfCUEY8Or5RLxWm7H8hEFSex3GYAV+cOlELPDUgVDLzcKJCmSx+Uj9f7sjxf2AQFKF
	bZoXyE/ppSSTsu3VvWZQZYz4loJ6cORfYEVVdarjEzkX5+RNMUCxtVnedt6608rc1fAXHMFv5uG0Q
	9iPhr6gWoRV/FJi3eLK4cLp5CYRXHoBiHD+1VRBD8ANQE/0KXgCXc4xFLuWJURVnp1g8QW8wP/rW9
	w6Qt7VXkJJfvWOvLoxLgaBiHILa/oD9L0iJyy+WGjkKUxdcKAmnHbtpENDanuT2apSHa1TKbLuZnD
	xbn3cZ2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpduM-0000000BofE-0yCg;
	Thu, 28 Mar 2024 00:46:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdt2-0000000Bnje-0vgv
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:45:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7A14C6171E;
	Thu, 28 Mar 2024 00:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC58C433C7;
	Thu, 28 Mar 2024 00:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586695;
	bh=SDWELck1RoGv2VSJxikvYBXlMcfGyvAzaBGySLOyeYQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UtLiGjhX7AvMYzjDfFZ574opBQKTuiGSVHa8HUFdQRks1nmKYrwiclfJWjCK4rHgF
	 3ka+LaBu08t+pri56NnCyZi++BT4E4O5D+vbvAd6cTkkBQ57jXABwUQols6NoRKVjB
	 4GmQTs20RPIc/t3eTB9CcQ8mhxi4MxCerYzCbS8XaToCvmFDgEESyNi41712rPG+lG
	 JaWbqWJi9c4rUdIbd4sK0U5m4/wwX4AgY2mLq5zVv8yLr9HYsi/mSi6P/Tuu0yMQBp
	 HXu7wX3iFKtgY2h5NDSaY+cDvA/ufODF87BJwzf9eAtZd4mQ1Kyq0Ny7t2pEKMOBZE
	 bP1E/b+nbXU7A==
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
Subject: [PATCH v3 25/30] block: Do not check zone type in blk_check_zone_append()
Date: Thu, 28 Mar 2024 09:44:04 +0900
Message-ID: <20240328004409.594888-26-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_174457_209988_D9A6985C 
X-CRM114-Status: GOOD (  13.42  )
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


