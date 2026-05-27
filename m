Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1009ECD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2KEyzXbJPuE0a1jUK29wcgYb0GSLQISya811Z5xV88A=; b=I1yHbV4B9bWUb61cE2HhCKVdJs
	94vTKQkmb8nLI613kFbliq6CKqDY1AtIbfBffiEVgTU1KoWStDrGxhzuChiGQhKi645I97fSjhCs0
	UYqza2GELPJP6isQ2q6Bcn7m69FKl77yhoVGR8KAStxJWaKLnvv8jTKEbwO9OlnVPqygPhdzRTaUC
	kr1HE485anfvSsDN05sWm6Oujkr010B1TRm5WMK3to1jWsOmrt2OUDDVUmr6VkJO3SemBV7FfuSrO
	wis+RIsRzsmQXq9XMIIntjwcJ/ydFLPLgre7aYJVyYho+HTIRsuRdu/I55CUiYLmELhQGuAbv7yOf
	c3eUVVPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFuG-00000004NaD-1zI0;
	Wed, 27 May 2026 15:10:52 +0000
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFuF-00000004NYo-0IjT;
	Wed, 27 May 2026 15:10:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] loop: cleanup lo_rw_aio
Date: Wed, 27 May 2026 17:10:20 +0200
Message-ID: <20260527151043.2349900-2-hch@lst.de>
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

Port over the changes from the zloop driver to remove the need for
the local bio, bvec and offset variables and clean up the code by
that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..310de0463beb 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -342,23 +342,19 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 {
 	struct iov_iter iter;
 	struct req_iterator rq_iter;
-	struct bio_vec *bvec;
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
-	struct bio *bio = rq->bio;
 	struct file *file = lo->lo_backing_file;
-	struct bio_vec tmp;
-	unsigned int offset;
 	unsigned int nr_bvec;
 	int ret;
 
 	nr_bvec = blk_rq_nr_bvec(rq);
 
 	if (rq->bio != rq->biotail) {
+		struct bio_vec tmp, *bvec;
 
-		bvec = kmalloc_objs(struct bio_vec, nr_bvec, GFP_NOIO);
-		if (!bvec)
+		cmd->bvec = kmalloc_objs(*cmd->bvec, nr_bvec, GFP_NOIO);
+		if (!cmd->bvec)
 			return -EIO;
-		cmd->bvec = bvec;
 
 		/*
 		 * The bios of the request may be started from the middle of
@@ -366,26 +362,26 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		 * copy bio->bi_iov_vec to new bvec. The rq_for_each_bvec
 		 * API will take care of all details for us.
 		 */
+		bvec = cmd->bvec;
 		rq_for_each_bvec(tmp, rq, rq_iter) {
 			*bvec = tmp;
 			bvec++;
 		}
-		bvec = cmd->bvec;
-		offset = 0;
+		iov_iter_bvec(&iter, rw, cmd->bvec, nr_bvec, blk_rq_bytes(rq));
+		iter.iov_offset = 0;
 	} else {
 		/*
 		 * Same here, this bio may be started from the middle of the
 		 * 'bvec' because of bio splitting, so offset from the bvec
 		 * must be passed to iov iterator
 		 */
-		offset = bio->bi_iter.bi_bvec_done;
-		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
+		iov_iter_bvec(&iter, rw,
+			__bvec_iter_bvec(rq->bio->bi_io_vec, rq->bio->bi_iter),
+			nr_bvec, blk_rq_bytes(rq));
+		iter.iov_offset = rq->bio->bi_iter.bi_bvec_done;
 	}
 	atomic_set(&cmd->ref, 2);
 
-	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
-	iter.iov_offset = offset;
-
 	cmd->iocb.ki_pos = pos;
 	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
-- 
2.53.0


