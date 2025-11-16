Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B756CD4F3E
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Nov 2025 10:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JSW7JgNcs7DWh1nW7rtjeN1ASDGAXAC868BibcndNtw=; b=jQJmqlKXKsfnOgXigpHVCMBsBY
	7t9xwkxLVdLeaPMOdtLdsIaAwYVSL1jZHXYhNfOMMNbBF4d0dgj4BvYrCV3xUdojytcw6C9q2SwpI
	J0lY+dATY3E5nWRPUzK0GaYZ0aPxDLbc7ZhJT0MIxe3oulC5Rd8lJr6e+90u4hJG0w2Ab1bmzNVpn
	MK5QAVmR2byloj9nC1atvvWOoKDHNWfU08RMzWPF++YTcMhigWTEHrQu2guEKV0zBdsHTUHcFVtyI
	ecG852RGXWIhL1WZ3p8RAigvYnh1C2J/Qd6Bsepgmkf5KBYZ8/stEUKBqZY0bjcjJeUzONM73SJsB
	Rc6WiH3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKa0B-0000000EXw9-0mUb;
	Sun, 16 Nov 2025 10:28:59 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKa08-0000000EXvi-0cjl
	for linux-nvme@lists.infradead.org;
	Sun, 16 Nov 2025 10:28:58 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-29812589890so43928865ad.3
        for <linux-nvme@lists.infradead.org>; Sun, 16 Nov 2025 02:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1763288934; x=1763893734; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JSW7JgNcs7DWh1nW7rtjeN1ASDGAXAC868BibcndNtw=;
        b=PrPv7hllhMLPca1RG1yG/lI1kuZ/eDcwwiRLeeIuY6K+rrKowLpzAM+4vwPLLYYQMv
         3Lz3bB45MYYB2YW9twrAHVfN0UUvBjSxl3t8SU4f9kyUwDLn3UKBK5SXa1mF9dHPnrtk
         CagCfpi4EU6TUr/RO6py4zm5v0jEa3AWtrl4dF4HYjbXX//EAa8c6RKREoUXNAGEKlv/
         5ya7XFPHdeNx9yF8+zZtztKTkX7TFPhlYnxrFsi8niGCISNVSxWAksRminFWbIiNjOjn
         x2mISCiYBCmakvZZP5aIAnQyKA+RhynGaYd4cTFSkmZxCMajtVz8XpbiobwbNxi/oXOU
         aXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763288934; x=1763893734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSW7JgNcs7DWh1nW7rtjeN1ASDGAXAC868BibcndNtw=;
        b=uYVN28elbEMpL1mqI0e9O14qpIBmgi63sCFS/fbM01Xo359R+YljL2fFkYHZ3LIqL8
         yzFwdPVBRa7THzlFoeF9lrhyL6vdG4xtSX1Wigqc3HxwlUyq/l5PrgAhPtMSX9L38Rob
         uZgB4xsmoOVdw3icjj0bhLBB1n88r/dD9c5AMK3XNebcku9mpBX69rpQutWcMTRdWM4I
         bEan+NcF7h/SEioiE1pU/lYZRh64lqODpCNONU9yCCj2mMVL1e4HlqTTHOEHk3rocJwU
         B/NkPpseSkVZVCKZy181mDejdXQ//raL1dfL+xmYF5FTEIjBqZ9K4s+g+MQ+MqGO4XZB
         rjug==
X-Forwarded-Encrypted: i=1; AJvYcCVMR57PNfwgTtsS9Ro+0xCPxRGT3B+H6K6kJUOtNwkCNQR+sBdEbgagNJJEHcym/CRVd5h0S2OILY5a@lists.infradead.org
X-Gm-Message-State: AOJu0YxmZ10gNHuKkMip1yKU+17Nagwgj5mWLCiTYQAdtevLcoCQB7FD
	pAqBjcq0RTxho01eFhIRq6DwkW+mjOc7R14sdOXK0vEC8FsAu3HkbJQzD/WSjFQNops=
X-Gm-Gg: ASbGncvv2k/bwf2IvYwrNA9G0JUWMBNUIkqU4Uid0c+Sm4dc8nuOC7yDToDP0/v4hed
	KI0BOAgq+MXu16jUDcKtyuQRBQLPdBiB/aVWm+a6NoLpRtLVMpgI8PqK7vn6QZMo/esnYHN+1mB
	1/2r1lvAgdAAKWTHIblV48YkUdR8qTWvpcxDEkdRIWRv4JQaA0Z7f6P0qj4RZriFGSAZ87GmNn2
	TbmuVn7tVEblVJamJ/78WYJCzq1S5eDi6XI5lBkMwKw1152skJLNMH4DJCVF4/iswwJvQhN4rnN
	3BQL2ttyQzsgdtTQgBhtFpvCGpGrpVrjKaC294Vl4d82tmeQ/cZJg34V1leoD6PpDgmDLkhrDOM
	IY3ADWyKCLUfq+UqMJUaWfdgF2w9zL/9vLiUH3fPv6lBUaHdq6A3JmnFtJBxCMnHeQS2BFODScT
	0Z5HIHpeCl1hEm/y8MR0haiswZyoVbhOSm
X-Google-Smtp-Source: AGHT+IHFG6QmWK1KpFn85ysEfm+psI5j9KN7/n/1T01x4vQCppnzXtL7aRATTWAaGCFS+DPVbWd8+Q==
X-Received: by 2002:a17:903:1211:b0:28d:18d3:46cb with SMTP id d9443c01a7336-2986a6bf9a7mr103443295ad.20.1763288934185;
        Sun, 16 Nov 2025 02:28:54 -0800 (PST)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:22b3:6dbf:5b14:3737])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2c0fe8sm106790585ad.80.2025.11.16.02.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 02:28:53 -0800 (PST)
Date: Sun, 16 Nov 2025 18:28:49 +0800
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: David Laight <david.laight.linux@gmail.com>
Cc: akpm@linux-foundation.org, andriy.shevchenko@intel.com, axboe@kernel.dk,
	ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
	home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
	kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com,
	xiubli@redhat.com
Subject: Re: [PATCH v5 3/6] lib/base64: rework encode/decode for speed and
 stricter validation
Message-ID: <aRmnYTHmfPi1lyix@wu-Pro-E500-G6-WS720T>
References: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
 <20251114060132.89279-1-409411716@gms.tku.edu.tw>
 <20251114091830.5325eed3@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251114091830.5325eed3@pumpkin>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251116_022856_439828_356C7409 
X-CRM114-Status: GOOD (  35.00  )
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

On Fri, Nov 14, 2025 at 09:18:30AM +0000, David Laight wrote:
> On Fri, 14 Nov 2025 14:01:32 +0800
> Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> 
> > The old base64 implementation relied on a bit-accumulator loop, which was
> > slow for larger inputs and too permissive in validation. It would accept
> > extra '=', missing '=', or even '=' appearing in the middle of the input,
> > allowing malformed strings to pass. This patch reworks the internals to
> > improve performance and enforce stricter validation.
> > 
> > Changes:
> >  - Encoder:
> >    * Process input in 3-byte blocks, mapping 24 bits into four 6-bit
> >      symbols, avoiding bit-by-bit shifting and reducing loop iterations.
> >    * Handle the final 1-2 leftover bytes explicitly and emit '=' only when
> >      requested.
> >  - Decoder:
> >    * Based on the reverse lookup tables from the previous patch, decode
> >      input in 4-character groups.
> >    * Each group is looked up directly, converted into numeric values, and
> >      combined into 3 output bytes.
> >    * Explicitly handle padded and unpadded forms:
> >       - With padding: input length must be a multiple of 4, and '=' is
> >         allowed only in the last two positions. Reject stray or early '='.
> >       - Without padding: validate tail lengths (2 or 3 chars) and require
> >         unused low bits to be zero.
> >    * Removed the bit-accumulator style loop to reduce loop iterations.
> > 
> > Performance (x86_64, Intel Core i7-10700 @ 2.90GHz, avg over 1000 runs,
> > KUnit):
> > 
> > Encode:
> >   64B   ~90ns   -> ~32ns   (~2.8x)
> >   1KB  ~1332ns  -> ~510ns  (~2.6x)
> > 
> > Decode:
> >   64B  ~1530ns  -> ~35ns   (~43.7x)
> >   1KB ~27726ns  -> ~530ns  (~52.3x)
> > 
> > Co-developed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Co-developed-by: Yu-Sheng Huang <home7438072@gmail.com>
> > Signed-off-by: Yu-Sheng Huang <home7438072@gmail.com>
> > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> 
> Reviewed-by: David Laight <david.laight.linux@gmail.com>
> 
> But see minor nit below.

Hi David,

Thanks for the review and for pointing this out.

Andrew, would it be possible for you to fold this small change 
(removing the redundant casts) directly when updating the patch?
If that’s not convenient, I can resend an updated version of the
series instead. 

Best regards,
Guan-Chun

> > ---
> >  lib/base64.c | 109 ++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 68 insertions(+), 41 deletions(-)
> > 
> > diff --git a/lib/base64.c b/lib/base64.c
> > index 9d1074bb821c..1a6d8fe37eda 100644
> > --- a/lib/base64.c
> > +++ b/lib/base64.c
> > @@ -79,28 +79,38 @@ static const s8 base64_rev_maps[][256] = {
> >  int base64_encode(const u8 *src, int srclen, char *dst, bool padding, enum base64_variant variant)
> >  {
> >  	u32 ac = 0;
> > -	int bits = 0;
> > -	int i;
> >  	char *cp = dst;
> >  	const char *base64_table = base64_tables[variant];
> >  
> > -	for (i = 0; i < srclen; i++) {
> > -		ac = (ac << 8) | src[i];
> > -		bits += 8;
> > -		do {
> > -			bits -= 6;
> > -			*cp++ = base64_table[(ac >> bits) & 0x3f];
> > -		} while (bits >= 6);
> > -	}
> > -	if (bits) {
> > -		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
> > -		bits -= 6;
> > +	while (srclen >= 3) {
> > +		ac = (u32)src[0] << 16 | (u32)src[1] << 8 | (u32)src[2];
> 
> There is no need for the (u32) casts.
> All char/short values are promoted to 'int' prior to any maths.
> 
> > +		*cp++ = base64_table[ac >> 18];
> > +		*cp++ = base64_table[(ac >> 12) & 0x3f];
> > +		*cp++ = base64_table[(ac >> 6) & 0x3f];
> > +		*cp++ = base64_table[ac & 0x3f];
> > +
> > +		src += 3;
> > +		srclen -= 3;
> >  	}
> > -	if (padding) {
> > -		while (bits < 0) {
> > +
> > +	switch (srclen) {
> > +	case 2:
> > +		ac = (u32)src[0] << 16 | (u32)src[1] << 8;
> > +		*cp++ = base64_table[ac >> 18];
> > +		*cp++ = base64_table[(ac >> 12) & 0x3f];
> > +		*cp++ = base64_table[(ac >> 6) & 0x3f];
> > +		if (padding)
> > +			*cp++ = '=';
> > +		break;
> > +	case 1:
> > +		ac = (u32)src[0] << 16;
> > +		*cp++ = base64_table[ac >> 18];
> > +		*cp++ = base64_table[(ac >> 12) & 0x3f];
> > +		if (padding) {
> > +			*cp++ = '=';
> >  			*cp++ = '=';
> > -			bits += 2;
> >  		}
> > +		break;
> >  	}
> >  	return cp - dst;
> >  }
> > @@ -116,41 +126,58 @@ EXPORT_SYMBOL_GPL(base64_encode);
> >   *
> >   * Decodes a string using the selected Base64 variant.
> >   *
> > - * This implementation hasn't been optimized for performance.
> > - *
> >   * Return: the length of the resulting decoded binary data in bytes,
> >   *	   or -1 if the string isn't a valid Base64 string.
> >   */
> >  int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
> >  {
> > -	u32 ac = 0;
> > -	int bits = 0;
> > -	int i;
> >  	u8 *bp = dst;
> > -	s8 ch;
> > +	s8 input[4];
> > +	s32 val;
> > +	const u8 *s = (const u8 *)src;
> > +	const s8 *base64_rev_tables = base64_rev_maps[variant];
> >  
> > -	for (i = 0; i < srclen; i++) {
> > -		if (padding) {
> > -			if (src[i] == '=') {
> > -				ac = (ac << 6);
> > -				bits += 6;
> > -				if (bits >= 8)
> > -					bits -= 8;
> > -				continue;
> > -			}
> > -		}
> > -		ch = base64_rev_maps[variant][(u8)src[i]];
> > -		if (ch == -1)
> > -			return -1;
> > -		ac = (ac << 6) | ch;
> > -		bits += 6;
> > -		if (bits >= 8) {
> > -			bits -= 8;
> > -			*bp++ = (u8)(ac >> bits);
> > +	while (srclen >= 4) {
> > +		input[0] = base64_rev_tables[s[0]];
> > +		input[1] = base64_rev_tables[s[1]];
> > +		input[2] = base64_rev_tables[s[2]];
> > +		input[3] = base64_rev_tables[s[3]];
> > +
> > +		val = input[0] << 18 | input[1] << 12 | input[2] << 6 | input[3];
> > +
> > +		if (unlikely(val < 0)) {
> > +			if (!padding || srclen != 4 || s[3] != '=')
> > +				return -1;
> > +			padding = 0;
> > +			srclen = s[2] == '=' ? 2 : 3;
> > +			break;
> >  		}
> > +
> > +		*bp++ = val >> 16;
> > +		*bp++ = val >> 8;
> > +		*bp++ = val;
> > +
> > +		s += 4;
> > +		srclen -= 4;
> >  	}
> > -	if (ac & ((1 << bits) - 1))
> > +
> > +	if (likely(!srclen))
> > +		return bp - dst;
> > +	if (padding || srclen == 1)
> >  		return -1;
> > +
> > +	val = (base64_rev_tables[s[0]] << 12) | (base64_rev_tables[s[1]] << 6);
> > +	*bp++ = val >> 10;
> > +
> > +	if (srclen == 2) {
> > +		if (val & 0x800003ff)
> > +			return -1;
> > +	} else {
> > +		val |= base64_rev_tables[s[2]];
> > +		if (val & 0x80000003)
> > +			return -1;
> > +		*bp++ = val >> 2;
> > +	}
> >  	return bp - dst;
> >  }
> >  EXPORT_SYMBOL_GPL(base64_decode);
> 

