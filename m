Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AFDC54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 00:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wvUiQBqZxzZkzLj/KZw/0/quQRGOcsUtfp+16jfHTj4=; b=TcL+KxBqfMSVKG3IS8T3KTFlnN
	dTyDPkc8PaCVanGd0rg+cQzAXuTbZUnv3f4oLpPpGP1BPg/dT050mNBaliaQWdGjB3dBrwMHODjjL
	RSDna82PuPpeFynD9E1La8JDf7oqAgSlcqVLb3A2wZzdNVwES9i2BsVNzX6PU9jIu4sCj/BAfJTQ/
	OsZqtX57LP36phpX4UGJ7EOzjN1ml3FyA1p0GtKdJOeWLx9pLpDh1aKdSkg5XzgUjon/7rTda0x3l
	GoFDd4oAK/9a45hpsi+oLhNGx8fColMPyDqgsOPzwK/BBTn3kaE0cOYSW1qnNaTs+1A57cVV+5Xcr
	+i6WHkOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdsR-0000000BnEG-1Lzy;
	Thu, 28 Mar 2024 00:44:19 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdsM-0000000BnBs-4BLm
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:44:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3DE4761714;
	Thu, 28 Mar 2024 00:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE35BC433B1;
	Thu, 28 Mar 2024 00:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586654;
	bh=rYPOJKSR4ZSBZRsgiieElKMZRibpVnpNXcy2Px1D6dg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hSr28L46GSjT6HCZ3CNJQ41oyb8Jp2ooxmR9VBil0THT0V62/askYVUutCHumZJHa
	 2p9lsjzabiUZb6OFd3cukMXhAjo/RmjhTQFRcRK40HaTUKJEF2nuWByJYqSc/31RDN
	 k9SHZG4/Jb/XAr5y1w9teEoZ4TeWkjG8auqjjsq6pP1CddU6d/gQu2OVW5js00toLE
	 SsHkBi71xHEPCdasU1cskp6lSTdvtYE6PD8azAAkAsxUZ/DJ+eqV2zi/QIWzPVSPtO
	 KhhdDdTTAXs0aCOe6vHxnhsuzxJtU1OQ9XXT0/gXtHUzAoxdtWEKGZnF72djUHyk0g
	 rG5r/zwhrbXBA==
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
Subject: [PATCH v3 01/30] block: Do not force full zone append completion in req_bio_endio()
Date: Thu, 28 Mar 2024 09:43:40 +0900
Message-ID: <20240328004409.594888-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_174415_179484_28632E26 
X-CRM114-Status: GOOD (  14.25  )
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

This reverts commit 748dc0b65ec2b4b7b3dbd7befcc4a54fdcac7988.

Partial zone append completions cannot be supported as there is no
guarantees that the fragmented data will be written sequentially in the
same manner as with a full command. Commit 748dc0b65ec2 ("block: fix
partial zone append completion handling in req_bio_endio()") changed
req_bio_endio() to always advance a partially failed BIO by its full
length, but this can lead to incorrect accounting. So revert this
change and let low level device drivers handle this case by always
failing completely zone append operations. With this revert, users will
still see an IO error for a partially completed zone append BIO.

Fixes: 748dc0b65ec2 ("block: fix partial zone append completion handling in req_bio_endio()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-mq.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 555ada922cf0..32afb87efbd0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -770,16 +770,11 @@ static void req_bio_endio(struct request *rq, struct bio *bio,
 		/*
 		 * Partial zone append completions cannot be supported as the
 		 * BIO fragments may end up not being written sequentially.
-		 * For such case, force the completed nbytes to be equal to
-		 * the BIO size so that bio_advance() sets the BIO remaining
-		 * size to 0 and we end up calling bio_endio() before returning.
 		 */
-		if (bio->bi_iter.bi_size != nbytes) {
+		if (bio->bi_iter.bi_size != nbytes)
 			bio->bi_status = BLK_STS_IOERR;
-			nbytes = bio->bi_iter.bi_size;
-		} else {
+		else
 			bio->bi_iter.bi_sector = rq->__sector;
-		}
 	}
 
 	bio_advance(bio, nbytes);
-- 
2.44.0


