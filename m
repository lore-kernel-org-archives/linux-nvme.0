Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BF2CCD184
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Oct 2025 08:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KgqhrnFFLcx9NWAAafw0DUJGNd8Ld5Si5GTZSSnF9u4=; b=MWuWic/rS3ROFHiipQ6tQwrH69
	gzTgKSjxQQbFvtR0M/4LVLlem5yH6zHOnnKL9diCZvDFk58Xvug/ra9yt2AzvQL685cG1S2C5ott2
	hulV0J9iEiLTZv+CgHmIG3NtdNJ8mGWPM6f6hf/2HdOQYp3J5cp6jigLIwM2K2NytOBPXEFoR9JP4
	afgEt8XcEjdkFgtQlsiEGm+N8pxvd3zp73buebMlXWUtvkWrvQLhKuqR1NUmE4IbdtBKMdNGI4tD+
	vOFuScoVmPHRl7T4kZISU2kZGq76V/Go+UaJvdKYEP6rKHZ/9hJAUT8/7OYQcBI+gF2Jl6nuo92ic
	7IWYZ7Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v639c-00000001aU5-1CwP;
	Tue, 07 Oct 2025 08:34:40 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v639Z-00000001aSZ-1cX9
	for linux-nvme@lists.infradead.org;
	Tue, 07 Oct 2025 08:34:38 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so6750086a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 07 Oct 2025 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1759826076; x=1760430876; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KgqhrnFFLcx9NWAAafw0DUJGNd8Ld5Si5GTZSSnF9u4=;
        b=gYHCGyM2zDZR7Lk2uS0Xi7QKYUIPUztQptDUBp3UO4Dhcs6HA+YBvLGnneTTe4SCPi
         DMx2Shkse33RLQrpkiBKiTdfR52QnUgPdfSJYHCaDQxDdsgc+8Dw50Nc1PZ9a25InYAA
         xbLTzsOuedvgB6vaglupNlBvfHAA1lWcD2X0LxRuwfU2ajkSflDv7f0Je0qv/etk+M6F
         lX4JwfZAFuXKWoST40M7WrHGVpUf/8RucgHmnMF3cdcpqfI0dRv7RkWroXSxzRTr8Rm1
         zh1VjeNU5dYwLWStcGDnMri6QpZKYtSUUzEwrGMzDLEr0xoI+rJrfnYLJM2yKCJ6G21V
         0pDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826076; x=1760430876;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgqhrnFFLcx9NWAAafw0DUJGNd8Ld5Si5GTZSSnF9u4=;
        b=IAd70Ohwcvv7N/25A2xzRa24R8ft961/PfBKOO2mQcb69FB8SfJk1eVtxEFuv3h5/8
         Zz43xm7FH70JAHiOHLMHrKs0eczB6wp8SUY3rBHUI4eqPO3vwg9Io4UxgIgqXEmNdPjI
         64ldFW9yCievdvHZ1fg9rrsLQkDZddksXG094zrH7qVXlQnaz9vjpDc0t58rPKteZLDl
         SXxMWCe+PDoOgMkYVE8DyI/o5uX60Ryn+G5+1e96ZHWsZh6yumY92Y+nZT4DCRWLFt0W
         Hth3dFjlLuGoTG7H7q2cxxKTKuLRNk7urTq21d5MpLfqUGX3Wc+uWePg68KHC7gUj6VW
         o7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDnkLvzlwFNNewlfmbS0AUyljE/zypwnadfcyvvMKQg6T29hunWxCUAVdGVUiYjDp9y56M0Q1HRpiE@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6dnts9i5Jye0J/EuTuY5EA8wg9uEpMjRibQFhzd8JcWnfNtyh
	amIy10zpn25F0luyGzNy5B7aci6Ut2il56wVhtslON00wKX61ibgZhvX9c4N1ksH09M=
X-Gm-Gg: ASbGnctqmSmwkS7RQExgdn/jeyuYnX8LN/KfFgPEKk1nPtFz1Hul5LbN3A8pfskpl24
	wjHUApvplcsy80cXFo0uhzK0+T/2SWrYFglnTnf9JbQwtMkoYr55O7e7jGnO9PNg3mpF29ChiaC
	e52yXNnwNA565fBDFom/b5EHUVoW229fx2dMbwk0pr30l+At036yekQk36UPtYSbkAh09NgQT9s
	9qjTScjs/VureC8Y37YtOYqYrEoFH47sFrbqkXj8z3Q6wWBOW1BVKeHSmGMHeCvHuRYsH2m6VDe
	ris7g4fHMw0QRvKsjf+RCELeBwXkzrNEbcXX8U+rI5XhCh07hRSTJiph2cztRcf37RJl1qbVktp
	MZ86X9QUzEvDwDWGKST8DgiAbyAPrAGmvRzPtKGfOUqZCGOXPZA/2CiOO0mRV1XSxgwp/ePOOF0
	0kgrY=
X-Google-Smtp-Source: AGHT+IG4PiJ7Ahe7MRzt+nwIi/+/a1f2W0pJRvgQ363IH2MoiBd+l107hDp6w8HAEeTEgfYg+b91IA==
X-Received: by 2002:a17:90b:1b01:b0:335:2a00:6842 with SMTP id 98e67ed59e1d1-339c279e4b8mr20038971a91.26.1759826076585;
        Tue, 07 Oct 2025 01:34:36 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:5196:9a8f:bb54:f0db])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a19fe4sm13597424a91.8.2025.10.07.01.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:34:36 -0700 (PDT)
Date: Tue, 7 Oct 2025 16:34:31 +0800
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
Subject: Re: [PATCH v3 3/6] lib/base64: rework encode/decode for speed and
 stricter validation
Message-ID: <aOTQl2SD5W8zBuNl@wu-Pro-E500-G6-WS720T>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
 <20250926065617.14361-1-409411716@gms.tku.edu.tw>
 <CADUfDZpu=rK4WwSmhNgxHQd2zeNvn8a7TmKCYuTL5T7dZ0x_4A@mail.gmail.com>
 <aNz21InCM4Pa93TL@wu-Pro-E500-G6-WS720T>
 <20251006215212.2920d571@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251006215212.2920d571@pumpkin>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251007_013437_438380_5E1AE688 
X-CRM114-Status: GOOD (  51.10  )
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

On Mon, Oct 06, 2025 at 09:52:12PM +0100, David Laight wrote:
> On Wed, 1 Oct 2025 17:39:32 +0800
> Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> 
> > On Tue, Sep 30, 2025 at 05:11:12PM -0700, Caleb Sander Mateos wrote:
> > > On Fri, Sep 26, 2025 at 12:01 AM Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:  
> > > >
> > > > The old base64 implementation relied on a bit-accumulator loop, which was
> > > > slow for larger inputs and too permissive in validation. It would accept
> > > > extra '=', missing '=', or even '=' appearing in the middle of the input,
> > > > allowing malformed strings to pass. This patch reworks the internals to
> > > > improve performance and enforce stricter validation.
> > > >
> > > > Changes:
> > > >  - Encoder:
> > > >    * Process input in 3-byte blocks, mapping 24 bits into four 6-bit
> > > >      symbols, avoiding bit-by-bit shifting and reducing loop iterations.
> > > >    * Handle the final 1-2 leftover bytes explicitly and emit '=' only when
> > > >      requested.
> > > >  - Decoder:
> > > >    * Based on the reverse lookup tables from the previous patch, decode
> > > >      input in 4-character groups.
> > > >    * Each group is looked up directly, converted into numeric values, and
> > > >      combined into 3 output bytes.
> > > >    * Explicitly handle padded and unpadded forms:
> > > >       - With padding: input length must be a multiple of 4, and '=' is
> > > >         allowed only in the last two positions. Reject stray or early '='.
> > > >       - Without padding: validate tail lengths (2 or 3 chars) and require
> > > >         unused low bits to be zero.
> > > >    * Removed the bit-accumulator style loop to reduce loop iterations.
> > > >
> > > > Performance (x86_64, Intel Core i7-10700 @ 2.90GHz, avg over 1000 runs,
> > > > KUnit):
> > > >
> > > > Encode:
> > > >   64B   ~90ns   -> ~32ns   (~2.8x)
> > > >   1KB  ~1332ns  -> ~510ns  (~2.6x)
> > > >
> > > > Decode:
> > > >   64B  ~1530ns  -> ~64ns   (~23.9x)
> > > >   1KB ~27726ns  -> ~982ns  (~28.3x)
> > > >
> > > > Co-developed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > Co-developed-by: Yu-Sheng Huang <home7438072@gmail.com>
> > > > Signed-off-by: Yu-Sheng Huang <home7438072@gmail.com>
> > > > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > ---
> > > >  lib/base64.c | 150 +++++++++++++++++++++++++++++++++++++--------------
> > > >  1 file changed, 110 insertions(+), 40 deletions(-)
> > > >
> > > > diff --git a/lib/base64.c b/lib/base64.c
> > > > index b20fdf168..fd1db4611 100644
> > > > --- a/lib/base64.c
> > > > +++ b/lib/base64.c
> > > > @@ -93,26 +93,43 @@ static const s8 base64_rev_tables[][256] = {
> > > >  int base64_encode(const u8 *src, int srclen, char *dst, bool padding, enum base64_variant variant)
> > > >  {
> > > >         u32 ac = 0;
> > > > -       int bits = 0;
> > > > -       int i;
> > > >         char *cp = dst;
> > > >         const char *base64_table = base64_tables[variant];
> > > >
> > > > -       for (i = 0; i < srclen; i++) {
> > > > -               ac = (ac << 8) | src[i];
> > > > -               bits += 8;
> > > > -               do {
> > > > -                       bits -= 6;
> > > > -                       *cp++ = base64_table[(ac >> bits) & 0x3f];
> > > > -               } while (bits >= 6);
> > > > -       }
> > > > -       if (bits) {
> > > > -               *cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
> > > > -               bits -= 6;
> > > > +       while (srclen >= 3) {
> > > > +               ac = ((u32)src[0] << 16) |
> > > > +                        ((u32)src[1] << 8) |
> > > > +                        (u32)src[2];
> > > > +
> > > > +               *cp++ = base64_table[ac >> 18];
> > > > +               *cp++ = base64_table[(ac >> 12) & 0x3f];
> > > > +               *cp++ = base64_table[(ac >> 6) & 0x3f];
> > > > +               *cp++ = base64_table[ac & 0x3f];
> > > > +
> > > > +               src += 3;
> > > > +               srclen -= 3;
> > > >         }
> > > > -       while (bits < 0) {
> > > > -               *cp++ = '=';
> > > > -               bits += 2;
> > > > +
> > > > +       switch (srclen) {
> > > > +       case 2:
> > > > +               ac = ((u32)src[0] << 16) |
> > > > +                    ((u32)src[1] << 8);
> > > > +
> > > > +               *cp++ = base64_table[ac >> 18];
> > > > +               *cp++ = base64_table[(ac >> 12) & 0x3f];
> > > > +               *cp++ = base64_table[(ac >> 6) & 0x3f];
> > > > +               if (padding)
> > > > +                       *cp++ = '=';
> > > > +               break;
> > > > +       case 1:
> > > > +               ac = ((u32)src[0] << 16);
> > > > +               *cp++ = base64_table[ac >> 18];
> > > > +               *cp++ = base64_table[(ac >> 12) & 0x3f];
> > > > +               if (padding) {
> > > > +                       *cp++ = '=';
> > > > +                       *cp++ = '=';
> > > > +               }
> > > > +               break;
> > > >         }
> > > >         return cp - dst;
> > > >  }
> > > > @@ -128,39 +145,92 @@ EXPORT_SYMBOL_GPL(base64_encode);
> > > >   *
> > > >   * Decodes a string using the selected Base64 variant.
> > > >   *
> > > > - * This implementation hasn't been optimized for performance.
> > > > - *
> > > >   * Return: the length of the resulting decoded binary data in bytes,
> > > >   *        or -1 if the string isn't a valid Base64 string.
> > > >   */
> > > >  int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
> > > >  {
> > > > -       u32 ac = 0;
> > > > -       int bits = 0;
> > > > -       int i;
> > > >         u8 *bp = dst;
> > > > -       s8 ch;
> > > > -
> > > > -       for (i = 0; i < srclen; i++) {
> > > > -               if (src[i] == '=') {
> > > > -                       ac = (ac << 6);
> > > > -                       bits += 6;
> > > > -                       if (bits >= 8)
> > > > -                               bits -= 8;
> > > > -                       continue;
> > > > -               }
> > > > -               ch = base64_rev_tables[variant][(u8)src[i]];
> > > > -               if (ch == -1)
> > > > +       s8 input1, input2, input3, input4;
> > > > +       u32 val;
> > > > +
> > > > +       if (srclen == 0)
> > > > +               return 0;  
> > > 
> > > Doesn't look like this special case is necessary; all the if and while
> > > conditions below are false if srclen == 0, so the function will just
> > > end up returning 0 in that case anyways. It would be nice to avoid
> > > this branch, especially as it seems like an uncommon case.
> > >  
> > 
> > You're right. I'll remove it. Thanks.
> > 
> > > > +
> > > > +       /* Validate the input length for padding */
> > > > +       if (unlikely(padding && (srclen & 0x03) != 0))
> > > > +               return -1;
> > > > +
> > > > +       while (srclen >= 4) {
> > > > +               /* Decode the next 4 characters */
> > > > +               input1 = base64_rev_tables[variant][(u8)src[0]];
> > > > +               input2 = base64_rev_tables[variant][(u8)src[1]];
> > > > +               input3 = base64_rev_tables[variant][(u8)src[2]];
> > > > +               input4 = base64_rev_tables[variant][(u8)src[3]];
> > > > +
> > > > +               /* Return error if any Base64 character is invalid */
> > > > +               if (unlikely(input1 < 0 || input2 < 0 || (!padding && (input3 < 0 || input4 < 0))))
> > > > +                       return -1;
> > > > +
> > > > +               /* Handle padding */
> > > > +               if (unlikely(padding && ((input3 < 0 && input4 >= 0) ||
> > > > +                                        (input3 < 0 && src[2] != '=') ||
> > > > +                                        (input4 < 0 && src[3] != '=') ||
> > > > +                                        (srclen > 4 && (input3 < 0 || input4 < 0)))))  
> > > 
> > > Would be preferable to check and strip the padding (i.e. decrease
> > > srclen) before this main loop. That way we could avoid several
> > > branches in this hot loop that are only necessary to handle the
> > > padding chars.
> > >   
> > 
> > You're right. As long as we check and strip the padding first, the
> > behavior with or without padding can be the same, and it could also
> > reduce some unnecessary branches. I'll make the change.
> 
> As I said earlier.
> Calculate 'val' first using signed arithmetic.
> If it is non-negative there are three bytes to write.
> If negative then check for src[2] and src[3] being '=' (etc) before erroring out.
> 
> That way there is only one check in the normal path.
> 
> 	David
>

Thanks for the feedback. We’ll update the implementation accordingly.

Best regards,
Guan-Chun

> > 
> > Best regards,
> > Guan-Chun
> > 
> > > > +                       return -1;
> > > > +               val = ((u32)input1 << 18) |
> > > > +                     ((u32)input2 << 12) |
> > > > +                     ((u32)((input3 < 0) ? 0 : input3) << 6) |
> > > > +                     (u32)((input4 < 0) ? 0 : input4);
> > > > +
> > > > +               *bp++ = (u8)(val >> 16);
> > > > +
> > > > +               if (input3 >= 0)
> > > > +                       *bp++ = (u8)(val >> 8);
> > > > +               if (input4 >= 0)
> > > > +                       *bp++ = (u8)val;
> > > > +
> > > > +               src += 4;
> > > > +               srclen -= 4;
> > > > +       }
> > > > +
> > > > +       /* Handle leftover characters when padding is not used */
> > > > +       if (!padding && srclen > 0) {
> > > > +               switch (srclen) {
> > > > +               case 2:
> > > > +                       input1 = base64_rev_tables[variant][(u8)src[0]];
> > > > +                       input2 = base64_rev_tables[variant][(u8)src[1]];
> > > > +                       if (unlikely(input1 < 0 || input2 < 0))
> > > > +                               return -1;
> > > > +
> > > > +                       val = ((u32)input1 << 6) | (u32)input2; /* 12 bits */
> > > > +                       if (unlikely(val & 0x0F))
> > > > +                               return -1; /* low 4 bits must be zero */
> > > > +
> > > > +                       *bp++ = (u8)(val >> 4);
> > > > +                       break;
> > > > +               case 3:
> > > > +                       input1 = base64_rev_tables[variant][(u8)src[0]];
> > > > +                       input2 = base64_rev_tables[variant][(u8)src[1]];
> > > > +                       input3 = base64_rev_tables[variant][(u8)src[2]];
> > > > +                       if (unlikely(input1 < 0 || input2 < 0 || input3 < 0))
> > > > +                               return -1;
> > > > +
> > > > +                       val = ((u32)input1 << 12) |
> > > > +                             ((u32)input2 << 6) |
> > > > +                             (u32)input3; /* 18 bits */
> > > > +
> > > > +                       if (unlikely(val & 0x03))
> > > > +                               return -1; /* low 2 bits must be zero */
> > > > +
> > > > +                       *bp++ = (u8)(val >> 10);
> > > > +                       *bp++ = (u8)((val >> 2) & 0xFF);  
> > > 
> > > "& 0xFF" is redundant with the cast to u8.
> > > 
> > > Best,
> > > Caleb
> > >   
> > > > +                       break;
> > > > +               default:
> > > >                         return -1;
> > > > -               ac = (ac << 6) | ch;
> > > > -               bits += 6;
> > > > -               if (bits >= 8) {
> > > > -                       bits -= 8;
> > > > -                       *bp++ = (u8)(ac >> bits);
> > > >                 }
> > > >         }
> > > > -       if (ac & ((1 << bits) - 1))
> > > > -               return -1;
> > > > +
> > > >         return bp - dst;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(base64_decode);
> > > > --
> > > > 2.34.1
> > > >
> > > >  
> > 
> 

