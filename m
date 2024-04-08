Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B94CD128A
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 02:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l7JmcucKAErqRzcPJiGAGE8ipO+ELWLOZ+89Z/Wi1zg=; b=325+AyF9N4GwHh5YKTwFTCG305
	jgAICycGFKf2XfDg4mOlmf/EOloYkNKl8sQPSRYeAjYTV1bxNOEyKUAjtXE1mKVDSusyN7iBgRT7T
	0hXN7+groRutkTBUuzrMYFK+5IpTUZf6G2ZixIc5e7PJNEZAPiQARtRj8qbPYPQFpzOv+6nBkpkjE
	F5dBSNbowJzd1IOXA3qSsaN5i5ykoCp91DH7mm0cOAGLbi1dJTnPysEIAqZHaVIMr1ifhGo067eSm
	kNc3IgYO7H2+A3z2lN2yo7OoFzB5PDXoDKGbwWiN48lTdsnD0EI+7SbkBES0H7LLynviPgCMvYqUm
	h8LzLlOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtf13-0000000E5SR-09P7;
	Mon, 08 Apr 2024 02:45:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte1V-0000000DvXM-3u6G
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 01:42:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A198560DF4;
	Mon,  8 Apr 2024 01:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EACC43394;
	Mon,  8 Apr 2024 01:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540533;
	bh=+ItUMOryXXhzBX320MW1H6xaMoPOl1/Lr1NZ1z2eEiA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Anle1WMi4b5Q96ApPdUZ09A/TRlgYf+0U4y+N3YxEyWJFqLxHXq3EfB3ZoCKGBo9m
	 3Y0uFA80xmqPH6YfaTNNTQZP+dudXMqjKN/4TTdHP+bmaLTkHnw/jqtNkUc+Y+dOfS
	 5cqUwgUL94lkcQHXcZ5L4z43ij4jDL6oPKntFnYgkATZO7PIiKs0IeA1NkOj7m5hPd
	 bmC9wOMAy2ENGo7Q5Z+wMdijc6hbzKQxdWfmRcgiVabq04ORh/XwFTwPM9JKDsYumd
	 Bx2Ia32DbmGzT0mbUJxsZOrl7PsYqGcRhYRXdAYK7kAh/OUPdSVB1BC1V7IyFdxqxb
	 8Aht4XDpwYuhQ==
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
Subject: [PATCH v7 23/28] block: Do not check zone type in blk_check_zone_append()
Date: Mon,  8 Apr 2024 10:41:23 +0900
Message-ID: <20240408014128.205141-24-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
References: <20240408014128.205141-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_184214_588143_BA969D12 
X-CRM114-Status: GOOD (  13.56  )
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
Tested-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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


