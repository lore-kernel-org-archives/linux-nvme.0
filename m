Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A44CD11DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 00:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JeEwLDWnwbM+KgJsTjO//fi1WiCjJRCX524sKO4/cPg=; b=xOnaTkfhU01f6sqnHeCNZdJ80E
	bvSQ4pmYZw+w7y/JdMsP5K7/Qb5osvBfreQeEL0+pJuScZt2984kYjkeQjtGtNdnupkpVoEE0djDj
	eJakK+dO0xfYWUdy7tzPmWqtnthwP35r+N8rXJkyPZjSfpyAZTPnNutnMEQIZ9r81PAKrwxkkylF6
	I/1RL7KigPhGJRTxm7WHgaYNQ5A3BQ1YBjf7XUEM0hag41wCxG7dkwpfiujGUWVIQxc4sfugkOtSh
	b2GKCl4f9FH0oNHdyYeyQsGkfpVFCYkQ43K1FLluEkWItmRtnPagHUPSVJ4fHycaM6RLsrjaWkV1B
	vN0+K07A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdsS-0000000BnF0-0yjT;
	Thu, 28 Mar 2024 00:44:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdsP-0000000BnDD-0LfV
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:44:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 988A86171A;
	Thu, 28 Mar 2024 00:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6019EC433C7;
	Thu, 28 Mar 2024 00:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586656;
	bh=0yqNrZFOQaepbT+fRTCJM2qoLk9O4d9p9W1UQpJmlfM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QiW6pFr/eUS/uk+wgXcUsBVs8Pe7johbGXcF/GTHlSVTFiLAFFuwi1lJkYh6rM6d2
	 8vEMQnCYVqOWKNqnyUpOhdJ1PmHjUltIiy7C39B5qQw9IDao1A8A+Ji67Menyu/egt
	 fsupPKWxwgH1PgQ7AWKYSL74GLljsaJShI2Lk3l9Y3p7iyt/EgoCqT6krGDybvrg2C
	 xjoz96ZOWDVv+7aXai63nxdZi9bttfjq5R+d79ogg1nvTqv0nOeSvUoFqv2ARdDTL1
	 3LA6BjA2s9T/fG3BtvoiHf0Thtzvavc4BR4+0ZltR194VJtON+y3D3aNv/7C19u3ny
	 NVWGfAG11UApA==
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
Subject: [PATCH v3 02/30] block: Restore sector of flush requests
Date: Thu, 28 Mar 2024 09:43:41 +0900
Message-ID: <20240328004409.594888-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_174417_261896_096C8CA4 
X-CRM114-Status: GOOD (  13.12  )
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

On completion of a flush sequence, blk_flush_restore_request() restores
the bio of a request to the original submitted BIO. However, the last
use of the request in the flush sequence may have been for a POSTFLUSH
which does not have a sector. So make sure to restore the request sector
using the iter sector of the original BIO. This BIO has not changed yet
since the completions of the flush sequence intermediate steps use
requeueing of the request until all steps are completed.

Restoring the request sector ensures that blk_mq_end_request() will see
a valid sector as originally set when the flush BIO was submitted.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index b0f314f4bc14..2f58ae018464 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -130,6 +130,7 @@ static void blk_flush_restore_request(struct request *rq)
 	 * original @rq->bio.  Restore it.
 	 */
 	rq->bio = rq->biotail;
+	rq->__sector = rq->bio->bi_iter.bi_sector;
 
 	/* make @rq a normal request */
 	rq->rq_flags &= ~RQF_FLUSH_SEQ;
-- 
2.44.0


