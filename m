Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5C1CDB482
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 05:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rrApDSK8LhmrUsgAWoAWx1t6oo2HNCJl+fzUvIjFTDs=; b=OAcVklx0HZgryggB4g71KEgUC/
	QLIDtDuT8wdothGMYeuyz6kD6tF9UN2wT7RwT0LgwTeqVQzV0zSLGqBWlRu/keIZbwo2flfdNJ1EC
	+TuxmjHipEbZm4sgRW2MhJSMPLVsWRlWpNp3K2zuMY1IEcoKA1RpI9vnZumvSkRNIWvBU/shpcMLs
	3k48Ksn7AR0iFehdwvmYB6wx1AWTayaSKNXZWoalO1+liHmE/NxtKr45hRyYPFZfIvHMnnJHfrWdg
	lojMNjl2jfKyAe5j0F+AvZfcl4UIaWlce1nJDuIKrOmGFzOLTIcXWcqiOwvGTsc5/u6asOvxV1rmI
	fIzxTzcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLkV-00GMf4-2R;
	Thu, 19 Oct 2023 05:39:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLkT-00GMdc-12
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 05:39:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D0D467373; Thu, 19 Oct 2023 07:39:05 +0200 (CEST)
Date: Thu, 19 Oct 2023 07:39:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	joshi.k@samsung.com, martin.petersen@oracle.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/4] block: bio-integrity: add support for user buffers
Message-ID: <20231019053905.GC14346@lst.de>
References: <20231018151843.3542335-1-kbusch@meta.com> <20231018151843.3542335-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018151843.3542335-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_223909_527076_6F4BA944 
X-CRM114-Status: GOOD (  16.67  )
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

int bio_integrity_map_user(struct bio *bio, void __user *ubuf, unsigned int len,
> +			   u32 seed, u32 maxvecs)
> +{
> +	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> +	unsigned long align = q->dma_pad_mask | queue_dma_alignment(q);
> +	struct page *stack_pages[UIO_FASTIOV];
> +	size_t offset = offset_in_page(ubuf);
> +	unsigned long ptr = (uintptr_t)ubuf;
> +	struct page **pages = stack_pages;
> +	struct bio_integrity_payload *bip;
> +	int npages, ret, i;
> +
> +	if (bio_integrity(bio) || ptr & align || maxvecs > UIO_FASTIOV)
> +		return -EINVAL;

We also need to check the length for the dma alignment/pad, not
just the start.  (The undocumented iov_iter_alignment_iovec helper
obsfucateѕ this for the data path).

> +	bip = bio_integrity_alloc(bio, GFP_KERNEL, maxvecs);
> +	if (IS_ERR(bip))
> +		return PTR_ERR(bip);
> +
> +	ret = pin_user_pages_fast(ptr, UIO_FASTIOV, FOLL_WRITE, pages);
> +	if (unlikely(ret < 0))
> +		goto free_bip;
> +
> +	npages = ret;
> +	for (i = 0; i < npages; i++) {
> +		u32 bytes = min_t(u32, len, PAGE_SIZE - offset);
> +		ret = bio_integrity_add_page(bio, pages[i], bytes, offset);
> +		if (ret != bytes) {
> +			ret = -EINVAL;
> +			goto release_pages;
> +		}
> +		len -= ret;
> +		offset = 0;
> +	}

Any reason to not use the bio_vec array as the buffer, similar to the
data size here?

> +EXPORT_SYMBOL(bio_integrity_map_user);

Everything that just thinly wraps get_user_pages_fast needs to be
EXPORT_SYMBOL_GPL.


