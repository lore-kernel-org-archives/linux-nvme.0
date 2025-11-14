Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEB9CE7A8E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 09:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fh8oH+7LCYbzfqHAKBW6hW6g41lmP/2iEuUwxvcptu4=; b=QRDX3rOzeougeT+AfD7LPd0RLg
	FPrUFhQJ7728DTHwgSe8NrZQ+LHmtg5MEGjh5fKrvWfBsp8IUkT3QB/xBd7tRfk6vXPfQ07RAsR36
	dRiO0Z3jJi+lrvv8UvdxL8apArn0KEkRlNhG7DyNlYWI2oRH5HVtQDnlewHCUKkGFjCDT0EgUadSx
	ngebUxKa5q5I3WNIHj9hrzzzY6q7Vknain52L5aP4SiOQ9LwGR4eqpEPNM5GVSYpD+r5lu5ZGqiBd
	I9eol1cA2bWaobdSUyx5P4hD2VJdvuvFXmdE3bBStw2xbMqQgJR1+UqTkwLBhdfSXOwCiY3vPaFd/
	iBT3VgOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJpwz-0000000BtU9-1XOj;
	Fri, 14 Nov 2025 09:18:37 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJpww-0000000BtTC-3XuF
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 09:18:35 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so12707575e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 14 Nov 2025 01:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763111913; x=1763716713; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh8oH+7LCYbzfqHAKBW6hW6g41lmP/2iEuUwxvcptu4=;
        b=IfaCNuLmKFYrKMySUTqJj2v/hyQh3oyG35qI6t8I2B2RfuN3LWg5+cvOpk8589/Egw
         aY8fYJvhJXKKKo83ntPnpsukJtys+XAEp1AttCKYNmn90cgA6XoZltV6/rWu9NrQgOEX
         LxfK6bKgEqGPENw9uY2ofLP0IToqi+K+iiJt1JOkBhkeSuxTjjK49mjte90Arw4hFVqw
         MXV8yVHLWmjm+Pl4YvRD5fPXyhTR4h5+fTbd04FCPpW6MBbigIE6VmNx4bVoFWWSitfb
         rMNZ6JyNH0azTpwyLkfbokvG+8gouG+zoc9fzbxipQhT7xTcDsUe11w/ZXV6Zq5nVh3s
         k6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763111913; x=1763716713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fh8oH+7LCYbzfqHAKBW6hW6g41lmP/2iEuUwxvcptu4=;
        b=Z4A/0N2z8EOHeT2yk7vR5Qe4IFe6arKic0Cp72k5DAANz74e9KB2L3NUeYh2m5TtVR
         hlba4Khebl087UMnjznT8wor1SSEJIuM3YuLYOSQGR8jTChzyJSZerO2hvgi4kgpasCT
         LZrlHGu3CIhHAAuN4yUMqUGhvful0zXEhwBTDIzGiBHI49DS4CBCFVzGFSQ/bEvlSx4o
         p2Wf6G2RvWFmTaopIw82akw0Qv82Eb/O+h2DRkMe3Iz1JN4mXqe2RxBSHcY8m5GBll4d
         wnEPcHXMJiJqTkgrUOEM4+qIS3uBDbr9u/R0h/qMahj6uZqeqKkpGIT/MWso5ZagF7/e
         5Jaw==
X-Forwarded-Encrypted: i=1; AJvYcCWfzkbao/NYuIc95k4KSEwaFBqF49bM+lgvmjMBOVlZKSlILQLwqlTz4QpTLM0rAQtgKO4Is/6IQWed@lists.infradead.org
X-Gm-Message-State: AOJu0YyzXgDgaET83b+0U9hxDsymbiCpdx5TbfGgdf9bmRGxNjmvPI55
	32ooertVvrfoATzEbi8ALNSdBtPSXe7GPA0B3fkbqFPfxIZbnuNkezMT
X-Gm-Gg: ASbGncvOn131hQcvUgnwj2khmc54kowt4bX56K4YM9aQhlPkXaBtweTxFdNtmddDjHn
	Sn/JhK6VCijt9HSBc+fpbg0XzqDGkExeWShbU+ZwAB76E2myNaETz4bkjsGuchupWJLtXq5mnZb
	vJtemYO/NvbBGyp6qAYEVDn4xv1lygKVQk3zZS5CxwG9Eb1ks0b6xtogZRtRVKSK5OFGWko/MH0
	tXGw2+UlVSPwvMUe9ow6lWJtKoHoON98ra1z4yaYNbIWuRsB5sGZzggwR3Tszcmf8bkgDO1Rxqa
	23SYkdsZIuhucXQM0+syw094m/87gkXFJXi+Uvx8QK7BxGRbOWGrW2yCvT31QHrs1rjtkOcQdCZ
	NlUt+b+2GhsH2AQZs1KT0AtCom3G6Huj1zWbUbFmJjStm8YVxBV6m5yan6sDFGxv3iQQuAg//5i
	VhUpXRylfvhwBOwo3wMj0LmdKZjIOew8bpr2IyeSCJm+7eFqIwlMH1
X-Google-Smtp-Source: AGHT+IHO9mXMvHyXvx42yMjsmcUbusK0R/9wGsfDIWs8A9ZbddaK/fnTOOmm5FKcI48o9dbS+Wkhjw==
X-Received: by 2002:a05:600c:4fc9:b0:477:55de:8b22 with SMTP id 5b1f17b1804b1-4778fe620a4mr21039125e9.16.1763111912900;
        Fri, 14 Nov 2025 01:18:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae5bsm8785202f8f.8.2025.11.14.01.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:18:32 -0800 (PST)
Date: Fri, 14 Nov 2025 09:18:30 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, andriy.shevchenko@intel.com, axboe@kernel.dk,
 ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
 home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
 kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v5 3/6] lib/base64: rework encode/decode for speed and
 stricter validation
Message-ID: <20251114091830.5325eed3@pumpkin>
In-Reply-To: <20251114060132.89279-1-409411716@gms.tku.edu.tw>
References: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
	<20251114060132.89279-1-409411716@gms.tku.edu.tw>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_011834_925965_C539736B 
X-CRM114-Status: GOOD (  29.16  )
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

On Fri, 14 Nov 2025 14:01:32 +0800
Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:

> The old base64 implementation relied on a bit-accumulator loop, which was
> slow for larger inputs and too permissive in validation. It would accept
> extra '=', missing '=', or even '=' appearing in the middle of the input,
> allowing malformed strings to pass. This patch reworks the internals to
> improve performance and enforce stricter validation.
> 
> Changes:
>  - Encoder:
>    * Process input in 3-byte blocks, mapping 24 bits into four 6-bit
>      symbols, avoiding bit-by-bit shifting and reducing loop iterations.
>    * Handle the final 1-2 leftover bytes explicitly and emit '=' only when
>      requested.
>  - Decoder:
>    * Based on the reverse lookup tables from the previous patch, decode
>      input in 4-character groups.
>    * Each group is looked up directly, converted into numeric values, and
>      combined into 3 output bytes.
>    * Explicitly handle padded and unpadded forms:
>       - With padding: input length must be a multiple of 4, and '=' is
>         allowed only in the last two positions. Reject stray or early '='.
>       - Without padding: validate tail lengths (2 or 3 chars) and require
>         unused low bits to be zero.
>    * Removed the bit-accumulator style loop to reduce loop iterations.
> 
> Performance (x86_64, Intel Core i7-10700 @ 2.90GHz, avg over 1000 runs,
> KUnit):
> 
> Encode:
>   64B   ~90ns   -> ~32ns   (~2.8x)
>   1KB  ~1332ns  -> ~510ns  (~2.6x)
> 
> Decode:
>   64B  ~1530ns  -> ~35ns   (~43.7x)
>   1KB ~27726ns  -> ~530ns  (~52.3x)
> 
> Co-developed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Co-developed-by: Yu-Sheng Huang <home7438072@gmail.com>
> Signed-off-by: Yu-Sheng Huang <home7438072@gmail.com>
> Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>

Reviewed-by: David Laight <david.laight.linux@gmail.com>

But see minor nit below.
> ---
>  lib/base64.c | 109 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 68 insertions(+), 41 deletions(-)
> 
> diff --git a/lib/base64.c b/lib/base64.c
> index 9d1074bb821c..1a6d8fe37eda 100644
> --- a/lib/base64.c
> +++ b/lib/base64.c
> @@ -79,28 +79,38 @@ static const s8 base64_rev_maps[][256] = {
>  int base64_encode(const u8 *src, int srclen, char *dst, bool padding, enum base64_variant variant)
>  {
>  	u32 ac = 0;
> -	int bits = 0;
> -	int i;
>  	char *cp = dst;
>  	const char *base64_table = base64_tables[variant];
>  
> -	for (i = 0; i < srclen; i++) {
> -		ac = (ac << 8) | src[i];
> -		bits += 8;
> -		do {
> -			bits -= 6;
> -			*cp++ = base64_table[(ac >> bits) & 0x3f];
> -		} while (bits >= 6);
> -	}
> -	if (bits) {
> -		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
> -		bits -= 6;
> +	while (srclen >= 3) {
> +		ac = (u32)src[0] << 16 | (u32)src[1] << 8 | (u32)src[2];

There is no need for the (u32) casts.
All char/short values are promoted to 'int' prior to any maths.

> +		*cp++ = base64_table[ac >> 18];
> +		*cp++ = base64_table[(ac >> 12) & 0x3f];
> +		*cp++ = base64_table[(ac >> 6) & 0x3f];
> +		*cp++ = base64_table[ac & 0x3f];
> +
> +		src += 3;
> +		srclen -= 3;
>  	}
> -	if (padding) {
> -		while (bits < 0) {
> +
> +	switch (srclen) {
> +	case 2:
> +		ac = (u32)src[0] << 16 | (u32)src[1] << 8;
> +		*cp++ = base64_table[ac >> 18];
> +		*cp++ = base64_table[(ac >> 12) & 0x3f];
> +		*cp++ = base64_table[(ac >> 6) & 0x3f];
> +		if (padding)
> +			*cp++ = '=';
> +		break;
> +	case 1:
> +		ac = (u32)src[0] << 16;
> +		*cp++ = base64_table[ac >> 18];
> +		*cp++ = base64_table[(ac >> 12) & 0x3f];
> +		if (padding) {
> +			*cp++ = '=';
>  			*cp++ = '=';
> -			bits += 2;
>  		}
> +		break;
>  	}
>  	return cp - dst;
>  }
> @@ -116,41 +126,58 @@ EXPORT_SYMBOL_GPL(base64_encode);
>   *
>   * Decodes a string using the selected Base64 variant.
>   *
> - * This implementation hasn't been optimized for performance.
> - *
>   * Return: the length of the resulting decoded binary data in bytes,
>   *	   or -1 if the string isn't a valid Base64 string.
>   */
>  int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
>  {
> -	u32 ac = 0;
> -	int bits = 0;
> -	int i;
>  	u8 *bp = dst;
> -	s8 ch;
> +	s8 input[4];
> +	s32 val;
> +	const u8 *s = (const u8 *)src;
> +	const s8 *base64_rev_tables = base64_rev_maps[variant];
>  
> -	for (i = 0; i < srclen; i++) {
> -		if (padding) {
> -			if (src[i] == '=') {
> -				ac = (ac << 6);
> -				bits += 6;
> -				if (bits >= 8)
> -					bits -= 8;
> -				continue;
> -			}
> -		}
> -		ch = base64_rev_maps[variant][(u8)src[i]];
> -		if (ch == -1)
> -			return -1;
> -		ac = (ac << 6) | ch;
> -		bits += 6;
> -		if (bits >= 8) {
> -			bits -= 8;
> -			*bp++ = (u8)(ac >> bits);
> +	while (srclen >= 4) {
> +		input[0] = base64_rev_tables[s[0]];
> +		input[1] = base64_rev_tables[s[1]];
> +		input[2] = base64_rev_tables[s[2]];
> +		input[3] = base64_rev_tables[s[3]];
> +
> +		val = input[0] << 18 | input[1] << 12 | input[2] << 6 | input[3];
> +
> +		if (unlikely(val < 0)) {
> +			if (!padding || srclen != 4 || s[3] != '=')
> +				return -1;
> +			padding = 0;
> +			srclen = s[2] == '=' ? 2 : 3;
> +			break;
>  		}
> +
> +		*bp++ = val >> 16;
> +		*bp++ = val >> 8;
> +		*bp++ = val;
> +
> +		s += 4;
> +		srclen -= 4;
>  	}
> -	if (ac & ((1 << bits) - 1))
> +
> +	if (likely(!srclen))
> +		return bp - dst;
> +	if (padding || srclen == 1)
>  		return -1;
> +
> +	val = (base64_rev_tables[s[0]] << 12) | (base64_rev_tables[s[1]] << 6);
> +	*bp++ = val >> 10;
> +
> +	if (srclen == 2) {
> +		if (val & 0x800003ff)
> +			return -1;
> +	} else {
> +		val |= base64_rev_tables[s[2]];
> +		if (val & 0x80000003)
> +			return -1;
> +		*bp++ = val >> 2;
> +	}
>  	return bp - dst;
>  }
>  EXPORT_SYMBOL_GPL(base64_decode);


