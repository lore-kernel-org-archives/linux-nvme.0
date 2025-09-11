Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FD5CAC587
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 18:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1IGtpNFAcyaUIJzY6ACOJFzAty9/iPImi9Smocj365w=; b=DJ4X74ry+LbqLmoWcW4tPVJkbN
	KY3dCHm+QWjXHX8REIoJvYYsJImFbyYdZ7UNuVyAzlgK1TYqJruG/zA9AUuEb7Ic3ostGGVRwLn1E
	pIOyTodWbB/qfmejhTkSp6nSTsnwKzWwbVzeFtSRk0UMfpTZ2g3MXj5BNH4zfEkrT/vSrkfYIQc8f
	+caz/Mol783nBLKApNpprroPh+a8xfN5WD/zewnNwG1s0Casv9ogZLNH/T4iO21S3faIOvJqlfI1E
	Eexk/MPxAUKSKk3TQ9PG8RtmBGGbVtde5K7pJM5bSUScv/N3FtzU20rIWK2Smlr3d6eJ6VQ856Kjt
	pArjaVFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwm2e-00000004jzB-0V7C;
	Thu, 11 Sep 2025 18:29:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwm2b-00000004jwP-0fEt
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 18:29:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3E8B24507B;
	Thu, 11 Sep 2025 18:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3559C4CEF0;
	Thu, 11 Sep 2025 18:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757615344;
	bh=pvWEsT93uVIOWz2M4Vho/D8Off0suykMzN0eQwwe1cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=REcPMWr12hkWlU47vLOp+4JNrEdwFzNsGScSmWVAnToIcCLLlhDQiuKTuTqKNUQem
	 Ocv0pa7kLZfhwH87URlPGO/+meOMec9lm0MCoaUkNuXdQMT4HLpDBmsPnKsgLWLL/6
	 y1I7y4iCX4GvruS/NveJh+l5kAG5WA/17rNfLjdGI5QvASUyOxxXNmxucFrWzX0K0R
	 ipgslH02B3b+9iyixNlQurXzn/3rqhpigEcftdN90RRtxfRDt8x5bOJqTqiMpDFIKs
	 vddMSornGj9xVKzeB3fhOqzps0gNC21jqSVWrQy0tPXp7A6RUzTPzTA4MR75V+fGFT
	 edMpfdGsma8Gw==
Date: Thu, 11 Sep 2025 11:27:42 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
	hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
	jaegeuk@kernel.org, kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, tytso@mit.edu,
	visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v2 2/5] lib/base64: rework encoder/decoder with
 customizable support and update nvme-auth
Message-ID: <20250911182742.GC1376@sol>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911074159.656943-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911074159.656943-1-409411716@gms.tku.edu.tw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_112906_035239_9DDD250E 
X-CRM114-Status: GOOD (  22.01  )
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

On Thu, Sep 11, 2025 at 03:41:59PM +0800, Guan-Chun Wu wrote:
> Rework base64_encode() and base64_decode() with extended interfaces
> that support custom 64-character tables and optional '=' padding.
> This makes them flexible enough to cover both standard RFC4648 Base64
> and non-standard variants such as base64url.

RFC4648 specifies both base64 and base64url.

> The encoder is redesigned to process input in 3-byte blocks, each
> mapped directly into 4 output symbols. Base64 naturally encodes
> 24 bits of input as four 6-bit values, so operating on aligned
> 3-byte chunks matches the algorithm's structure. This block-based
> approach eliminates the need for bit-by-bit streaming, reduces shifts,
> masks, and loop iterations, and removes data-dependent branches from
> the main loop.

There already weren't any data-dependent branches in the encoder.

> The decoder replaces strchr()-based lookups with direct table-indexed
> mapping. It processes input in 4-character groups and supports both
> padded and non-padded forms. Validation has been strengthened: illegal
> characters and misplaced '=' padding now cause errors, preventing
> silent data corruption.

The decoder already detected invalid inputs.

> While this is a mechanical update following the lib/base64 rework,
> nvme-auth also benefits from the performance improvements in the new
> encoder/decoder, achieving faster encode/decode without altering the
> output format.
> 
> The reworked encoder and decoder unify Base64 handling across the kernel
> with higher performance, stricter correctness, and flexibility to support
> subsystem-specific variants.

Which part is more strictly correct?

> diff --git a/lib/base64.c b/lib/base64.c
> index 9416bded2..b2bd5dab5 100644
> --- a/lib/base64.c
> +++ b/lib/base64.c
> @@ -15,104 +15,236 @@
>  #include <linux/string.h>
>  #include <linux/base64.h>
>  
> -static const char base64_table[65] =
> -	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> +#define BASE64_6BIT_MASK      0x3f /* Mask to extract lowest 6 bits */
> +#define BASE64_BITS_PER_BYTE  8
> +#define BASE64_CHUNK_BITS     6
> +
> +/* Output-char-indexed shifts: for output chars 0,1,2,3 respectively */
> +#define BASE64_SHIFT_OUT0	(BASE64_CHUNK_BITS * 3) /* 18 */
> +#define BASE64_SHIFT_OUT1	(BASE64_CHUNK_BITS * 2) /* 12 */
> +#define BASE64_SHIFT_OUT2	(BASE64_CHUNK_BITS * 1) /* 6  */
> +/* OUT3 uses 0 shift and just masks with BASE64_6BIT_MASK */
> +
> +/* For extracting bytes from the 24-bit value (decode main loop) */
> +#define BASE64_SHIFT_BYTE0        (BASE64_BITS_PER_BYTE * 2) /* 16 */
> +#define BASE64_SHIFT_BYTE1        (BASE64_BITS_PER_BYTE * 1) /* 8  */
> +
> +/* Tail (no padding) shifts to extract bytes */
> +#define BASE64_TAIL2_BYTE0_SHIFT  ((BASE64_CHUNK_BITS * 2) - BASE64_BITS_PER_BYTE)       /* 4  */
> +#define BASE64_TAIL3_BYTE0_SHIFT  ((BASE64_CHUNK_BITS * 3) - BASE64_BITS_PER_BYTE)       /* 10 */
> +#define BASE64_TAIL3_BYTE1_SHIFT  ((BASE64_CHUNK_BITS * 3) - (BASE64_BITS_PER_BYTE * 2)) /* 2  */
> +
> +/* Extra: masks for leftover validation (no padding) */
> +#define BASE64_MASK(n) ({        \
> +	unsigned int __n = (n);  \
> +	__n ? ((1U << __n) - 1U) : 0U; \
> +})
> +#define BASE64_TAIL2_UNUSED_BITS  (BASE64_CHUNK_BITS * 2 - BASE64_BITS_PER_BYTE)     /* 4 */
> +#define BASE64_TAIL3_UNUSED_BITS  (BASE64_CHUNK_BITS * 3 - BASE64_BITS_PER_BYTE * 2) /* 2 */

These #defines make the code unnecessarily hard to read.  Most of them
should just be replaced with the integer literals.

>   * This implementation hasn't been optimized for performance.

But the commit message claims performance improvements.

>   *
>   * Return: the length of the resulting decoded binary data in bytes,
>   *	   or -1 if the string isn't a valid base64 string.

base64 => Base64, since multiple variants are supported now.  Refer to
the terminology used by RFC4686.  Base64 is the general term, and
"base64" and "base64url" specific variants of Base64.

- Eric

