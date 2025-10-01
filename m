Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DFCCCA470
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 14:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XqH0aTCG1Npbjt4UvAY64PL1wv1XtMcuMWK/965I/ys=; b=rGQZ8susBren84OH2fe/ZcJKq0
	0+PXOabSzP+6pptjwbPeuoTeL6M9tsSTAGdVhx7mWPVuh2GKur9SoqLglGkiTBb3PE5NeC6M3wvw8
	2ZPFPCQcwA9KxR0bQ2o4Do7HIW9YjBUo1QLhBJGNmhm0p5r8zJS8JBYLHJqL8cfgGwIBHpcd2F25Z
	YsW0EDYJsM0PTHTcNck6GUWy5DuMAx8/2sF8/leknnHGYRczkbzWgTPvJrNG41zjvjpKM/gZiFgS0
	99cVSF2srX817ERnLdsNEb5lJOn86hXipdY5FJLlu4Yc6fli6+m6YhPc2t4wuBUJKUZtnRrlmoxr2
	P2AVQ/Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3xWT-000000088Eu-3THg;
	Wed, 01 Oct 2025 14:09:37 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3xWQ-000000088EP-3p8x
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 14:09:36 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-271d1305ad7so94883605ad.2
        for <linux-nvme@lists.infradead.org>; Wed, 01 Oct 2025 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1759327774; x=1759932574; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XqH0aTCG1Npbjt4UvAY64PL1wv1XtMcuMWK/965I/ys=;
        b=NNbf70Svuly+NuCGG8sL6ObvhEU8MA+AC+8RDyHQ6ezXv3nFy3KdWnkBdSSrz+2OLx
         W5mKcbN65ygNpwwBCXXUGucUJBHtI+veLfn9CNSxePjXupKHrwCOMaiOglrcHhwJQlhS
         gR0P1VZRvVv2WZiLSEjfY1bxNwX0oLUAhfwuwP8C/A8JRAQGndk3DA9upWLIkx3xbG9S
         D5r0yVA2A2edX4B0bXDBnseq6rHIwawy4AiT0ZXXJ01dr+7RPDlSNsr/p7cXT5yPXUui
         AiUgkmH42TVw4VVYYZx966MvPDQErty+S/JbMGVx5IpRG39PYClPfSBE5X1sU200cjYK
         1V/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327774; x=1759932574;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqH0aTCG1Npbjt4UvAY64PL1wv1XtMcuMWK/965I/ys=;
        b=OMym8ZHo2YQXeNRVJc2Xsc2aGEW0in/iAL+ZM+W0en6pfHA5IZnrhyaKQidBTieRbe
         fX55FT3MoOENOh6il51xhvU5pzgCYQFb6sru6l1/YSgg43+UtC4Kicwuo7mCOkfNLC5x
         eRz3Qlp4i+ASxTbANW1x99kvpawPFvaE1Zs+o9KJH/vwbcPDBRrcYKED3rO50HF8UVfo
         lQy22/C2tp6CASRcMus2X2uw6ben91+Zl8EqI6aah3Htmw2OZ1aaWs+44TuPYOa74FjP
         OBR/M+jJdUAnh83DQcx+lLCg4ZHItHrnPgPmUUPLwjExs8i2icPuoJF7xXT5DhqtypTg
         RF4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjLUoLF4D4fz3Ze+WPsnEBcVzD0L3+fjfJGaKB77nQaBrsDltyu+nN/n94WiPepfaKNNa9ByMyBvZV@lists.infradead.org
X-Gm-Message-State: AOJu0YzDp7YRwZND7wCN+WkIeekTkt0ITyqUNZKv8AbBoAdl46HIQvbQ
	B8aRdUfb+WNHWt0L3eNeEdz267Oyib1GTPymgPL0lAzr6yMWkbz8L8Z4Xl3hdnMjiCw=
X-Gm-Gg: ASbGncupiX/ypIeA5Wk/cXMRj5jLkn5js5r1v4p0ZnglH1NUuGkK+nuKgsuTNsQS8rt
	2QXrxPJwGCskyZrgWI9vlerRGu7WeKSyc/H5rd+Pwf+aSZuFz0a881UZk1IC6DoWrXqw1oAYfnC
	YcmmVyNy8YYem+IcUM19XyLNgSndqw+OzIM/H7ic4cEDEr/xW17zEuCh350V0PMrbLhXBIy7qZ6
	IJZRH0q0PurGxP47/cySY4uGvTapaKkhlfagMK7HAFXbQemwclDkSEBu7AWmcmM++dxQfKvCz/D
	spDbAJHcWR3zFEJVFIV8bfomRzwZv0Oar+G1zmglCdGu74nQnie/F91jOXzUEwIe77VfejMy9Ea
	3MZB1JzgDbgyXRYpLCJpGAKOkSJyP8pqgQFetdaIUJD2fiQV+UbEIUVQ5Nrce5w25Zfg2
X-Google-Smtp-Source: AGHT+IGgYOAP5JcZE9yHPeldcLK5JZTHw150agf7t58NJs7o4pgbl6tneqfkXD6iMaFuGY1SnGJkGg==
X-Received: by 2002:a17:902:d60f:b0:272:f9c3:31f7 with SMTP id d9443c01a7336-28e7f32ffb4mr43337615ad.50.1759327773570;
        Wed, 01 Oct 2025 07:09:33 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:6af7:94e4:3a78:e342])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66f9257sm186844295ad.35.2025.10.01.07.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:09:32 -0700 (PDT)
Date: Wed, 1 Oct 2025 22:09:27 +0800
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
	ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com,
	idryomov@gmail.com, jaegeuk@kernel.org, kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, tytso@mit.edu,
	visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v3 1/6] lib/base64: Add support for multiple variants
Message-ID: <aN02F6hb/evk95D7@wu-Pro-E500-G6-WS720T>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
 <20250926065512.13881-1-409411716@gms.tku.edu.tw>
 <CADUfDZp6WeW9YQRRnxB7fFObtajatY_+f+x1D5dQOrNv626znA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZp6WeW9YQRRnxB7fFObtajatY_+f+x1D5dQOrNv626znA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_070935_049206_FA6E5B4D 
X-CRM114-Status: GOOD (  37.17  )
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

On Tue, Sep 30, 2025 at 04:56:17PM -0700, Caleb Sander Mateos wrote:
> On Thu, Sep 25, 2025 at 11:59 PM Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> >
> > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> >
> > Extend the base64 API to support multiple variants (standard, URL-safe,
> > and IMAP) as defined in RFC 4648 and RFC 3501. The API now takes a
> > variant parameter and an option to control padding. Update NVMe auth
> > code to use the new interface with BASE64_STD.
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > ---
> >  drivers/nvme/common/auth.c |  4 ++--
> >  include/linux/base64.h     | 10 ++++++++--
> >  lib/base64.c               | 39 ++++++++++++++++++++++----------------
> >  3 files changed, 33 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> > index 91e273b89..5fecb53cb 100644
> > --- a/drivers/nvme/common/auth.c
> > +++ b/drivers/nvme/common/auth.c
> > @@ -178,7 +178,7 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
> >         if (!key)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       key_len = base64_decode(secret, allocated_len, key->key);
> > +       key_len = base64_decode(secret, allocated_len, key->key, true, BASE64_STD);
> >         if (key_len < 0) {
> >                 pr_debug("base64 key decoding error %d\n",
> >                          key_len);
> > @@ -663,7 +663,7 @@ int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
> >         if (ret)
> >                 goto out_free_digest;
> >
> > -       ret = base64_encode(digest, digest_len, enc);
> > +       ret = base64_encode(digest, digest_len, enc, true, BASE64_STD);
> >         if (ret < hmac_len) {
> >                 ret = -ENOKEY;
> >                 goto out_free_digest;
> > diff --git a/include/linux/base64.h b/include/linux/base64.h
> > index 660d4cb1e..a2c6c9222 100644
> > --- a/include/linux/base64.h
> > +++ b/include/linux/base64.h
> > @@ -8,9 +8,15 @@
> >
> >  #include <linux/types.h>
> >
> > +enum base64_variant {
> > +       BASE64_STD,       /* RFC 4648 (standard) */
> > +       BASE64_URLSAFE,   /* RFC 4648 (base64url) */
> > +       BASE64_IMAP,      /* RFC 3501 */
> > +};
> > +
> >  #define BASE64_CHARS(nbytes)   DIV_ROUND_UP((nbytes) * 4, 3)
> >
> > -int base64_encode(const u8 *src, int len, char *dst);
> > -int base64_decode(const char *src, int len, u8 *dst);
> > +int base64_encode(const u8 *src, int len, char *dst, bool padding, enum base64_variant variant);
> > +int base64_decode(const char *src, int len, u8 *dst, bool padding, enum base64_variant variant);
> >
> >  #endif /* _LINUX_BASE64_H */
> > diff --git a/lib/base64.c b/lib/base64.c
> > index b736a7a43..1af557785 100644
> > --- a/lib/base64.c
> > +++ b/lib/base64.c
> > @@ -1,12 +1,12 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * base64.c - RFC4648-compliant base64 encoding
> > + * base64.c - Base64 with support for multiple variants
> >   *
> >   * Copyright (c) 2020 Hannes Reinecke, SUSE
> >   *
> >   * Based on the base64url routines from fs/crypto/fname.c
> > - * (which are using the URL-safe base64 encoding),
> > - * modified to use the standard coding table from RFC4648 section 4.
> > + * (which are using the URL-safe Base64 encoding),
> > + * modified to support multiple Base64 variants.
> >   */
> >
> >  #include <linux/kernel.h>
> > @@ -15,26 +15,31 @@
> >  #include <linux/string.h>
> >  #include <linux/base64.h>
> >
> > -static const char base64_table[65] =
> > -       "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> > +static const char base64_tables[][65] = {
> > +       [BASE64_STD] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",
> > +       [BASE64_URLSAFE] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_",
> > +       [BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
> > +};
> >
> >  /**
> > - * base64_encode() - base64-encode some binary data
> > + * base64_encode() - Base64-encode some binary data
> >   * @src: the binary data to encode
> >   * @srclen: the length of @src in bytes
> > - * @dst: (output) the base64-encoded string.  Not NUL-terminated.
> > + * @dst: (output) the Base64-encoded string.  Not NUL-terminated.
> > + * @padding: whether to append '=' padding characters
> > + * @variant: which base64 variant to use
> >   *
> > - * Encodes data using base64 encoding, i.e. the "Base 64 Encoding" specified
> > - * by RFC 4648, including the  '='-padding.
> > + * Encodes data using the selected Base64 variant.
> >   *
> > - * Return: the length of the resulting base64-encoded string in bytes.
> > + * Return: the length of the resulting Base64-encoded string in bytes.
> >   */
> > -int base64_encode(const u8 *src, int srclen, char *dst)
> > +int base64_encode(const u8 *src, int srclen, char *dst, bool padding, enum base64_variant variant)
> 
> Padding isn't actually implemented in this commit? That seems a bit
> confusing. I think it would ideally be implemented in the same commit
> that adds it. That could be before or after the commit that optimizes
> the encode/decode implementations.
> 
> Best,
> Caleb
>

Got it, thanks for pointing that out. We'll address it in the next version.

Best regards,
Guan-Chun

> >  {
> >         u32 ac = 0;
> >         int bits = 0;
> >         int i;
> >         char *cp = dst;
> > +       const char *base64_table = base64_tables[variant];
> >
> >         for (i = 0; i < srclen; i++) {
> >                 ac = (ac << 8) | src[i];
> > @@ -57,25 +62,27 @@ int base64_encode(const u8 *src, int srclen, char *dst)
> >  EXPORT_SYMBOL_GPL(base64_encode);
> >
> >  /**
> > - * base64_decode() - base64-decode a string
> > + * base64_decode() - Base64-decode a string
> >   * @src: the string to decode.  Doesn't need to be NUL-terminated.
> >   * @srclen: the length of @src in bytes
> >   * @dst: (output) the decoded binary data
> > + * @padding: whether to append '=' padding characters
> > + * @variant: which base64 variant to use
> >   *
> > - * Decodes a string using base64 encoding, i.e. the "Base 64 Encoding"
> > - * specified by RFC 4648, including the  '='-padding.
> > + * Decodes a string using the selected Base64 variant.
> >   *
> >   * This implementation hasn't been optimized for performance.
> >   *
> >   * Return: the length of the resulting decoded binary data in bytes,
> > - *        or -1 if the string isn't a valid base64 string.
> > + *        or -1 if the string isn't a valid Base64 string.
> >   */
> > -int base64_decode(const char *src, int srclen, u8 *dst)
> > +int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
> >  {
> >         u32 ac = 0;
> >         int bits = 0;
> >         int i;
> >         u8 *bp = dst;
> > +       const char *base64_table = base64_tables[variant];
> >
> >         for (i = 0; i < srclen; i++) {
> >                 const char *p = strchr(base64_table, src[i]);
> > --
> > 2.34.1
> >
> >

