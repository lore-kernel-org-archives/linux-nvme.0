Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2A2C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 08:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hOWeWH6hvi2201kQLVb6boL5Ejp6JjvpUkhPZE1X5w8=; b=f+DdCKNAyMjsc6Xg6Jf92s9Wa5
	7U0CV0gBtLJwLl0eZpTiQh2URwsnYMfxIXqoVXg44NOWyQtVgitz7ViPgI+5MQ6QPV3pV4OPDBUqN
	eJfk2ez+IJAIupzWa3ZJF7XrucM+SbLAWDt+kFaZVajZ2VkKjfNXnWb2jVlNuXXpHyRN40oWrsg2X
	8N8NsnnPUB8eY59BH2ehaiipLmE9BalncIO0cpB4CbRHjCra6zJFQetlddgrBzpIAIj60kEo/sisb
	pp147wQcj36acs2yHzbLgQ5vSViGlNmUpbgqmmiX+jD/N65tmmq/qX+DESU2QpLXW0P8NK6VpuD5Y
	N1yUKNFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwCu-0000000EyaL-3IGo;
	Wed, 03 Apr 2024 08:42:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwCr-0000000EyYs-2kDK
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 08:42:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2F99F61349;
	Wed,  3 Apr 2024 08:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB466C433B1;
	Wed,  3 Apr 2024 08:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133773;
	bh=q0Zy99bP83WbjKg0IGQneTwwnlnEYLjCem44Js5QK/0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tNDfnk5smhubh8TeFLFt+QL5tGEz9LT8xwaqAZkooRFAXeYFaogjIpTRAuczVbYdQ
	 LAHZ5qZQjxpNIqu6K8XDx5LKA4cjWiGLcVCDvGH7dksz6EM29p4yWSBQNhslnwcEcn
	 aH6qeWqHSYL1y7aYgtUSDGWajw06O1G0toKBfl792P61NUCSXxAvLNALYBUeNG6CXN
	 HJh1r3wr1sCf3BhHxD1ak6K+1umqqd0vj4UBi7Zsv5TfM9kYF2LSzEkB5JV8s06ibm
	 yfbJPfZMOH8IePydakXe8WbAItvI9yhfgSxKKrlXplkNQ6V1DypJt+Ngc0G6jgrVpy
	 cbYmpEIefx2bw==
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
Subject: [PATCH v5 02/28] block: Remove req_bio_endio()
Date: Wed,  3 Apr 2024 17:42:21 +0900
Message-ID: <20240403084247.856481-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403084247.856481-1-dlemoal@kernel.org>
References: <20240403084247.856481-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_014253_806361_CED11589 
X-CRM114-Status: GOOD (  15.94  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c | 58 ++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b8dbfed8b28b..fcbf0953a179 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -762,31 +762,6 @@ void blk_dump_rq_flags(struct request *rq, char *msg)
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
@@ -890,6 +865,8 @@ static void blk_complete_request(struct request *req)
 bool blk_update_request(struct request *req, blk_status_t error,
 		unsigned int nr_bytes)
 {
+	bool is_flush = req->rq_flags & RQF_FLUSH_SEQ;
+	bool quiet = req->rq_flags & RQF_QUIET;
 	int total_bytes;
 
 	trace_block_rq_complete(req, error, nr_bytes);
@@ -910,9 +887,8 @@ bool blk_update_request(struct request *req, blk_status_t error,
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
@@ -924,12 +900,34 @@ bool blk_update_request(struct request *req, blk_status_t error,
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


