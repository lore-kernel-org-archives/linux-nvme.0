Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C75CE7A96
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XDbO6elBelp1xcMzvhbE4h1VYLIpO20wVUv2aHOqtRg=; b=wbpJ7RLLkeyFwpjGhnwxXdDXBd
	g5yDMCOW32RWuYijsYFA939emeU4MpQpdW5TWUWevHs6VzDgQT/aIfgJ3C1LOnLMTxYQ/HzqrRJaw
	wNSsVEPY2TJtbsKlfWRShHRjfjEAW2WyWPoLHUzANIBf1IsacXrt7B/q7wKMSVIQDCdj2jBVQ4IMw
	ooMmw/5/EKlBqouEwKknFJu5xmMjrLzV02uQTppimvPk4fsXTZzUUeJHHKeBIcHWlPiuOt3U1pccn
	4SAxDi48E5GKI1sEI1POD6ZuKxxXF/MtcTEIvQkAqBKEVI21SaVEtxkbnB/JE1jTzSvBADBgSBar4
	WqhX54lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJpsT-0000000Bs9g-2kgz;
	Fri, 14 Nov 2025 09:13:57 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJpsO-0000000Bs8e-3uji
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 09:13:54 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-42b3b29153fso989059f8f.3
        for <linux-nvme@lists.infradead.org>; Fri, 14 Nov 2025 01:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763111631; x=1763716431; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDbO6elBelp1xcMzvhbE4h1VYLIpO20wVUv2aHOqtRg=;
        b=IprVNKgsWHcqA0/d3VqdRCkIcPRO/yVF6alfcqJSvjwY5iTVuSmG5+pf8uOo1pRVA9
         iE0A4HhFVz55/A0LfrH5nYcEeDeFpCWmSVAMuxUiZFf3HJ2jsnFhFlSXEpSPG6x8D9g3
         Rx1gd0nLnQ7E7pag74Dts22NSoigimY4WLJMYcj5rBw91zxSiZnWp+M4tssv/2me4dSl
         ZN3HgcmhYEyeQwChKxx7LA3yelR6aw8TWlYUp6zMwvDAwL5vq/gsUXFvhU76EL5PXm5B
         UfZ9RDRdpMtWrPvqS5VpAxh2fQIgjQMET1XzVo3bzhhXL4KDrgR6ugsApViiI1l6XdGN
         G1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763111631; x=1763716431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XDbO6elBelp1xcMzvhbE4h1VYLIpO20wVUv2aHOqtRg=;
        b=m+1gbVGr6nY+/cz42D2SLfVf5RChYqtBrv3NpnpWfV4mqTVhv0n83a0qSmwef7oFKL
         M6MZI+x+Jgq7lUyVQJv/V2IhB4jhKX/fGr+39/4x8W7D2/F50YqC2+iA0MOQqHlTisik
         IRkf/EYIJ136rNNKJhFd3z30GjHfVsgXhbeA5jJ2M768oCB9zgrsOjHftXyWubqssIPt
         raC4yaLk8S2hGPq7pRBvogSag7TGV314/VpDLIC4KgmL3aWICypL3/8sns6VPsUDtiy1
         Yjzm06Wx3Ilar/KXZVShPH84LJ1qRHHEYfBKEFtqnANsk+JWC/oL7zHcHUsrLHxLEfoh
         /g7g==
X-Forwarded-Encrypted: i=1; AJvYcCUtjpAL0T4LAQjzZ2oSlj8O2Nbr7iHLA6O5BJ/cFo7KMsJF1ox+Ei/qh0DPRsJjdiwCog2v833cfVBZ@lists.infradead.org
X-Gm-Message-State: AOJu0YyvnkXJU8opV2Bc6YiR2+9EED2uhSnZiqKmMN//NDdXFXVrYAkO
	rFcY4syiu0CYuIKR7D3hEX8rcZ4gBb5xuAilSy1FaiW7jjYCRlvG3DDz
X-Gm-Gg: ASbGncvmLBeWKOtROXPuNlMOxHngAam1UTXIqKbCG8UKdk3+Fen8k383DrckY0LZ+5I
	yfGvTRbg8Fl/v2QqK13GODlyzoLhZRdLU0kzbQ9aSA/GZpCaK+NBKEnoPcj88IkpufwfYrGvSrR
	M0j+0+cGEACPHcAKh5sAIHQ+O5mljWrIwuQ91ymENfUwYlIE/E6XHFO0Je9SKkYkwnHF1Up1wXc
	4QW8IkG1GlZx84Ia68ZewhfLAQBxkkn7Y8/dp4Nn6GwZiIonPPDNorMhgKhXZ911y/bGARQrnTo
	MGFPiGeVtW/lHjhl58pi2RlvNYC7+zRgJWyYITAv6eh2B0xD3nU9fSv3zb41c6ioNkt72GYHN7i
	KVHMWkyZTulXUhaGUeVaHwDxHBkqtPSzZssDTI75EsjUl1MEqlAr6jQP8imQklfRkqb1Qn/7D3J
	JrgAgLoxpmxPe/hGdBKE89mh+Ay6WMWPAErBjCujkhpYxzCsSHG4q7dxVGDBrE0dQ=
X-Google-Smtp-Source: AGHT+IHbVSvNUwD21hr+V01d6xNdOdYhkl3Gm087EM2lU14638PysIjp1BDXseK+rppV65oO+BHNwg==
X-Received: by 2002:a05:6000:1842:b0:42b:2eb3:c910 with SMTP id ffacd0b85a97d-42b593246b5mr2399008f8f.3.1763111630406;
        Fri, 14 Nov 2025 01:13:50 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b8a0sm8843496f8f.25.2025.11.14.01.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:13:50 -0800 (PST)
Date: Fri, 14 Nov 2025 09:13:48 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, andriy.shevchenko@intel.com, axboe@kernel.dk,
 ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
 home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
 kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v5 1/6] lib/base64: Add support for multiple variants
Message-ID: <20251114091348.562c5965@pumpkin>
In-Reply-To: <20251114060045.88792-1-409411716@gms.tku.edu.tw>
References: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
	<20251114060045.88792-1-409411716@gms.tku.edu.tw>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_011353_019987_67A4F55B 
X-CRM114-Status: GOOD (  31.22  )
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

On Fri, 14 Nov 2025 14:00:45 +0800
Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:

> From: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> Extend the base64 API to support multiple variants (standard, URL-safe,
> and IMAP) as defined in RFC 4648 and RFC 3501. The API now takes a
> variant parameter and an option to control padding. Update NVMe auth
> code to use the new interface with BASE64_STD.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>

Reviewed-by: David Laight <david.laight.linux@gmail.com>

> ---
>  drivers/nvme/common/auth.c |  4 +--
>  include/linux/base64.h     | 10 ++++--
>  lib/base64.c               | 62 ++++++++++++++++++++++----------------
>  3 files changed, 46 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 1f51fbebd9fa..e07e7d4bf8b6 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -178,7 +178,7 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
>  	if (!key)
>  		return ERR_PTR(-ENOMEM);
>  
> -	key_len = base64_decode(secret, allocated_len, key->key);
> +	key_len = base64_decode(secret, allocated_len, key->key, true, BASE64_STD);
>  	if (key_len < 0) {
>  		pr_debug("base64 key decoding error %d\n",
>  			 key_len);
> @@ -663,7 +663,7 @@ int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
>  	if (ret)
>  		goto out_free_digest;
>  
> -	ret = base64_encode(digest, digest_len, enc);
> +	ret = base64_encode(digest, digest_len, enc, true, BASE64_STD);
>  	if (ret < hmac_len) {
>  		ret = -ENOKEY;
>  		goto out_free_digest;
> diff --git a/include/linux/base64.h b/include/linux/base64.h
> index 660d4cb1ef31..a2c6c9222da3 100644
> --- a/include/linux/base64.h
> +++ b/include/linux/base64.h
> @@ -8,9 +8,15 @@
>  
>  #include <linux/types.h>
>  
> +enum base64_variant {
> +	BASE64_STD,       /* RFC 4648 (standard) */
> +	BASE64_URLSAFE,   /* RFC 4648 (base64url) */
> +	BASE64_IMAP,      /* RFC 3501 */
> +};
> +
>  #define BASE64_CHARS(nbytes)   DIV_ROUND_UP((nbytes) * 4, 3)
>  
> -int base64_encode(const u8 *src, int len, char *dst);
> -int base64_decode(const char *src, int len, u8 *dst);
> +int base64_encode(const u8 *src, int len, char *dst, bool padding, enum base64_variant variant);
> +int base64_decode(const char *src, int len, u8 *dst, bool padding, enum base64_variant variant);
>  
>  #endif /* _LINUX_BASE64_H */
> diff --git a/lib/base64.c b/lib/base64.c
> index b736a7a431c5..a7c20a8e8e98 100644
> --- a/lib/base64.c
> +++ b/lib/base64.c
> @@ -1,12 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * base64.c - RFC4648-compliant base64 encoding
> + * base64.c - Base64 with support for multiple variants
>   *
>   * Copyright (c) 2020 Hannes Reinecke, SUSE
>   *
>   * Based on the base64url routines from fs/crypto/fname.c
> - * (which are using the URL-safe base64 encoding),
> - * modified to use the standard coding table from RFC4648 section 4.
> + * (which are using the URL-safe Base64 encoding),
> + * modified to support multiple Base64 variants.
>   */
>  
>  #include <linux/kernel.h>
> @@ -15,26 +15,31 @@
>  #include <linux/string.h>
>  #include <linux/base64.h>
>  
> -static const char base64_table[65] =
> -	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> +static const char base64_tables[][65] = {
> +	[BASE64_STD] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",
> +	[BASE64_URLSAFE] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_",
> +	[BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
> +};
>  
>  /**
> - * base64_encode() - base64-encode some binary data
> + * base64_encode() - Base64-encode some binary data
>   * @src: the binary data to encode
>   * @srclen: the length of @src in bytes
> - * @dst: (output) the base64-encoded string.  Not NUL-terminated.
> + * @dst: (output) the Base64-encoded string.  Not NUL-terminated.
> + * @padding: whether to append '=' padding characters
> + * @variant: which base64 variant to use
>   *
> - * Encodes data using base64 encoding, i.e. the "Base 64 Encoding" specified
> - * by RFC 4648, including the  '='-padding.
> + * Encodes data using the selected Base64 variant.
>   *
> - * Return: the length of the resulting base64-encoded string in bytes.
> + * Return: the length of the resulting Base64-encoded string in bytes.
>   */
> -int base64_encode(const u8 *src, int srclen, char *dst)
> +int base64_encode(const u8 *src, int srclen, char *dst, bool padding, enum base64_variant variant)
>  {
>  	u32 ac = 0;
>  	int bits = 0;
>  	int i;
>  	char *cp = dst;
> +	const char *base64_table = base64_tables[variant];
>  
>  	for (i = 0; i < srclen; i++) {
>  		ac = (ac << 8) | src[i];
> @@ -48,44 +53,49 @@ int base64_encode(const u8 *src, int srclen, char *dst)
>  		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
>  		bits -= 6;
>  	}
> -	while (bits < 0) {
> -		*cp++ = '=';
> -		bits += 2;
> +	if (padding) {
> +		while (bits < 0) {
> +			*cp++ = '=';
> +			bits += 2;
> +		}
>  	}
>  	return cp - dst;
>  }
>  EXPORT_SYMBOL_GPL(base64_encode);
>  
>  /**
> - * base64_decode() - base64-decode a string
> + * base64_decode() - Base64-decode a string
>   * @src: the string to decode.  Doesn't need to be NUL-terminated.
>   * @srclen: the length of @src in bytes
>   * @dst: (output) the decoded binary data
> + * @padding: whether to append '=' padding characters
> + * @variant: which base64 variant to use
>   *
> - * Decodes a string using base64 encoding, i.e. the "Base 64 Encoding"
> - * specified by RFC 4648, including the  '='-padding.
> + * Decodes a string using the selected Base64 variant.
>   *
>   * This implementation hasn't been optimized for performance.
>   *
>   * Return: the length of the resulting decoded binary data in bytes,
> - *	   or -1 if the string isn't a valid base64 string.
> + *	   or -1 if the string isn't a valid Base64 string.
>   */
> -int base64_decode(const char *src, int srclen, u8 *dst)
> +int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
>  {
>  	u32 ac = 0;
>  	int bits = 0;
>  	int i;
>  	u8 *bp = dst;
> +	const char *base64_table = base64_tables[variant];
>  
>  	for (i = 0; i < srclen; i++) {
>  		const char *p = strchr(base64_table, src[i]);
> -
> -		if (src[i] == '=') {
> -			ac = (ac << 6);
> -			bits += 6;
> -			if (bits >= 8)
> -				bits -= 8;
> -			continue;
> +		if (padding) {
> +			if (src[i] == '=') {
> +				ac = (ac << 6);
> +				bits += 6;
> +				if (bits >= 8)
> +					bits -= 8;
> +				continue;
> +			}
>  		}
>  		if (p == NULL || src[i] == 0)
>  			return -1;


