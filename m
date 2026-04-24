Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C152FF885A
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 22:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sP0lCimfdvfDSqEeUm59MNd60riyN4YefaPMvPHzWYA=; b=J2EcrwSYY8KmroS95J+LwMWr2b
	fIl7lgJexmn+PqhrlWBhlOo+ayHKKt7C9bxaZi+dwd8frM5/OvCGDy55Xx9x2aUQHe2aLUESNz/y7
	UV3ahWqks4c6wGjual4MBFmT8siqK6QZHlY2XeJjCfzcmf7rjshNTJgNbATrfpIeC1kHvsI8JBlHV
	/ji4IejBdo8HMDUBlrhS8HrZwTUnsP/LAayApvbDVUiD7ZzBLx9fYhg9yZU6P79zp1iexjk4KEUk8
	FNfwQJaqY84Ty4L1x2figfMNZiC/dBX2zLOMnJCP6NehIlDIhlgh21tKYpmkD65/iOyVpTM5Q6NZh
	m4I8gG8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPEJ-0000000DpkP-1CFW;
	Fri, 24 Apr 2026 22:42:35 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPEH-0000000DpiZ-14OZ
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 22:42:34 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g2Sdj0Sh5z1XQmtl;
	Fri, 24 Apr 2026 22:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777070539; x=1779662540; bh=sP0lC
	imfdvfDSqEeUm59MNd60riyN4YefaPMvPHzWYA=; b=0KKHMQh+9wl8nnzvXXX4w
	Iu/d2Xxf+a4RSz2Ets6jyok0LR6gLYCnlcndIvhlYEpTTZf9DrvfZe40fdabqEM3
	WU//0gxmCcW9KftV2HUPPvhcSl28JZmwvjzCvLQFRjo2eOiuij+t0a0UQQDejCFk
	V2bjXY6Z7de2CtQvk4nAeRGi0RGRGLpx0KsZrYLAs4Qn/LuzhBoeUY8zVRisBUTt
	dDfxRkBk3NMbWLf5xsmypTZLAv/s9KMkRrvT/6ksEit7zZCD8bF3BcUKrDwV4dDE
	aZmassXSxEuQZT74paiWwDxl+og70rDJZIc/RiCOWXX4tbMfUX5g4s7dznNDjouV
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eEfDLWO7i0hg; Fri, 24 Apr 2026 22:42:19 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g2SdP3Mp6z1XLHZ6;
	Fri, 24 Apr 2026 22:42:17 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 03/12] block: Introduce blkdev_copy_offload()
Date: Fri, 24 Apr 2026 15:41:52 -0700
Message-ID: <20260424224201.1949243-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
In-Reply-To: <20260424224201.1949243-1-bvanassche@acm.org>
References: <20260424224201.1949243-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_154233_321951_49EE3563 
X-CRM114-Status: GOOD (  31.85  )
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

Introduce blkdev_copy_offload() for performing copy offloading. This
function implements the algorithm explained the description of the
previous patch. If the input parameters exceed what can be supported
with a single copy offload operation, multiple copy offload operations
are submitted.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/Makefile            |   2 +-
 block/blk-copy.c          | 355 ++++++++++++++++++++++++++++++++++++++
 include/linux/blk_types.h |  40 +++++
 include/linux/blkdev.h    |   1 +
 4 files changed, 397 insertions(+), 1 deletion(-)
 create mode 100644 block/blk-copy.c

diff --git a/block/Makefile b/block/Makefile
index 7dce2e44276c..d99e8d4fda7d 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -6,7 +6,7 @@
 obj-y		:=3D bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
 			blk-merge.o blk-timeout.o blk-lib.o blk-mq.o \
-			blk-mq-tag.o blk-mq-dma.o blk-stat.o \
+			blk-mq-tag.o blk-mq-dma.o blk-stat.o blk-copy.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
 			disk-events.o blk-ia-ranges.o early-lookup.o
diff --git a/block/blk-copy.c b/block/blk-copy.c
new file mode 100644
index 000000000000..8ac8879442f7
--- /dev/null
+++ b/block/blk-copy.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Offloaded and onloaded data copying support.
+ */
+#include <linux/bio.h>
+#include <linux/blkdev.h>
+#include <linux/blk-copy.h>
+#include <linux/blk-mq.h>
+
+/* End all bios in the @ctx->bios list with status @ctx->status. */
+static void blkdev_end_bios(struct bio_copy_offload_ctx *ctx)
+{
+	struct bio *bio, *next;
+
+	bio =3D ctx->bios;
+	ctx->bios =3D NULL;
+	for (; bio; bio =3D next) {
+		next =3D bio->bi_next;
+		bio->bi_status =3D ctx->status;
+		bio_endio(bio);
+	}
+}
+
+/*
+ * Called after LBA translation finished for all bios associated with co=
py context
+ * @ctx.
+ */
+static void blkdev_translation_complete(struct bio_copy_offload_ctx *ctx=
)
+{
+	struct module *owner =3D NULL;
+	struct bio *bio;
+
+	WARN_ON_ONCE(ctx->phase !=3D BLKDEV_TRANSLATE_LBAS);
+	ctx->phase =3D BLKDEV_COPY;
+
+	/* Check whether all bios are associated with the same block driver. */
+	for (bio =3D ctx->bios; bio; bio =3D bio->bi_next) {
+		if (!owner) {
+			owner =3D bio->bi_bdev->bd_disk->fops->owner;
+		} else if (owner !=3D bio->bi_bdev->bd_disk->fops->owner) {
+			ctx->status =3D BLK_STS_INVAL;
+			break;
+		}
+	}
+
+	/* Remove the first bio from the bio list and submit it. */
+	bio =3D ctx->bios;
+	ctx->bios =3D bio->bi_next;
+	bio->bi_next =3D NULL;
+	if (ctx->biotail =3D=3D bio)
+		ctx->biotail =3D NULL;
+	if (ctx->status =3D=3D BLK_STS_OK)
+		submit_bio(bio);
+	else
+		bio_endio(bio);
+}
+
+/* REQ_OP_COPY_* completion handler. */
+static void blkdev_req_op_copy_done(struct bio *bio)
+{
+	struct bio_copy_offload_ctx *ctx =3D bio->bi_copy_ctx;
+	struct blk_copy_params *params =3D ctx->params;
+	blk_status_t status;
+
+	switch (ctx->phase) {
+	case BLKDEV_TRANSLATE_LBAS:
+		scoped_guard(spinlock_irqsave, &ctx->lock)
+			if (!ctx->status)
+				ctx->status =3D bio->bi_status;
+		break;
+	case BLKDEV_COPY:
+		status =3D ctx->status;
+		ctx->phase =3D BLKDEV_COPY_DONE;
+		blkdev_end_bios(ctx);
+		kfree(ctx);
+		scoped_guard(spinlock_irqsave, &params->lock) {
+			if (!params->status)
+				params->status =3D status;
+		}
+		if (atomic_dec_and_test(&params->copy_ctx_count))
+			params->end_io(params);
+		break;
+	case BLKDEV_COPY_DONE:
+		break;
+	}
+}
+
+/*
+ * Check that all LBA offsets are aligned with both the source and the d=
estination
+ * logical block sizes. Compare input and output length. Store the numbe=
r of bytes
+ * to be transferred in *@len.
+ */
+static int blkdev_copy_check_params(const struct blk_copy_params *params=
,
+				    loff_t *len)
+{
+	const unsigned int mask =3D
+		max(bdev_logical_block_size(params->in_bdev),
+		    bdev_logical_block_size(params->out_bdev)) - 1;
+	loff_t in_len =3D 0, out_len =3D 0;
+	unsigned int i;
+
+	for (i =3D 0; i < params->in_nseg; i++) {
+		if ((params->in_segs[i].pos | params->in_segs[i].len) & mask)
+			return -EINVAL;
+		in_len +=3D params->in_segs[i].len;
+	}
+
+	for (i =3D 0; i < params->out_nseg; i++) {
+		if ((params->out_segs[i].pos | params->out_segs[i].len) & mask)
+			return -EINVAL;
+		out_len +=3D params->out_segs[i].len;
+	}
+
+	if (in_len !=3D out_len)
+		return -EINVAL;
+
+	*len =3D in_len;
+
+	return 0;
+}
+
+/*
+ * Calculate the number of bytes in the max_copy_src_segments input segm=
ents
+ * starting from input segment @in_idx.
+ */
+static loff_t blk_max_src_len(const struct blk_copy_params *params,
+			      unsigned int in_idx)
+{
+	uint16_t max_src_segments =3D
+		params->in_bdev->bd_queue->limits.max_copy_src_segments;
+	unsigned int max_i =3D min(params->in_nseg, in_idx + max_src_segments);
+	loff_t len =3D 0;
+
+	for (uint32_t i =3D in_idx; i < max_i; i++)
+		len +=3D params->in_segs[i].len;
+
+	return len;
+}
+
+/*
+ * Calculate the number of bytes in the max_copy_dst_segments output seg=
ments
+ * starting from output segment @out_idx.
+ */
+static loff_t blk_max_dst_len(const struct blk_copy_params *params,
+			      unsigned int out_idx)
+{
+	uint16_t max_dst_segments =3D
+		params->out_bdev->bd_queue->limits.max_copy_dst_segments;
+	unsigned int max_i =3D min(params->out_nseg, out_idx + max_dst_segments=
);
+	loff_t len =3D 0;
+
+	for (uint32_t i =3D out_idx; i < max_i; i++)
+		len +=3D params->out_segs[i].len;
+
+	return len;
+}
+
+struct blkdev_copy_sync_ctx {
+	struct completion compl;
+	blk_status_t status;
+};
+
+static void blkdev_end_copy_sync(const struct blk_copy_params *params)
+{
+	struct blkdev_copy_sync_ctx *ctx =3D params->private;
+
+	complete(&ctx->compl);
+}
+
+static int blkdev_copy_sync(struct blk_copy_params *params)
+{
+	struct blkdev_copy_sync_ctx ctx =3D {
+		.compl =3D COMPLETION_INITIALIZER_ONSTACK(ctx.compl),
+	};
+	int ret;
+
+	WARN_ON_ONCE(params->end_io || params->private);
+	params->end_io =3D blkdev_end_copy_sync;
+	params->private =3D &ctx;
+
+	ret =3D blkdev_copy_offload(params);
+	if (ret && ret !=3D -EIOCBQUEUED)
+		return ret;
+
+	wait_for_completion(&ctx.compl);
+	return blk_status_to_errno(ctx.status);
+}
+
+/**
+ * blkdev_copy_chunk() - submit a single copy offload operation
+ * @params: Copy offload input parameters.
+ * @in_idx: Index of the input segment from where to start copying.
+ * @out_idx: Index of the output segment to where to start copying.
+ * @in_offset: Offset in bytes from the start of input segment @in_idx.
+ * @out_offset: Offset in bytes from the start of output segment @out_id=
x.
+ * @chunk: Maximum number of bytes to copy.
+ *
+ * Returns: the number of bytes covered by the submitted copy operation =
or a
+ *	negative error number.
+ */
+static loff_t blkdev_copy_chunk(struct blk_copy_params *params, u32 *in_=
idx,
+				u32 *out_idx, loff_t *in_offset,
+				loff_t *out_offset, loff_t chunk)
+{
+	struct bio_copy_offload_ctx *ctx;
+	u32 bio_count;
+
+	ctx =3D kzalloc_obj(*ctx);
+	if (!ctx)
+		return -ENOMEM;
+
+	spin_lock_init(&ctx->lock);
+	ctx->params =3D params;
+	ctx->phase =3D BLKDEV_TRANSLATE_LBAS;
+	ctx->translation_complete =3D blkdev_translation_complete;
+	/*
+	 * Initialized to one to prevent that ctx->translation_complete() is
+	 * called before bio submission has finished.
+	 */
+	ctx->bio_count =3D 1;
+
+	WARN_ON_ONCE(chunk <=3D 0);
+	chunk =3D min(chunk, blk_max_src_len(params, *in_idx) - *in_offset);
+	WARN_ON_ONCE(chunk <=3D 0);
+	chunk =3D min(chunk, blk_max_dst_len(params, *out_idx) - *out_offset);
+	WARN_ON_ONCE(chunk <=3D 0);
+	ctx->len =3D chunk;
+	for (loff_t bytes, remaining_in =3D chunk; remaining_in > 0;
+	     remaining_in -=3D bytes) {
+		struct bio *src_bio;
+
+		src_bio =3D bio_alloc(params->in_bdev, 0, REQ_OP_COPY_SRC,
+				    GFP_NOIO);
+		if (!src_bio) {
+			if (remaining_in =3D=3D chunk)
+				goto free_ctx;
+			else
+				goto enomem;
+		}
+		atomic_inc(&params->copy_ctx_count);
+		scoped_guard(spinlock_irqsave, &ctx->lock)
+			ctx->bio_count++;
+		bytes =3D min(remaining_in, params->in_segs[*in_idx].len -
+			    *in_offset);
+		src_bio->bi_iter.bi_size =3D bytes;
+		src_bio->bi_iter.bi_sector =3D (params->in_segs[*in_idx].pos +
+					      *in_offset) >> SECTOR_SHIFT;
+		src_bio->bi_copy_ctx =3D ctx;
+		src_bio->bi_end_io =3D blkdev_req_op_copy_done;
+		*in_offset +=3D bytes;
+		if (*in_offset >=3D params->in_segs[*in_idx].len) {
+			*in_offset -=3D params->in_segs[*in_idx].len;
+			(*in_idx)++;
+		}
+		submit_bio(src_bio);
+	}
+	for (loff_t bytes, remaining_out =3D chunk; remaining_out;
+	     remaining_out -=3D bytes) {
+		struct bio *dst_bio;
+
+		dst_bio =3D bio_alloc(params->out_bdev, 0, REQ_OP_COPY_DST,
+				    GFP_NOIO);
+		if (!dst_bio)
+			goto enomem;
+		scoped_guard(spinlock_irqsave, &ctx->lock)
+			ctx->bio_count++;
+		bytes =3D min(remaining_out, params->out_segs[*out_idx].len -
+			    *out_offset);
+		dst_bio->bi_iter.bi_size =3D bytes;
+		dst_bio->bi_iter.bi_sector =3D (params->out_segs[*out_idx].pos +
+					      *out_offset) >> SECTOR_SHIFT;
+		dst_bio->bi_copy_ctx =3D ctx;
+		dst_bio->bi_end_io =3D blkdev_req_op_copy_done;
+		*out_offset +=3D bytes;
+		if (*out_offset >=3D params->out_segs[*out_idx].len) {
+			*out_offset -=3D params->out_segs[*out_idx].len;
+			(*out_idx)++;
+		}
+		submit_bio(dst_bio);
+	}
+
+dec_bio_count:
+	scoped_guard(spinlock_irqsave, &ctx->lock)
+		bio_count =3D --ctx->bio_count;
+	if (bio_count =3D=3D 0)
+		ctx->translation_complete(ctx);
+	return chunk;
+
+enomem:
+	scoped_guard(spinlock_irqsave, &ctx->lock)
+		if (!ctx->status)
+			ctx->status =3D BLK_STS_RESOURCE;
+	chunk =3D -ENOMEM;
+	goto dec_bio_count;
+
+free_ctx:
+	kfree(ctx);
+	return -ENOMEM;
+}
+
+/**
+ * blkdev_copy_offload() - copy data and offload copying if possible.
+ * @params: Source and destination block device, data ranges and complet=
ion
+ *	callback.
+ *
+ * If @params->end_io !=3D NULL, data is copied asynchronously. If @para=
ms->end_io
+ * =3D=3D NULL, this function only returns after data copying finished.
+ *
+ * Return: 0 upon success; -EIOCBQUEUED if the completion callback funct=
ion will
+ *	be called or has already been called; -EOPNOTSUPP if copy offloading =
is
+ *	not supported by the block device or if the source or destination
+ *	address ranges span more than one dm device.
+ */
+int blkdev_copy_offload(struct blk_copy_params *params)
+{
+	loff_t in_offset =3D 0, out_offset =3D 0;
+	u32 in_idx =3D 0, out_idx =3D 0;
+	loff_t len, chunk, max_chunk;
+	int ret;
+
+	might_sleep();
+
+	if (!params->end_io)
+		return blkdev_copy_sync(params);
+
+	spin_lock_init(&params->lock);
+
+	if (!bdev_max_copy_sectors(params->in_bdev) ||
+	    !bdev_max_copy_sectors(params->out_bdev))
+		return -EOPNOTSUPP;
+
+	ret =3D blkdev_copy_check_params(params, &len);
+	if (ret)
+		return ret;
+
+	params->len =3D len;
+
+	max_chunk =3D (u64)min(bdev_max_copy_sectors(params->in_bdev),
+			     bdev_max_copy_sectors(params->out_bdev))
+		    << SECTOR_SHIFT;
+
+	atomic_set(&params->copy_ctx_count, 1);
+
+	for (loff_t offset =3D 0; offset < len; offset +=3D chunk) {
+		chunk =3D min(len - offset, max_chunk);
+		chunk =3D blkdev_copy_chunk(params, &in_idx, &out_idx, &in_offset,
+					  &out_offset, chunk);
+	}
+
+	if (atomic_dec_and_test(&params->copy_ctx_count))
+		params->end_io(params);
+
+	return -EIOCBQUEUED;
+}
+EXPORT_SYMBOL_GPL(blkdev_copy_offload);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4e448e810b87..27a0f92fc2cb 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -535,4 +535,44 @@ struct blk_rq_stat {
 	u64 batch;
 };
=20
+/* A single input or output segment descriptor. */
+struct blk_copy_seg {
+	loff_t pos;
+	loff_t len;
+};
+
+/**
+ * struct blk_copy_params - input parameters and internal parameters for=
 copy
+ *	operations.
+ * @in_bdev: Input block device.
+ * @in_segs: Input LBA ranges.
+ * @in_nseg: Number of elements in @in_segs.
+ * @out_bdev: Output block device.
+ * @out_segs: Output LBA ranges.
+ * @out_nseg: Number of elements in @out_segs.
+ * @end_io: Called after copying data finished. If %NULL, copying data h=
appens
+ *	synchronously instead of asynchronously.
+ * @private: May be used by @end_io. Not used directly.
+ * @len: Total number of bytes to copy. Set by blkdev_copy_offload() or
+ *	blkdev_copy_onload().
+ * @copy_ctxs: Number of in-flight copy contexts associated with copy of=
fload
+ *	operations.
+ * @lock: Protects @status updates.
+ * @status: I/O completion status.
+ */
+struct blk_copy_params {
+	struct block_device *in_bdev;
+	struct blk_copy_seg *in_segs;
+	unsigned int in_nseg;
+	struct block_device *out_bdev;
+	struct blk_copy_seg *out_segs;
+	unsigned int out_nseg;
+	void (*end_io)(const struct blk_copy_params *params);
+	void *private;
+	loff_t len;
+	atomic_t copy_ctx_count;
+	spinlock_t lock;
+	blk_status_t status;
+};
+
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8ae64cc0546f..fea296150cda 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1283,6 +1283,7 @@ void __blkdev_issue_discard(struct block_device *bd=
ev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector=
,
 		sector_t nr_sects, gfp_t gfp);
+int blkdev_copy_offload(struct blk_copy_params *params);
=20
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes =
*/

