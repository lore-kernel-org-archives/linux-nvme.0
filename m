Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EA9C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 08:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FV5eAOodbAF2or/ukhXrK1xeZSws/u8PRcersuVvC68=; b=hLQx9z8TQQGTK3RW0op2+Td7Tp
	KFo0ltxk0MepvzKlXfokZBttHskFN2JMOsnS59HfSsa96AVk2KXbBQklR3H7lSQmLAgAEapwPBEiK
	2S6+seNKTW9bBxltAhvTI4ZKYjqL92NGZ65BgjYQsEPe4f2kK4eGNDXhpw2OFdThXCV2x5t8VcpRT
	Z/tpa2K+IAmG2evyNpLuKVt64/yf5GjJ2uYONphpln+HHjUGVaBIZwe1CXt6eSLc2X8q4TowHCZ1G
	0BAnOruQW4/r9QIghxZRJDv5adM1Lhar1WdX/mmtIiKuRscKBZrXbT+e4A2JdBgwKdf62C8xizEFn
	3JkTODYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwEW-0000000Ezll-3wWf;
	Wed, 03 Apr 2024 08:44:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwDW-0000000Ez7N-1rpF
	for linux-nvme@bombadil.infradead.org;
	Wed, 03 Apr 2024 08:43:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=FV5eAOodbAF2or/ukhXrK1xeZSws/u8PRcersuVvC68=; b=nEeWWbrsZZWb06KT70jif1+Wxg
	bqFg/zL/lMozrrh9Ioh0N5aKD+sMRjbuP+HzQoMmNVRsbe1tbgo4dChA/76Xo4OKGwX/mmlxPdQFb
	9w+RDNiEn8w74epFFkq/zWqoMfYcxahfeDo+qjGYzb4Da2/8UnXFbeDK2F6W+iJx4/V8ZQI5G6NV2
	70RRXADAwEabA+UH6ImzwHxeRgQGl6sxdd4OefZZOnKiy9kQdUXh6X23NEOTxf3aeyuvS4VRvXzCV
	eDv0kXkcramxCnBAVksL4QpWsZnGcTmkk6fL2pizttDHpIxE1zTE8uS+04/cmrLmW2MZdRb3Z2g+b
	0zB/gKkQ==;
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwDS-000000046Rh-2plY
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 08:43:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 572F1CE2124;
	Wed,  3 Apr 2024 08:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9F7C43390;
	Wed,  3 Apr 2024 08:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133806;
	bh=swSQmLVcxXZAAaPOdJC4n8okb3JMRstty8OESc7Mb0Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=L+XG5dQPK3OEoJhS7JDkk6+6SRWeWPCto2t+qQTOPYiilPaF6tB0rsQqp02pMdpR5
	 3+DXqOWHXKJgXfvq8NWeezxHm/uik08lEWoY5LqDueKtDoE56/gr5nPyIdvnKo+hf3
	 SBQJIf6S3r/8FPopNvxdg4H/NyCaLW7ixbIta+XWAFexRPU1ii/bFQom3owjA9PjoV
	 m/gN+upjTp90M7Wn5Gmvw9XmxVtgH1q3ZnR59wNroWYCX4S1ydwrpdgJd7o72iiPsv
	 s0N9Gwo5hg0fFWxliqfQNtNxCUU5FZ2QXDDLgZ7xuTMOIF11epxSJW27ecAwlEdxt0
	 fUj/29tkqiNVw==
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
Subject: [PATCH v5 23/28] block: Do not check zone type in blk_check_zone_append()
Date: Wed,  3 Apr 2024 17:42:42 +0900
Message-ID: <20240403084247.856481-24-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403084247.856481-1-dlemoal@kernel.org>
References: <20240403084247.856481-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_094331_286241_48C9FACB 
X-CRM114-Status: GOOD (  13.63  )
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


