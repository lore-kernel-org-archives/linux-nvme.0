Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20845CCA476
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 09:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bp51fhwIp2TxChiApwV+E+DXmQ/uPeFWu0ZwqX85B3w=; b=hDcyMuwMtRRoT6xwcBVfT8fEWp
	pJdxl6DUN2hGOwHmr5PPm+6e34yVBeVlC09qNhqfV6Qo7wvCQTmC9g93XQdQDH+xqECMUUb3zlH7K
	3AbgDMYDplsMCJ3g1vx/tKtGrImu8LB41k2HYc44dEQ3lKhJ/wyKpMSm6eWrAC18AvwFsnobLJAwG
	sYwYg1gRTEvx5glBy9SoHnq/u48wGkIjueqfUWY7CXo7iL0fqni+64hDwK7EJwP3K7Mks1qkVcMVB
	lDkPo50Yc2BIi3oL8ryU/qMxG04Qu9ApgQsqagWA5YbRZ3xENjTmP9jczhHxcZzBZzTxZiMZV9eyp
	frlp35rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8FBv-0000000CnYi-2oCF;
	Mon, 13 Oct 2025 09:50:07 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8FBs-0000000CnXs-3oR2
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 09:50:06 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2681660d604so44279345ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 13 Oct 2025 02:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1760349003; x=1760953803; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bp51fhwIp2TxChiApwV+E+DXmQ/uPeFWu0ZwqX85B3w=;
        b=m6ypT53QFv0MjwN7Szcoac4FJF0OQgrZKOyhWajM553AHV7Lmofi6gkRPXnex2a2mj
         x9AgUGVHkOq6cLJ5f1XiLq8RNiUdOYP2sCS1G3ZBlEBarKJ47W2JuBPV65iAg0rzmteg
         X1UaNgg3lt8jaiZpR30CPYyvbHfnouMmN2QG6z2yzayOl1BjA7X3a5tl9tjb/1Gxz7Hh
         bHW6awn1GZa9PY/GrKlOlP3ESq2OZxMu0BCUpUSFIYtrw2wPZE602EVJIsVCSzJwaWMR
         GuiAdmyt5ZrzH+aiOi4ZF1yKo8n82FqJYs5W3BLwr4ZG3hOZ+NKZ/fdIvkSalUNojp2g
         rRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349003; x=1760953803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp51fhwIp2TxChiApwV+E+DXmQ/uPeFWu0ZwqX85B3w=;
        b=H2wj5KChJGvvE/1dMTIiis0zPncJZHR7bef9z08tBo+jA2FalmKGAK5rVLhwkzFrLW
         W0mTvls8IEu4a5LMLLorwdBRGNgWNwtu2ZZHTkQWELdlnajzHpilU2N+/LgBCQmaxtN5
         sneYs5PCRXXGy846LBiQxnnvI5o8na3TrZqTUY0hQpVRLWk2WaR1v2qBSqbBsj4frGpT
         CHg6aAeHt/ddCq6DeKYCb9wKLAmWNQiD52FuW7ju2PHyZEUc/hwSMqmN0Rbc1sHp8uTC
         fjShxkGwxnxP7zYQeGfhuM3I10CyimuwI7kFlTb5eGx0jifqM9XBQOaPF/XltZz0PE84
         5jvw==
X-Forwarded-Encrypted: i=1; AJvYcCVbEfJ7bTdaxqVDtmSE0ShbVrBzhY0tWuor2dQIAMmKT/f7T20+gv86bngH7RyWe6Zhq2preNULg7DA@lists.infradead.org
X-Gm-Message-State: AOJu0YyZnEXJU2SU4ipeVSZ09sc/7dqnu2n3CyUFm0/2IKhO4i4jKetL
	Z0mnsjd0VSeQ1Iss5YyccY86Nel0zJ+0ztcsSUHdH1tqHH1QC1OKjIrS5prSKo5wnKs=
X-Gm-Gg: ASbGnctHe9Z+XCG5ASGLBH9/At2zband3O/gzc/k/j53EVNQXXKRC3v3yxS8PdKGPJa
	8FSqm4wSahoUiwaDkm3nH9upR6JeDvDD/G0NC0gb4KRMQcAA1KWmF1H/ptq8KrkviYj2gtWyFKW
	aJVu7+LbXGrp5XdxGm+dU1yRbDD3tJrM1xO+FmdG2TOvoIduAIUFVpkDlp/KfOb5PK9TMdduisp
	faVv8Q9y3d6XaAddntaHWFtXH7dmXSCtOMxIsOw+xxhtSAlBLxDJRB5QOYK1Qo3RLAxhQIcjVy0
	QY77cnpeVGWjYPM8gp78EcqoyeqIVl9B3ulm29aJxm2+roPLUGJllOGeEJKR0VI7zqXLYW+7Q7y
	Hn4jARv4mFWHxUuRkuouGpgmwKVLV7e/aIL82IUAyMnZ/YhSvSmnhD5CGMzlhQO7A105ogFNozg
	==
X-Google-Smtp-Source: AGHT+IG1JzQQHQjMT21Ythm1gXAqTXhkL84Z5ZHyVJBm9N9Dh0WoFdsAzPwZjCutcgln/HrN3DWkBQ==
X-Received: by 2002:a17:902:f60d:b0:26a:b9b4:8342 with SMTP id d9443c01a7336-2902726259dmr238303985ad.25.1760349003313;
        Mon, 13 Oct 2025 02:50:03 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:b0a8:f639:5bec:40e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f06c82sm129052355ad.81.2025.10.13.02.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:50:02 -0700 (PDT)
Date: Mon, 13 Oct 2025 17:49:55 +0800
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: David Laight <david.laight.linux@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	akpm@linux-foundation.org, axboe@kernel.dk,
	ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
	home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
	kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com,
	xiubli@redhat.com
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with reverse
 lookup tables
Message-ID: <aOzLQ2KSqGn1eYrm@wu-Pro-E500-G6-WS720T>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010105138.0356ad75@pumpkin>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_025005_071600_30A9AD70 
X-CRM114-Status: GOOD (  49.88  )
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

On Fri, Oct 10, 2025 at 10:51:38AM +0100, David Laight wrote:
> On Thu, 9 Oct 2025 20:25:17 +0800
> Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> 
> ...
> > As Eric mentioned, the decoder in fs/crypto/ needs to reject invalid input.
> 
> (to avoid two different input buffers giving the same output)
> 
> Which is annoyingly reasonable.
> 
> > One possible solution I came up with is to first create a shared
> > base64_rev_common lookup table as the base for all Base64 variants.
> > Then, depending on the variant (e.g., BASE64_STD, BASE64_URLSAFE, etc.), we
> > can dynamically adjust the character mappings for position 62 and position 63
> > at runtime, based on the variant.
> > 
> > Here are the changes to the code:
> > 
> > static const s8 base64_rev_common[256] = {
> > 	[0 ... 255] = -1,
> > 	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12,
> > 		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
> > 	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38,
> > 		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
> > 	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61,
> > };
> > 
> > static const struct {
> > 	char char62, char63;
> > } base64_symbols[] = {
> > 	[BASE64_STD] = { '+', '/' },
> > 	[BASE64_URLSAFE] = { '-', '_' },
> > 	[BASE64_IMAP] = { '+', ',' },
> > };
> > 
> > int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
> > {
> > 	u8 *bp = dst;
> > 	u8 pad_cnt = 0;
> > 	s8 input1, input2, input3, input4;
> > 	u32 val;
> > 	s8 base64_rev_tables[256];
> > 
> > 	/* Validate the input length for padding */
> > 	if (unlikely(padding && (srclen & 0x03) != 0))
> > 		return -1;
> 
> There is no need for an early check.
> Pick it up after the loop when 'srclen != 0'.
>

I think the early check is still needed, since I'm removing the
padding '=' first.
This makes the handling logic consistent for both padded and unpadded
inputs, and avoids extra if conditions for padding inside the hot loop.

> > 
> > 	memcpy(base64_rev_tables, base64_rev_common, sizeof(base64_rev_common));
> 
> Ugg - having a memcpy() here is not a good idea.
> It really is better to have 3 arrays, but use a 'mostly common' initialiser.
> Perhaps:
> #define BASE64_REV_INIT(ch_62, ch_63) = { \
> 	[0 ... 255] = -1, \
> 	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
> 		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, \
> 	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, \
> 		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, \
> 	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> 	[ch_62] = 62, [ch_63] = 63, \
> }
> 
> static const s8 base64_rev_maps[][256] = {
> 	[BASE64_STD] = BASE64_REV_INIT('+', '/'),
> 	[BASE64_URLSAFE] = BASE64_REV_INIT('-', '_'),
> 	[BASE64_IMAP] = BASE64_REV_INIT('+', ',')
> };
> 
> Then (after validating variant):
> 	const s8 *map = base64_rev_maps[variant];
>

Got it. I'll switch to using three static tables with a common initializer
as you suggested.

> > 
> > 	if (variant < BASE64_STD || variant > BASE64_IMAP)
> > 		return -1;
> > 
> > 	base64_rev_tables[base64_symbols[variant].char62] = 62;
> > 	base64_rev_tables[base64_symbols[variant].char63] = 63;
> > 
> > 	while (padding && srclen > 0 && src[srclen - 1] == '=') {
> > 		pad_cnt++;
> > 		srclen--;
> > 		if (pad_cnt > 2)
> > 			return -1;
> > 	}
> 
> I'm not sure I'd to that there.
> You are (in some sense) optimising for padding.
> From what I remember, "abcd" gives 24 bits, "abc=" 16 and "ab==" 8.
> 
> > 
> > 	while (srclen >= 4) {
> > 		/* Decode the next 4 characters */
> > 		input1 = base64_rev_tables[(u8)src[0]];
> > 		input2 = base64_rev_tables[(u8)src[1]];
> > 		input3 = base64_rev_tables[(u8)src[2]];
> > 		input4 = base64_rev_tables[(u8)src[3]];
> 
> I'd be tempted to make src[] unsigned - probably be assigning the parameter
> to a local at the top of the function.
> 
> Also you have input3 = ... src[2]...
> Perhaps they should be input[0..3] instead.
>

OK, I'll make the changes.

> > 
> > 		val = (input1 << 18) |
> > 		      (input2 << 12) |
> > 		      (input3 << 6) |
> > 		      input4;
> 
> Four lines is excessive, C doesn't require the () and I'm not sure the
> compilers complain about << and |.
> 

OK, I'll make the changes.

> > 
> > 		if (unlikely((s32)val < 0))
> > 			return -1;
> 
> Make 'val' signed - then you don't need the cast.
> You can pick up the padding check here, something like:
> 			val = input1 << 18 | input2 << 12;
> 			if (!padding || val < 0 || src[3] != '=')
> 				return -1;
> 			*bp++ = val >> 16;
> 			if (src[2] == '=')
> 				return bp - dst;
> 			if (input3 < 0)
> 				return -1;
> 			val |= input3 << 6;
> 			*bp++ = val >> 8;
> 			return bp - dst;
> 
> Or, if you really want to use the code below the loop:
> 			if (!padding || src[3] != '=')
> 				return -1;
> 			padding = 0;
> 			srclen -= 1 + (src[2] == '=');
> 			break;
> 
> 
> > 
> > 		*bp++ = (u8)(val >> 16);
> > 		*bp++ = (u8)(val >> 8);
> > 		*bp++ = (u8)val;
> 
> You don't need those casts.
>

OK, I'll make the changes.

> > 
> > 		src += 4;
> > 		srclen -= 4;
> > 	}
> > 
> > 	/* Handle leftover characters when padding is not used */
> 
> You are coming here with padding.
> I'm not sure what should happen without padding.
> For a multi-line file decode I suspect the characters need adding to
> the start of the next line (ie lines aren't required to contain
> multiples of 4 characters - even though they almost always will).
> 

Ah, my mistake. I forgot to remove that comment.
Based on my observation, base64_decode() should process the entire input
buffer in a single call, so I believe it does not need to handle
multi-line input.

Best regards,
Guan-Chun

> > 	if (srclen > 0) {
> > 		switch (srclen) {
> 
> You don't need an 'if' and a 'switch'.
> srclen is likely to be zero, but perhaps write as:
> 	if (likely(!srclen))
> 		return bp - dst;
> 	if (padding || srclen == 1)
> 		return -1;
> 
> 	val = base64_rev_tables[(u8)src[0]] << 12 | base64_rev_tables[(u8)src[1]] << 6;
> 	*bp++ = val >> 10;
> 	if (srclen == 1) {
> 		if (val & 0x800003ff)
> 			return -1;
> 	} else {
> 		val |= base64_rev_tables[(u8)src[2]];
> 		if (val & 0x80000003)
> 			return -1;
> 		*bp++ = val >> 2;
> 	}
> 	return bp - dst;
> }
> 
> 	David
> 
> > 		case 2:
> > 			input1 = base64_rev_tables[(u8)src[0]];
> > 			input2 = base64_rev_tables[(u8)src[1]];
> > 			val = (input1 << 6) | input2; /* 12 bits */
> > 			if (unlikely((s32)val < 0 || val & 0x0F))
> > 				return -1;
> > 
> > 			*bp++ = (u8)(val >> 4);
> > 			break;
> > 		case 3:
> > 			input1 = base64_rev_tables[(u8)src[0]];
> > 			input2 = base64_rev_tables[(u8)src[1]];
> > 			input3 = base64_rev_tables[(u8)src[2]];
> > 
> > 			val = (input1 << 12) |
> > 			      (input2 << 6) |
> > 			      input3; /* 18 bits */
> > 			if (unlikely((s32)val < 0 || val & 0x03))
> > 				return -1;
> > 
> > 			*bp++ = (u8)(val >> 10);
> > 			*bp++ = (u8)(val >> 2);
> > 			break;
> > 		default:
> > 			return -1;
> > 		}
> > 	}
> > 
> > 	return bp - dst;
> > }
> > Based on KUnit testing, the performance results are as follows:
> > 	base64_performance_tests: [64B] decode run : 40ns
> > 	base64_performance_tests: [1KB] decode run : 463ns
> > 
> > However, this approach introduces an issue. It uses 256 bytes of memory
> > on the stack for base64_rev_tables, which might not be ideal. Does anyone
> > have any thoughts or alternative suggestions to solve this issue, or is it
> > not really a concern?
> > 
> > Best regards,
> > Guan-Chun
> > 
> > > > 
> > > > Best,
> > > > Caleb  
> > >   
> 

