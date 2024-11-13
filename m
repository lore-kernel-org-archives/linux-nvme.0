Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5549D462B9
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 15:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AULfdb3WZgUO3JCKZ2NM+vw/f0W+uRYWQJj+bN/yryk=; b=VD6iIZhpo3Ju3TYVxVM7xILchs
	o+Mc1LP0dkenW6qXuR30+IbCTDvBCr6RWH5S3EbW5wer7072IwxtgsTnuY8TUTNsr+J1AbO2ma8Vq
	wJl13p1IjEBet7QBtdCvRaqUB7xbynbPUe8Gz7lX7efEpeLUTvfR4pqneWLc5X4ML+wPoGJWqnhc5
	58Sfhgra8UkAxe5lMp6dbiCpH3HG6yu3sqoTnk/jm8r/fGp/rut8mgp7aAJiAt3xbWXEwl5M6GNUQ
	SGdQhRkn6urasr70EKYhilBEV7RfPvJitrTSV8lKeEu3VXfM/6cujqIxf2hsKYm/IKv/x+66Wi90k
	+0KogIxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFBC-00000007HV2-0XB8;
	Wed, 13 Nov 2024 15:21:14 +0000
Received: from 2a02-8389-2341-5b80-9e61-c6cf-2f07-a796.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9e61:c6cf:2f07:a796] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFB9-00000007HS5-2HE3;
	Wed, 13 Nov 2024 15:21:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org
Subject: [PATCH 6/6] block: don't reorder requests in blk_mq_add_to_batch
Date: Wed, 13 Nov 2024 16:20:46 +0100
Message-ID: <20241113152050.157179-7-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113152050.157179-1-hch@lst.de>
References: <20241113152050.157179-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

LIFO ordering for batched completions is a bit unexpected and also
defeats some merging optimizations in e.g. the XFS buffered write
code.  Now that we can easily add the request to the tail of the list
do that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk-mq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index c61e04365677..c596e0e4cb75 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -884,7 +884,7 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 	else if (iob->complete != complete)
 		return false;
 	iob->need_ts |= blk_mq_need_time_stamp(req);
-	rq_list_add_head(&iob->req_list, req);
+	rq_list_add_tail(&iob->req_list, req);
 	return true;
 }
 
-- 
2.45.2


