Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AD1CD4F24
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 10:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y8agHE2UtR+0v8hUNRpGN3/NHmgQczj9TZKmKbKc+JU=; b=B+Q5+21D4lowGvxaKJp0fEP8Yb
	JJhbO2vAhkVV9vo0qihnugTYxq697vKgpv/+I1IXXYMpkPxb1vmssYmMRB7tezM8fP/pXy4B66z0g
	IUM8a8QAmBJIE1e5A7o8cZqNZD7VWDS/qYxCTwSgA+elpwQc72Wg+5iq5kRsJGq1MQm9nMb+XWeBz
	DHrGUxuJnS4TeVMyCvG8ahQjJJjT3NsvRfuZgIjxUs77hWR6nusKVLA1ZPIfHDXNqwdsuCwGao31k
	QvlAgp4PeUti06unndOyJ7BENis3vQGwPcGHfGAd6dahhS/sRYjMjbnFvlPFJwrSW0prdUXXohklL
	J0QMwFJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN6Td-000000026KI-3TQr;
	Wed, 13 May 2026 10:06:05 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN6Ta-000000026JZ-3zci
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 10:06:04 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-bd21ffaca79so379740666b.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 May 2026 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778666761; x=1779271561; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8agHE2UtR+0v8hUNRpGN3/NHmgQczj9TZKmKbKc+JU=;
        b=XzoblZaIY1h/5qEdy3oBv33jIKtnVmq765sMbXSxCSIyI5H/3oeqC8dWKRlazZVTJS
         hkpDdUkmPEnI5a+uu2AA9kx7/C4kqSO7adTpNcH7nDhQRvvHs2gUYk2iB5RvKPe4A6jm
         RodaHOr2m77PWIzYhHL5fd6y5db4Hok/CgjWwLTy5Y9uk+3MFpveSLXu//uZLtFfO4Br
         CvvLz0CoiJyiitHwG0KkkNFZ4Q6iiQUJVdBqFggNnFyMv0UPbwYsxaaxtJlnEBaxq68P
         /r2hEC06wWKpyeW9sly5/GbSWy6zenXVAnSCubnDqwg0XtIVcFcAj77slUTzPIoTkT3Y
         ajZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778666761; x=1779271561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y8agHE2UtR+0v8hUNRpGN3/NHmgQczj9TZKmKbKc+JU=;
        b=bIWbLdo8FeS72q+ObwQc0uok3oTro1zUzp+qYX6zlH04IjJ/eL3LiX4nX/OTTFq+fV
         5GQkm7OcGRv8CNXcbygxCJEyx/Htr9lMtpO7Zj6hOUZdMeXIlNeRL1MP/ekv/b8Olnyh
         Bwiop6ePtlcbL7NImp+j8Tr/Im3Zs45xD7QHL2BNTldYY0pvA8vDUHPxzt/B7B2Itdsy
         V0QR0PB/sPL4wlre+MgGSEM0h38WbOO0JnoNA8s9ybibvi7L2upF+jx0UwxO/dNUZCDu
         fuyj9FGQXYrPGNaBOua1s0fOrWJW6/FMquhwkcv9f1zOkl5ysfBkGv73ePvvMxSN2o41
         vYnw==
X-Forwarded-Encrypted: i=1; AFNElJ9CjuzKWs9VHdBZqfqOEoNCNF8bwWHw64m3Ww1lvHjKmK2sUZamIO7G4vYl51Gtnj59EfOfGedxSMfN@lists.infradead.org
X-Gm-Message-State: AOJu0YxfvL+rJH2oA8Uuol5l6vLIwLB2o/YsHAHYd7JjzdADkLulncH2
	A0IGPmizBFlPTJoanrFxkYmBQRAbysd8AJy54YSRHKCtjL8nAiCjtMyY
X-Gm-Gg: Acq92OExGmgYcRPK+AdUIHO8qwlufB0Q65yen/5j0TNSPiOsfkmJdnbSVzheNE/4Ozg
	sk6Jm5BZJeAsQJEhnISdrAjcObOIq1kDU/wPTwCIEE1NOJj95UEXIY/0TmOe3Rb7NBlooKkcXkj
	TxNRpVZPHq8UO7kYlwjaZziLas8Km2Gr5CklqeZkI3IuasiUlAjSLelPVyDaJjtGQiQq9fOClxr
	LYN9soRbYSY6ZFDkLCtti5c+3VymiG8TBJPxGXlp4QZBEokf8qm/y40gLAUBBrKre8eAZXdOzrn
	VeuPed1tooKIQra/IiRpY3tzKXfAzhQ8zK6YNvNx4lSSZeX0tzcgnmZtQhybhV7VGggS53jzuKk
	njkNiylS1QHZpl06TWBXvVVRNfSQJh0p/5hDjaxJWYc/VqEVs14jtzZ19gFhmMXFe+ie0oozVkG
	y9aAgAFR43ixn58MVKKT2lH3XoEVCi2j25ocQbBTrui+rj5S5lEIYro0MHGaTa
X-Received: by 2002:a17:907:9493:b0:bc5:2352:555c with SMTP id a640c23a62f3a-bd3add39c4bmr174356866b.14.1778666759127;
        Wed, 13 May 2026 03:05:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd2dba8fd22sm216615666b.16.2026.05.13.03.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:05:58 -0700 (PDT)
Date: Wed, 13 May 2026 11:05:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, Nitesh
 Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, Anuj
 Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 02/10] iov_iter: add iterator type for dmabuf maps
Message-ID: <20260513110557.705bdeed@pumpkin>
In-Reply-To: <20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
	<20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_030603_040791_44DDD394 
X-CRM114-Status: GOOD (  32.05  )
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

On Wed, 29 Apr 2026 16:25:48 +0100
Pavel Begunkov <asml.silence@gmail.com> wrote:

> Introduce a new iterator type for dmabuf maps. The map in an opaque
> object with internals and format specific to the subsystem / driver, and
> only it can use that subsystem / driver for issuing IO. The task of the
> middle layers is to pass the map / iterator further down, maybe doing
> basic splitting and length checking. The iterator can only be used by
> operations of the file the associated map was created for.
> 
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  include/linux/uio.h | 11 +++++++++++
>  lib/iov_iter.c      | 29 +++++++++++++++++++++++------
>  2 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index a9bc5b3067e3..75051aed70de 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -12,6 +12,7 @@
>  
>  struct page;
>  struct folio_queue;
> +struct io_dmabuf_map;
>  
>  typedef unsigned int __bitwise iov_iter_extraction_t;
>  
> @@ -29,6 +30,7 @@ enum iter_type {
>  	ITER_FOLIOQ,
>  	ITER_XARRAY,
>  	ITER_DISCARD,
> +	ITER_DMABUF_MAP,
>  };
>  
>  #define ITER_SOURCE	1	// == WRITE
> @@ -71,6 +73,7 @@ struct iov_iter {
>  				const struct folio_queue *folioq;
>  				struct xarray *xarray;
>  				void __user *ubuf;
> +				struct io_dmabuf_map *dmabuf_map;
>  			};
>  			size_t count;
>  		};
> @@ -155,6 +158,11 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
>  	return iov_iter_type(i) == ITER_XARRAY;
>  }
>  
> +static inline bool iov_iter_is_dmabuf_map(const struct iov_iter *i)
> +{
> +	return iov_iter_type(i) == ITER_DMABUF_MAP;
> +}
> +
>  static inline unsigned char iov_iter_rw(const struct iov_iter *i)
>  {
>  	return i->data_source ? WRITE : READ;
> @@ -300,6 +308,9 @@ void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
>  			  unsigned int first_slot, unsigned int offset, size_t count);
>  void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
>  		     loff_t start, size_t count);
> +void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
> +			struct io_dmabuf_map *map,
> +			loff_t off, size_t count);
>  ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
>  			size_t maxsize, unsigned maxpages, size_t *start);
>  ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 243662af1af7..e2253684b991 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
>  {
>  	if (unlikely(i->count < size))
>  		size = i->count;
> -	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
> +	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
> +	    unlikely(iov_iter_is_dmabuf_map(i))) {


Doesn't the extra check add more code to all the non-ubuf cases?
This could be fixed by either making iter_type a bitmask (with one bit set)
or writing an iter_is_one_of(i, ITER_xxx, ITER_yyy) define that uses
'(1 << i->iter_type) & ((1 << ITER_xxx) | ...)'
(look at the the nolibc printf code for an example).

>  		i->iov_offset += size;
>  		i->count -= size;
>  	} else if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
> @@ -631,7 +632,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
>  		return;
>  	}
>  	unroll -= i->iov_offset;
> -	if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
> +	if (iov_iter_is_xarray(i) || iter_is_ubuf(i) ||

iter_is_ubuf() should have been first here.

-- David

> +	    iov_iter_is_dmabuf_map(i)) {
>  		BUG(); /* We should never go beyond the start of the specified
>  			* range since we might then be straying into pages that
>  			* aren't pinned.
> @@ -775,6 +777,20 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
>  }
>  EXPORT_SYMBOL(iov_iter_xarray);
>  
> +void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
> +			 struct io_dmabuf_map *map,
> +			 loff_t off, size_t count)
> +{
> +	WARN_ON(direction & ~(READ | WRITE));
> +	*i = (struct iov_iter){
> +		.iter_type = ITER_DMABUF_MAP,
> +		.data_source = direction,
> +		.dmabuf_map = map,
> +		.count = count,
> +		.iov_offset = off,
> +	};
> +}
> +
>  /**
>   * iov_iter_discard - Initialise an I/O iterator that discards data
>   * @i: The iterator to initialise.
> @@ -841,7 +857,7 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
>  
>  unsigned long iov_iter_alignment(const struct iov_iter *i)
>  {
> -	if (likely(iter_is_ubuf(i))) {
> +	if (likely(iter_is_ubuf(i)) || iov_iter_is_dmabuf_map(i)) {
>  		size_t size = i->count;
>  		if (size)
>  			return ((unsigned long)i->ubuf + i->iov_offset) | size;
> @@ -872,7 +888,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
>  	size_t size = i->count;
>  	unsigned k;
>  
> -	if (iter_is_ubuf(i))
> +	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
>  		return 0;
>  
>  	if (WARN_ON(!iter_is_iovec(i)))
> @@ -1469,11 +1485,12 @@ EXPORT_SYMBOL_GPL(import_ubuf);
>  void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
>  {
>  	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
> -			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
> +			 !iter_is_ubuf(i) && !iov_iter_is_kvec(i) &&
> +			 !iov_iter_is_dmabuf_map(i)))
>  		return;
>  	i->iov_offset = state->iov_offset;
>  	i->count = state->count;
> -	if (iter_is_ubuf(i))
> +	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
>  		return;
>  	/*
>  	 * For the *vec iters, nr_segs + iov is constant - if we increment


