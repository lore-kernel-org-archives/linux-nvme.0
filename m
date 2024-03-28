Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF81C54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 00:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iIBhCufjR/Ri/wGNxoTzg+c/DE6dWgZmFKeO5N7LoPk=; b=oaYWfOuKZjMLDqJieepFtzrRWC
	dNcKQEXeehlqvNS+FqaQRBZnHmXNlGL9xTIY/UwJUwumyeHtWh+LtJ+v40fyYCGOkbw7NonGUvnVR
	1KrRPpJsiw7Jtpu0omJnjUkIw3UH9T+rqc8zNCnWjGFwe3uaHDpyErTUl82JZxD7RjbZm3qSclTJF
	X2LM4eTuwTnd3OaIjV0dwYWxo/O8I46R+Jlu7CXPB/KMyb46lQtpLFPub5ShwN30qPhP/bgkWbTsd
	fZ5nYvFX1SZ7MrlsbUgZ64fHgNDXmCUWv92Mdclj3fi30v6NRwRRIufL85+4MNbbINtCNdmvpcH9E
	7W3A9AWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdsT-0000000BnG1-1vHZ;
	Thu, 28 Mar 2024 00:44:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdsQ-0000000BnDp-2SDI
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:44:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 17C01616EC;
	Thu, 28 Mar 2024 00:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61907C43390;
	Thu, 28 Mar 2024 00:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586657;
	bh=S/bqIQEromjzn63uV5lCrPSKRr0yJBlNomhFxuECu0A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=psZLWZ8+7sQrg8dsnV4lrLQFFqDYKgipJ3st8dLa1mF4fSKTLq0mw/1t+7YjjYI4L
	 DXiPusd4mN7ZW7ANRKw3UrD++YaAuK9TUoQ6jKByJLfrQVebgfrwb4GfoG4UbCFS4G
	 aC08063kftNv3reuT3H7psGJUZdG6hjOG7ZYBIRrPjb89+ibRyg5z0j37xhu00R4Yb
	 aGXPDjzgZu2kIvTffZtxmYxXX4mEZx4rBqIGgb/Ar2UO/zzS2np1i6Uo+XGnPes+bl
	 iw0eeofNim2z+grQj0AS34hW2EoyMf8XYWAeZjw1D6rupRkfO0epKpKf4FlY0sjAkR
	 8VolbDvnpo2Hg==
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
Subject: [PATCH v3 03/30] block: Remove req_bio_endio()
Date: Thu, 28 Mar 2024 09:43:42 +0900
Message-ID: <20240328004409.594888-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_174418_769022_8681E401 
X-CRM114-Status: GOOD (  15.37  )
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

Moving req_bio_endio() code into its only caller, blk_update_request(),
allows reducing accesses to and tests of bio and request fields. Also,
given that partial completions of zone append operations is not
possible and that zone append operations cannot be merged, the update
of the BIO sector using the request sector for these operations can be
moved directly before the call to bio_endio().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-mq.c | 58 ++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32afb87efbd0..e55af6058cbf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -761,31 +761,6 @@ void blk_dump_rq_flags(struct request *rq, char *msg)
 }
 EXPORT_SYMBOL(blk_dump_rq_flags);
 
-static void req_bio_endio(struct request *rq, struct bio *bio,
-			  unsigned int nbytes, blk_status_t error)
-{
-	if (unlikely(error)) {
-		bio->bi_status = error;
-	} else if (req_op(rq) == REQ_OP_ZONE_APPEND) {
-		/*
-		 * Partial zone append completions cannot be supported as the
-		 * BIO fragments may end up not being written sequentially.
-		 */
-		if (bio->bi_iter.bi_size != nbytes)
-			bio->bi_status = BLK_STS_IOERR;
-		else
-			bio->bi_iter.bi_sector = rq->__sector;
-	}
-
-	bio_advance(bio, nbytes);
-
-	if (unlikely(rq->rq_flags & RQF_QUIET))
-		bio_set_flag(bio, BIO_QUIET);
-	/* don't actually finish bio if it's part of flush sequence */
-	if (bio->bi_iter.bi_size == 0 && !(rq->rq_flags & RQF_FLUSH_SEQ))
-		bio_endio(bio);
-}
-
 static void blk_account_io_completion(struct request *req, unsigned int bytes)
 {
 	if (req->part && blk_do_io_stat(req)) {
@@ -889,6 +864,8 @@ static void blk_complete_request(struct request *req)
 bool blk_update_request(struct request *req, blk_status_t error,
 		unsigned int nr_bytes)
 {
+	bool is_flush = req->rq_flags & RQF_FLUSH_SEQ;
+	bool quiet = req->rq_flags & RQF_QUIET;
 	int total_bytes;
 
 	trace_block_rq_complete(req, error, nr_bytes);
@@ -909,9 +886,8 @@ bool blk_update_request(struct request *req, blk_status_t error,
 	if (blk_crypto_rq_has_keyslot(req) && nr_bytes >= blk_rq_bytes(req))
 		__blk_crypto_rq_put_keyslot(req);
 
-	if (unlikely(error && !blk_rq_is_passthrough(req) &&
-		     !(req->rq_flags & RQF_QUIET)) &&
-		     !test_bit(GD_DEAD, &req->q->disk->state)) {
+	if (unlikely(error && !blk_rq_is_passthrough(req) && !quiet) &&
+	    !test_bit(GD_DEAD, &req->q->disk->state)) {
 		blk_print_req_error(req, error);
 		trace_block_rq_error(req, error, nr_bytes);
 	}
@@ -923,12 +899,34 @@ bool blk_update_request(struct request *req, blk_status_t error,
 		struct bio *bio = req->bio;
 		unsigned bio_bytes = min(bio->bi_iter.bi_size, nr_bytes);
 
-		if (bio_bytes == bio->bi_iter.bi_size)
+		if (unlikely(error))
+			bio->bi_status = error;
+
+		if (bio_bytes == bio->bi_iter.bi_size) {
 			req->bio = bio->bi_next;
+		} else if (req_op(req) == REQ_OP_ZONE_APPEND &&
+			   error == BLK_STS_OK) {
+			/*
+			 * Partial zone append completions cannot be supported
+			 * as the BIO fragments may end up not being written
+			 * sequentially.
+			 */
+			bio->bi_status = BLK_STS_IOERR;
+		}
 
 		/* Completion has already been traced */
 		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
-		req_bio_endio(req, bio, bio_bytes, error);
+		if (unlikely(quiet))
+			bio_set_flag(bio, BIO_QUIET);
+
+		bio_advance(bio, bio_bytes);
+
+		/* Don't actually finish bio if it's part of flush sequence */
+		if (!bio->bi_iter.bi_size && !is_flush) {
+			if (req_op(req) == REQ_OP_ZONE_APPEND)
+				bio->bi_iter.bi_sector = req->__sector;
+			bio_endio(bio);
+		}
 
 		total_bytes += bio_bytes;
 		nr_bytes -= bio_bytes;
-- 
2.44.0


