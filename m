Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560A1CD1297
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 05:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/pPRLpo3z61egoHz+yhoio6BWOGbdq9PFRCbsFUyggE=; b=0NdGqejdnK6Fx290AipiYfgw3c
	9YDayt5WbglCT6WvtcXq5fYwTuJIDMTwItUEpQKKfbEBMO6NJ1XgEV2C9UlNXmUfJtOAgMKhmEMzc
	z1XniYU4z7iDJpgtLm+Nn0zxnfz/B08zUxi8TAnpxoFn+xNTOWu1cjXhxAS0epsgl/MIw8Wenm7T/
	mogvlnU7XFQgvZvx8TtxYP4Ecnq2wrbWQDLsR4mG74uz3HqKfq/ZoP7tEGyRECGdKNGez14o+r61x
	aFoaa6sNgpanBti+XIh3/JDePyVrraT6K8CbmOB2+FnG+69xTI4sR9KTSqOnPKlCvW+1/pKF8CoiJ
	QSXX29fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscSS-00000005LPO-348B;
	Fri, 05 Apr 2024 05:49:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbPe-00000005BbE-1leT
	for linux-nvme@bombadil.infradead.org;
	Fri, 05 Apr 2024 04:42:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=/pPRLpo3z61egoHz+yhoio6BWOGbdq9PFRCbsFUyggE=; b=HRnUgG2iv5xqHtdadiROjGXDpf
	00oZZ1O5Cgtxiwdw30V+UEm/Hdu0em5jfcGiPLp0gjwVcOqi0GH0dk0ZtgOg6/GnK8aknGNfeNJ68
	uoIiVMa/dbNgY+Pn9CxvlN9LUE63NrU4Lp21gDuAIWslKlgG6LVu5i7/v9upRuVEVSmtR7WADl3sX
	MdNayWzIWWWJJ4WK9ISIGP6u0SP87ZvAPS4aldb5hdajuqK8MmJRHInd4QSZCfLxFWg021nnUJutv
	r61eMyhdhBTu7OjIDNP7/nmhSMrpIyr8ce4FDXsYkQyvLOdNtin4ibQZiaNHXK7yv4hrUf+bxTecX
	35RGB0yg==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbPY-00000005PL0-2q9v
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 04:42:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A7FD26189D;
	Fri,  5 Apr 2024 04:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F6AC433C7;
	Fri,  5 Apr 2024 04:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712292160;
	bh=E2v5U0YF9ZxevipD+89HMq04gTozrT9G7N1H2nvm/ag=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uelITkzb+PYKlkW4wTtLXfczSY9VsakDrSUCYDdrjtCQ6m1I/kVdnvzJoG5YcUjS+
	 LcLN65OH3KYLQeoBx9aLzmcs3Zl+OVAXkkO9XvUYrG/3R1rh07Xwrq5jMYW9gEaR9h
	 qS/U0tk+0N4YBUGQ+GM3pD+OoZMo77RBqUTJQxTz83Y92yNHcgrNV6p/4KR26CmKm9
	 ufMBzgblI3nb17wZ+Xz62ZDENBbxmS4eZnba4pj0cQ5c+ZUPrT/k9YkO35TeMg1NKu
	 H8uxNlbJoyDkGRasjTQpMMtZJvkqxufukWaYHhHrn5CFD3N9wrKQsZXX6mgWDHaKhO
	 o1lkzbmjC9HFg==
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
Subject: [PATCH v6 21/28] block: mq-deadline: Remove support for zone write locking
Date: Fri,  5 Apr 2024 13:42:00 +0900
Message-ID: <20240405044207.1123462-22-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405044207.1123462-1-dlemoal@kernel.org>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_054245_240574_92D9CAFD 
X-CRM114-Status: GOOD (  29.47  )
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

With the block layer generic plugging of write operations for zoned
block devices, mq-deadline, or any other scheduler, can only ever
see at most one write operation per zone at any time. There is thus no
sequentiality requirements for these writes and thus no need to tightly
control the dispatching of write requests using zone write locking.

Remove all the code that implement this control in the mq-deadline
scheduler and remove advertizing support for the
ELEVATOR_F_ZBD_SEQ_WRITE elevator feature.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 block/mq-deadline.c | 176 ++------------------------------------------
 1 file changed, 6 insertions(+), 170 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 02a916ba62ee..dce8d746b5bd 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -102,7 +102,6 @@ struct deadline_data {
 	int prio_aging_expire;
 
 	spinlock_t lock;
-	spinlock_t zone_lock;
 };
 
 /* Maps an I/O priority class to a deadline scheduler priority. */
@@ -157,8 +156,7 @@ deadline_latter_request(struct request *rq)
 }
 
 /*
- * Return the first request for which blk_rq_pos() >= @pos. For zoned devices,
- * return the first request after the start of the zone containing @pos.
+ * Return the first request for which blk_rq_pos() >= @pos.
  */
 static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
 				enum dd_data_dir data_dir, sector_t pos)
@@ -170,14 +168,6 @@ static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
 		return NULL;
 
 	rq = rb_entry_rq(node);
-	/*
-	 * A zoned write may have been requeued with a starting position that
-	 * is below that of the most recently dispatched request. Hence, for
-	 * zoned writes, start searching from the start of a zone.
-	 */
-	if (blk_rq_is_seq_zoned_write(rq))
-		pos = round_down(pos, rq->q->limits.chunk_sectors);
-
 	while (node) {
 		rq = rb_entry_rq(node);
 		if (blk_rq_pos(rq) >= pos) {
@@ -308,36 +298,6 @@ static inline bool deadline_check_fifo(struct dd_per_prio *per_prio,
 	return time_is_before_eq_jiffies((unsigned long)rq->fifo_time);
 }
 
-/*
- * Check if rq has a sequential request preceding it.
- */
-static bool deadline_is_seq_write(struct deadline_data *dd, struct request *rq)
-{
-	struct request *prev = deadline_earlier_request(rq);
-
-	if (!prev)
-		return false;
-
-	return blk_rq_pos(prev) + blk_rq_sectors(prev) == blk_rq_pos(rq);
-}
-
-/*
- * Skip all write requests that are sequential from @rq, even if we cross
- * a zone boundary.
- */
-static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
-						struct request *rq)
-{
-	sector_t pos = blk_rq_pos(rq);
-
-	do {
-		pos += blk_rq_sectors(rq);
-		rq = deadline_latter_request(rq);
-	} while (rq && blk_rq_pos(rq) == pos);
-
-	return rq;
-}
-
 /*
  * For the specified data direction, return the next request to
  * dispatch using arrival ordered lists.
@@ -346,40 +306,10 @@ static struct request *
 deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		      enum dd_data_dir data_dir)
 {
-	struct request *rq, *rb_rq, *next;
-	unsigned long flags;
-
 	if (list_empty(&per_prio->fifo_list[data_dir]))
 		return NULL;
 
-	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
-		return rq;
-
-	/*
-	 * Look for a write request that can be dispatched, that is one with
-	 * an unlocked target zone. For some HDDs, breaking a sequential
-	 * write stream can lead to lower throughput, so make sure to preserve
-	 * sequential write streams, even if that stream crosses into the next
-	 * zones and these zones are unlocked.
-	 */
-	spin_lock_irqsave(&dd->zone_lock, flags);
-	list_for_each_entry_safe(rq, next, &per_prio->fifo_list[DD_WRITE],
-				 queuelist) {
-		/* Check whether a prior request exists for the same zone. */
-		rb_rq = deadline_from_pos(per_prio, data_dir, blk_rq_pos(rq));
-		if (rb_rq && blk_rq_pos(rb_rq) < blk_rq_pos(rq))
-			rq = rb_rq;
-		if (blk_req_can_dispatch_to_zone(rq) &&
-		    (blk_queue_nonrot(rq->q) ||
-		     !deadline_is_seq_write(dd, rq)))
-			goto out;
-	}
-	rq = NULL;
-out:
-	spin_unlock_irqrestore(&dd->zone_lock, flags);
-
-	return rq;
+	return rq_entry_fifo(per_prio->fifo_list[data_dir].next);
 }
 
 /*
@@ -390,36 +320,8 @@ static struct request *
 deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		      enum dd_data_dir data_dir)
 {
-	struct request *rq;
-	unsigned long flags;
-
-	rq = deadline_from_pos(per_prio, data_dir,
-			       per_prio->latest_pos[data_dir]);
-	if (!rq)
-		return NULL;
-
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
-		return rq;
-
-	/*
-	 * Look for a write request that can be dispatched, that is one with
-	 * an unlocked target zone. For some HDDs, breaking a sequential
-	 * write stream can lead to lower throughput, so make sure to preserve
-	 * sequential write streams, even if that stream crosses into the next
-	 * zones and these zones are unlocked.
-	 */
-	spin_lock_irqsave(&dd->zone_lock, flags);
-	while (rq) {
-		if (blk_req_can_dispatch_to_zone(rq))
-			break;
-		if (blk_queue_nonrot(rq->q))
-			rq = deadline_latter_request(rq);
-		else
-			rq = deadline_skip_seq_writes(dd, rq);
-	}
-	spin_unlock_irqrestore(&dd->zone_lock, flags);
-
-	return rq;
+	return deadline_from_pos(per_prio, data_dir,
+				 per_prio->latest_pos[data_dir]);
 }
 
 /*
@@ -525,10 +427,6 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 		rq = next_rq;
 	}
 
-	/*
-	 * For a zoned block device, if we only have writes queued and none of
-	 * them can be dispatched, rq will be NULL.
-	 */
 	if (!rq)
 		return NULL;
 
@@ -549,10 +447,6 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	prio = ioprio_class_to_prio[ioprio_class];
 	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
 	dd->per_prio[prio].stats.dispatched++;
-	/*
-	 * If the request needs its target zone locked, do it.
-	 */
-	blk_req_zone_write_lock(rq);
 	rq->rq_flags |= RQF_STARTED;
 	return rq;
 }
@@ -722,7 +616,6 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	dd->fifo_batch = fifo_batch;
 	dd->prio_aging_expire = prio_aging_expire;
 	spin_lock_init(&dd->lock);
-	spin_lock_init(&dd->zone_lock);
 
 	/* We dispatch from request queue wide instead of hw queue */
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
@@ -804,12 +697,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	lockdep_assert_held(&dd->lock);
 
-	/*
-	 * This may be a requeue of a write request that has locked its
-	 * target zone. If it is the case, this releases the zone lock.
-	 */
-	blk_req_zone_write_unlock(rq);
-
 	prio = ioprio_class_to_prio[ioprio_class];
 	per_prio = &dd->per_prio[prio];
 	if (!rq->elv.priv[0]) {
@@ -841,18 +728,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		 */
 		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
 		insert_before = &per_prio->fifo_list[data_dir];
-#ifdef CONFIG_BLK_DEV_ZONED
-		/*
-		 * Insert zoned writes such that requests are sorted by
-		 * position per zone.
-		 */
-		if (blk_rq_is_seq_zoned_write(rq)) {
-			struct request *rq2 = deadline_latter_request(rq);
-
-			if (rq2 && blk_rq_zone_no(rq2) == blk_rq_zone_no(rq))
-				insert_before = &rq2->queuelist;
-		}
-#endif
 		list_add_tail(&rq->queuelist, insert_before);
 	}
 }
@@ -887,33 +762,8 @@ static void dd_prepare_request(struct request *rq)
 	rq->elv.priv[0] = NULL;
 }
 
-static bool dd_has_write_work(struct blk_mq_hw_ctx *hctx)
-{
-	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
-	enum dd_prio p;
-
-	for (p = 0; p <= DD_PRIO_MAX; p++)
-		if (!list_empty_careful(&dd->per_prio[p].fifo_list[DD_WRITE]))
-			return true;
-
-	return false;
-}
-
 /*
  * Callback from inside blk_mq_free_request().
- *
- * For zoned block devices, write unlock the target zone of
- * completed write requests. Do this while holding the zone lock
- * spinlock so that the zone is never unlocked while deadline_fifo_request()
- * or deadline_next_request() are executing. This function is called for
- * all requests, whether or not these requests complete successfully.
- *
- * For a zoned block device, __dd_dispatch_request() may have stopped
- * dispatching requests if all the queued requests are write requests directed
- * at zones that are already locked due to on-going write requests. To ensure
- * write request dispatch progress in this case, mark the queue as needing a
- * restart to ensure that the queue is run again after completion of the
- * request and zones being unlocked.
  */
 static void dd_finish_request(struct request *rq)
 {
@@ -928,21 +778,8 @@ static void dd_finish_request(struct request *rq)
 	 * called dd_insert_requests(). Skip requests that bypassed I/O
 	 * scheduling. See also blk_mq_request_bypass_insert().
 	 */
-	if (!rq->elv.priv[0])
-		return;
-
-	atomic_inc(&per_prio->stats.completed);
-
-	if (blk_queue_is_zoned(q)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&dd->zone_lock, flags);
-		blk_req_zone_write_unlock(rq);
-		spin_unlock_irqrestore(&dd->zone_lock, flags);
-
-		if (dd_has_write_work(rq->mq_hctx))
-			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);
-	}
+	if (rq->elv.priv[0])
+		atomic_inc(&per_prio->stats.completed);
 }
 
 static bool dd_has_work_for_prio(struct dd_per_prio *per_prio)
@@ -1266,7 +1103,6 @@ static struct elevator_type mq_deadline = {
 	.elevator_attrs = deadline_attrs,
 	.elevator_name = "mq-deadline",
 	.elevator_alias = "deadline",
-	.elevator_features = ELEVATOR_F_ZBD_SEQ_WRITE,
 	.elevator_owner = THIS_MODULE,
 };
 MODULE_ALIAS("mq-deadline-iosched");
-- 
2.44.0


