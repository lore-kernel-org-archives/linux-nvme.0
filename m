Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D57AD44150
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 12:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eFnAU/YKrxAyCOfUvcjuy01kOFc9uTpB/T3yj/VVbHA=; b=tvG3OebWxLK8eKdEs2sNITtwTJ
	o16evNhN33udnStFtKuJyuG8yK6ZPpxOn0hH1Kg/LXAkqK8JOyM+hV9h7CQW19KZekkDlGyiHIxX/
	mnv5QfgFgWDqukzhu+EXuhHir1jKghoQNMaPEAustY74cRzm3KUtbMmEDz6iUVX4t+FkgCuoM2XlV
	5H308AOzrhvK3twg4JVsHZVuabL53YoXIOniV5FdY5JEVqMFUzN3i7wV0n1f/IkJ495NgwNB2CDpZ
	wTbDlMO2+dq90t0GK4LzUfzldeOLt+izoAoqcF3nKfQSAxlNh3szgtBo9EkCHaN4zYSI/WO2GE390
	+z3n5ozw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNAG-0000000CJBJ-0l26;
	Tue, 19 Nov 2024 12:17:04 +0000
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNAE-0000000CJ83-1nRx;
	Tue, 19 Nov 2024 12:17:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH 09/15] block: expose write streams for block device nodes
Date: Tue, 19 Nov 2024 13:16:23 +0100
Message-ID: <20241119121632.1225556-10-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119121632.1225556-1-hch@lst.de>
References: <20241119121632.1225556-1-hch@lst.de>
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

Export statx information about the number and granularity of write
streams, use the per-kiocb write hint and map temperature hints
to write streams (which is a bit questionable, but this shows how it is
done).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c |  6 ++++++
 block/fops.c | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 738e3c8457e7..c23245f1fdfe 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1296,6 +1296,12 @@ void bdev_statx(struct path *path, struct kstat *stat,
 		stat->result_mask |= STATX_DIOALIGN;
 	}
 
+	if ((request_mask & STATX_WRITE_STREAM) &&
+	    bdev_max_write_streams(bdev)) {
+		stat->write_stream_max = bdev_max_write_streams(bdev);
+		stat->result_mask |= STATX_WRITE_STREAM;
+	}
+
 	if (request_mask & STATX_WRITE_ATOMIC && bdev_can_atomic_write(bdev)) {
 		struct request_queue *bd_queue = bdev->bd_queue;
 
diff --git a/block/fops.c b/block/fops.c
index 2d01c9007681..2a860dbe5e48 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -72,6 +72,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	}
 	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 	bio.bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
+	bio.bi_write_stream = iocb->ki_write_stream;
 	bio.bi_ioprio = iocb->ki_ioprio;
 	if (iocb->ki_flags & IOCB_ATOMIC)
 		bio.bi_opf |= REQ_ATOMIC;
@@ -201,6 +202,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	for (;;) {
 		bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 		bio->bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
+		bio->bi_write_stream = iocb->ki_write_stream;
 		bio->bi_private = dio;
 		bio->bi_end_io = blkdev_bio_end_io;
 		bio->bi_ioprio = iocb->ki_ioprio;
@@ -317,6 +319,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	dio->iocb = iocb;
 	bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 	bio->bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
+	bio->bi_write_stream = iocb->ki_write_stream;
 	bio->bi_end_io = blkdev_bio_end_io_async;
 	bio->bi_ioprio = iocb->ki_ioprio;
 
@@ -373,6 +376,26 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (blkdev_dio_invalid(bdev, iocb, iter))
 		return -EINVAL;
 
+	if (iov_iter_rw(iter) == WRITE) {
+		u16 max_write_streams = bdev_max_write_streams(bdev);
+
+		if (iocb->ki_write_stream) {
+			if (iocb->ki_write_stream > max_write_streams)
+				return -EINVAL;
+		} else if (max_write_streams) {
+			enum rw_hint write_hint =
+				file_inode(iocb->ki_filp)->i_write_hint;
+
+			/*
+			 * Just use the write hint as write stream for block
+			 * device writes.  This assumes no file system is
+			 * mounted that would use the streams differently.
+			 */
+			if (write_hint <= max_write_streams)
+				iocb->ki_write_stream = write_hint;
+		}
+	}
+
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
 	if (likely(nr_pages <= BIO_MAX_VECS)) {
 		if (is_sync_kiocb(iocb))
-- 
2.45.2


