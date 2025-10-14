Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A86CCD187
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Oct 2025 08:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UCGlydBv1IgmD6OYCzpqtJgg2Lvc0HUVlRtG6th7/NU=; b=TXpi3KdqpOELQJc8kzhP7pHoSb
	mDnfW2CSj9HLC9jhcpXVN8R/CKsC8+ZSnQSgPD/yzEcxf1k4cacsXHk0zU0YwPmIABLaN7z1umZxr
	ptSt5mu6j7w9gpM4lYhzShydeSE0/4pAZbeDmSReKwk7gCKV3kPYCEQxX7a67q8Op6i0slbtlXSpO
	JLw5b06POsx3zBOsUXJMB355NBLPQSd72UPls0mrte1RrrFjVOEs1xCjdd2GaM1V+L7VXHAh7IRqW
	J2g2VlEOkJR4Xz9qezFI95QW96yj8DdWFyTcGXsxe88hv0K3lK3ND+8zXC/hvWDiDOh9LiQqEFH9q
	TOzEmS3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8aB0-0000000FZy3-2GAE;
	Tue, 14 Oct 2025 08:14:34 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8aAu-0000000FZta-2vzK
	for linux-nvme@lists.infradead.org;
	Tue, 14 Oct 2025 08:14:29 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso27094595e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 14 Oct 2025 01:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760429666; x=1761034466; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCGlydBv1IgmD6OYCzpqtJgg2Lvc0HUVlRtG6th7/NU=;
        b=dL0yxiUmBCvVBWxWQTFdEczz79X1kxb5W+NPN6t3TO9vJ2p55lkjWiyfxyGIBxH0rF
         WvF5hRCg6fuPDN4AUzeT2P6D27Pp+4LtVKGcRWyut0AoQRmFDKtmdP8nOzCb+yoWASmc
         +3D1foSRPiuKcheZaZs22fN93EqgR8L7Whf3jHmboTmT2cvmWc+ivzx3aAWK/Z8F2mp8
         LAwyZK1mJB+476t9+3otUDE9QIvalvGx9xjAqH/bQI5ecT6JUrBEDJ8x5p9lo70iEMLd
         9+viffMDEZUjmT+BdSo4tPb7hI+EErmejT/t7s4Tvnz0PrSPfRqLIMOSFvXg3TQSxlpl
         RBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429666; x=1761034466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCGlydBv1IgmD6OYCzpqtJgg2Lvc0HUVlRtG6th7/NU=;
        b=Ng7NJ7zzNSH0yrlQjQd1S3FCR8CVKMaVf7T67/3tKplJvdvSGvlVi5NZHmd+V3Irq9
         veFmIo3OHS9FLfC36ZHeYp4gP5X2RqryR8IyYukQT0Mc3vRDXueE8KcKx/e3X9L8x+Nj
         JH/NOKnllkwSmff8MlBGk9RBd0s4KhwoSqx0Lo3TikYiabj7W7ZWeiZL47HOx/PLnK7H
         SEtNZIqALLMxsCz0INCbP8S15UtSCIPdB60BwTjwq9TwBGrT2W/NPvSmIDACmugkemQ1
         jKSNw7zTv9rCj5pBuEZyBHjIyvD4tdG0pPLjPpBjJZWCzXs/4JbHK6LlbaT3lEt62vA5
         A3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXNzhu0PV0Wzl9TqVXrYQxHCq14Ep3dLoFzfNnta0Yw9NwJo/ansnmMptNLjpYBTMwBRBUgKV16AX1m@lists.infradead.org
X-Gm-Message-State: AOJu0Yzoi6oP8e1BS2uQVHSzHhma4xpUHrACQvGzLCd7htnTgWzezvqY
	TMoQRJJX6I3p9lz1hn4n4oB95fxzCZYEGrt8zpIHlTKObdXJkydWFN50
X-Gm-Gg: ASbGncu1PjbVxm9MzVi0UdyBXuTfPgtdhpNR40J4J8rmKWbxC0C8t9I7dkIr9mlYq72
	tjrZOnkGIjaeL5UbH/M3AeIqpJstsJAmtAizddeEQNXrbZRbkea87Re/5a+GjAhONdjZvJurT3M
	8MpHmyUtaHiDHk7ohOVXl4lq8447MXX7md1PIX1gb1E2w8RP8kIHzcwkdfelwQZZzp/9kgB9bQV
	lTijvoaEumrauL8e4O2XmtA6rPkPUD3kuje0wPNPJry1E/RwO+9hJ+DUzOS3Zart7hTBSLQ0BeZ
	5Bo7CX1GNwccqZkRoscSNpehg8iD52Kbze8bJPvlg9PkER86KBLFR0fcJt8VSj0aPvYazYctTmk
	ayvt1Z4g88F+4JrnSrPwx3/h/xFpBOiuK/7DR9q+cIDJ6cV4B93/lBF13GWm45ltOtmxtZ5SWbJ
	TsvaQdtU4=
X-Google-Smtp-Source: AGHT+IGlURcaYtxeR/4YJghdHkVrrVvxKtUh4t7BLUPo3pxJJ/Y8h3MpYW3S6t6HOaxlenUga+CUFg==
X-Received: by 2002:a05:600c:1f8e:b0:46f:b42e:e392 with SMTP id 5b1f17b1804b1-46fbbeb30a2mr74875685e9.39.1760429666272;
        Tue, 14 Oct 2025 01:14:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489194dsm226883765e9.12.2025.10.14.01.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:14:25 -0700 (PDT)
Date: Tue, 14 Oct 2025 09:14:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
 ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
 jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with
 reverse lookup tables
Message-ID: <20251014091420.173dfc9c@pumpkin>
In-Reply-To: <aOzLQ2KSqGn1eYrm@wu-Pro-E500-G6-WS720T>
References: <20250926065556.14250-1-409411716@gms.tku.edu.tw>
	<CADUfDZruZWyrsjRCs_Y5gjsbfU7dz_ALGG61pQ8qCM7K2_DjmA@mail.gmail.com>
	<aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T>
	<CADUfDZq4c3dRgWpevv3+29frvd6L8G9RRdoVFpFnyRsF3Eve1Q@mail.gmail.com>
	<20251005181803.0ba6aee4@pumpkin>
	<aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
	<CADUfDZp6TA_S72+JDJRmObJgmovPgit=-Zf+-oC+r0wUsyg9Jg@mail.gmail.com>
	<20251007192327.57f00588@pumpkin>
	<aOeprat4/97oSWE0@wu-Pro-E500-G6-WS720T>
	<20251010105138.0356ad75@pumpkin>
	<aOzLQ2KSqGn1eYrm@wu-Pro-E500-G6-WS720T>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_011428_800649_F7C040D9 
X-CRM114-Status: GOOD (  58.89  )
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

On Mon, 13 Oct 2025 17:49:55 +0800
Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:

> On Fri, Oct 10, 2025 at 10:51:38AM +0100, David Laight wrote:
> > On Thu, 9 Oct 2025 20:25:17 +0800
> > Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> > 
> > ...  
> > > As Eric mentioned, the decoder in fs/crypto/ needs to reject invalid input.  
> > 
> > (to avoid two different input buffers giving the same output)
> > 
> > Which is annoyingly reasonable.
> >   
> > > One possible solution I came up with is to first create a shared
> > > base64_rev_common lookup table as the base for all Base64 variants.
> > > Then, depending on the variant (e.g., BASE64_STD, BASE64_URLSAFE, etc.), we
> > > can dynamically adjust the character mappings for position 62 and position 63
> > > at runtime, based on the variant.
> > > 
> > > Here are the changes to the code:
> > > 
> > > static const s8 base64_rev_common[256] = {
> > > 	[0 ... 255] = -1,
> > > 	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12,
> > > 		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
> > > 	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38,
> > > 		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
> > > 	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61,
> > > };
> > > 
> > > static const struct {
> > > 	char char62, char63;
> > > } base64_symbols[] = {
> > > 	[BASE64_STD] = { '+', '/' },
> > > 	[BASE64_URLSAFE] = { '-', '_' },
> > > 	[BASE64_IMAP] = { '+', ',' },
> > > };
> > > 
> > > int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
> > > {
> > > 	u8 *bp = dst;
> > > 	u8 pad_cnt = 0;
> > > 	s8 input1, input2, input3, input4;
> > > 	u32 val;
> > > 	s8 base64_rev_tables[256];
> > > 
> > > 	/* Validate the input length for padding */
> > > 	if (unlikely(padding && (srclen & 0x03) != 0))
> > > 		return -1;  
> > 
> > There is no need for an early check.
> > Pick it up after the loop when 'srclen != 0'.
> >  
> 
> I think the early check is still needed, since I'm removing the
> padding '=' first.
> This makes the handling logic consistent for both padded and unpadded
> inputs, and avoids extra if conditions for padding inside the hot loop.

The 'invalid input' check will detect the padding.
Then you don't get an extra check if there is no padding (probably normal).
I realised I didn't get it quite right - updated below.

> 
> > > 
> > > 	memcpy(base64_rev_tables, base64_rev_common, sizeof(base64_rev_common));  
> > 
> > Ugg - having a memcpy() here is not a good idea.
> > It really is better to have 3 arrays, but use a 'mostly common' initialiser.
> > Perhaps:
> > #define BASE64_REV_INIT(ch_62, ch_63) = { \
> > 	[0 ... 255] = -1, \
> > 	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
> > 		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, \
> > 	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, \
> > 		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, \
> > 	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> > 	[ch_62] = 62, [ch_63] = 63, \
> > }
> > 
> > static const s8 base64_rev_maps[][256] = {
> > 	[BASE64_STD] = BASE64_REV_INIT('+', '/'),
> > 	[BASE64_URLSAFE] = BASE64_REV_INIT('-', '_'),
> > 	[BASE64_IMAP] = BASE64_REV_INIT('+', ',')
> > };
> > 
> > Then (after validating variant):
> > 	const s8 *map = base64_rev_maps[variant];
> >  
> 
> Got it. I'll switch to using three static tables with a common initializer
> as you suggested.
> 
> > > 
> > > 	if (variant < BASE64_STD || variant > BASE64_IMAP)
> > > 		return -1;
> > > 
> > > 	base64_rev_tables[base64_symbols[variant].char62] = 62;
> > > 	base64_rev_tables[base64_symbols[variant].char63] = 63;
> > > 
> > > 	while (padding && srclen > 0 && src[srclen - 1] == '=') {
> > > 		pad_cnt++;
> > > 		srclen--;
> > > 		if (pad_cnt > 2)
> > > 			return -1;
> > > 	}  
> > 
> > I'm not sure I'd to that there.
> > You are (in some sense) optimising for padding.
> > From what I remember, "abcd" gives 24 bits, "abc=" 16 and "ab==" 8.
> >   
> > > 
> > > 	while (srclen >= 4) {
> > > 		/* Decode the next 4 characters */
> > > 		input1 = base64_rev_tables[(u8)src[0]];
> > > 		input2 = base64_rev_tables[(u8)src[1]];
> > > 		input3 = base64_rev_tables[(u8)src[2]];
> > > 		input4 = base64_rev_tables[(u8)src[3]];  
> > 
> > I'd be tempted to make src[] unsigned - probably be assigning the parameter
> > to a local at the top of the function.
> > 
> > Also you have input3 = ... src[2]...
> > Perhaps they should be input[0..3] instead.
> >  
> 
> OK, I'll make the changes.
> 
> > > 
> > > 		val = (input1 << 18) |
> > > 		      (input2 << 12) |
> > > 		      (input3 << 6) |
> > > 		      input4;  
> > 
> > Four lines is excessive, C doesn't require the () and I'm not sure the
> > compilers complain about << and |.
> >   
> 
> OK, I'll make the changes.
> 
> > > 
> > > 		if (unlikely((s32)val < 0))
> > > 			return -1;  
> > 
> > Make 'val' signed - then you don't need the cast.
...
> > Or, if you really want to use the code below the loop:
> > 			if (!padding || src[3] != '=')
> > 				return -1;
> > 			padding = 0;
> > 			srclen -= 1 + (src[2] == '=');
> > 			break;

That is missing a test...
Change to:
			if (!padding || srclen != 4 || src[3] != '=')
				return -1;
			padding = 0;
			srclen = src[2] == '=' ? 2 : 3;
			break;

The compiler will then optimise away the first checks after the
loop because it knows they can't happen.

> > 
> >   
> > > 
> > > 		*bp++ = (u8)(val >> 16);
> > > 		*bp++ = (u8)(val >> 8);
> > > 		*bp++ = (u8)val;  
> > 
> > You don't need those casts.
> >  
> 
> OK, I'll make the changes.
> 
> > > 
> > > 		src += 4;
> > > 		srclen -= 4;
> > > 	}
> > > 
> > > 	/* Handle leftover characters when padding is not used */  
> > 
> > You are coming here with padding.
> > I'm not sure what should happen without padding.
> > For a multi-line file decode I suspect the characters need adding to
> > the start of the next line (ie lines aren't required to contain
> > multiples of 4 characters - even though they almost always will).
> >   
> 
> Ah, my mistake. I forgot to remove that comment.
> Based on my observation, base64_decode() should process the entire input
> buffer in a single call, so I believe it does not need to handle
> multi-line input.

I was thinking of the the case where it is processing the output of
something like base64encode.
The caller will have separated out the lines, but I don't know whether
every line has to contain a multiple of 4 characters - or whether the
lines can be arbitrarily split after being encoded (I know that won't
normally happen - but you never know). 

> 
> Best regards,
> Guan-Chun
> 
> > > 	if (srclen > 0) {
> > > 		switch (srclen) {  
> > 
> > You don't need an 'if' and a 'switch'.
> > srclen is likely to be zero, but perhaps write as:
> > 	if (likely(!srclen))
> > 		return bp - dst;
> > 	if (padding || srclen == 1)
> > 		return -1;
> > 
> > 	val = base64_rev_tables[(u8)src[0]] << 12 | base64_rev_tables[(u8)src[1]] << 6;
> > 	*bp++ = val >> 10;
> > 	if (srclen == 1) {
Obviously should be (srclen == 2)
> > 		if (val & 0x800003ff)
> > 			return -1;
> > 	} else {
> > 		val |= base64_rev_tables[(u8)src[2]];
> > 		if (val & 0x80000003)
> > 			return -1;
> > 		*bp++ = val >> 2;
> > 	}
> > 	return bp - dst;
> > }
> > 
> > 	David

	David

> >   
> > > 		case 2:
> > > 			input1 = base64_rev_tables[(u8)src[0]];
> > > 			input2 = base64_rev_tables[(u8)src[1]];
> > > 			val = (input1 << 6) | input2; /* 12 bits */
> > > 			if (unlikely((s32)val < 0 || val & 0x0F))
> > > 				return -1;
> > > 
> > > 			*bp++ = (u8)(val >> 4);
> > > 			break;
> > > 		case 3:
> > > 			input1 = base64_rev_tables[(u8)src[0]];
> > > 			input2 = base64_rev_tables[(u8)src[1]];
> > > 			input3 = base64_rev_tables[(u8)src[2]];
> > > 
> > > 			val = (input1 << 12) |
> > > 			      (input2 << 6) |
> > > 			      input3; /* 18 bits */
> > > 			if (unlikely((s32)val < 0 || val & 0x03))
> > > 				return -1;
> > > 
> > > 			*bp++ = (u8)(val >> 10);
> > > 			*bp++ = (u8)(val >> 2);
> > > 			break;
> > > 		default:
> > > 			return -1;
> > > 		}
> > > 	}
> > > 
> > > 	return bp - dst;
> > > }
> > > Based on KUnit testing, the performance results are as follows:
> > > 	base64_performance_tests: [64B] decode run : 40ns
> > > 	base64_performance_tests: [1KB] decode run : 463ns
> > > 
> > > However, this approach introduces an issue. It uses 256 bytes of memory
> > > on the stack for base64_rev_tables, which might not be ideal. Does anyone
> > > have any thoughts or alternative suggestions to solve this issue, or is it
> > > not really a concern?
> > > 
> > > Best regards,
> > > Guan-Chun
> > >   
> > > > > 
> > > > > Best,
> > > > > Caleb    
> > > >     
> >   


