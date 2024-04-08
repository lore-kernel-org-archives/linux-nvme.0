Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC59CD1299
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 01:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BYWnyhuYo6cAvFuzMvSDsxH9lf3UDIghq32VWrwk8BM=; b=F8TjWLrloQim9wpgpUiT2aM1dY
	PzE0k2qEZRcJi0el7x9PxbZAtZrepyC1ycBLkLVEpBYmAHTDkEZ7bUIzx0lHTBaqgbti7UJqksqIK
	iaiessTXQGz63BeDWpy/rmrIzwCHvUuz61DmQN4/FGrEyk6e8ilbHBDYhuFlG0j08hjCByUDB0vf4
	mkSrpSi97Rxi3nULcG5F84WlAFuLawNsnnOUKWsM8VsUhDB3QFwtD5FcnyQbmGO8FxkOCjL56lEb5
	KqxqEQIRkmCIoofJjzuL9ag0iheXojvle3yfd37zYajfWqcVv9eZlYaUGgTbMwLVRgAea8XMQjlQv
	3gsQLFkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte0x-0000000DvFd-1ETS;
	Mon, 08 Apr 2024 01:41:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte0t-0000000DvDj-0ar9
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 01:41:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8FE0B60DC5;
	Mon,  8 Apr 2024 01:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053C0C43390;
	Mon,  8 Apr 2024 01:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540493;
	bh=iGEVLC9YGivLU1QMrPXjUR/C6DUcKR6exN+/jtWzOmE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GAYobnC8jmVdiUfRp+4E8ZBL3tC5XiVxaUPM17iFESW3DD2a41wvJeOGH0HzL58eE
	 xic8S8VLdz6A2sTwDFrWOEFZ3ovRmXA+xBlrgqqfZ66DElMmBY9u2TIXmwu1Sttq6Y
	 2F/8y7FAnDII6xaWz035qk8x4Su2B1Bbbrzoo6xF0Ra3i4S5IaDFOpwpKAf0eg3euX
	 3nSHmfCH4fxlR6LyWsgX8kUbJsIYZDi+WG0lrCBWTsl7MtA2/VGtgA/MaZGX6+DMRT
	 j2VW+9hUA1GowfpHj2o/mhPHktjvjnWo/MTDK05dOhK7br5Kc9aZgTrlQNZdSOYqdq
	 b04BYWbxoauBw==
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
Subject: [PATCH v7 01/28] block: Restore sector of flush requests
Date: Mon,  8 Apr 2024 10:41:01 +0900
Message-ID: <20240408014128.205141-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
References: <20240408014128.205141-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_184135_263576_32DF8C3D 
X-CRM114-Status: GOOD (  13.14  )
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
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
Tested-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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


