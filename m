Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC911CAC58E
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 15:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dcOnUF1U1PZg880W/AxFiJs+QjKGSBs0jPeBEW1iTDE=; b=wOPGE8syih6oRU/syY5oKBtIs7
	g3O1BnPAK1edYf0Ogf0boEKYz79FPCWsRucBDh2XD4i2bhfER6UnNDiiUm0gjtMEEh0DOjmOpl0rx
	Jq627OZJiOUJlPvmSopS8Li0fLq4dJ1YcOukPhzM6+rb3aNALqXAdIcFfiusPog0PzbyyhXQ/VldG
	vZ0hmskgyD0wQS4kKu5AHE884WQqNoI2QEdWYG92KTLSKQmFJAHivOZoCJm4vvmLmfD4k1/t7Se/w
	x1QvS9cEWXBZS9rOHEd/q1dqhMvIntZ9Bjwu8FuP8yUX7tJpuHjOYpudjFGvt4tRq55VVL4szCCgE
	B1wUzVGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwji1-000000043jn-2O9g;
	Thu, 11 Sep 2025 15:59:41 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwjhz-000000043hJ-0n0V
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 15:59:40 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-24b157ba91bso1361455ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757606378; x=1758211178; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcOnUF1U1PZg880W/AxFiJs+QjKGSBs0jPeBEW1iTDE=;
        b=OR3rsIHwhslZYZfOYCm3O+Fq3TKuNdvr7iFdC1pQ1lsQe1EtjaikRouurqJKyJc5V+
         0DrVxmoyr9FPYrUwSrY7PPRUV+HvMnT5oWpte4VMsk4evD5MyDGkB0+o+36PqQzknYNc
         8Vj/g2goAQlzpBaUJ5Zmi+tRMWGSFULXv0iByDY5ou66wI9ceYr8IUCIOUaZR7l/znkb
         DfB7Iw6IKcLAv+kGP+4n2rdJR0W35HdC/1t/1C0oxpD4HANw12a/MkTtm1R6r+MMbasF
         awPUi34SlJLXr/yywktld7QDtHMOTRYNOjVkg4ZOTb6quyoyyLxUBjrn4hvZ1d2FN32w
         YXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757606378; x=1758211178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcOnUF1U1PZg880W/AxFiJs+QjKGSBs0jPeBEW1iTDE=;
        b=MQg16f0Inhxf5gG5FrK+gkiYgqEM1BlMhC4C04Tfa+0xeZDTurKjwrI54L6p0A0Out
         UzVhj+MxXwaad8K63cmcLmRLgiqTQ1505WAaxMpuC/P8d3MnAnVFntMWjT/DsYi1SlCl
         791Z42wYaQWEPtElXfBuEbex+sx1j5mtFZbsuyiO2VK4i00IrLWqOSICMzrBT/hVnTxB
         f3KfHzV5C89xIDLlbZMDgrFr74cJmis7HaJKtPFetDTxaVfmWZ3GqvZOh/1mYhSMsUQL
         8naW/S9rWLc1gBA4KBQARXJHGmKx3nsN2t93vy7d23II7bF0ZNPjM4vWag1qKKgSp3LW
         Y0Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVTLFvcaEQ8AXx6EF7TNt3n2WnAINHi58r1BuGXm4699phERp1JMLI7SKFrJHNWYCU/DCrCbsfTWI4I@lists.infradead.org
X-Gm-Message-State: AOJu0Yw9F33Wr0Nw2OJGp04zymR6qny6ctXwTyT5QsL9nsDwx255Nf9Z
	C61bc5D2b/bVTx+cJGIvMb7vhVuJ4niLBMc/F0BeGNu4YlyatH8TstV1JUTEkFIhhUmTRZSG28I
	7tLF4TD28RV5mjb+wraFmwVmnd3QSmgLKRb3gU6CVOQ==
X-Gm-Gg: ASbGncv4DIld0mKxX8GJVGI8ck5lQZgOAUiFoNfzE6kN9/kVaMi9F+Owu3dX8WiEQEx
	jiggJcN92nb4bZENrYE1rEOCRoBbsr6GZhUr5fdYmo13QF/Is3NNKhiyecWzCNFtIzhcL5k8ToK
	WY9g/mHcNJ+0T4sky7ivUZFWpQ/nCalwcCaLCM+aqV8c4FBwvh10RTA61bF6pz6e8s/0wGSMK/G
	SbVBerZozGkPFFe2zEg+U8FiXEdoACrCClKdi3nzDxsoPtoh1AuCz1D5Lvc
X-Google-Smtp-Source: AGHT+IFgi3xZ2iyGah3A4pqApYs7u4F2FR8QgKMKAxLaiJqHl1jwWScgvmEohwMntLodwZUjliIOOvFHEczXP5qDVD0=
X-Received: by 2002:a17:902:ec8e:b0:24e:af92:70e0 with SMTP id
 d9443c01a7336-2516da031a3mr141475155ad.1.1757606377975; Thu, 11 Sep 2025
 08:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw> <20250911074159.656943-1-409411716@gms.tku.edu.tw>
In-Reply-To: <20250911074159.656943-1-409411716@gms.tku.edu.tw>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 11 Sep 2025 08:59:26 -0700
X-Gm-Features: Ac12FXy3YKPoYEwvmwz20U9emEECiKRnYWsVa-UrNyueRxf6yjGvOJ86ByCDIU0
Message-ID: <CADUfDZpSjONx+KcATaH+JELbQy+1fq0JVvh9tNjDgABs4rhjbA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] lib/base64: rework encoder/decoder with
 customizable support and update nvme-auth
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org, 
	ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com, 
	jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_085939_261368_64377550 
X-CRM114-Status: GOOD (  39.28  )
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

On Thu, Sep 11, 2025 at 12:43=E2=80=AFAM Guan-Chun Wu <409411716@gms.tku.ed=
u.tw> wrote:
>
> Rework base64_encode() and base64_decode() with extended interfaces
> that support custom 64-character tables and optional '=3D' padding.
> This makes them flexible enough to cover both standard RFC4648 Base64
> and non-standard variants such as base64url.
>
> The encoder is redesigned to process input in 3-byte blocks, each
> mapped directly into 4 output symbols. Base64 naturally encodes
> 24 bits of input as four 6-bit values, so operating on aligned
> 3-byte chunks matches the algorithm's structure. This block-based
> approach eliminates the need for bit-by-bit streaming, reduces shifts,
> masks, and loop iterations, and removes data-dependent branches from
> the main loop. Only the final 1 or 2 leftover bytes are handled
> separately according to the standard rules. As a result, the encoder
> achieves ~2.8x speedup for small inputs (64B) and up to ~2.6x
> speedup for larger inputs (1KB), while remaining fully RFC4648-compliant.
>
> The decoder replaces strchr()-based lookups with direct table-indexed
> mapping. It processes input in 4-character groups and supports both
> padded and non-padded forms. Validation has been strengthened: illegal
> characters and misplaced '=3D' padding now cause errors, preventing
> silent data corruption.
>
> These changes improve decoding performance by ~12-15x.
>
> Benchmarks on x86_64 (Intel Core i7-10700 @ 2.90GHz, averaged
> over 1000 runs, tested with KUnit):
>
> Encode:
>  - 64B input: avg ~90ns -> ~32ns  (~2.8x faster)
>  - 1KB input: avg ~1332ns -> ~510ns  (~2.6x faster)
>
> Decode:
>  - 64B input: avg ~1530ns -> ~122ns   (~12.5x faster)
>  - 1KB input: avg ~27726ns -> ~1859ns (~15x faster)
>
> Update nvme-auth to use the reworked base64_encode() and base64_decode()
> interfaces, which now require explicit padding and table parameters.
> A static base64_table is defined to preserve RFC4648 standard encoding
> with padding enabled, ensuring functional behavior remains unchanged.
>
> While this is a mechanical update following the lib/base64 rework,
> nvme-auth also benefits from the performance improvements in the new
> encoder/decoder, achieving faster encode/decode without altering the
> output format.
>
> The reworked encoder and decoder unify Base64 handling across the kernel
> with higher performance, stricter correctness, and flexibility to support
> subsystem-specific variants.
>
> Co-developed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Co-developed-by: Yu-Sheng Huang <home7438072@gmail.com>
> Signed-off-by: Yu-Sheng Huang <home7438072@gmail.com>
> Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> ---
>  drivers/nvme/common/auth.c |   7 +-
>  include/linux/base64.h     |   4 +-
>  lib/base64.c               | 238 ++++++++++++++++++++++++++++---------
>  3 files changed, 192 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 91e273b89..4d57694f8 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -161,6 +161,9 @@ u32 nvme_auth_key_struct_size(u32 key_len)
>  }
>  EXPORT_SYMBOL_GPL(nvme_auth_key_struct_size);
>
> +static const char base64_table[65] =3D
> +       "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=
";
> +
>  struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
>                                               u8 key_hash)
>  {
> @@ -178,7 +181,7 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigne=
d char *secret,
>         if (!key)
>                 return ERR_PTR(-ENOMEM);
>
> -       key_len =3D base64_decode(secret, allocated_len, key->key);
> +       key_len =3D base64_decode(secret, allocated_len, key->key, true, =
base64_table);
>         if (key_len < 0) {
>                 pr_debug("base64 key decoding error %d\n",
>                          key_len);
> @@ -663,7 +666,7 @@ int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, si=
ze_t psk_len,
>         if (ret)
>                 goto out_free_digest;
>
> -       ret =3D base64_encode(digest, digest_len, enc);
> +       ret =3D base64_encode(digest, digest_len, enc, true, base64_table=
);
>         if (ret < hmac_len) {
>                 ret =3D -ENOKEY;
>                 goto out_free_digest;
> diff --git a/include/linux/base64.h b/include/linux/base64.h
> index 660d4cb1e..22351323d 100644
> --- a/include/linux/base64.h
> +++ b/include/linux/base64.h
> @@ -10,7 +10,7 @@
>
>  #define BASE64_CHARS(nbytes)   DIV_ROUND_UP((nbytes) * 4, 3)
>
> -int base64_encode(const u8 *src, int len, char *dst);
> -int base64_decode(const char *src, int len, u8 *dst);
> +int base64_encode(const u8 *src, int len, char *dst, bool padding, const=
 char *table);
> +int base64_decode(const char *src, int len, u8 *dst, bool padding, const=
 char *table);
>
>  #endif /* _LINUX_BASE64_H */
> diff --git a/lib/base64.c b/lib/base64.c
> index 9416bded2..b2bd5dab5 100644
> --- a/lib/base64.c
> +++ b/lib/base64.c
> @@ -15,104 +15,236 @@
>  #include <linux/string.h>
>  #include <linux/base64.h>
>
> -static const char base64_table[65] =3D
> -       "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=
";
> +#define BASE64_6BIT_MASK      0x3f /* Mask to extract lowest 6 bits */
> +#define BASE64_BITS_PER_BYTE  8
> +#define BASE64_CHUNK_BITS     6
> +
> +/* Output-char-indexed shifts: for output chars 0,1,2,3 respectively */
> +#define BASE64_SHIFT_OUT0      (BASE64_CHUNK_BITS * 3) /* 18 */
> +#define BASE64_SHIFT_OUT1      (BASE64_CHUNK_BITS * 2) /* 12 */
> +#define BASE64_SHIFT_OUT2      (BASE64_CHUNK_BITS * 1) /* 6  */
> +/* OUT3 uses 0 shift and just masks with BASE64_6BIT_MASK */
> +
> +/* For extracting bytes from the 24-bit value (decode main loop) */
> +#define BASE64_SHIFT_BYTE0        (BASE64_BITS_PER_BYTE * 2) /* 16 */
> +#define BASE64_SHIFT_BYTE1        (BASE64_BITS_PER_BYTE * 1) /* 8  */
> +
> +/* Tail (no padding) shifts to extract bytes */
> +#define BASE64_TAIL2_BYTE0_SHIFT  ((BASE64_CHUNK_BITS * 2) - BASE64_BITS=
_PER_BYTE)       /* 4  */
> +#define BASE64_TAIL3_BYTE0_SHIFT  ((BASE64_CHUNK_BITS * 3) - BASE64_BITS=
_PER_BYTE)       /* 10 */
> +#define BASE64_TAIL3_BYTE1_SHIFT  ((BASE64_CHUNK_BITS * 3) - (BASE64_BIT=
S_PER_BYTE * 2)) /* 2  */
> +
> +/* Extra: masks for leftover validation (no padding) */
> +#define BASE64_MASK(n) ({        \
> +       unsigned int __n =3D (n);  \
> +       __n ? ((1U << __n) - 1U) : 0U; \
> +})
> +#define BASE64_TAIL2_UNUSED_BITS  (BASE64_CHUNK_BITS * 2 - BASE64_BITS_P=
ER_BYTE)     /* 4 */
> +#define BASE64_TAIL3_UNUSED_BITS  (BASE64_CHUNK_BITS * 3 - BASE64_BITS_P=
ER_BYTE * 2) /* 2 */
>
>  static inline const char *find_chr(const char *base64_table, char ch)
>  {
>         if ('A' <=3D ch && ch <=3D 'Z')
> -               return base64_table + ch - 'A';
> +               return base64_table + (ch - 'A');
>         if ('a' <=3D ch && ch <=3D 'z')
> -               return base64_table + 26 + ch - 'a';
> +               return base64_table + 26 + (ch - 'a');
>         if ('0' <=3D ch && ch <=3D '9')
> -               return base64_table + 26 * 2 + ch - '0';
> -       if (ch =3D=3D base64_table[26 * 2 + 10])
> -               return base64_table + 26 * 2 + 10;
> -       if (ch =3D=3D base64_table[26 * 2 + 10 + 1])
> -               return base64_table + 26 * 2 + 10 + 1;
> +               return base64_table + 52 + (ch - '0');
> +       if (ch =3D=3D base64_table[62])
> +               return &base64_table[62];
> +       if (ch =3D=3D base64_table[63])
> +               return &base64_table[63];

All the changes in this function look cosmetic. Could you fold them
into the patch that introduced the function to avoid touching the
lines multiple times?

Best,
Caleb

>         return NULL;
>  }
>
>  /**
> - * base64_encode() - base64-encode some binary data
> + * base64_encode() - base64-encode with custom table and optional paddin=
g
>   * @src: the binary data to encode
>   * @srclen: the length of @src in bytes
> - * @dst: (output) the base64-encoded string.  Not NUL-terminated.
> + * @dst: (output) the base64-encoded string. Not NUL-terminated.
> + * @padding: whether to append '=3D' characters so output length is a mu=
ltiple of 4
> + * @table: 64-character encoding table to use (e.g. standard or URL-safe=
 variant)
>   *
> - * Encodes data using base64 encoding, i.e. the "Base 64 Encoding" speci=
fied
> - * by RFC 4648, including the  '=3D'-padding.
> + * Encodes data using the given 64-character @table. If @padding is true=
,
> + * the output is padded with '=3D' as described in RFC 4648; otherwise p=
adding
> + * is omitted. This allows generation of both standard and non-standard
> + * Base64 variants (e.g. URL-safe encoding).
>   *
>   * Return: the length of the resulting base64-encoded string in bytes.
>   */
> -int base64_encode(const u8 *src, int srclen, char *dst)
> +int base64_encode(const u8 *src, int srclen, char *dst, bool padding, co=
nst char *table)
>  {
>         u32 ac =3D 0;
> -       int bits =3D 0;
> -       int i;
>         char *cp =3D dst;
>
> -       for (i =3D 0; i < srclen; i++) {
> -               ac =3D (ac << 8) | src[i];
> -               bits +=3D 8;
> -               do {
> -                       bits -=3D 6;
> -                       *cp++ =3D base64_table[(ac >> bits) & 0x3f];
> -               } while (bits >=3D 6);
> -       }
> -       if (bits) {
> -               *cp++ =3D base64_table[(ac << (6 - bits)) & 0x3f];
> -               bits -=3D 6;
> +       while (srclen >=3D 3) {
> +               ac =3D ((u32)src[0] << (BASE64_BITS_PER_BYTE * 2)) |
> +                        ((u32)src[1] << (BASE64_BITS_PER_BYTE)) |
> +                        (u32)src[2];
> +
> +               *cp++ =3D table[ac >> BASE64_SHIFT_OUT0];
> +               *cp++ =3D table[(ac >> BASE64_SHIFT_OUT1) & BASE64_6BIT_M=
ASK];
> +               *cp++ =3D table[(ac >> BASE64_SHIFT_OUT2) & BASE64_6BIT_M=
ASK];
> +               *cp++ =3D table[ac & BASE64_6BIT_MASK];
> +
> +               src +=3D 3;
> +               srclen -=3D 3;
>         }
> -       while (bits < 0) {
> -               *cp++ =3D '=3D';
> -               bits +=3D 2;
> +
> +       switch (srclen) {
> +       case 2:
> +               ac =3D ((u32)src[0] << (BASE64_BITS_PER_BYTE * 2)) |
> +                    ((u32)src[1] << (BASE64_BITS_PER_BYTE));
> +
> +               *cp++ =3D table[ac >> BASE64_SHIFT_OUT0];
> +               *cp++ =3D table[(ac >> BASE64_SHIFT_OUT1) & BASE64_6BIT_M=
ASK];
> +               *cp++ =3D table[(ac >> BASE64_SHIFT_OUT2) & BASE64_6BIT_M=
ASK];
> +               if (padding)
> +                       *cp++ =3D '=3D';
> +               break;
> +       case 1:
> +               ac =3D ((u32)src[0] << (BASE64_BITS_PER_BYTE * 2));
> +               *cp++ =3D table[ac >> BASE64_SHIFT_OUT0];
> +               *cp++ =3D table[(ac >> BASE64_SHIFT_OUT1) & BASE64_6BIT_M=
ASK];
> +               if (padding) {
> +                       *cp++ =3D '=3D';
> +                       *cp++ =3D '=3D';
> +               }
> +               break;
>         }
>         return cp - dst;
>  }
>  EXPORT_SYMBOL_GPL(base64_encode);
>
>  /**
> - * base64_decode() - base64-decode a string
> + * base64_decode() - base64-decode with custom table and optional paddin=
g
>   * @src: the string to decode.  Doesn't need to be NUL-terminated.
>   * @srclen: the length of @src in bytes
>   * @dst: (output) the decoded binary data
> + * @padding: when true, accept and handle '=3D' padding as per RFC 4648;
> + *           when false, '=3D' is treated as invalid
> + * @table: 64-character encoding table to use (e.g. standard or URL-safe=
 variant)
>   *
> - * Decodes a string using base64 encoding, i.e. the "Base 64 Encoding"
> - * specified by RFC 4648, including the  '=3D'-padding.
> + * Decodes a string using the given 64-character @table. If @padding is =
true,
> + * '=3D' padding is accepted as described in RFC 4648; otherwise '=3D' i=
s
> + * treated as an error. This allows decoding of both standard and
> + * non-standard Base64 variants (e.g. URL-safe decoding).
>   *
>   * This implementation hasn't been optimized for performance.
>   *
>   * Return: the length of the resulting decoded binary data in bytes,
>   *        or -1 if the string isn't a valid base64 string.
>   */
> -int base64_decode(const char *src, int srclen, u8 *dst)
> +static inline int base64_decode_table(char ch, const char *table)
> +{
> +       if (ch =3D=3D '\0')
> +               return -1;
> +       const char *p =3D find_chr(table, ch);
> +
> +       return p ? (p - table) : -1;
> +}
> +
> +static inline int decode_base64_block(const char *src, const char *table=
,
> +                                     int *input1, int *input2,
> +                                     int *input3, int *input4,
> +                                     bool padding)
> +{
> +       *input1 =3D base64_decode_table(src[0], table);
> +       *input2 =3D base64_decode_table(src[1], table);
> +       *input3 =3D base64_decode_table(src[2], table);
> +       *input4 =3D base64_decode_table(src[3], table);
> +
> +       /* Return error if any base64 character is invalid */
> +       if (*input1 < 0 || *input2 < 0 || (!padding && (*input3 < 0 || *i=
nput4 < 0)))
> +               return -1;
> +
> +       /* Handle padding */
> +       if (padding) {
> +               if (*input3 < 0 && *input4 >=3D 0)
> +                       return -1;
> +               if (*input3 < 0 && src[2] !=3D '=3D')
> +                       return -1;
> +               if (*input4 < 0 && src[3] !=3D '=3D')
> +                       return -1;
> +       }
> +       return 0;
> +}
> +
> +int base64_decode(const char *src, int srclen, u8 *dst, bool padding, co=
nst char *table)
>  {
> -       u32 ac =3D 0;
> -       int bits =3D 0;
> -       int i;
>         u8 *bp =3D dst;
> +       int input1, input2, input3, input4;
> +       u32 val;
>
> -       for (i =3D 0; i < srclen; i++) {
> -               const char *p =3D find_chr(base64_table, src[i]);
> +       if (srclen =3D=3D 0)
> +               return 0;
>
> -               if (src[i] =3D=3D '=3D') {
> -                       ac =3D (ac << 6);
> -                       bits +=3D 6;
> -                       if (bits >=3D 8)
> -                               bits -=3D 8;
> -                       continue;
> +       /* Validate the input length for padding */
> +       if (padding && (srclen & 0x03) !=3D 0)
> +               return -1;
> +
> +       while (srclen >=3D 4) {
> +               /* Decode the next 4 characters */
> +               if (decode_base64_block(src, table, &input1, &input2, &in=
put3,
> +                                       &input4, padding) < 0)
> +                       return -1;
> +               if (padding && srclen > 4) {
> +                       if (input3 < 0 || input4 < 0)
> +                               return -1;
>                 }
> -               if (p =3D=3D NULL || src[i] =3D=3D 0)
> +               val =3D ((u32)input1 << BASE64_SHIFT_OUT0) |
> +                     ((u32)input2 << BASE64_SHIFT_OUT1) |
> +                     ((u32)((input3 < 0) ? 0 : input3) << BASE64_SHIFT_O=
UT2) |
> +                     (u32)((input4 < 0) ? 0 : input4);
> +
> +               *bp++ =3D (u8)(val >> BASE64_SHIFT_BYTE0);
> +
> +               if (input3 >=3D 0)
> +                       *bp++ =3D (u8)(val >> BASE64_SHIFT_BYTE1);
> +               if (input4 >=3D 0)
> +                       *bp++ =3D (u8)val;
> +
> +               src +=3D 4;
> +               srclen -=3D 4;
> +       }
> +
> +       /* Handle leftover characters when padding is not used */
> +       if (!padding && srclen > 0) {
> +               switch (srclen) {
> +               case 2:
> +                       input1 =3D base64_decode_table(src[0], table);
> +                       input2 =3D base64_decode_table(src[1], table);
> +                       if (input1 < 0 || input2 < 0)
> +                               return -1;
> +
> +                       val =3D ((u32)input1 << BASE64_CHUNK_BITS) | (u32=
)input2; /* 12 bits */
> +                       if (val & BASE64_MASK(BASE64_TAIL2_UNUSED_BITS))
> +                               return -1; /* low 4 bits must be zero */
> +
> +                       *bp++ =3D (u8)(val >> BASE64_TAIL2_BYTE0_SHIFT);
> +                       break;
> +               case 3:
> +                       input1 =3D base64_decode_table(src[0], table);
> +                       input2 =3D base64_decode_table(src[1], table);
> +                       input3 =3D base64_decode_table(src[2], table);
> +                       if (input1 < 0 || input2 < 0 || input3 < 0)
> +                               return -1;
> +
> +                       val =3D ((u32)input1 << (BASE64_CHUNK_BITS * 2)) =
|
> +                             ((u32)input2 << BASE64_CHUNK_BITS) |
> +                             (u32)input3; /* 18 bits */
> +
> +                       if (val & BASE64_MASK(BASE64_TAIL3_UNUSED_BITS))
> +                               return -1; /* low 2 bits must be zero */
> +
> +                       *bp++ =3D (u8)(val >> BASE64_TAIL3_BYTE0_SHIFT);
> +                       *bp++ =3D (u8)((val >> BASE64_TAIL3_BYTE1_SHIFT) =
& 0xFF);
> +                       break;
> +               default:
>                         return -1;
> -               ac =3D (ac << 6) | (p - base64_table);
> -               bits +=3D 6;
> -               if (bits >=3D 8) {
> -                       bits -=3D 8;
> -                       *bp++ =3D (u8)(ac >> bits);
>                 }
>         }
> -       if (ac & ((1 << bits) - 1))
> -               return -1;
> +
>         return bp - dst;
>  }
>  EXPORT_SYMBOL_GPL(base64_decode);
> --
> 2.34.1
>
>

