Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E702FCD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mm/qnc7jP80KHSMsNawLUGCDZW5gR0UcuDRrCHUzi2c=; b=I5eB3z6mlJNk3rEXTnrjefKNoI
	Q1ucg9sN0kj1HwSA/i/wjY0wWdyclrO3IECY3C7Fy3qfc37ggVTbORwQ3sEJ92rRt8AE1P7nq3QkT
	2ZgRnOBGMMo7hBzSDQEBCbG87mOa9l2hh/d04CDFbl5jIVIXGcw0DIS02KuWy8OzLSa1DxPIMtizK
	PHT/+k6Mt1z6gMT3nk3HR/+lF4gDI+VEG6woa+RcEJPG55+2iL5/LA684UVOZ1KVW0IoT108Od2rd
	9AXFY92O73Cm6otBMyfwcp1s+h3riY027DChgdM5KrCAFhoSld6A5SdCKvfgTlBashiUN/bp44vbM
	SXmohzkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFuK-00000004Nbu-2SKD;
	Wed, 27 May 2026 15:10:56 +0000
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFuI-00000004NZx-46t3;
	Wed, 27 May 2026 15:10:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvme-tcp: cleanup nvme_tcp_init_iter
Date: Wed, 27 May 2026 17:10:21 +0200
Message-ID: <20260527151043.2349900-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527151043.2349900-1-hch@lst.de>
References: <20260527151043.2349900-1-hch@lst.de>
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

Split the two init cases based on code in the zloop driver.  This
simplifies the code and makes it easier to follow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/tcp.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 36b3ec50a9fd..9313ab211c67 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -340,32 +340,25 @@ static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
 		unsigned int dir)
 {
 	struct request *rq = blk_mq_rq_from_pdu(req);
-	struct bio_vec *vec;
-	unsigned int size;
-	int nr_bvec;
-	size_t offset;
 
 	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		vec = &rq->special_vec;
-		nr_bvec = 1;
-		size = blk_rq_payload_bytes(rq);
-		offset = 0;
+		iov_iter_bvec(&req->iter, dir, &rq->special_vec, 1,
+				blk_rq_payload_bytes(rq));
+		req->iter.iov_offset = 0;
 	} else {
 		struct bio *bio = req->curr_bio;
 		struct bvec_iter bi;
 		struct bio_vec bv;
+		int nr_bvec = 0;
 
-		vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
-		nr_bvec = 0;
-		bio_for_each_bvec(bv, bio, bi) {
+		bio_for_each_bvec(bv, bio, bi)
 			nr_bvec++;
-		}
-		size = bio->bi_iter.bi_size;
-		offset = bio->bi_iter.bi_bvec_done;
-	}
 
-	iov_iter_bvec(&req->iter, dir, vec, nr_bvec, size);
-	req->iter.iov_offset = offset;
+		iov_iter_bvec(&req->iter, dir,
+			__bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter), nr_bvec,
+			bio->bi_iter.bi_size);
+		req->iter.iov_offset = bio->bi_iter.bi_bvec_done;
+	}
 }
 
 static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
-- 
2.53.0


