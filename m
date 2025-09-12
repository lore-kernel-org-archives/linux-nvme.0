Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541C4CAC582
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Sep 2025 06:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WHuTi6TQfgFAtMCkxSDV0wAwRzh2olOxA10o4YRtx2Y=; b=SceG0bYZf2zT0yPf0WY8XC8jkx
	+gD4q344DZ7JFqSLZSmrvlqgfsz14w7Xar+fcwSjurbNf+m/a1sHQB3KDTAwq/fb8eGCckabTafFr
	5JDslRFqxyhJd+/ng5+ZnI6iJGuzB5pnBQ1loMyhGahdI7eWuZPtX8bURaF+8Fq0TBMlDxYurvc2F
	m3Vdbi+BDN6MLTaa9iavQGIpx0N2ejEM5cwnWSEx0u3VC/DmZXQgW9YWBPFkvl+1WNxLCAtCOGqBL
	GU5UbxCkNgME7TXyEYlrTi1nQDPVJqeTRstJmgCGmXB0iBpNJkv4p/4lSfvEcywNxsiT+Vrr7VBuQ
	8gRhWgpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwxQ4-00000007R6j-1g5N;
	Fri, 12 Sep 2025 06:38:04 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwxQ1-00000007R4a-0Cgw
	for linux-nvme@lists.infradead.org;
	Fri, 12 Sep 2025 06:38:03 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-77269d19280so1484072b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 23:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1757659080; x=1758263880; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WHuTi6TQfgFAtMCkxSDV0wAwRzh2olOxA10o4YRtx2Y=;
        b=HOU8OGhStdWTlf62GPH8vTrfD9+U26ACfgy/I+0qZfkUjBXz3xK3TRp8U9ffYkvqnu
         3IU9YGcclyEMRYkwjw7WI99uTvzQoc98zHWLhY9UOnkRr8z4AVOKKDuPoeK20ZSN7mma
         Af52vJCVl4pK1E82uePvcqb0PvN42BSsczNO2B5E2XrUmmEA7l3ZK5yLB+vucKhasnhV
         9tHW7PMWjlNss+1w2f3EYvOhsDosAPQNA0ux4T7/SyO4FNY7EbxGPCd/Tp86TcgB1R3B
         n/DqiWCt8MH8zDjQKyS6k2wqDuyAirwSYlT3GbbdlSkCY1cOcizQp9fD7BVG5SuemHDj
         FIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659080; x=1758263880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHuTi6TQfgFAtMCkxSDV0wAwRzh2olOxA10o4YRtx2Y=;
        b=avaQhJvyKS3rfU30At4bi0yfFSwWUBrvHtb1haGxaaN+2npnwhX5YODe6XmMa8Uq56
         ApGVe4db14wk3qbAbnd+F9mQPGHnHeWyXYdtxKo3wcPMh7bN2YrnOVqsLhKypmTIg3tD
         AGif4Nkd6jOonBf8zTx/Yj5DZsfA6x3kjmiMDWqjuKvL+LrGKrRdEo4plWG2A3g9NTS2
         pN8ov+4snwVMihmC5xJnUpyVWwl2RY4henLDum0gxjzF8rQqZ4BprgkKvXHsQQ142VKZ
         rTmcEDSEAqhUl+wBBfkX2Hp2SZTTpxinEC3ZbhqQ5koCjBA1vESerExetdQCS0eAEmwr
         JwUA==
X-Forwarded-Encrypted: i=1; AJvYcCXDv7+KCc7WpNq4iYvWVYBootFt8BuNcfMb7Wpu/A6lUKiuBBy5CDWUHygI+VlDXRgQK2KFHCSZG2Xw@lists.infradead.org
X-Gm-Message-State: AOJu0YzTHnyvR8978RQHc0xZYj6wKIlWgGmOQT0NNIxln5NXCFeAQcRG
	4nZbwshJI76GkKZabChNZ5+DUry8C8/PzO1PSksL61h4/WUW9mh8yiiiRO2zsmy8Lwc=
X-Gm-Gg: ASbGncua90m2YDI7Yx8gDiz4qvPJ0r8OkNQ8CPPgAV68Qyy1JeSY+5PT8qN/DuPC7Qd
	TDCP9Ebi1HqjhnrHCJo9HzjQ0zUqzofKvJJNMSF+OkO3DH3tSGTG2hdiScOiod4LeUVg5U3MyMt
	lkmciLEkVmhzpRvx5DfR52NzUeupmjOz0qv9JpsuTntYI0sns1sKG15dzHhaDdhg2/kg3fiNumj
	s+Qn/mg+pfEHudttyIsK/MbnAn+NiM1smbgtSasa5WoH5EkENQ6DqSVLx+k53m+CfM9H2RtGvJB
	44+v+6+S/SuqYt859K5slVPskOaqKDScea+qbffEVFzU9DhdyIdmXJcZdkwfMs+Wfi3dyxSy04C
	aH69TTw7XU3rsb5L0yB3eWMA0vkTJSTYzPLKGQ/xkzljm67dHoQh90Tg=
X-Google-Smtp-Source: AGHT+IH14YJIU/pCQLxK6heygYQ8+5SPefXRMNU94Q5Y9SS8UUy1273yVEMkFePKwHp+1d4YOuXzeg==
X-Received: by 2002:a05:6a00:138f:b0:76e:885a:c338 with SMTP id d2e1a72fcca58-7761219fbc4mr2061714b3a.30.1757659079662;
        Thu, 11 Sep 2025 23:37:59 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:9e14:1074:637d:9ff6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c54a71sm4279534b3a.102.2025.09.11.23.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:37:58 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:37:54 +0800
From: FIRST_NAME LAST_NAME <409411716@gms.tku.edu.tw>
To: Eric Biggers <ebiggers@kernel.org>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
	hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
	jaegeuk@kernel.org, kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, tytso@mit.edu,
	visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v2 2/5] lib/base64: rework encoder/decoder with
 customizable support and update nvme-auth
Message-ID: <aMO/woLrAN7bn9Fd@wu-Pro-E500-G6-WS720T>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911074159.656943-1-409411716@gms.tku.edu.tw>
 <20250911182742.GC1376@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911182742.GC1376@sol>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_233801_328055_62D8DAC8 
X-CRM114-Status: GOOD (  33.17  )
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

The stricter correctness here refers to the decoder — specifically the padding
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

That was my mistake — I forgot to update this part of the comment.
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

