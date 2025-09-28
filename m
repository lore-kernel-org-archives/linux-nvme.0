Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05101CAC5BB
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Sep 2025 18:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zmGgp8LZB8H7aPG6SX5XQzX0Iik7pnp4RAkYSd2NXzI=; b=4ivS8eqHy5JmFtIzP73m5/5ATH
	Go+2ELy4NU2m7Bvy8RJg+Vpw8PToPhRJh+xUcACUqe6fcrCz+f5hciRWXBYwVAZ2j/TYY3bOh4Yvg
	r7MXeu+9s0ppz2nBP8xWqHl0MxoxUovIVvAmjM2pK3hPtzVDnSkhms+tBI7/6PGwTYT7MYbaMSZnv
	MFZRmsCQIw8GSEJsUzSdrZJC9qTdQNfO7L2XSH+YtPpfMX+J+0FaedEdVXf0Z5Ss81lbnuKYLb9t8
	bjKiyYdSovwtZwdHInnQPrhTBSLKCruE2s9xD0w+CBR/+PmO68lsWdxjSmyD1xt+0UdsudLo6yRw1
	zftkE4rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2wae-0000000HH6S-1yIz;
	Sun, 28 Sep 2025 18:57:44 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2wab-0000000HH4R-33Rn
	for linux-nvme@lists.infradead.org;
	Sun, 28 Sep 2025 18:57:42 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so38654515e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 28 Sep 2025 11:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759085859; x=1759690659; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmGgp8LZB8H7aPG6SX5XQzX0Iik7pnp4RAkYSd2NXzI=;
        b=YSlIOK0iEaod7DUYdrpQAT0CGQ5ofUe6KxqDhWR6MuJ35Vgfx81R9GooXoFwgWJsJ6
         VaYSEWaATFaeE2R7Y882FEN4I8Ffvx9Pj1Of/8GTw/nFalaUFS8aH7tG446QzxA/ZUf7
         ZYgBXU0ls0QusNC+8TziPsvYK1IO1I/FcdVjMF2VFJAA+UDtIHiCnkZzCSJOc4gvne6f
         TmqcaV5zXvpui3xXFbXQ+xxGk3mouBmAANWCXa1bFDgejQgKmBs12EHdn+h75KJTrlmH
         upLTKabz1IDnzJ0pB/wSNVuFKq51ZIFK79pq4k2RQzdcXOmSSXzA2VkLJCyLKdeVxOq6
         E6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759085859; x=1759690659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmGgp8LZB8H7aPG6SX5XQzX0Iik7pnp4RAkYSd2NXzI=;
        b=u1Ny0byN+/hsXeAfewXFJcEEdV7xOph9+e2sdRUVOngGOORuj4h7pzj4XtQ6FpM/EA
         fCHqEacghpQEz2o5x8Y4loR5Owr7dOlyduCNPhKr2bSai6nAcjbJD3hw7CDqMAvV7f4l
         HX7HG4wIPL3GnWEUs3M6vfWpxh0+Tnzb5wR0YSaqeGKU2HKwhZ3brAN6B38gnXjiaZle
         6nFiqu89tyM3RmT0mVkqgH/YlZmPT92xi/ylgYyuagzqkCNNfMd8TLXcxWJy2PP3e70x
         XaKfXCiozijk00soHaUzCSmWpVpsAXf3fiQ6P5AumIKqWaDpTh+dLf8RmLy+8+dnhAoo
         QnDw==
X-Forwarded-Encrypted: i=1; AJvYcCUbOUHquaR0EF6ia4L+Qc3JkwSwv91PeUzk3NBtyB41/aLIq1i267e7CbAmbw8tkfvKXD9x+1iLKuQk@lists.infradead.org
X-Gm-Message-State: AOJu0YwW34upRNX/mp/GRZzl6m+Sk65qKX+ZcfBTKyGCYleo+3VRMaNk
	+7bDEttUm0wICYSA6HPpJbAz8duIbba0ibj/BKDvej13ILG6KxRRXxuO
X-Gm-Gg: ASbGncsnCE4hRjugb5T1G4zKY59YG1rO3DHVke8hi7sjl0SJTWkSz1MndG0DSJNVvZ7
	nGH5L1vWMlg1Z9+42GeZ9lyhykBvUFUwcU9XUAQ85P2ih1V6Q+M4Pf8BrA+rhMIsd+uzrRt3dB0
	X4d8s2LkbHPDl1HN/poE0DCYsMjyqh1TgFg3xTeV+y9M3ccaxPDAFNg/kP81mjaZSYa4ZcXJytj
	tItewyaFZq6ZZS7eAIJxzYPhYhvsbDqb7RrWvydMzji6gozv7A0Bm15bmngPmJPUuubixZ7PLGD
	b98TXh3hkd2vfAOUHW/Z9WGNICDsgFbyZxB8gzKN9buDkr0oQqQfOxNycgfv0nr85qqcU2zgCV7
	cyztlNL6e4y1adGRJjurr9TWAOTA70C3zXyzANb9X11C+4DpoZShQE1ulZoC9zviP0wuNxUs2Xu
	s=
X-Google-Smtp-Source: AGHT+IFdXSUmu1jDu9C+PMSkYOzc5SUURLTfRIaH+ROSnCKAviW3HCbfr6MunNZeaSZVBZNwp+b1tQ==
X-Received: by 2002:a05:600c:4508:b0:46e:3e72:a56 with SMTP id 5b1f17b1804b1-46e3e720b94mr81111745e9.1.1759085858562;
        Sun, 28 Sep 2025 11:57:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9ac5basm222579525e9.7.2025.09.28.11.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 11:57:38 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:57:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
 ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
 jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with
 reverse lookup tables
Message-ID: <20250928195736.71bec9ae@pumpkin>
In-Reply-To: <20250926065556.14250-1-409411716@gms.tku.edu.tw>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
	<20250926065556.14250-1-409411716@gms.tku.edu.tw>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250928_115741_812083_6DDF516E 
X-CRM114-Status: GOOD (  21.61  )
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

On Fri, 26 Sep 2025 14:55:56 +0800
Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:

> From: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> Replace the use of strchr() in base64_decode() with precomputed reverse
> lookup tables for each variant. This avoids repeated string scans and
> improves performance. Use -1 in the tables to mark invalid characters.
> 
> Decode:
>   64B   ~1530ns  ->  ~75ns    (~20.4x)
>   1KB  ~27726ns  -> ~1165ns   (~23.8x)
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> ---
>  lib/base64.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 61 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/base64.c b/lib/base64.c
> index 1af557785..b20fdf168 100644
> --- a/lib/base64.c
> +++ b/lib/base64.c
> @@ -21,6 +21,63 @@ static const char base64_tables[][65] = {
>  	[BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
>  };
>  
> +static const s8 base64_rev_tables[][256] = {
> +	[BASE64_STD] = {
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  -1,  -1,  -1,  63,
> +	 52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
> +	 15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
> +	 41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	},

Using:
	[BASE64_STD] = {
	[0 ... 255] = -1,
	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12,
		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38,
		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 48, 50, 51,
	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61,
	['+'] = 62,
	['/'] = 63};
would be more readable.
(Assuming no one has turned on a warning that stops you defaulting the entries to -1.)

The is also definitely scope for a #define to common things up.
Even if it has to have the values for all the 5 special characters (-1 if not used)
rather than the characters for 62 and 63.

	David

> +	[BASE64_URLSAFE] = {
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  -1,  -1,
> +	 52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
> +	 15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  63,
> +	 -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
> +	 41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	},
> +	[BASE64_IMAP] = {
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  63,  -1,  -1,  -1,
> +	 52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
> +	 15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
> +	 41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
> +	},
> +};
> +
>  /**
>   * base64_encode() - Base64-encode some binary data
>   * @src: the binary data to encode
> @@ -82,11 +139,9 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
>  	int bits = 0;
>  	int i;
>  	u8 *bp = dst;
> -	const char *base64_table = base64_tables[variant];
> +	s8 ch;
>  
>  	for (i = 0; i < srclen; i++) {
> -		const char *p = strchr(base64_table, src[i]);
> -
>  		if (src[i] == '=') {
>  			ac = (ac << 6);
>  			bits += 6;
> @@ -94,9 +149,10 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
>  				bits -= 8;
>  			continue;
>  		}
> -		if (p == NULL || src[i] == 0)
> +		ch = base64_rev_tables[variant][(u8)src[i]];
> +		if (ch == -1)
>  			return -1;
> -		ac = (ac << 6) | (p - base64_table);
> +		ac = (ac << 6) | ch;
>  		bits += 6;
>  		if (bits >= 8) {
>  			bits -= 8;


