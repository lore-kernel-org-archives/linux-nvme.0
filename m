Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61B6C5320E
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 07:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r4q9Z2zB00z58Bhwj39sdRfBLaLk7wJquW0n/jUCCYM=; b=Hpeg0CH4eEZDuoProT0hd+8Yik
	jeNMpye5B8QI+nThHwl6+nbF6Ej7z3g1NQ7U+HugswUoeuOtyUY4cAqTL7OhcQ/taB46CPpzhP9HS
	S0iRzZem4LCYFZZSqbgkfKgMK3tStuhy6sTIIQ3NgzOS/AInQyeOAO6826h8Opj3paHSe/gyGXWBc
	jGUn+5KwbM/v7iLCnONhcCG7Jk1nzuxc8IpYD/FteO/QqsECCejrPWzBmNpLHjEcdrKhiX4spuktr
	HzYprLNAAG3qzw/Ey9R9uJZBTq8bLQ2L3Uw+zaDka0XO45LLAhRZFlTXYfYA0LH0RKwa0dUKOZ689
	ysw1OgWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siqb1-0000000ACjM-0FaW;
	Tue, 27 Aug 2024 07:26:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siqay-0000000ACiX-1FAO
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 07:26:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CBB9568BEB; Tue, 27 Aug 2024 09:26:23 +0200 (CEST)
Date: Tue, 27 Aug 2024 09:26:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: pjy@amazon.com
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: BUG Report: kernel NULL pointer dereference in
 bio_integrity_advance()
Message-ID: <20240827072623.GA13080@lst.de>
References: <mb61pcylvnym8.fsf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61pcylvnym8.fsf@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_002628_497771_B7E67E0C 
X-CRM114-Status: GOOD (  18.39  )
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

On Mon, Aug 26, 2024 at 02:32:31PM +0000, pjy@amazon.com wrote:
> This is because in the function:
> 
> void bio_integrity_advance(struct bio *bio, unsigned int bytes_done)
> {
> 	struct bio_integrity_payload *bip = bio_integrity(bio);
> 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
> 	unsigned bytes = bio_integrity_bytes(bi, bytes_done >> 9);
> 
> 	bip->bip_iter.bi_sector += bio_integrity_intervals(bi, bytes_done >> 9);
> 	bvec_iter_advance(bip->bip_vec, &bip->bip_iter, bytes);
> }
> 
> Here blk_get_integrity() returns NULL and bio_integrity_bytes() uses it
> without checking for NULL.

So the above is on a NVMe namespace that does not support metadata?

We currently don't check if a namespace supports metadata before
sending it, so something like the patch below should fix it:

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index f1d58e70933f54..b1d1422f812a63 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2017-2021 Christoph Hellwig.
  */
 #include <linux/bio-integrity.h>
+#include <linux/blk-integrity.h>
 #include <linux/ptrace.h>	/* for force_successful_syscall_return */
 #include <linux/nvme_ioctl.h>
 #include <linux/io_uring/cmd.h>
@@ -121,6 +122,9 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
 	struct bio *bio = NULL;
 	int ret;
+		
+	if (meta_buffer && meta_len && !blk_get_integrity(bdev->bd_disk))
+		return -EINVAL;
 
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;

