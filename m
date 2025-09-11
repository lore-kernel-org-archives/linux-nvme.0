Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D21CAC592
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 15:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sm39d5NFqL/jKxwzJUkYjs0RqtR2b1iX+TUT2ANp2Xo=; b=wPOEMGL5/iPiB3C2TbmzHVTp5z
	csNOWH/mqYnnW9jX2NyK0QEQl9Yv8qEceEDeOOKuQQ7IXuvBfnINLnuEEN30TGctyk+XtnZuDpJYs
	+rZcHKLJltFdqtDXK3qIdHfgnnFxKPjd3t5HXTnC1LtyCiWbWD1lS+2RdZm+g0zwiFe2GPWiw3TJG
	9OH8uFx1cT7N1DS3l8J28mpwi5pXOTRybrXMNC4X2QTqdyzmtFw4yahOxCp7rKiSsftBpDNcy7/O2
	C0qW/VAYzPH+CFIZPhKCBJQFNINZEhWkLvjtIkUKdlUpdoKy1k5G1uD2miqpPQiilKOsUtb1/D+gj
	U/RA850g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwjZ5-00000003zzm-2dgG;
	Thu, 11 Sep 2025 15:50:27 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwjZ3-00000003zyF-1GJ0
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 15:50:26 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-24cda620e37so1461935ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 08:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757605824; x=1758210624; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sm39d5NFqL/jKxwzJUkYjs0RqtR2b1iX+TUT2ANp2Xo=;
        b=ODNg5zMD7C195iOb/lMfdIUVC984SNw2v+N7X/kOXXnmDkZUGzrcLAzmaUZzzYWtrI
         4dMh9z3EqsTXe4BA5weaqwttrDUXT6GgDngjbC/VwaxDatBsxOAxY7IN4bVg8x9ayuZ8
         R5GjI9VY/PIFPU8fhDQZkvQJhdM5A95Ptz6QD3gKVHnqQGqTbMMKvnUvJr2hzw1Z7jCc
         C/MUfYxiHUbMYATQvus9RVpDFb7sQ3lN5SE0u1ZOPiZFY4VAQdAsjK9PrjvvvX0636pi
         ZSlSOz+09sGDDS2ECuZpX43oN2nWuywcXrI/V1Oc3FodzdAYy+Yu5j0INpVLfV9vmLIZ
         Xx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757605824; x=1758210624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sm39d5NFqL/jKxwzJUkYjs0RqtR2b1iX+TUT2ANp2Xo=;
        b=QKTOfXZPr8sV/DKzt/9Ehe4VhKu8M3OZsCoS5+utSD+EKKlOApLOXZXfi7eZ8F+opG
         SIFxSkRsenQO093xbPcM6xvwFzjhTBBywKtHPpgJzYZyAW3dIuMdXWuG2H2LEXyGlxqf
         Yf2IGtUSjqW9rx/eUNL/TbRxyyORtjDAXC+GhaP03aGVqjfX+lWEbl86sQFuWxD4VVfv
         bbOLpBfEHUKDzygxFmXw1A9vcyX4l+B7+cYFRt+lfdvORirhlU0e1AmsoK5d28VLGuzk
         mIxpnWr8mZJxlvJ5uO6y0Nye4EQvCg5hOVOmPVNvetaWlqfSVQhXGwh4j5022hD88pVK
         X2uw==
X-Forwarded-Encrypted: i=1; AJvYcCWi79a2Uwzh2u9EZfZX93wY0ZjU6dcDFd0i1qjNU8/WdIUvAZYvwP+zA+zN1s73KVduRJEENzLqGQTX@lists.infradead.org
X-Gm-Message-State: AOJu0YzcDD7ZU1IZzeybNF5Ec6TF9p+2Y1nZ2OWwL9DW/zw1vlSVjFnu
	39pu6tDlDqnpShxdFt8tlvJ6PDzI90XSVQta1+exf254390dDdq6f77ixuK0A/gbexlKLP7Y9d4
	aeOyHtBC9fZLKDLzRvHKH5wzr7LKhCblbmaG8lMJqEw==
X-Gm-Gg: ASbGncsRT63i2jBrwwXCciLxZzuF8hvdOYE2F/E38VlibhqT3FdxVNcJctBsBGcZIdX
	a7w9FKelAMdUo+xVNJRtgk47U4KvQLhkRNqBJqI6kZ89V0racRX6tC4mPp/w3cTkxOY+7/YP/n2
	FKYDbzyUX+biqhqYIWpafwUP+4CpjsxU87PtvmW8nOWQQ7h+Cw+Z4vS+6LfcwDwSujVJvnXSnJv
	LjbdJhNjmWvc0+z9wArKIYbKSfL0SXFCfaVCHo=
X-Google-Smtp-Source: AGHT+IHeD3ijdPFv6sWC+2qqn5ewuQ4r5M61SalEw+nEx55NKT7Qlty/iU0ChnsPVabDot6LaASoCZDlZs00KT1RgN0=
X-Received: by 2002:a17:902:ec8e:b0:24d:15b7:1fa4 with SMTP id
 d9443c01a7336-2517653b663mr140062445ad.10.1757605824176; Thu, 11 Sep 2025
 08:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw> <20250911073204.574742-1-409411716@gms.tku.edu.tw>
In-Reply-To: <20250911073204.574742-1-409411716@gms.tku.edu.tw>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 11 Sep 2025 08:50:12 -0700
X-Gm-Features: Ac12FXwoL045SNoj1J2Tk9bFEh24Fjp_N53zMjtCDhxT-Fzyr-6A0W4BpkqjnRk
Message-ID: <CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better performance
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org, 
	ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com, 
	jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_085025_390108_A684EAAD 
X-CRM114-Status: GOOD (  22.63  )
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

On Thu, Sep 11, 2025 at 12:33=E2=80=AFAM Guan-Chun Wu <409411716@gms.tku.ed=
u.tw> wrote:
>
> From: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> The base64 decoder previously relied on strchr() to locate each
> character in the base64 table. In the worst case, this requires
> scanning all 64 entries, and even with bitwise tricks or word-sized
> comparisons, still needs up to 8 checks.
>
> Introduce a small helper function that maps input characters directly
> to their position in the base64 table. This reduces the maximum number
> of comparisons to 5, improving decoding efficiency while keeping the
> logic straightforward.
>
> Benchmarks on x86_64 (Intel Core i7-10700 @ 2.90GHz, averaged
> over 1000 runs, tested with KUnit):
>
> Decode:
>  - 64B input: avg ~1530ns -> ~126ns (~12x faster)
>  - 1KB input: avg ~27726ns -> ~2003ns (~14x faster)
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> ---
>  lib/base64.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/lib/base64.c b/lib/base64.c
> index b736a7a43..9416bded2 100644
> --- a/lib/base64.c
> +++ b/lib/base64.c
> @@ -18,6 +18,21 @@
>  static const char base64_table[65] =3D
>         "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=
";

Does base64_table still need to be NUL-terminated?

>
> +static inline const char *find_chr(const char *base64_table, char ch)

Don't see a need to pass in base64_table, the function could just
access the global variable directly.

> +{
> +       if ('A' <=3D ch && ch <=3D 'Z')
> +               return base64_table + ch - 'A';
> +       if ('a' <=3D ch && ch <=3D 'z')
> +               return base64_table + 26 + ch - 'a';
> +       if ('0' <=3D ch && ch <=3D '9')
> +               return base64_table + 26 * 2 + ch - '0';
> +       if (ch =3D=3D base64_table[26 * 2 + 10])
> +               return base64_table + 26 * 2 + 10;
> +       if (ch =3D=3D base64_table[26 * 2 + 10 + 1])
> +               return base64_table + 26 * 2 + 10 + 1;
> +       return NULL;

This is still pretty branchy. One way to avoid the branches would be
to define a reverse lookup table mapping base64 chars to their values
(or a sentinel value for invalid chars). Have you benchmarked that
approach?

Best,
Caleb

> +}
> +
>  /**
>   * base64_encode() - base64-encode some binary data
>   * @src: the binary data to encode
> @@ -78,7 +93,7 @@ int base64_decode(const char *src, int srclen, u8 *dst)
>         u8 *bp =3D dst;
>
>         for (i =3D 0; i < srclen; i++) {
> -               const char *p =3D strchr(base64_table, src[i]);
> +               const char *p =3D find_chr(base64_table, src[i]);
>
>                 if (src[i] =3D=3D '=3D') {
>                         ac =3D (ac << 6);
> --
> 2.34.1
>
>

