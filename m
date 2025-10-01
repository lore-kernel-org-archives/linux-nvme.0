Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E59BCCA470
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 00:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4DSU3acyqxN1lYkbp2Gqvkb9p2L/gX/8eplXEY/yyd0=; b=J2HKfuDre0mEDNvQCVWBtr2SlT
	+zZMtr+9iMTsKLcYqfbeCMYuy9TezoRsxFTpA0Wv0TjU8EnLId/YRklkUbAYAC8boJC6AqFMNLG4X
	WU42UPtkgc7+J87GdO8d8yeNS4KC2MG0MLLmr9g8B1yfZ79G3wmCo9bkCLakUFvEn0q7kj2did+jr
	psifI881jhlIa5fmn+uwFV1RCN89BtQ3bSw/XXfvbrctkLUrKXz9x/SE0nIaiJMMAVlskYYgdwduX
	CFHulTD9zuMvEq4EOK0ErIXzQC7ivfMlw+tDQ4h7wMCVmY1EXxNS/eEgzCbBKQMut3SqCVQhMBkR6
	3RQtko0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3kRL-00000006QM6-3hb0;
	Wed, 01 Oct 2025 00:11:27 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3kRI-00000006QLF-3vHC
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 00:11:26 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3307e8979f2so1159633a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 30 Sep 2025 17:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1759277484; x=1759882284; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DSU3acyqxN1lYkbp2Gqvkb9p2L/gX/8eplXEY/yyd0=;
        b=MZoHZz3tKDcf2poKQwR7z8cxw9BqEMrVaJyIsZ5CvQH0Fg4G5BW+8l0otQEXggAEYz
         bRTkI+dX0gUj6QyqMNjUsLeZC3TZtBBH0zVETVJnsXnTDrlOv8I86Wfau22TNIsF2JcC
         ti26UHzSUhqtN+mUPkvmT+4a8f8UJg7Dk85V2HfdQ25EXbFChi7CLeoveBMnX5ij2XeN
         hDsT7+KNqltQ9LaRGu7f9UQ3OrmTi1LKry2s05D28iNMOSOmEQENtVXW3DhC0QPXfObV
         ttFsYegXSadkaVSQktYjub4ih2Upg+A4qFpRZtbSKsdUnD5WFD6h+3oKSx2XCP9CGcrv
         C1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759277484; x=1759882284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DSU3acyqxN1lYkbp2Gqvkb9p2L/gX/8eplXEY/yyd0=;
        b=ClACE4PSYVnZuWTHvZwColRfFSJRfVGIqiTDMSotVOL/lpADMLjXA/w4VLD/7CgF5j
         mAt3VNT3G0Z3pWpakAJADlUMK1vDLhW0NNti5Ez5h3xzU/DY22YPuvckgJlU7lS+DIb9
         fnvlLsceH3KuA8KZsiUq3e4jXSw7YmbASco52Z1eO1M80L7+Yj3xp0lHHZWsSOCM49Cj
         LN0Rt5fxT/1bvdA8HJt6wlrpZYrETk+mWNxhzQUCBPJsQ3gbVbt7qFEghx03P4wlwCwV
         dJrbcpao/f22pnWMnJ689DuRjBV88Yz1/yU7ay5TTXpx4Bk/DEnqlQynl6g3ea3fhdFu
         acyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpLgtfcnpkGGZyXY1/wmjmVGNr6yUX4Uwfo1eNMMYQypG2Rr8z1n43i+6lgJGuxoQP1xEoAr6HoISb@lists.infradead.org
X-Gm-Message-State: AOJu0YwZpOoU7bKaA7Jd6or/JNouOdfEjXjtQvTORfSij0yCqYEHE7DT
	AyDaODkEGIaR199MhKEfwmr8ya+VsXY0Cf+Nfw5D1RqcG2MvDHGCpHe6Y8ZffX8SUaVeSWi82Lk
	RlPGMN3PwSpzCUVUAjf3zqanHNNplhTz0kffAWkkvNQ==
X-Gm-Gg: ASbGncsE9MmUvkh8qtI4LPsR3cCa3rUfESoEIh1UDRTH0UGhg3eAxZL1Oxiq8TgSntd
	xuxGTRNLC/bmDCyZeJPbiXix5m7jQl7R+/0aeSR6YntpqFrhWJoisedyS4MtYUe3utyJxgev/LY
	uTT79ErxHyuS56dWRiauixdEhAI4oIOv0tSuJ+RHH5PqnlV3BZW2a6hHi1lIRGcwKMYxvkTmHlz
	shPwakqlCavur1uh9WiZAy7TJT02d+MARSZkT2NfXryadjzooEGmM5SeJJlvW0a
X-Google-Smtp-Source: AGHT+IH3GE/DZ3MSHAOXxAHWgBR+LMCCV37xzgvUOEqpCJDrI3crv9C/h9WRhJLTqZyHasjKOWfldDQut/rNgNRPZ0k=
X-Received: by 2002:a17:902:d4cb:b0:25c:b66e:9c2a with SMTP id
 d9443c01a7336-28e7f2fa9b7mr11054465ad.6.1759277483763; Tue, 30 Sep 2025
 17:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw> <20250926065617.14361-1-409411716@gms.tku.edu.tw>
In-Reply-To: <20250926065617.14361-1-409411716@gms.tku.edu.tw>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 30 Sep 2025 17:11:12 -0700
X-Gm-Features: AS18NWBvBb_ZPhcEO5KRhrM9SZABPhK814Z1fs3a4G2IOurdkxPcQ3z475xIaJo
Message-ID: <CADUfDZpu=rK4WwSmhNgxHQd2zeNvn8a7TmKCYuTL5T7dZ0x_4A@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] lib/base64: rework encode/decode for speed and
 stricter validation
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org, 
	ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com, 
	jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_171125_022027_29F0D070 
X-CRM114-Status: GOOD (  35.50  )
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

On Fri, Sep 26, 2025 at 12:01=E2=80=AFAM Guan-Chun Wu <409411716@gms.tku.ed=
u.tw> wrote:
>
> The old base64 implementation relied on a bit-accumulator loop, which was
> slow for larger inputs and too permissive in validation. It would accept
> extra '=3D', missing '=3D', or even '=3D' appearing in the middle of the =
input,
> allowing malformed strings to pass. This patch reworks the internals to
> improve performance and enforce stricter validation.
>
> Changes:
>  - Encoder:
>    * Process input in 3-byte blocks, mapping 24 bits into four 6-bit
>      symbols, avoiding bit-by-bit shifting and reducing loop iterations.
>    * Handle the final 1-2 leftover bytes explicitly and emit '=3D' only w=
hen
>      requested.
>  - Decoder:
>    * Based on the reverse lookup tables from the previous patch, decode
>      input in 4-character groups.
>    * Each group is looked up directly, converted into numeric values, and
>      combined into 3 output bytes.
>    * Explicitly handle padded and unpadded forms:
>       - With padding: input length must be a multiple of 4, and '=3D' is
>         allowed only in the last two positions. Reject stray or early '=
=3D'.
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
>   64B  ~1530ns  -> ~64ns   (~23.9x)
>   1KB ~27726ns  -> ~982ns  (~28.3x)
>
> Co-developed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Co-developed-by: Yu-Sheng Huang <home7438072@gmail.com>
> Signed-off-by: Yu-Sheng Huang <home7438072@gmail.com>
> Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> ---
>  lib/base64.c | 150 +++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 110 insertions(+), 40 deletions(-)
>
> diff --git a/lib/base64.c b/lib/base64.c
> index b20fdf168..fd1db4611 100644
> --- a/lib/base64.c
> +++ b/lib/base64.c
> @@ -93,26 +93,43 @@ static const s8 base64_rev_tables[][256] =3D {
>  int base64_encode(const u8 *src, int srclen, char *dst, bool padding, en=
um base64_variant variant)
>  {
>         u32 ac =3D 0;
> -       int bits =3D 0;
> -       int i;
>         char *cp =3D dst;
>         const char *base64_table =3D base64_tables[variant];
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
> +               ac =3D ((u32)src[0] << 16) |
> +                        ((u32)src[1] << 8) |
> +                        (u32)src[2];
> +
> +               *cp++ =3D base64_table[ac >> 18];
> +               *cp++ =3D base64_table[(ac >> 12) & 0x3f];
> +               *cp++ =3D base64_table[(ac >> 6) & 0x3f];
> +               *cp++ =3D base64_table[ac & 0x3f];
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
> +               ac =3D ((u32)src[0] << 16) |
> +                    ((u32)src[1] << 8);
> +
> +               *cp++ =3D base64_table[ac >> 18];
> +               *cp++ =3D base64_table[(ac >> 12) & 0x3f];
> +               *cp++ =3D base64_table[(ac >> 6) & 0x3f];
> +               if (padding)
> +                       *cp++ =3D '=3D';
> +               break;
> +       case 1:
> +               ac =3D ((u32)src[0] << 16);
> +               *cp++ =3D base64_table[ac >> 18];
> +               *cp++ =3D base64_table[(ac >> 12) & 0x3f];
> +               if (padding) {
> +                       *cp++ =3D '=3D';
> +                       *cp++ =3D '=3D';
> +               }
> +               break;
>         }
>         return cp - dst;
>  }
> @@ -128,39 +145,92 @@ EXPORT_SYMBOL_GPL(base64_encode);
>   *
>   * Decodes a string using the selected Base64 variant.
>   *
> - * This implementation hasn't been optimized for performance.
> - *
>   * Return: the length of the resulting decoded binary data in bytes,
>   *        or -1 if the string isn't a valid Base64 string.
>   */
>  int base64_decode(const char *src, int srclen, u8 *dst, bool padding, en=
um base64_variant variant)
>  {
> -       u32 ac =3D 0;
> -       int bits =3D 0;
> -       int i;
>         u8 *bp =3D dst;
> -       s8 ch;
> -
> -       for (i =3D 0; i < srclen; i++) {
> -               if (src[i] =3D=3D '=3D') {
> -                       ac =3D (ac << 6);
> -                       bits +=3D 6;
> -                       if (bits >=3D 8)
> -                               bits -=3D 8;
> -                       continue;
> -               }
> -               ch =3D base64_rev_tables[variant][(u8)src[i]];
> -               if (ch =3D=3D -1)
> +       s8 input1, input2, input3, input4;
> +       u32 val;
> +
> +       if (srclen =3D=3D 0)
> +               return 0;

Doesn't look like this special case is necessary; all the if and while
conditions below are false if srclen =3D=3D 0, so the function will just
end up returning 0 in that case anyways. It would be nice to avoid
this branch, especially as it seems like an uncommon case.

> +
> +       /* Validate the input length for padding */
> +       if (unlikely(padding && (srclen & 0x03) !=3D 0))
> +               return -1;
> +
> +       while (srclen >=3D 4) {
> +               /* Decode the next 4 characters */
> +               input1 =3D base64_rev_tables[variant][(u8)src[0]];
> +               input2 =3D base64_rev_tables[variant][(u8)src[1]];
> +               input3 =3D base64_rev_tables[variant][(u8)src[2]];
> +               input4 =3D base64_rev_tables[variant][(u8)src[3]];
> +
> +               /* Return error if any Base64 character is invalid */
> +               if (unlikely(input1 < 0 || input2 < 0 || (!padding && (in=
put3 < 0 || input4 < 0))))
> +                       return -1;
> +
> +               /* Handle padding */
> +               if (unlikely(padding && ((input3 < 0 && input4 >=3D 0) ||
> +                                        (input3 < 0 && src[2] !=3D '=3D'=
) ||
> +                                        (input4 < 0 && src[3] !=3D '=3D'=
) ||
> +                                        (srclen > 4 && (input3 < 0 || in=
put4 < 0)))))

Would be preferable to check and strip the padding (i.e. decrease
srclen) before this main loop. That way we could avoid several
branches in this hot loop that are only necessary to handle the
padding chars.

> +                       return -1;
> +               val =3D ((u32)input1 << 18) |
> +                     ((u32)input2 << 12) |
> +                     ((u32)((input3 < 0) ? 0 : input3) << 6) |
> +                     (u32)((input4 < 0) ? 0 : input4);
> +
> +               *bp++ =3D (u8)(val >> 16);
> +
> +               if (input3 >=3D 0)
> +                       *bp++ =3D (u8)(val >> 8);
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
> +                       input1 =3D base64_rev_tables[variant][(u8)src[0]]=
;
> +                       input2 =3D base64_rev_tables[variant][(u8)src[1]]=
;
> +                       if (unlikely(input1 < 0 || input2 < 0))
> +                               return -1;
> +
> +                       val =3D ((u32)input1 << 6) | (u32)input2; /* 12 b=
its */
> +                       if (unlikely(val & 0x0F))
> +                               return -1; /* low 4 bits must be zero */
> +
> +                       *bp++ =3D (u8)(val >> 4);
> +                       break;
> +               case 3:
> +                       input1 =3D base64_rev_tables[variant][(u8)src[0]]=
;
> +                       input2 =3D base64_rev_tables[variant][(u8)src[1]]=
;
> +                       input3 =3D base64_rev_tables[variant][(u8)src[2]]=
;
> +                       if (unlikely(input1 < 0 || input2 < 0 || input3 <=
 0))
> +                               return -1;
> +
> +                       val =3D ((u32)input1 << 12) |
> +                             ((u32)input2 << 6) |
> +                             (u32)input3; /* 18 bits */
> +
> +                       if (unlikely(val & 0x03))
> +                               return -1; /* low 2 bits must be zero */
> +
> +                       *bp++ =3D (u8)(val >> 10);
> +                       *bp++ =3D (u8)((val >> 2) & 0xFF);

"& 0xFF" is redundant with the cast to u8.

Best,
Caleb

> +                       break;
> +               default:
>                         return -1;
> -               ac =3D (ac << 6) | ch;
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

