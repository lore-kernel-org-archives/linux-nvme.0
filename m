Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB9DCCA470
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 23:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KgDda9PZ/ZOIVHoxLqUI98Lhj+DhQRySzSwpHGi1nUs=; b=1e/TyDz/Ls4p4cos1BKkbIrwLv
	QywoJhKD+i+tX0sq12k8vJu64CMn/DdJ5cNunHEXyCwzef2CDCWiPn6T4IVeeyFrcLpAuCa9DUCHU
	kYUDQqfSbzC6lZvTPWIR6T7JY/RDBoTh6hPDo17q8n15aty5B8Y5T6mURkUY5jVNbcjUjkRlQR4w1
	lRSKhmcwPY7Fap3VfF6p5baBlFxaOERYei6J/5bUzJbiS1+OTvV4FnTJy3LAE2upo7IBQsjeNbrCD
	s7DS5rLfBLtNyAuSNs+Rb4kwaUywl9FqM/Yo/XPdeJ1sy14SxuG02K7gxGscXleySsKfUBo10NRPH
	GRbxqrKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3kCu-00000006OUH-1CJl;
	Tue, 30 Sep 2025 23:56:32 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3kCr-00000006OTv-3kbO
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 23:56:30 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-27eca7297a7so9235095ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 30 Sep 2025 16:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1759276589; x=1759881389; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgDda9PZ/ZOIVHoxLqUI98Lhj+DhQRySzSwpHGi1nUs=;
        b=Ci9Mg6TbuDVXwUcgQq7ogxmeprC3GEYPppbf97eJ55y3jbDhBd60/YZW8/so2sEVcn
         zIXGiRCvNpWUwaDDt6fOLLSKsP+xRU0OpGNAh+m1qxppgfZN1iblYQjqrMuX5OJLPFkd
         YC/86//HH+t6fggzTuUXopenO8prrgw7p8eQj3M30AnkQBUqb3mir3Wb8CVB+OZGjvsB
         C/0nQX/QcG1vZwQnd31d0r1Z/80QaqyrxWY8ALiLCGIBLet/ecz3b9FVYxuJ8ePJmn9f
         iAPX69VkZLHl2FqaKMR4NirL9ARy6mAeHAm/w5lhyULRoC1tFtam1Mzn4u6TBrQSwKaH
         2cFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759276589; x=1759881389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgDda9PZ/ZOIVHoxLqUI98Lhj+DhQRySzSwpHGi1nUs=;
        b=HwjyQ/JTF4rmnAEsXQcT2rYa1fJmk6HQBf3OdVYXArXmfD4voj+ygLmInmSwwMBiak
         PqYThO7e1gzr/BRgkRHyXX1mFbCvAeJMsDhAPjhzZ1NypzuFQ1koAZVjjRA0yt4qUnEi
         fZ6l/pNCgSFG/Um8LhC6lZTyw9Z0iEhT5LJZUhSBtiVYB6snS7XB9gS3HlSsrP7sGBsF
         fvb9AgF0QHNtQ4902vTyMKRJV2C3zAY2Ovij8AWGUWdaijelJ/PvckqQEwig4knpOKTp
         nSpt4ZrLG077S7Pq5jKmYzb/sSKGyr2tVcSsbhxPzUrDDvPdMqPUo7PvAJuL2Cy5c5eq
         1Peg==
X-Forwarded-Encrypted: i=1; AJvYcCVeVTJKCfhUvWrID2yT614eUosDwFmFJ5whhFUIdQBqGnLLHuudFAZX3QQzV502yJPa9Sh7gUR8viPu@lists.infradead.org
X-Gm-Message-State: AOJu0Yz0my0K3+kHWuPEYIeE2V2MrmJQLKykYhaFqB/1LbP8YV2bU2u1
	dv453ClBUb7++OaxlPX3ZQ5wwXVzo1bVz5uWrSACiSQoneR75oUs0181VgyxsVhciJQP+7nTjac
	DznN/VUQbsr7EFUkFn0MxAuYH4yMHJ4GGTJjsOXlWAA==
X-Gm-Gg: ASbGncvX9DdIpIpQBjsz/h0Jli3QPDcJgPq9VTrNfQFWey10fVJrxXRpMq7cCZrfj7/
	jX+jO1/Ag69A1jGa85frc/DhGqc7SSLGsYb7Illp6GcDEf0fhmTuckcflmxWDZPTKBDC1lhmflX
	YGfp9gzOOECYrV+xK50soilgyn2rtNoE3ka7YycXPtKSI3MIxGvJQ5IOAhr49SoYPva0mZ+ZvXA
	X2r1RQWOIMmfvdGcEXkvaV6wvcppUsFuXPVejoi7VKMRI+YZUXvMu0geZ3i076k
X-Google-Smtp-Source: AGHT+IEpxdka3fpY1RGSt22bA+AUtwMCp/hERU5iCKu9uk3PEWfxh8d2ZVgwfA2eMNx71KLt9vE6DliHzz7bVhBKN/c=
X-Received: by 2002:a17:902:ce8c:b0:27e:f07c:8429 with SMTP id
 d9443c01a7336-28e7f263d0fmr9971685ad.1.1759276588590; Tue, 30 Sep 2025
 16:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw> <20250926065512.13881-1-409411716@gms.tku.edu.tw>
In-Reply-To: <20250926065512.13881-1-409411716@gms.tku.edu.tw>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 30 Sep 2025 16:56:17 -0700
X-Gm-Features: AS18NWAZDkDjzHRxic_YNlGQtc5_abU1XjZFoUXfiVOKnVWiVuhgyXH0Q0cj-2w
Message-ID: <CADUfDZp6WeW9YQRRnxB7fFObtajatY_+f+x1D5dQOrNv626znA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] lib/base64: Add support for multiple variants
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org, 
	ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com, 
	jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_165629_943248_B6F25621 
X-CRM114-Status: GOOD (  29.27  )
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

On Thu, Sep 25, 2025 at 11:59=E2=80=AFPM Guan-Chun Wu <409411716@gms.tku.ed=
u.tw> wrote:
>
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
> ---
>  drivers/nvme/common/auth.c |  4 ++--
>  include/linux/base64.h     | 10 ++++++++--
>  lib/base64.c               | 39 ++++++++++++++++++++++----------------
>  3 files changed, 33 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 91e273b89..5fecb53cb 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -178,7 +178,7 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigne=
d char *secret,
>         if (!key)
>                 return ERR_PTR(-ENOMEM);
>
> -       key_len =3D base64_decode(secret, allocated_len, key->key);
> +       key_len =3D base64_decode(secret, allocated_len, key->key, true, =
BASE64_STD);
>         if (key_len < 0) {
>                 pr_debug("base64 key decoding error %d\n",
>                          key_len);
> @@ -663,7 +663,7 @@ int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, si=
ze_t psk_len,
>         if (ret)
>                 goto out_free_digest;
>
> -       ret =3D base64_encode(digest, digest_len, enc);
> +       ret =3D base64_encode(digest, digest_len, enc, true, BASE64_STD);
>         if (ret < hmac_len) {
>                 ret =3D -ENOKEY;
>                 goto out_free_digest;
> diff --git a/include/linux/base64.h b/include/linux/base64.h
> index 660d4cb1e..a2c6c9222 100644
> --- a/include/linux/base64.h
> +++ b/include/linux/base64.h
> @@ -8,9 +8,15 @@
>
>  #include <linux/types.h>
>
> +enum base64_variant {
> +       BASE64_STD,       /* RFC 4648 (standard) */
> +       BASE64_URLSAFE,   /* RFC 4648 (base64url) */
> +       BASE64_IMAP,      /* RFC 3501 */
> +};
> +
>  #define BASE64_CHARS(nbytes)   DIV_ROUND_UP((nbytes) * 4, 3)
>
> -int base64_encode(const u8 *src, int len, char *dst);
> -int base64_decode(const char *src, int len, u8 *dst);
> +int base64_encode(const u8 *src, int len, char *dst, bool padding, enum =
base64_variant variant);
> +int base64_decode(const char *src, int len, u8 *dst, bool padding, enum =
base64_variant variant);
>
>  #endif /* _LINUX_BASE64_H */
> diff --git a/lib/base64.c b/lib/base64.c
> index b736a7a43..1af557785 100644
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
> -static const char base64_table[65] =3D
> -       "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=
";
> +static const char base64_tables[][65] =3D {
> +       [BASE64_STD] =3D "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstu=
vwxyz0123456789+/",
> +       [BASE64_URLSAFE] =3D "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopq=
rstuvwxyz0123456789-_",
> +       [BASE64_IMAP] =3D "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrst=
uvwxyz0123456789+,",
> +};
>
>  /**
> - * base64_encode() - base64-encode some binary data
> + * base64_encode() - Base64-encode some binary data
>   * @src: the binary data to encode
>   * @srclen: the length of @src in bytes
> - * @dst: (output) the base64-encoded string.  Not NUL-terminated.
> + * @dst: (output) the Base64-encoded string.  Not NUL-terminated.
> + * @padding: whether to append '=3D' padding characters
> + * @variant: which base64 variant to use
>   *
> - * Encodes data using base64 encoding, i.e. the "Base 64 Encoding" speci=
fied
> - * by RFC 4648, including the  '=3D'-padding.
> + * Encodes data using the selected Base64 variant.
>   *
> - * Return: the length of the resulting base64-encoded string in bytes.
> + * Return: the length of the resulting Base64-encoded string in bytes.
>   */
> -int base64_encode(const u8 *src, int srclen, char *dst)
> +int base64_encode(const u8 *src, int srclen, char *dst, bool padding, en=
um base64_variant variant)

Padding isn't actually implemented in this commit? That seems a bit
confusing. I think it would ideally be implemented in the same commit
that adds it. That could be before or after the commit that optimizes
the encode/decode implementations.

Best,
Caleb

>  {
>         u32 ac =3D 0;
>         int bits =3D 0;
>         int i;
>         char *cp =3D dst;
> +       const char *base64_table =3D base64_tables[variant];
>
>         for (i =3D 0; i < srclen; i++) {
>                 ac =3D (ac << 8) | src[i];
> @@ -57,25 +62,27 @@ int base64_encode(const u8 *src, int srclen, char *ds=
t)
>  EXPORT_SYMBOL_GPL(base64_encode);
>
>  /**
> - * base64_decode() - base64-decode a string
> + * base64_decode() - Base64-decode a string
>   * @src: the string to decode.  Doesn't need to be NUL-terminated.
>   * @srclen: the length of @src in bytes
>   * @dst: (output) the decoded binary data
> + * @padding: whether to append '=3D' padding characters
> + * @variant: which base64 variant to use
>   *
> - * Decodes a string using base64 encoding, i.e. the "Base 64 Encoding"
> - * specified by RFC 4648, including the  '=3D'-padding.
> + * Decodes a string using the selected Base64 variant.
>   *
>   * This implementation hasn't been optimized for performance.
>   *
>   * Return: the length of the resulting decoded binary data in bytes,
> - *        or -1 if the string isn't a valid base64 string.
> + *        or -1 if the string isn't a valid Base64 string.
>   */
> -int base64_decode(const char *src, int srclen, u8 *dst)
> +int base64_decode(const char *src, int srclen, u8 *dst, bool padding, en=
um base64_variant variant)
>  {
>         u32 ac =3D 0;
>         int bits =3D 0;
>         int i;
>         u8 *bp =3D dst;
> +       const char *base64_table =3D base64_tables[variant];
>
>         for (i =3D 0; i < srclen; i++) {
>                 const char *p =3D strchr(base64_table, src[i]);
> --
> 2.34.1
>
>

