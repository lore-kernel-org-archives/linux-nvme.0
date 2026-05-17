Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2451BCD4F3C
	for <linux-nvme@archiver.kernel.org>; Sun, 17 May 2026 22:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HAWq+vjhLlKkDV7pcNfnDGU5AieRK5nEFdmCh3ZmCaw=; b=zSJ8q6M6XBJD9ho9vTfO9tBsOz
	rbXDVujBDZjzl/Ky8Q8kZZVThjvrySa0oRv2ffquFPQjryOTi4udlkVVaVP/tKLldXk7UKYuLbQy1
	qnWMevsjaKyUkX+UVQrPHE4oFKt2agsPZ2RDP6SGdUa0BL+BrCjJJmEqQsuv8GOmRtcobr3Sl+ob1
	p84w47HT+ofiFIgAMUcIz7wFXpYuEPuJa9LWXZeD6SH6K3xbUcKnvM4jrlT5aQJY00y5VJi7iLTYl
	UEFIiaVznHKWHtf8ZZ+Gt3H03ru5tVDrVDT0afpf2pX8QNluU3BF5Tw4dt06w70nIoh9/4SyHwGgI
	DsSLbh1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOkBu-0000000DbNi-06AI;
	Sun, 17 May 2026 22:42:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOkBs-0000000DbNY-2WFU
	for linux-nvme@lists.infradead.org;
	Sun, 17 May 2026 22:42:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 86B6B60055;
	Sun, 17 May 2026 22:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA689C2BCB0;
	Sun, 17 May 2026 22:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779057751;
	bh=3iOivSf6w1GmUE9wsNkmfi5xiRA8ejFL0Xb42zY2nfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4nLtLw4vQcxwBuVpycw5KkOxK3AfSqdDYXBV3gvBhoYxboHzaMxd2uxB8Umy6eK6
	 whLwQeUwdfLLgkdMdxAHstiRIiFoS7Cz5QYLgRf8vlhvuv9hp5zfX95SJKADvW0DDZ
	 YTN+JTbPaQLZuVQk9buQYZDRB7lDtMP13HINGzXOg2WVFcDk28jreKA6OJgGg5/qyQ
	 s4lKeT7ghd9GkdVYzETj2lFPqzzIX9kl03auDN4EhuC7fp0XL9Nl+96l4m4fpNWXKg
	 9eCeO6C0xpX+o8YNkl33S7mG3jEMrAaYcgLYhTBOYwa6ozrYcrodLfr/2I0TUvKN76
	 0U89uJNgQ6+hQ==
Date: Sun, 17 May 2026 16:42:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao S <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to pr_debug
Message-ID: <agpEVUYhyqBxBypz@kbusch-mbp>
References: <20260427003457.1264511-1-coshi036@gmail.com>
 <afzWCpJSqvjnTgpF@kbusch-mbp>
 <CACd_6n29MeACfWpqK5jaSPOVK+q5yop+eeuO_Wk0M0E5Wr7ujw@mail.gmail.com>
 <ago7kyBnaWKU7l3E@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ago7kyBnaWKU7l3E@kbusch-mbp>
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

On Sun, May 17, 2026 at 04:05:07PM -0600, Keith Busch wrote:
> On Sat, May 16, 2026 at 11:53:54PM -0400, Chao S wrote:
> > On Thu, May 07, 2026 at 07:12:26PM +0100, Keith Busch wrote:
> > > [...] how that was defeated [...]
> > 
> > Hi Keith,
> > 
> > Not the freeze.  The WARN does not depend on q->limits, but on
> > ns->head->ms (read live at dispatch, set inside the freeze window) and
> > on REQ_INTEGRITY, never set for EXT_LBAS-non-PI.  capacity==0 only
> > gates submission (bio_check_eod()), not dispatch: a writeback bio that
> > passed bio_check_eod() under the old capacity sits on the task plug
> > holding no q_usage_counter ref, so it does not block the freeze;
> > blk_finish_plug() flushes it after the update committed head->ms != 0
> > (dmesg: the capacity-change line prints before the WARN).
> > 
> > So it is reachable -- the host-unaware geometry change you described,
> > unrelated to your block fix.  The deeper fencing gap is the separate
> > TP-level issue; v2 does not attempt it, it only stops a
> > device-reachable, already-safely-rejected dispatch from being a WARN
> > (a panic under panic_on_warn).
> 
> I think tHe WARN is serving it's intendeded purpose: the block layer
> shouldn't have submitted this request. You can't do generic read/write
> with extended metadatate as the DMA is going to corrupt memory with
> respect to what the block layer expects.
> 
> This driver is depending on the capacity constraint to prevent this
> scenario, so I think The "end-of-device" check needs to happen within
> the entered queue context. If there's a scenario that escapes that
> check, then I think that's what needs fixing, not the driver.

Does this fix it? I don't necessarily like having yet another check in
the hotpath, but should be exactly the check that drivers expected to be
done, so should be cache hot in the normal case.

---
diff --git a/block/blk-core.c b/block/blk-core.c
index 17450058ea6d8..4b5fb32a7d6f8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -553,7 +553,7 @@ ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
  * This may well happen - the kernel calls bread() without checking the size of
  * the device, e.g., when mounting a file system.
  */
-static inline int bio_check_eod(struct bio *bio)
+int bio_check_eod(struct bio *bio)
 {
 	sector_t maxsector = bdev_nr_sectors(bio->bi_bdev);
 	unsigned int nr_sectors = bio_sectors(bio);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8f..b75117ec5c988 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3186,6 +3186,11 @@ void blk_mq_submit_bio(struct bio *bio)
 		goto queue_exit;
 	}
 
+	if (unlikely(bio_check_eod(bio))) {
+		bio_io_error(bio);
+		goto queue_exit;
+	}
+
 	if ((bio->bi_opf & REQ_POLLED) && !blk_mq_can_poll(q)) {
 		bio->bi_status = BLK_STS_NOTSUPP;
 		bio_endio(bio);
diff --git a/block/blk.h b/block/blk.h
index b998a7761faf3..84515bb75485d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -54,6 +54,7 @@ bool blk_queue_start_drain(struct request_queue *q);
 bool __blk_freeze_queue_start(struct request_queue *q,
 			      struct task_struct *owner);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
+int bio_check_eod(struct bio *bio);
 void submit_bio_noacct_nocheck(struct bio *bio, bool split);
 int bio_submit_or_kill(struct bio *bio, unsigned int flags);
 
-- 

