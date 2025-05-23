Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C886C54ED0
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 14:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6doQPpYhjYjpofhzi8sE2USoJ4axG1fgmnATV43tg0I=; b=f7pzX9IVCyyybp8F2jm5rHkY6Y
	aLUdZQpCHCbJk7qW4gbE/WzQ+Vi/kzflDLNioQ7nbkcN1NdIwbLTiLlvyV8I5ngKwtH9QIIKKpVoJ
	fRSLV2j+urey+SFZnmF/RkXVw9FtCRmGYWjLdAfI1RXRSZU9Er2vNWqEIHsKe6ZK8qBARtjfnTAOJ
	9BXB9VfPWHyc2U3FSEpyO9ODGb4OFol3eLuhGJ407CcY/HVPPuzp/hdvidcKXobVqFW6R5GfRQ2w8
	ns4TQAQwsr9Hr83j583gYkL6zsMoqkDsTjx+66xdYyw/OmNB5xM0WyYaYFV8JikdoW1JeNcqz0Tqp
	e/EVyfmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uITb8-000000045b4-2eXr;
	Fri, 23 May 2025 14:42:10 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uISab-00000003yzp-375K;
	Fri, 23 May 2025 13:37:33 +0000
Date: Fri, 23 May 2025 06:37:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] block: add support for copy offload
Message-ID: <aDB6Hdp9ZQ1gX5gr@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-3-kbusch@meta.com>
 <aDBuQbsBRVjOc5wU@infradead.org>
 <aDB3lSQRLxjDHTSE@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDB3lSQRLxjDHTSE@kbusch-mbp>
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

On Fri, May 23, 2025 at 07:26:45AM -0600, Keith Busch wrote:
> > Urrgg.  Please don't overload the bio_vec. We've been working hard to
> > generalize it and share the data structures with more users in the
> > block layer. 
> 
> Darn, this part of the proposal is really the core concept of this patch
> set that everything builds around. It's what allows submitting
> arbitrarily large sized copy requests and letting the block layer
> efficiently split a bio to the queue limits later.

Well, you can still do that without overloading the bio_bvec by just
making bi_io_vec in the bio itself a union.

> 
> > If having a bio for each source range is too much overhead
> > for your user case (but I'd like to numbers for that), we'll need to
> > find a way to do that without overloading the actual bio_vec structure.
> 
> Getting good numbers might be a problem in the near term. The current
> generation of devices I have access to that can do copy offload don't
> have asic support for it, so it is instrumented entirely in firmware.
> The performance is currently underwhelming, but I expect next generation
> to be much better.

I meant numbers for the all in one bio vs multiple bios approach.
For hardware I think the main benefit is to not use host dram
bandwith.

Anyway, below is a patch to wire it up to the XFS garbage collection
daemin.  It survices the xfstests test cases for GC when run on a
conventional device, but otherwise I've not done much testing with it.

It shows two things, though:

 - right now there is block layer merging, and we always see single
   range bios.  That is really annoying, and fixing the fs code to
   submit multiple ranges in one go would be really annoying, as
   extent-based completions hang off the bio completions.  So I'd
   really like to block layer merges similar to what the old
   multi-bio code or the discard code do.
 - copy also needs to be handled by the zoned write plugs
 - bio_add_copy_src not updating bi_size is unexpected and annoying :)

diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
index 8c541ca71872..e7dfdbbcf126 100644
--- a/fs/xfs/xfs_zone_gc.c
+++ b/fs/xfs/xfs_zone_gc.c
@@ -158,6 +158,8 @@ struct xfs_zone_gc_data {
 	 * Iterator for the victim zone.
 	 */
 	struct xfs_zone_gc_iter		iter;
+
+	bool				can_copy;
 };
 
 /*
@@ -212,12 +214,19 @@ xfs_zone_gc_data_alloc(
 	if (bioset_init(&data->bio_set, 16, offsetof(struct xfs_gc_bio, bio),
 			BIOSET_NEED_BVECS))
 		goto out_free_recs;
-	for (i = 0; i < XFS_ZONE_GC_NR_SCRATCH; i++) {
-		data->scratch[i].folio =
-			folio_alloc(GFP_KERNEL, get_order(XFS_GC_CHUNK_SIZE));
-		if (!data->scratch[i].folio)
-			goto out_free_scratch;
+
+	if (bdev_copy_sectors(mp->m_rtdev_targp->bt_bdev)) {
+		xfs_info(mp, "using copy offload");
+		data->can_copy = true;
+	} else {
+		for (i = 0; i < XFS_ZONE_GC_NR_SCRATCH; i++) {
+			data->scratch[i].folio = folio_alloc(GFP_KERNEL,
+					get_order(XFS_GC_CHUNK_SIZE));
+			if (!data->scratch[i].folio)
+				goto out_free_scratch;
+		}
 	}
+
 	INIT_LIST_HEAD(&data->reading);
 	INIT_LIST_HEAD(&data->writing);
 	INIT_LIST_HEAD(&data->resetting);
@@ -241,8 +250,10 @@ xfs_zone_gc_data_free(
 {
 	int			i;
 
-	for (i = 0; i < XFS_ZONE_GC_NR_SCRATCH; i++)
-		folio_put(data->scratch[i].folio);
+	if (!data->can_copy) {
+		for (i = 0; i < XFS_ZONE_GC_NR_SCRATCH; i++)
+			folio_put(data->scratch[i].folio);
+	}
 	bioset_exit(&data->bio_set);
 	kfree(data->iter.recs);
 	kfree(data);
@@ -589,6 +600,8 @@ static unsigned int
 xfs_zone_gc_scratch_available(
 	struct xfs_zone_gc_data	*data)
 {
+	if (data->can_copy)
+		return UINT_MAX;
 	return XFS_GC_CHUNK_SIZE - data->scratch[data->scratch_idx].offset;
 }
 
@@ -690,7 +703,10 @@ xfs_zone_gc_start_chunk(
 		return false;
 	}
 
-	bio = bio_alloc_bioset(bdev, 1, REQ_OP_READ, GFP_NOFS, &data->bio_set);
+	bio = bio_alloc_bioset(bdev, 1,
+			data->can_copy ? REQ_OP_COPY : REQ_OP_READ,
+			GFP_NOFS, &data->bio_set);
+	bio->bi_end_io = xfs_zone_gc_end_io;
 
 	chunk = container_of(bio, struct xfs_gc_bio, bio);
 	chunk->ip = ip;
@@ -700,21 +716,38 @@ xfs_zone_gc_start_chunk(
 		xfs_rgbno_to_rtb(iter->victim_rtg, irec.rm_startblock);
 	chunk->new_daddr = daddr;
 	chunk->is_seq = is_seq;
-	chunk->scratch = &data->scratch[data->scratch_idx];
 	chunk->data = data;
 	chunk->oz = oz;
 
-	bio->bi_iter.bi_sector = xfs_rtb_to_daddr(mp, chunk->old_startblock);
-	bio->bi_end_io = xfs_zone_gc_end_io;
-	bio_add_folio_nofail(bio, chunk->scratch->folio, chunk->len,
-			chunk->scratch->offset);
-	chunk->scratch->offset += chunk->len;
-	if (chunk->scratch->offset == XFS_GC_CHUNK_SIZE) {
-		data->scratch_idx =
-			(data->scratch_idx + 1) % XFS_ZONE_GC_NR_SCRATCH;
+	if (data->can_copy) {
+		struct bio_vec src = {
+			.bv_sector =
+				xfs_rtb_to_daddr(mp, chunk->old_startblock),
+			.bv_sectors = BTOBB(chunk->len),
+		};
+
+		bio_add_copy_src(bio, &src);
+		bio->bi_iter.bi_sector = daddr;
+		bio->bi_iter.bi_size = chunk->len;
+
+		WRITE_ONCE(chunk->state, XFS_GC_BIO_NEW);
+		list_add_tail(&chunk->entry, &data->writing);
+	} else {
+		chunk->scratch = &data->scratch[data->scratch_idx];
+
+		bio->bi_iter.bi_sector =
+			xfs_rtb_to_daddr(mp, chunk->old_startblock);
+		bio_add_folio_nofail(bio, chunk->scratch->folio, chunk->len,
+				chunk->scratch->offset);
+		chunk->scratch->offset += chunk->len;
+		if (chunk->scratch->offset == XFS_GC_CHUNK_SIZE) {
+			data->scratch_idx =
+				(data->scratch_idx + 1) %
+					XFS_ZONE_GC_NR_SCRATCH;
+		}
+		WRITE_ONCE(chunk->state, XFS_GC_BIO_NEW);
+		list_add_tail(&chunk->entry, &data->reading);
 	}
-	WRITE_ONCE(chunk->state, XFS_GC_BIO_NEW);
-	list_add_tail(&chunk->entry, &data->reading);
 	xfs_zone_gc_iter_advance(iter, irec.rm_blockcount);
 
 	submit_bio(bio);
@@ -839,10 +872,12 @@ xfs_zone_gc_finish_chunk(
 		return;
 	}
 
-	chunk->scratch->freed += chunk->len;
-	if (chunk->scratch->freed == chunk->scratch->offset) {
-		chunk->scratch->offset = 0;
-		chunk->scratch->freed = 0;
+	if (!chunk->data->can_copy) {
+		chunk->scratch->freed += chunk->len;
+		if (chunk->scratch->freed == chunk->scratch->offset) {
+			chunk->scratch->offset = 0;
+			chunk->scratch->freed = 0;
+		}
 	}
 
 	/*

