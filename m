Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4154C07545
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WQ3EdvtSOCTptFxh33u4vpqtlrpvtWSj9J/yn8tDhIk=; b=QmKN/GpXvm0eYB8S4l+VVQ0bL+
	SdW+TLRLV4QTACW9sMyo/7tAVvOlHL3TrFDwjm/GsahqORqmZEBTz7FjuhDXa45YgxIVJsv7SIyHg
	A4dINMQ3VlJGg87YOIALAVVLtFs0XxrIsgkhg1CcePJa2eSQ7ZiKOq385DODwwuhsDDAICHsBhfja
	MuaBaSuNRe0XxGwyt9Eb7NX4H96m+YnAX3cZgPXXy+2HIAnDPXD7hzbgBlMcjba6JrsjNuW2cBaCv
	id7gZVXKGKESbXXqkr7cyHynRzrn7iyvOrQcGAVKt+B8lYnUHcNxIp+VNRB849n8+uMa4qr660Wfp
	v7jPB4rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvf63-00CXne-1Z;
	Wed, 25 Oct 2023 14:42:59 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvf5y-00CXme-07
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 14:42:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 5B57CB82FA0;
	Wed, 25 Oct 2023 14:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFB5C433C7;
	Wed, 25 Oct 2023 14:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698244971;
	bh=mLkOdv4b8i2eFv8X9BAoS+Y8GxKrlJPAVyrio6dKXsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WNCl4OydQlz7ER2rwKCubLGIZ3l6bw4RfTfDTHRwG8h8gTk5uAEHNCOW8nJkh8/tm
	 v5IfrECbzJ87hTFtOria90MP+xZ4DZbIsQ5XcbF26nSne5s5gsICe9I6JXeuoS1rfW
	 CsYzCE84HAr/8BSLezYABVL1m12erLdFWL1gzO5alf2Jd7bkzGlMewwilXEWFuNsgu
	 ttJFQI5GaWOUmjfDPOCvkxO/hlR1MWe3F3gJPM/HStqJimqpQRj7dvjC3TF0qnADq2
	 b37MkX7iKEpEA3T7MGAnMy0g9kprK4eUquTYUPpkHxbfcYwPlm3+/uYujolQMiMXOQ
	 9U3YEHdaoWIqA==
Date: Wed, 25 Oct 2023 08:42:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Subject: Re: [PATCH 1/4] block: bio-integrity: add support for user buffers
Message-ID: <ZTkpaHa8fM4xhLz4@kbusch-mbp.dhcp.thefacebook.com>
References: <20231018151843.3542335-1-kbusch@meta.com>
 <CGME20231018152817epcas5p454a337b03087ccaf8935a022884b7cd2@epcas5p4.samsung.com>
 <20231018151843.3542335-2-kbusch@meta.com>
 <1ca15dc4-6192-c557-2871-d2afbf19dd97@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ca15dc4-6192-c557-2871-d2afbf19dd97@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_074254_226150_784B50DB 
X-CRM114-Status: GOOD (  12.28  )
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

On Wed, Oct 25, 2023 at 06:21:55PM +0530, Kanchan Joshi wrote:
> On 10/18/2023 8:48 PM, Keith Busch wrote:
> >   }
> >   EXPORT_SYMBOL(bio_integrity_add_page);
> >   
> > +int bio_integrity_map_user(struct bio *bio, void __user *ubuf, unsigned int len,
> > +			   u32 seed, u32 maxvecs)
> > +{
> > +	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> > +	unsigned long align = q->dma_pad_mask | queue_dma_alignment(q);
> > +	struct page *stack_pages[UIO_FASTIOV];
> > +	size_t offset = offset_in_page(ubuf);
> > +	unsigned long ptr = (uintptr_t)ubuf;
> > +	struct page **pages = stack_pages;
> > +	struct bio_integrity_payload *bip;
> > +	int npages, ret, i;
> > +
> > +	if (bio_integrity(bio) || ptr & align || maxvecs > UIO_FASTIOV)
> > +		return -EINVAL;
> > +
> > +	bip = bio_integrity_alloc(bio, GFP_KERNEL, maxvecs);
> > +	if (IS_ERR(bip))
> > +		return PTR_ERR(bip);
> > +
> > +	ret = pin_user_pages_fast(ptr, UIO_FASTIOV, FOLL_WRITE, pages);
> 
> Why not pass maxvecs here? If you pass UIO_FASTIOV, it will map those 
> many pages here. And will result into a leak (missed unpin) eventually 
> (see below).

The 'maxvecs' is for the number of bvecs, and UIO_FASTIOV is for the
number of pages. A single bvec can contain multiple pages, so the idea
was to attempt merging if multiple pages were required.

This patch though didn't calculate the pages right. Next version I'm
working on uses iov_iter instead. V2 also retains a kernel copy
fallback.

