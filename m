Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59283CCF9E5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YHYAm5clDKGEgl2cOgr+YFXcUNktmsVcXuwqgoHg62Q=; b=fqYtT3T5HmAu8UI4euVFRgLh+b
	G3nQuVu9byjBDFIpYo/MqiqhTwSp3S1E9/Wp7zNCqs5nON/XiXmTPVFJ3N+4xOS31jr9LMsDXs8o4
	zsWx09MbsHFkFWZ8dBmrvya5qbbvO6lMRl+dT9G92h/PlkL6dEiGPGlfqsD0jDT8U842SDOwtPWLO
	RzMeqM1+gct9V0skDm2d1k9moqS0v9TGigoYGeJKJcxIxozVkok8fAHWF+Teg+0S5SEAezvX/8s/c
	nhQVItYDvEEQpLxYnjiPF/yGMMf/yeqInkVPm0k0SpRRSlY9udmEoNDjC2nkX5mDEiqthc0XgC3IX
	O+dkbIjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDN19-0000000DzQK-14hB;
	Mon, 27 Oct 2025 13:12:11 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDN15-0000000DzPn-3NJV
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 13:12:09 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-b679450ecb6so3396401a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 27 Oct 2025 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761570725; x=1762175525; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YHYAm5clDKGEgl2cOgr+YFXcUNktmsVcXuwqgoHg62Q=;
        b=LOj1/2WQXdgzYzSpTA86B3eZQT7/bpXnHDd53Fqz3IQrBnBNR1vc2BKNyAcv3SPPh5
         OZ5oCRwXj011xAGQXHXXm2IobB5dxC1wiInMuAJ9lw/RyoTbU8VXg9rDQKAO8njVUZsY
         HcRO1tED9/FklpIC7SHWuSSn0Ka0iH01tDrMd/lZoca3uHtaClHmqj4VppBRkoSCbsPN
         Jv1HPHF19SP50iMjK7roKjBNYGoR0YQdOofFmj2KF44McPB+oFOSIZJ9gGkeMNfMRv6p
         W9bzWwlirT1oRIQ65ZyyrWuCVnT7Bq1BLIob4XwcGPANEyD/r12EOGnyJijjsxGQ2ef9
         xz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761570725; x=1762175525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHYAm5clDKGEgl2cOgr+YFXcUNktmsVcXuwqgoHg62Q=;
        b=WaE2MqODApm/p+PoStCVCK9r7jrNWWfThF/w8A1sibac9XxGFOOUqlZDn2j56vnAGh
         OOIBIW/pc2JaRB7lmapSdbMGwosfgIy8MmwN+gwgxazQwiCLupy5ThV0LmjNe5AJ0v4s
         UgaOueOttiJXTAiaUAnhDTEOb/AIMTg76mntCe5FI412KhrFwlEc5CI4FsfeVaI5lK9b
         hLglN4Fz3Rzd3MATdlkWqGfQZxW5TGSOi3zdEE847zml4MHpqUgTgphqZIFhSRBShqgA
         bYMyKVL+EkQu5nBMdc6sZFRyxfkfN3Eo/U5KFxE8xSujOCgh4oHcHUt1pMGz7W7hFPYn
         jq7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4ylJrjrEtoLFesYaX7hOnPH/h9hCI2o/pldD88uwE38f8InXiVwb5h6PcIcbvvR54S7ZnKFUt9Ji5@lists.infradead.org
X-Gm-Message-State: AOJu0YwJRvKvFScmBoQhwHi2jiF3sA/N2XY8IcOHrnKwPx/kpWqD7RIw
	qFkWTX7MHAgOiR+AaAtAK0TwHlgr5IjsPm56tH+hGqHb2+oUhJhhb3Y+pvnl4lC34vc=
X-Gm-Gg: ASbGncu5ksifOMu4KVz5k+0cLfY34q9mb2CAfNwTHJJN4i+6eFxDIerG8ksYHND5L1L
	s7TrDKlxIRrzHyEAcIsyI47h73WUyeu0rM42fQlBf2UxVjySdbJH72VEDkx0DMuHlFb1WxrtDDC
	JiMMfpYIWcn63TS9igkCTuPXPPiqExAxE6dVu3uLAYx1yEU7xstf7hVLoAtc726wKBXYPndUFzN
	x4o2OK8tYBWpUT64xSQ6dXahgpJ3Gt2Gip51+ytwWgY7Q2Mq7s/QvkdU4CzyrGBRtxHDEXYyiy8
	tnDOi894U4VDuIdKgsphopVQOZGZi3lxEmHSkoVheA6ijRFnHFbvF8Rt3tfdRdgD8H6E/QWuwSg
	r/rhuXPF7eCvnjFd3kozkC2vBlBDj6+QRXQ7B7BsE+cqcYH9tAsGEwVHuRJw4yV1H5BFfV4p4yD
	6CVLVWbEIIxN/AKXQGDfaD
X-Google-Smtp-Source: AGHT+IFRgrc7hf2+6CuHsBHMzYgRmSG6lQVmw3vlPAYNWTFNGjLEiLeTnXfLTsx0w4DvUGGNsCkacQ==
X-Received: by 2002:a17:902:c410:b0:26d:d860:3db1 with SMTP id d9443c01a7336-2946dec239cmr180220365ad.24.1761570725236;
        Mon, 27 Oct 2025 06:12:05 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:745:9b32:70e1:48f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3b64sm84103415ad.3.2025.10.27.06.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:12:04 -0700 (PDT)
Date: Mon, 27 Oct 2025 21:12:00 +0800
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
Message-ID: <aP9voK9lE/MlanGl@wu-Pro-E500-G6-WS720T>
References: <aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T>
 <CADUfDZq4c3dRgWpevv3+29frvd6L8G9RRdoVFpFnyRsF3Eve1Q@mail.gmail.com>
 <20251005181803.0ba6aee4@pumpkin>
 <aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
 <CADUfDZp6TA_S72+JDJRmObJgmovPgit=-Zf+-oC+r0wUsyg9Jg@mail.gmail.com>
 <20251007192327.57f00588@pumpkin>
 <aOeprat4/97oSWE0@wu-Pro-E500-G6-WS720T>
 <20251010105138.0356ad75@pumpkin>
 <aOzLQ2KSqGn1eYrm@wu-Pro-E500-G6-WS720T>
 <20251014091420.173dfc9c@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014091420.173dfc9c@pumpkin>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_061207_995249_B1E25D0A 
X-CRM114-Status: GOOD (  63.59  )
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

On Tue, Oct 14, 2025 at 09:14:20AM +0100, David Laight wrote:
> On Mon, 13 Oct 2025 17:49:55 +0800
> Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
>
> > On Fri, Oct 10, 2025 at 10:51:38AM +0100, David Laight wrote:
> > > On Thu, 9 Oct 2025 20:25:17 +0800
> > > Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> > > 
> > > ...  
> > > > As Eric mentioned, the decoder in fs/crypto/ needs to reject invalid input.  
> > > 
> > > (to avoid two different input buffers giving the same output)
> > > 
> > > Which is annoyingly reasonable.
> > >   
> > > > One possible solution I came up with is to first create a shared
> > > > base64_rev_common lookup table as the base for all Base64 variants.
> > > > Then, depending on the variant (e.g., BASE64_STD, BASE64_URLSAFE, etc.), we
> > > > can dynamically adjust the character mappings for position 62 and position 63
> > > > at runtime, based on the variant.
> > > > 
> > > > Here are the changes to the code:
> > > > 
> > > > static const s8 base64_rev_common[256] = {
> > > > 	[0 ... 255] = -1,
> > > > 	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12,
> > > > 		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
> > > > 	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38,
> > > > 		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
> > > > 	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61,
> > > > };
> > > > 
> > > > static const struct {
> > > > 	char char62, char63;
> > > > } base64_symbols[] = {
> > > > 	[BASE64_STD] = { '+', '/' },
> > > > 	[BASE64_URLSAFE] = { '-', '_' },
> > > > 	[BASE64_IMAP] = { '+', ',' },
> > > > };
> > > > 
> > > > int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
> > > > {
> > > > 	u8 *bp = dst;
> > > > 	u8 pad_cnt = 0;
> > > > 	s8 input1, input2, input3, input4;
> > > > 	u32 val;
> > > > 	s8 base64_rev_tables[256];
> > > > 
> > > > 	/* Validate the input length for padding */
> > > > 	if (unlikely(padding && (srclen & 0x03) != 0))
> > > > 		return -1;  
> > > 
> > > There is no need for an early check.
> > > Pick it up after the loop when 'srclen != 0'.
> > >  
> > 
> > I think the early check is still needed, since I'm removing the
> > padding '=' first.
> > This makes the handling logic consistent for both padded and unpadded
> > inputs, and avoids extra if conditions for padding inside the hot loop.
> 
> The 'invalid input' check will detect the padding.
> Then you don't get an extra check if there is no padding (probably normal).
> I realised I didn't get it quite right - updated below.
> 
> > 
> > > > 
> > > > 	memcpy(base64_rev_tables, base64_rev_common, sizeof(base64_rev_common));  
> > > 
> > > Ugg - having a memcpy() here is not a good idea.
> > > It really is better to have 3 arrays, but use a 'mostly common' initialiser.
> > > Perhaps:
> > > #define BASE64_REV_INIT(ch_62, ch_63) = { \
> > > 	[0 ... 255] = -1, \
> > > 	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
> > > 		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, \
> > > 	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, \
> > > 		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, \
> > > 	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> > > 	[ch_62] = 62, [ch_63] = 63, \
> > > }
> > > 
> > > static const s8 base64_rev_maps[][256] = {
> > > 	[BASE64_STD] = BASE64_REV_INIT('+', '/'),
> > > 	[BASE64_URLSAFE] = BASE64_REV_INIT('-', '_'),
> > > 	[BASE64_IMAP] = BASE64_REV_INIT('+', ',')
> > > };
> > > 
> > > Then (after validating variant):
> > > 	const s8 *map = base64_rev_maps[variant];
> > >  
> > 
> > Got it. I'll switch to using three static tables with a common initializer
> > as you suggested.
> > 
> > > > 
> > > > 	if (variant < BASE64_STD || variant > BASE64_IMAP)
> > > > 		return -1;
> > > > 
> > > > 	base64_rev_tables[base64_symbols[variant].char62] = 62;
> > > > 	base64_rev_tables[base64_symbols[variant].char63] = 63;
> > > > 
> > > > 	while (padding && srclen > 0 && src[srclen - 1] == '=') {
> > > > 		pad_cnt++;
> > > > 		srclen--;
> > > > 		if (pad_cnt > 2)
> > > > 			return -1;
> > > > 	}  
> > > 
> > > I'm not sure I'd to that there.
> > > You are (in some sense) optimising for padding.
> > > From what I remember, "abcd" gives 24 bits, "abc=" 16 and "ab==" 8.
> > >   
> > > > 
> > > > 	while (srclen >= 4) {
> > > > 		/* Decode the next 4 characters */
> > > > 		input1 = base64_rev_tables[(u8)src[0]];
> > > > 		input2 = base64_rev_tables[(u8)src[1]];
> > > > 		input3 = base64_rev_tables[(u8)src[2]];
> > > > 		input4 = base64_rev_tables[(u8)src[3]];  
> > > 
> > > I'd be tempted to make src[] unsigned - probably be assigning the parameter
> > > to a local at the top of the function.
> > > 
> > > Also you have input3 = ... src[2]...
> > > Perhaps they should be input[0..3] instead.
> > >  
> > 
> > OK, I'll make the changes.
> > 
> > > > 
> > > > 		val = (input1 << 18) |
> > > > 		      (input2 << 12) |
> > > > 		      (input3 << 6) |
> > > > 		      input4;  
> > > 
> > > Four lines is excessive, C doesn't require the () and I'm not sure the
> > > compilers complain about << and |.
> > >   
> > 
> > OK, I'll make the changes.
> > 
> > > > 
> > > > 		if (unlikely((s32)val < 0))
> > > > 			return -1;  
> > > 
> > > Make 'val' signed - then you don't need the cast.
> ...
> > > Or, if you really want to use the code below the loop:
> > > 			if (!padding || src[3] != '=')
> > > 				return -1;
> > > 			padding = 0;
> > > 			srclen -= 1 + (src[2] == '=');
> > > 			break;
> 
> That is missing a test...
> Change to:
> 			if (!padding || srclen != 4 || src[3] != '=')
> 				return -1;
> 			padding = 0;
> 			srclen = src[2] == '=' ? 2 : 3;
> 			break;
>
> The compiler will then optimise away the first checks after the
> loop because it knows they can't happen.

Hi David,

I noticed your suggested approach:
val_24 = t[b[0]] | t[b[1]] << 6 | t[b[2]] << 12 | t[b[3]] << 18;
Per the C11 draft, this can lead to undefined behavior.
"If E1 has a signed type and nonnegative value, and E1 × 2^E2 is
representable in the result type, then that is the resulting value;
otherwise, the behavior is undefined."
Therefore, left-shifting a negative signed value is undefined behavior.

Perhaps we could change the code as shown below. What do you think?

int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
{
	u8 *bp = dst;
	s8 input[4];
	u32 val;
	const u8 *s = (const u8 *)src;
	const s8 *base64_rev_table = base64_rev_maps[variant];

	while (srclen >= 4) {
		input[0] = base64_rev_table[s[0]];
		input[1] = base64_rev_table[s[1]];
		input[2] = base64_rev_table[s[2]];
		input[3] = base64_rev_table[s[3]];

		if (unlikely((input[0] | input[1] | input[2] | input[3]) < 0)) {
			if (!padding || srclen != 4 || s[3] != '=')
				return -1;
			padding = 0;
			srclen = s[2] == '=' ? 2 : 3;
			break;
		}

		val = (u32)input[0] << 18 | (u32)input[1] << 12 |
			(u32)input[2] << 6 | (u32)input[3];

		*bp++ = val >> 16;
		*bp++ = val >> 8;
		*bp++ = val;

		s += 4;
		srclen -= 4;
	}

	if (likely(!srclen))
		return bp - dst;
	if (padding || srclen == 1)
		return -1;

	input[0] = base64_rev_table[s[0]];
	input[1] = base64_rev_table[s[1]];

	if (unlikely(input[0] < 0 || input[1] < 0))
		return -1;

	val = (u32)input[0] << 18 | (u32)input[1] << 12;

	if (srclen == 2) {
		if (unlikely(input[1] & 0x0f))
			return -1;
		*bp++ = val >> 16;
	} else {
		input[2] = base64_rev_table[s[2]];
		if (unlikely(input[2] < 0 || (input[2] & 0x03)))
			return -1;
		val |= (u32)input[2] << 6;
		*bp++ = val >> 16;
		*bp++ = val >> 8;
	}

	return bp - dst;
}

Best regards,
Guan-Chun

> > > 
> > >   
> > > > 
> > > > 		*bp++ = (u8)(val >> 16);
> > > > 		*bp++ = (u8)(val >> 8);
> > > > 		*bp++ = (u8)val;  
> > > 
> > > You don't need those casts.
> > >  
> > 
> > OK, I'll make the changes.
> > 
> > > > 
> > > > 		src += 4;
> > > > 		srclen -= 4;
> > > > 	}
> > > > 
> > > > 	/* Handle leftover characters when padding is not used */  
> > > 
> > > You are coming here with padding.
> > > I'm not sure what should happen without padding.
> > > For a multi-line file decode I suspect the characters need adding to
> > > the start of the next line (ie lines aren't required to contain
> > > multiples of 4 characters - even though they almost always will).
> > >   
> > 
> > Ah, my mistake. I forgot to remove that comment.
> > Based on my observation, base64_decode() should process the entire input
> > buffer in a single call, so I believe it does not need to handle
> > multi-line input.
> 
> I was thinking of the the case where it is processing the output of
> something like base64encode.
> The caller will have separated out the lines, but I don't know whether
> every line has to contain a multiple of 4 characters - or whether the
> lines can be arbitrarily split after being encoded (I know that won't
> normally happen - but you never know). 
> 
> > 
> > Best regards,
> > Guan-Chun
> > 
> > > > 	if (srclen > 0) {
> > > > 		switch (srclen) {  
> > > 
> > > You don't need an 'if' and a 'switch'.
> > > srclen is likely to be zero, but perhaps write as:
> > > 	if (likely(!srclen))
> > > 		return bp - dst;
> > > 	if (padding || srclen == 1)
> > > 		return -1;
> > > 
> > > 	val = base64_rev_tables[(u8)src[0]] << 12 | base64_rev_tables[(u8)src[1]] << 6;
> > > 	*bp++ = val >> 10;
> > > 	if (srclen == 1) {
> Obviously should be (srclen == 2)
> > > 		if (val & 0x800003ff)
> > > 			return -1;
> > > 	} else {
> > > 		val |= base64_rev_tables[(u8)src[2]];
> > > 		if (val & 0x80000003)
> > > 			return -1;
> > > 		*bp++ = val >> 2;
> > > 	}
> > > 	return bp - dst;
> > > }
> > > 
> > > 	David
> 
> 	David
> 
> > >   
> > > > 		case 2:
> > > > 			input1 = base64_rev_tables[(u8)src[0]];
> > > > 			input2 = base64_rev_tables[(u8)src[1]];
> > > > 			val = (input1 << 6) | input2; /* 12 bits */
> > > > 			if (unlikely((s32)val < 0 || val & 0x0F))
> > > > 				return -1;
> > > > 
> > > > 			*bp++ = (u8)(val >> 4);
> > > > 			break;
> > > > 		case 3:
> > > > 			input1 = base64_rev_tables[(u8)src[0]];
> > > > 			input2 = base64_rev_tables[(u8)src[1]];
> > > > 			input3 = base64_rev_tables[(u8)src[2]];
> > > > 
> > > > 			val = (input1 << 12) |
> > > > 			      (input2 << 6) |
> > > > 			      input3; /* 18 bits */
> > > > 			if (unlikely((s32)val < 0 || val & 0x03))
> > > > 				return -1;
> > > > 
> > > > 			*bp++ = (u8)(val >> 10);
> > > > 			*bp++ = (u8)(val >> 2);
> > > > 			break;
> > > > 		default:
> > > > 			return -1;
> > > > 		}
> > > > 	}
> > > > 
> > > > 	return bp - dst;
> > > > }
> > > > Based on KUnit testing, the performance results are as follows:
> > > > 	base64_performance_tests: [64B] decode run : 40ns
> > > > 	base64_performance_tests: [1KB] decode run : 463ns
> > > > 
> > > > However, this approach introduces an issue. It uses 256 bytes of memory
> > > > on the stack for base64_rev_tables, which might not be ideal. Does anyone
> > > > have any thoughts or alternative suggestions to solve this issue, or is it
> > > > not really a concern?
> > > > 
> > > > Best regards,
> > > > Guan-Chun
> > > >   
> > > > > > 
> > > > > > Best,
> > > > > > Caleb    
> > > > >     
> > >   
> 

