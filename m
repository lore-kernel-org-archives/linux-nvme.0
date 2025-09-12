Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B452CAC582
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Sep 2025 07:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AW7tsP6xOhY4n2HUUy8zRpS39bN8hH1JOudjtFI/rVM=; b=ZOR//1++wAkcmO+R/9sNOxbbBq
	pfamEhp4xYlJ3LwfzIwQA+KJdX6hIyl/iIQ/3xq0J2oR+y5hsbjd5Kd91HcObvjHnp1Btl8IvVENS
	+QxXj+nEpryqI7ncq1u97MSpKfChMJDYaj5k+qFxhkBgQw/qilwfALkXVwiqKjoigWLRSxcH7yW+/
	eD2XYbp+CwwbuNs78z1WO8RKkrIsxwfr7EUSMnzfr7ThMronlVqyKCni2ErRa3tjBOuAwaIBbx+NO
	SAXbJDqgKE2Vd8QCaniTXij6sZ2b9qGsAvChtxx9+9OJPgpkPL6vxxJF0g8cgHqRXD3/4it7E3WZ7
	ZTwvp0KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwy0J-00000007arX-0GyS;
	Fri, 12 Sep 2025 07:15:31 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwy0G-00000007ar2-1RmE
	for linux-nvme@lists.infradead.org;
	Fri, 12 Sep 2025 07:15:29 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-b4c9a6d3fc7so985999a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 12 Sep 2025 00:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1757661327; x=1758266127; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AW7tsP6xOhY4n2HUUy8zRpS39bN8hH1JOudjtFI/rVM=;
        b=FNn0hYyRtuN1sWDx8fxAWrdq6c3/MK9m0ueK+znPllecRQ6Qe/1rrSFEEKVnuZNKCU
         EYLY1cfgfsYvkCmxgBQpNqKWMp0tDLNCjLnF7Kh3xL1RIwSnBQ1P0duEkWyyVAexoEWa
         cM7vejcOpml3f5EbsaI0yCdUQJKEir7X0PhkyJTJswM9sgx7svvtiKRQRK+AtytmnP4I
         v55ZaWW1y3vq5Pa8/cIK+AGZhpZl2CuPdyIHzu8CtEIZp5debT7iV3T3TW6n0IEx3oEp
         QlwDKq27d+dUm7zdcY+bf4e8zgfxtuWVhX1H2MVTdF9V4P3zZmQ2/7oBmmPtLHfQVjm2
         UYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757661327; x=1758266127;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AW7tsP6xOhY4n2HUUy8zRpS39bN8hH1JOudjtFI/rVM=;
        b=FLBr10nmnZf9nIZCPBcLKEURk9HQSg/p71lA8BpV/mrYG9SPN3tiyoensQWVNXOtAT
         +S8MtENmM7QS4ks1g4qE0qEw0WIUIwrif2p6UupIaBGdP4uYZIs7Wfo1ZfHjFid5vLFb
         MUTTlfhuyLPx/ZwbCng/7roJQFNAGlYnL+Y9X/qzF/NTy2HpGJ5dhBHAYFWqLpmUhran
         eLFPtIA0+qSsz3DzxbSv3C5XaC8z40TlZcHK77VgZfnF4uNZSoE4AbC5euc/4cD+RFnm
         ETjDVxBo/T9O6/y1mZjuTPWQjCW787+tVsTH0G7HBM8Gt4/v7uIWOpRuBKm9FaQ80Yu1
         aeuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpJ0b9Z3wdvPXSFsJRw/B7zNH/rRu5hMBr3TzHICe8A2py8ZcxZfhykjzyJxBVbrhEY1o7h5TJrijI@lists.infradead.org
X-Gm-Message-State: AOJu0YwCRd+TcENFP5MKy037+Cq3Vs/Rdz8xu/rzJJIo+2yGyB8O7y1/
	WavRqbgkvvQqHs3vWQwOlMWIfkxUqSly+yL5R+41vEuKTX4/K9qTdOQ4aGymuyRwDV0=
X-Gm-Gg: ASbGncv7pTk74phxsF2hukuXa0MIUVScUuiwbGP88iCSup1GiuZQRA5AGDLBFh0cm+P
	099EttEfy5cbzQK59Vk3/j74nQo3SlCvHTxU9KOo37FTBrZaTV8iSg5Btz5VQVyL3GMHNEeJDjr
	XAqPb1gzXyMmvYMHstJpTqPuynUX1bvf1f4DDfToSQCRghoeTpeDXnFcByJ31LDmhxWZwv0UHjz
	CedO6ooBEFfeQao89uXEhDHAyWg4JykmKTTtYhxCvQQDo96JdJ/PzY4hqjaQcxumjkDGlrFQ7YV
	8La3eE02gtHh9IYb0azro+YamzJyv8DUGxCiwzUrNT+9s3xNrAR4o2S5xTbix9WoPEphpJBy85K
	tKT9EddRrTJFEcw8fX15c9+mqc93WyxLNTOaP5IYK/xkZ
X-Google-Smtp-Source: AGHT+IFW30ssn2TairJ8HtopqhokGY4ajOoSTmmyCvBDKvXwFswORwAcYfMn/Bm/7xA9nsncRM3K+A==
X-Received: by 2002:a17:902:fc4b:b0:24a:a2c5:a0a1 with SMTP id d9443c01a7336-25d248c9a0fmr24778485ad.21.1757661327374;
        Fri, 12 Sep 2025 00:15:27 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:9e14:1074:637d:9ff6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc6b06sm39911365ad.17.2025.09.12.00.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 00:15:26 -0700 (PDT)
Date: Fri, 12 Sep 2025 15:15:21 +0800
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: Eric Biggers <ebiggers@kernel.org>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
	hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
	jaegeuk@kernel.org, kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, tytso@mit.edu,
	visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v2 2/5] lib/base64: rework encoder/decoder with
 customizable support and update nvme-auth
Message-ID: <aMPIiXe3baF2gDnQ@wu-Pro-E500-G6-WS720T>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911074159.656943-1-409411716@gms.tku.edu.tw>
 <20250911182742.GC1376@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911182742.GC1376@sol>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_001528_390467_5BFB98A6 
X-CRM114-Status: GOOD (  33.50  )
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

On Thu, Sep 11, 2025 at 11:27:42AM -0700, Eric Biggers wrote:
> On Thu, Sep 11, 2025 at 03:41:59PM +0800, Guan-Chun Wu wrote:
> > Rework base64_encode() and base64_decode() with extended interfaces
> > that support custom 64-character tables and optional '=' padding.
> > This makes them flexible enough to cover both standard RFC4648 Base64
> > and non-standard variants such as base64url.
> 
> RFC4648 specifies both base64 and base64url.
>

Got it, I'll update the commit message in the next version.

> > The encoder is redesigned to process input in 3-byte blocks, each
> > mapped directly into 4 output symbols. Base64 naturally encodes
> > 24 bits of input as four 6-bit values, so operating on aligned
> > 3-byte chunks matches the algorithm's structure. This block-based
> > approach eliminates the need for bit-by-bit streaming, reduces shifts,
> > masks, and loop iterations, and removes data-dependent branches from
> > the main loop.
> 
> There already weren't any data-dependent branches in the encoder.
> 

Got it, I'll update the commit message in the next version.

> > The decoder replaces strchr()-based lookups with direct table-indexed
> > mapping. It processes input in 4-character groups and supports both
> > padded and non-padded forms. Validation has been strengthened: illegal
> > characters and misplaced '=' padding now cause errors, preventing
> > silent data corruption.
> 
> The decoder already detected invalid inputs.
> 

You're right, the decoder already rejected invalid inputs.
What has been strengthened in the new version is the padding handling 
(length must be a multiple of 4, and = only allowed in the last two positions).

> > While this is a mechanical update following the lib/base64 rework,
> > nvme-auth also benefits from the performance improvements in the new
> > encoder/decoder, achieving faster encode/decode without altering the
> > output format.
> > 
> > The reworked encoder and decoder unify Base64 handling across the kernel
> > with higher performance, stricter correctness, and flexibility to support
> > subsystem-specific variants.
> 
> Which part is more strictly correct?
> 

The stricter correctness here refers to the decoder, specifically the padding
checks (length must be a multiple of 4, and = only allowed in the last two positions).

> > diff --git a/lib/base64.c b/lib/base64.c
> > index 9416bded2..b2bd5dab5 100644
> > --- a/lib/base64.c
> > +++ b/lib/base64.c
> > @@ -15,104 +15,236 @@
> >  #include <linux/string.h>
> >  #include <linux/base64.h>
> >  
> > -static const char base64_table[65] =
> > -	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> > +#define BASE64_6BIT_MASK      0x3f /* Mask to extract lowest 6 bits */
> > +#define BASE64_BITS_PER_BYTE  8
> > +#define BASE64_CHUNK_BITS     6
> > +
> > +/* Output-char-indexed shifts: for output chars 0,1,2,3 respectively */
> > +#define BASE64_SHIFT_OUT0	(BASE64_CHUNK_BITS * 3) /* 18 */
> > +#define BASE64_SHIFT_OUT1	(BASE64_CHUNK_BITS * 2) /* 12 */
> > +#define BASE64_SHIFT_OUT2	(BASE64_CHUNK_BITS * 1) /* 6  */
> > +/* OUT3 uses 0 shift and just masks with BASE64_6BIT_MASK */
> > +
> > +/* For extracting bytes from the 24-bit value (decode main loop) */
> > +#define BASE64_SHIFT_BYTE0        (BASE64_BITS_PER_BYTE * 2) /* 16 */
> > +#define BASE64_SHIFT_BYTE1        (BASE64_BITS_PER_BYTE * 1) /* 8  */
> > +
> > +/* Tail (no padding) shifts to extract bytes */
> > +#define BASE64_TAIL2_BYTE0_SHIFT  ((BASE64_CHUNK_BITS * 2) - BASE64_BITS_PER_BYTE)       /* 4  */
> > +#define BASE64_TAIL3_BYTE0_SHIFT  ((BASE64_CHUNK_BITS * 3) - BASE64_BITS_PER_BYTE)       /* 10 */
> > +#define BASE64_TAIL3_BYTE1_SHIFT  ((BASE64_CHUNK_BITS * 3) - (BASE64_BITS_PER_BYTE * 2)) /* 2  */
> > +
> > +/* Extra: masks for leftover validation (no padding) */
> > +#define BASE64_MASK(n) ({        \
> > +	unsigned int __n = (n);  \
> > +	__n ? ((1U << __n) - 1U) : 0U; \
> > +})
> > +#define BASE64_TAIL2_UNUSED_BITS  (BASE64_CHUNK_BITS * 2 - BASE64_BITS_PER_BYTE)     /* 4 */
> > +#define BASE64_TAIL3_UNUSED_BITS  (BASE64_CHUNK_BITS * 3 - BASE64_BITS_PER_BYTE * 2) /* 2 */
> 
> These #defines make the code unnecessarily hard to read.  Most of them
> should just be replaced with the integer literals.
> 

Got it, thanks for the feedback. I'll simplify this in the next version.

> >   * This implementation hasn't been optimized for performance.
> 
> But the commit message claims performance improvements.
> 

That was my mistake. I forgot to update this part of the comment.
I’ll fix it in the next version.

> >   *
> >   * Return: the length of the resulting decoded binary data in bytes,
> >   *	   or -1 if the string isn't a valid base64 string.
> 
> base64 => Base64, since multiple variants are supported now.  Refer to
> the terminology used by RFC4686.  Base64 is the general term, and
> "base64" and "base64url" specific variants of Base64.
> 
> - Eric

Ok, I'll update the comments to use Base64.

Best regards,
Guan-chun

