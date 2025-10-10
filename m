Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41E4CCA476
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Oct 2025 09:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eV0VkyvZwjNec7z9vbdRZ7vdRavcOqLYA4ozWnex1xw=; b=nWXh52DM9G28M6D1EVaYufWBSV
	0ZCPIhdh8GHaPcyYNhfiHlNc4JUkcZPgGQe0qBVK1L40aPqTomIT7xy3JNzkKF9j6Z2zzYFiIW4eU
	Ykx13gl6bt6o+PtPkOnI1SjwCd3ucN8QEw4vx1Qruyq2ROiC8iEZDUpXhrIsfKE26nI2wq4DteMpw
	rQhLQFVSSnwsYAe2oJvxDX5/eXNj/fSiJU+cxLIr+q4NwuKHgMuRk5qKSL1zGCW/Xhg5906PO2liO
	wIQK9UcLIP5cFcmA/WCOWo//GHmS+JtdMnxEXHJX2DC0yaMClIwdAYtIj74v8sEz84WCP+ll0zH05
	8t+y9PIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v79mu-00000008Cc3-15az;
	Fri, 10 Oct 2025 09:51:48 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v79ms-00000008CbJ-05bo
	for linux-nvme@lists.infradead.org;
	Fri, 10 Oct 2025 09:51:47 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-42421b1514fso938186f8f.2
        for <linux-nvme@lists.infradead.org>; Fri, 10 Oct 2025 02:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760089904; x=1760694704; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eV0VkyvZwjNec7z9vbdRZ7vdRavcOqLYA4ozWnex1xw=;
        b=hGcStIMPaxaJZ4gouWk4V/GafFsYx6eQ72Y3yRGAMrZB8joCWMk8wWy62Q1THkb6M7
         EjzgMmw3L7T67RgGy6D6wHwQkskNeJ4vkA5fSWtFSE8RDEUEbzPKRTaTD8lA7o4WoHPF
         yCVtylrhDZ6yyc2Xct+3BEozCn5+VpwFTZCPCt9hAdnPIvFno3FJ+ISZcHLcCy6NEte2
         7FPBJ1nWWqFe+J2RvIe4oYbmdHA2/rPE8JE/wDnnvrgC3hgMD8O6f/a21CswGLMrWvC1
         rQa07JDEviaV05dQiEYANeRYYrqM63UDJC2ZCS+XgDVrdOWKJzg0nScdkRm4ZXnRnAiz
         Fv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760089904; x=1760694704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eV0VkyvZwjNec7z9vbdRZ7vdRavcOqLYA4ozWnex1xw=;
        b=XQcaG4Ox9uGxXPAT7kTwqAdrJfyX3Gw4QgUzQWVGW2SDFPz/Zhqk7ouFw6DE/N5XdK
         TvOU6GwjjPc+aaFvy796Tl5q/g+4jkz9/qKS1ssETSvsijD1Nr/xKL8up4cby2GPNAhh
         GCN1v66pNmorxqiqMz9I/FcKf1GiLCITZGCGJ+kbW3YhbiCcMkwf1+mehRTBZgrokVvy
         wExca4Us9SXQzCOmFHmah7cXLajSxWplH0DosuufJX8imxPjAZJA/jRCvMtFNrFslTqY
         7jbjYDjgFafECrr9lhNGMvtSWIAndxbyGwV80NBxWr3iyhjZ8GzlpOQMowlB7cc4y5bZ
         OB0A==
X-Forwarded-Encrypted: i=1; AJvYcCW1+67GiIyqiDWpruKMqgHSss6A4mW7oI4aTWlnXPUjdopvKUfrDaGG12XnC6XALu3hTP4LjEsk6bXo@lists.infradead.org
X-Gm-Message-State: AOJu0YwtyqaWi6s0eXCppuNgI3jw+MQE0Zy+s3Cbi0XujsqSXCGNTR96
	8sXQuVVG3JGaASFd0WsZdPUSIe/Q8dyvqf1evnUU1V+0FX392ELvsoS0
X-Gm-Gg: ASbGncuhyHeN9gI0KRT8rQ/WmH/OJxfgalNghNWMuVDF6VuHaupIutHn407RRcvXwEG
	k4L4jR+f7tIfFkGQYcQwmhM9dSf5crYqIeinbmjrEGvKZfb/AWX8kuO5eB+jBz7w7RNPQS6Mqky
	82aFdIqOcUL5E4Sf5u1JPmh5bXta5gJYGpDApIxXgrH1pQXsG4UFfg1o9gGGihr803W2V+IOSUs
	CEWBwkJZTN8N9c2xNjreU8rVL7xEtqgu8BCV978825D8BpP5cr3FHE+SGTVlAkOuAlIbtsOKo31
	NpSRGUHqWUYZDv6+hugyIMkbySblsZSOIHsuJjMCeba4DlUkFRvd0DuCEWKySeBqq5ifMi1qieE
	3qvEuK89DizCDXlbnKHlHeXCCleSEz1tCaYbYq6VOMBTdH3MA0BKyF4DC+R5YCe2w8s/Df2ouTh
	voJahmhmk=
X-Google-Smtp-Source: AGHT+IEA2a9V9moY9Q0X8l4fa8n2FoyS2Xm8feyo+zRRNYARtth7YTtorp1JP7E6mAtA18UXC+S7bw==
X-Received: by 2002:a05:6000:603:b0:401:41a9:524f with SMTP id ffacd0b85a97d-4266e7d452bmr7539955f8f.29.1760089903522;
        Fri, 10 Oct 2025 02:51:43 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e83e1sm3392578f8f.51.2025.10.10.02.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:51:43 -0700 (PDT)
Date: Fri, 10 Oct 2025 10:51:38 +0100
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
Message-ID: <20251010105138.0356ad75@pumpkin>
In-Reply-To: <aOeprat4/97oSWE0@wu-Pro-E500-G6-WS720T>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
	<20250926065556.14250-1-409411716@gms.tku.edu.tw>
	<CADUfDZruZWyrsjRCs_Y5gjsbfU7dz_ALGG61pQ8qCM7K2_DjmA@mail.gmail.com>
	<aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T>
	<CADUfDZq4c3dRgWpevv3+29frvd6L8G9RRdoVFpFnyRsF3Eve1Q@mail.gmail.com>
	<20251005181803.0ba6aee4@pumpkin>
	<aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
	<CADUfDZp6TA_S72+JDJRmObJgmovPgit=-Zf+-oC+r0wUsyg9Jg@mail.gmail.com>
	<20251007192327.57f00588@pumpkin>
	<aOeprat4/97oSWE0@wu-Pro-E500-G6-WS720T>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251010_025146_099029_63B68249 
X-CRM114-Status: GOOD (  32.94  )
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

On Thu, 9 Oct 2025 20:25:17 +0800
Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:

...
> As Eric mentioned, the decoder in fs/crypto/ needs to reject invalid inpu=
t.

(to avoid two different input buffers giving the same output)

Which is annoyingly reasonable.

> One possible solution I came up with is to first create a shared
> base64_rev_common lookup table as the base for all Base64 variants.
> Then, depending on the variant (e.g., BASE64_STD, BASE64_URLSAFE, etc.), =
we
> can dynamically adjust the character mappings for position 62 and positio=
n 63
> at runtime, based on the variant.
>=20
> Here are the changes to the code:
>=20
> static const s8 base64_rev_common[256] =3D {
> 	[0 ... 255] =3D -1,
> 	['A'] =3D  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12,
> 		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
> 	['a'] =3D 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38,
> 		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
> 	['0'] =3D 52, 53, 54, 55, 56, 57, 58, 59, 60, 61,
> };
>=20
> static const struct {
> 	char char62, char63;
> } base64_symbols[] =3D {
> 	[BASE64_STD] =3D { '+', '/' },
> 	[BASE64_URLSAFE] =3D { '-', '_' },
> 	[BASE64_IMAP] =3D { '+', ',' },
> };
>=20
> int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enu=
m base64_variant variant)
> {
> 	u8 *bp =3D dst;
> 	u8 pad_cnt =3D 0;
> 	s8 input1, input2, input3, input4;
> 	u32 val;
> 	s8 base64_rev_tables[256];
>=20
> 	/* Validate the input length for padding */
> 	if (unlikely(padding && (srclen & 0x03) !=3D 0))
> 		return -1;

There is no need for an early check.
Pick it up after the loop when 'srclen !=3D 0'.

>=20
> 	memcpy(base64_rev_tables, base64_rev_common, sizeof(base64_rev_common));

Ugg - having a memcpy() here is not a good idea.
It really is better to have 3 arrays, but use a 'mostly common' initialiser.
Perhaps:
#define BASE64_REV_INIT(ch_62, ch_63) =3D { \
	[0 ... 255] =3D -1, \
	['A'] =3D  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, \
	['a'] =3D 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, \
		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, \
	['0'] =3D 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
	[ch_62] =3D 62, [ch_63] =3D 63, \
}

static const s8 base64_rev_maps[][256] =3D {
	[BASE64_STD] =3D BASE64_REV_INIT('+', '/'),
	[BASE64_URLSAFE] =3D BASE64_REV_INIT('-', '_'),
	[BASE64_IMAP] =3D BASE64_REV_INIT('+', ',')
};

Then (after validating variant):
	const s8 *map =3D base64_rev_maps[variant];

>=20
> 	if (variant < BASE64_STD || variant > BASE64_IMAP)
> 		return -1;
>=20
> 	base64_rev_tables[base64_symbols[variant].char62] =3D 62;
> 	base64_rev_tables[base64_symbols[variant].char63] =3D 63;
>=20
> 	while (padding && srclen > 0 && src[srclen - 1] =3D=3D '=3D') {
> 		pad_cnt++;
> 		srclen--;
> 		if (pad_cnt > 2)
> 			return -1;
> 	}

I'm not sure I'd to that there.
You are (in some sense) optimising for padding.
=46rom what I remember, "abcd" gives 24 bits, "abc=3D" 16 and "ab=3D=3D" 8.

>=20
> 	while (srclen >=3D 4) {
> 		/* Decode the next 4 characters */
> 		input1 =3D base64_rev_tables[(u8)src[0]];
> 		input2 =3D base64_rev_tables[(u8)src[1]];
> 		input3 =3D base64_rev_tables[(u8)src[2]];
> 		input4 =3D base64_rev_tables[(u8)src[3]];

I'd be tempted to make src[] unsigned - probably be assigning the parameter
to a local at the top of the function.

Also you have input3 =3D ... src[2]...
Perhaps they should be input[0..3] instead.

>=20
> 		val =3D (input1 << 18) |
> 		      (input2 << 12) |
> 		      (input3 << 6) |
> 		      input4;

Four lines is excessive, C doesn't require the () and I'm not sure the
compilers complain about << and |.

>=20
> 		if (unlikely((s32)val < 0))
> 			return -1;

Make 'val' signed - then you don't need the cast.
You can pick up the padding check here, something like:
			val =3D input1 << 18 | input2 << 12;
			if (!padding || val < 0 || src[3] !=3D '=3D')
				return -1;
			*bp++ =3D val >> 16;
			if (src[2] =3D=3D '=3D')
				return bp - dst;
			if (input3 < 0)
				return -1;
			val |=3D input3 << 6;
			*bp++ =3D val >> 8;
			return bp - dst;

Or, if you really want to use the code below the loop:
			if (!padding || src[3] !=3D '=3D')
				return -1;
			padding =3D 0;
			srclen -=3D 1 + (src[2] =3D=3D '=3D');
			break;


>=20
> 		*bp++ =3D (u8)(val >> 16);
> 		*bp++ =3D (u8)(val >> 8);
> 		*bp++ =3D (u8)val;

You don't need those casts.

>=20
> 		src +=3D 4;
> 		srclen -=3D 4;
> 	}
>=20
> 	/* Handle leftover characters when padding is not used */

You are coming here with padding.
I'm not sure what should happen without padding.
For a multi-line file decode I suspect the characters need adding to
the start of the next line (ie lines aren't required to contain
multiples of 4 characters - even though they almost always will).

> 	if (srclen > 0) {
> 		switch (srclen) {

You don't need an 'if' and a 'switch'.
srclen is likely to be zero, but perhaps write as:
	if (likely(!srclen))
		return bp - dst;
	if (padding || srclen =3D=3D 1)
		return -1;

	val =3D base64_rev_tables[(u8)src[0]] << 12 | base64_rev_tables[(u8)src[1]=
] << 6;
	*bp++ =3D val >> 10;
	if (srclen =3D=3D 1) {
		if (val & 0x800003ff)
			return -1;
	} else {
		val |=3D base64_rev_tables[(u8)src[2]];
		if (val & 0x80000003)
			return -1;
		*bp++ =3D val >> 2;
	}
	return bp - dst;
}

	David

> 		case 2:
> 			input1 =3D base64_rev_tables[(u8)src[0]];
> 			input2 =3D base64_rev_tables[(u8)src[1]];
> 			val =3D (input1 << 6) | input2; /* 12 bits */
> 			if (unlikely((s32)val < 0 || val & 0x0F))
> 				return -1;
>=20
> 			*bp++ =3D (u8)(val >> 4);
> 			break;
> 		case 3:
> 			input1 =3D base64_rev_tables[(u8)src[0]];
> 			input2 =3D base64_rev_tables[(u8)src[1]];
> 			input3 =3D base64_rev_tables[(u8)src[2]];
>=20
> 			val =3D (input1 << 12) |
> 			      (input2 << 6) |
> 			      input3; /* 18 bits */
> 			if (unlikely((s32)val < 0 || val & 0x03))
> 				return -1;
>=20
> 			*bp++ =3D (u8)(val >> 10);
> 			*bp++ =3D (u8)(val >> 2);
> 			break;
> 		default:
> 			return -1;
> 		}
> 	}
>=20
> 	return bp - dst;
> }
> Based on KUnit testing, the performance results are as follows:
> 	base64_performance_tests: [64B] decode run : 40ns
> 	base64_performance_tests: [1KB] decode run : 463ns
>=20
> However, this approach introduces an issue. It uses 256 bytes of memory
> on the stack for base64_rev_tables, which might not be ideal. Does anyone
> have any thoughts or alternative suggestions to solve this issue, or is it
> not really a concern?
>=20
> Best regards,
> Guan-Chun
>=20
> > >=20
> > > Best,
> > > Caleb =20
> >  =20


