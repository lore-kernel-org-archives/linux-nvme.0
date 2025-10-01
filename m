Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8669BCCA470
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 10:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oN9puFkb46cQNIS5IreI+mnmbbovgsA4IsgTPeMWaYs=; b=3qawMXC2xRv58z3UuGUID5povl
	fJWkaIFfaKG1qTyiOwDpW3Oa+tAmcOHnwVNajB8P8EPbG7BaaEnlbYduc07UlM12VoDDG98dLBZjk
	kO8cvKMg4kiifRzLhgWE+9g8eJPuM6tgEvE+77bIWoC7CUYEBbvJAnUQfkRiG7/wVLgqO0J3lF0X8
	s8NvBv4S9w+bvZBysQj3llhW8Oba5NYpGVaIJzoIaUQeCmrPfiPGxYLL9CgWMgdf/v+v3kX5raNPr
	zGu4BtHj7kEDHqIixDA/ntaLH2mEm8XCCbuP0qeGmIAY47bW3/WDDEgqhM6NnK71yNj1bpuqKxvcq
	xSCRnXpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3tv3-00000007EhX-22rA;
	Wed, 01 Oct 2025 10:18:45 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3tv0-00000007EgP-0kCN
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 10:18:43 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3307de086d8so6516179a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 01 Oct 2025 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1759313921; x=1759918721; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oN9puFkb46cQNIS5IreI+mnmbbovgsA4IsgTPeMWaYs=;
        b=KiiqAQ6cSwh7K1n4oYs2jRgCQ+mHBhKEmpxLBA7OLC7mToFUcAHKWcZ/XErmutWw0W
         G5zGkZWDt1ugxvUp+6mM3xI8NYDwPDsoLr6SHQZON27QD03qUBgNSDK1cVIvJ4Qembsl
         2z4sd53cRqbIuyeiLkndIhD0mmwzPdv5+LKXzYH9obSWI6EkJLngmM5N4/hz4Nppngun
         bfngiXFQb3lWoTSS6BylPJjL56AaVKZSltVbiwcYZgJDZEMWPtQ4Qn/S1lcKThokloSJ
         2W4uhyereMl+r7MB15t0ajMNIK0rpSEo8laRuWXJbTdrTnSvsJRS0XVbYI+7fIFlq8bS
         yAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759313921; x=1759918721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oN9puFkb46cQNIS5IreI+mnmbbovgsA4IsgTPeMWaYs=;
        b=tH4ze/f0jgHTH/V5RTaELqkTS1zO/bZlhX7M7RRbNqUqDSlRmS0Lhd0pg+Np20/KZ6
         0zoTO3+l2tvUSx8woXlEE9j3QRzM6048XOCP+pTE/UWTUc2ltjDFU7EMn63J3WmcHBJ2
         t1Mni8BdMkm3OuXgjlLaIHNa5bWIPBDyZ/f6jRujVzfLf+44RmDPHZoapGyVzlUDDdGY
         wNMpGcRNbvYGMFBBfAYcpJQeF5b101Atf1a8U0vIDt552luR/qEwozqRJ6fifeDuyKjS
         S4kMbarK0ZhDa8KOHSWvPGSJtZH+xt5iGam131tP+kr8jeGvJH0toePB708Q1NPU/RQN
         0GPg==
X-Forwarded-Encrypted: i=1; AJvYcCXijOIj2owm2W+Cgye8y5TjYFXs08xjkr1R7JmDOn4Gg2VPdN3tcwlik11CSTHEFrUDMMwbvdO/mW+0@lists.infradead.org
X-Gm-Message-State: AOJu0YyFSObszQ0Xb8NYgKWWZT60kup7JA3yTbdBveCjX5JoEDIrpHAc
	rsWr98DAjxqSZwc6Bvv9uF6q2GnyeSd/Rh8+CbW+530Iw35PVnTSh8l9ZcZNK3E3ISA=
X-Gm-Gg: ASbGncvW/7HbmzUBgg7aQ9EUwlWbuLXZmmjlWTCyCUcxCNnptcdCLcvtbUN0eSaqCcb
	lPIeJEu39WxMxBoYDoL3xGkaKpvzwOX1AKIDOiZJIfOjkj6irYCn43YsnmE2K2uYTEc3ToaMjW1
	VbnYdPzjhy1Y+92BR33s2IJ9i9RZjXXL2kLwel9SG9x/bCkJf14dGkwvu18Ru6t2XV5O5vq2SBW
	TVzsp0V1MMGbQ4lk4rZPjYQuivzeTvgOZb510oP04G5DG4NL0aFvnPrMJDW9RwDO95jFjr+LvE8
	3bws9sRo39nsr4aNCi+m+Av9N6T2pQhoZn+qDjYrH3Ps9vbm9Dg1akreXiV4MNo/mllN8TGg6BM
	zxZaDwKWfn1bsVD1hmUXDceH/Saa7Wbig+eU6Rm9IAoXG2xmFYfaV2juGuRcF8AtOXlCI
X-Google-Smtp-Source: AGHT+IFs4kOlgU8X0QG7s3rpttQScpOUbtBqzYPxpTiDMADf9+c+J2mflBuEXTDwUDvWGGyPG/XFLw==
X-Received: by 2002:a17:90b:1652:b0:32a:e706:b7b6 with SMTP id 98e67ed59e1d1-339a6e75590mr2927307a91.11.1759313921134;
        Wed, 01 Oct 2025 03:18:41 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:6af7:94e4:3a78:e342])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6f20ebbsm1965811a91.24.2025.10.01.03.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 03:18:39 -0700 (PDT)
Date: Wed, 1 Oct 2025 18:18:35 +0800
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
	ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com,
	idryomov@gmail.com, jaegeuk@kernel.org, kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, tytso@mit.edu,
	visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with reverse
 lookup tables
Message-ID: <aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
 <20250926065556.14250-1-409411716@gms.tku.edu.tw>
 <CADUfDZruZWyrsjRCs_Y5gjsbfU7dz_ALGG61pQ8qCM7K2_DjmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZruZWyrsjRCs_Y5gjsbfU7dz_ALGG61pQ8qCM7K2_DjmA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_031842_242450_51B95A54 
X-CRM114-Status: GOOD (  28.17  )
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

On Fri, Sep 26, 2025 at 04:33:12PM -0700, Caleb Sander Mateos wrote:
> On Thu, Sep 25, 2025 at 11:59 PM Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> >
> > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> >
> > Replace the use of strchr() in base64_decode() with precomputed reverse
> > lookup tables for each variant. This avoids repeated string scans and
> > improves performance. Use -1 in the tables to mark invalid characters.
> >
> > Decode:
> >   64B   ~1530ns  ->  ~75ns    (~20.4x)
> >   1KB  ~27726ns  -> ~1165ns   (~23.8x)
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > ---
> >  lib/base64.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 61 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/base64.c b/lib/base64.c
> > index 1af557785..b20fdf168 100644
> > --- a/lib/base64.c
> > +++ b/lib/base64.c
> > @@ -21,6 +21,63 @@ static const char base64_tables[][65] = {
> >         [BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
> >  };
> >
> > +static const s8 base64_rev_tables[][256] = {
> > +       [BASE64_STD] = {
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  -1,  -1,  -1,  63,
> > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
> > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
> > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +       },
> > +       [BASE64_URLSAFE] = {
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  -1,  -1,
> > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
> > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  63,
> > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
> > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +       },
> > +       [BASE64_IMAP] = {
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  63,  -1,  -1,  -1,
> > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
> > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
> > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> > +       },
> 
> Do we actually need 3 separate lookup tables? It looks like all 3
> variants agree on the value of any characters they have in common. So
> we could combine them into a single lookup table that would work for a
> valid base64 string of any variant. The only downside I can see is
> that base64 strings which are invalid in some variants might no longer
> be rejected by base64_decode().
>

In addition to the approach David mentioned, maybe we can use a common
lookup table for A–Z, a–z, and 0–9, and then handle the variant-specific
symbols with a switch.

For example:

static const s8 base64_rev_common[256] = {
    [0 ... 255] = -1,
    ['A'] = 0, ['B'] = 1, /* ... */, ['Z'] = 25,
    ['a'] = 26, /* ... */, ['z'] = 51,
    ['0'] = 52, /* ... */, ['9'] = 61,
};

static inline int base64_rev_lookup(u8 c, enum base64_variant variant) {
    s8 v = base64_rev_common[c];
    if (v != -1)
        return v;

    switch (variant) {
    case BASE64_STD:
        if (c == '+') return 62;
        if (c == '/') return 63;
        break;
    case BASE64_IMAP:
    	if (c == '+') return 62;
        if (c == ',') return 63;
        break;
    case BASE64_URLSAFE:
        if (c == '-') return 62;
        if (c == '_') return 63;
	break;
    }
    return -1;
}

What do you think?

Best regards,
Guan-Chun

> > +};
> > +
> >  /**
> >   * base64_encode() - Base64-encode some binary data
> >   * @src: the binary data to encode
> > @@ -82,11 +139,9 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
> >         int bits = 0;
> >         int i;
> >         u8 *bp = dst;
> > -       const char *base64_table = base64_tables[variant];
> > +       s8 ch;
> >
> >         for (i = 0; i < srclen; i++) {
> > -               const char *p = strchr(base64_table, src[i]);
> > -
> >                 if (src[i] == '=') {
> >                         ac = (ac << 6);
> >                         bits += 6;
> > @@ -94,9 +149,10 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
> >                                 bits -= 8;
> >                         continue;
> >                 }
> > -               if (p == NULL || src[i] == 0)
> > +               ch = base64_rev_tables[variant][(u8)src[i]];
> > +               if (ch == -1)
> 
> Checking for < 0 can save an additional comparison here.
> 
> Best,
> Caleb
> 
> >                         return -1;
> > -               ac = (ac << 6) | (p - base64_table);
> > +               ac = (ac << 6) | ch;
> >                 bits += 6;
> >                 if (bits >= 8) {
> >                         bits -= 8;
> > --
> > 2.34.1
> >
> >

