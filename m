Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427E1CAC5B8
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 23:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MTw+KZvrDjb5UTFpK7FAxk2eU7ODCJYc2yTxNUcpgiw=; b=1EUzysw1Lim2M6tlinRfarWuCl
	X/tFjkBH+zihArnIdWFRo+oTwdpGvp31OdMqVPDdNlxqIS5eGXRq5GNgpzShTvKb3jl8b65rieAjJ
	xuyaJSNiOqxSuoJ4iX8nn0kfF73ZFLXKs1gJ3Ocm3jlNS9X37OTRF1i8bCaVHOUIC0eXtU/U9JHrV
	0XLuwPqbN0MQX1rsQWgg4AC10BZnQ3xvguen0LVWBM7Ir3Nn2jTy4wONAD5RGEuXloI/JkiABYx4K
	6l2jNbTjQuoKHQuNv3ctprDCB6TU5non8oOiLt/nju7tmFR4rEOM8QjY8a2v9xWAD+aVrrZphGcPl
	RSWPi1Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2HwR-00000005Nqh-2ziZ;
	Fri, 26 Sep 2025 23:33:31 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2HwL-00000005NoD-1MJZ
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 23:33:26 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2697051902fso5699935ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 26 Sep 2025 16:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758929604; x=1759534404; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTw+KZvrDjb5UTFpK7FAxk2eU7ODCJYc2yTxNUcpgiw=;
        b=G/6lLCxCvHxODyPimBXJv+z/AwkzgxiZp6g0aOUx/2Pj7NbnQ6I/y2AZbwhuDGgzkI
         I/tODxjymOkxFDFmpUyCE+6Ci8lwqS4LcBuXfzT1pJ11hcHa829UnIBNjFR9UiUXkD5n
         JGAIUZanNasBDb0/fr2YZ/qXUJuaP6PCHiCxwiCxq+RfC0xKkPmGArodr+8N4rzkLmRQ
         pi4lsoSztYyf21JWXF/fkUXJEy5rrHvnf9VkAJHFNqQ18JpCSgqa08SYarAqcJ0jDDm9
         1+UTVgGEe3QQlfEU/tAxkBlUwbaco1MlZNSKwba0/+KF6JfAZ7ltD7WjHWsQ2c5sFy6p
         s4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758929604; x=1759534404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTw+KZvrDjb5UTFpK7FAxk2eU7ODCJYc2yTxNUcpgiw=;
        b=vKQdEyICGUcsL1+fxeBPtV7+WA7UXQWmNMT9q91w9liLDz6+AhbSQO7ktpRtZHLkBK
         lzi1EnpvaOcvlREe4Cv91buknekTagj/QAfmrnyNqd5qBpTJv8smZElruzhN9FYpxvyk
         lv4HKyTzcZ3wOPrD/zMIhxXXaFWdHyrfuH/oWIOMuYRrhc/xt9gB2x6RbnYlzcdhct5A
         z2cxl5kSUhiMcQdQIU8p50QjDVGkrCEcdYzKIw9HjDLbwCiZSJCN09I3/wU8E628WH4X
         ERqaC87HdcFY6l/7/pD1umw4w4jInqTIWRZ+EYThMO2UPQH4pKu2pDWZ97nCdgXNxmlo
         nslA==
X-Forwarded-Encrypted: i=1; AJvYcCXSi7E9B9jQnzO8ZD11yOH5fnrYsrJrEG+SMZWKGBfiGSXLFbLosuB4ewmnhPoQBUQkRasshXfcTbSM@lists.infradead.org
X-Gm-Message-State: AOJu0Yyh4OPKZPuib/g6qjlKfZt8ERqbbpazGXfabblSXsgzjjO0FGhR
	CyOQMSL+zWO3is8xhBxid4Gi5lMKSG8NCY2NPwFOukQSOwPxfcTtvOnyJQ4ndH1T7gKu1lq+/8L
	Q7VU3hpIMscHkeDkJ0AZadk82LkCoOawxrcG807//Zw==
X-Gm-Gg: ASbGnctTpvkxb/TELrGmQUKmkbSyK+NjYPAKghd1ihbQiiiWDhUROIRapIs0MsRcL+/
	ufDzqd1MEbvZDtnhbYyL1nJd0vM6AAUEfxtcijJdm0f3Pt8O3XFxCdUSBV62CUHLcl9b28d1TFE
	xF2BdWJmX54402YAlUar/pWifdas404BF7Bjvv/yvAD0OuLXaF59EHJYmmrt0ppKuNCmPtLAMW4
	4tky2FIHMrbiu8WD7+6NdrvqTHj7opUx5bcr90O
X-Google-Smtp-Source: AGHT+IEmwasV917F/ENXUuMXNw6qnyku7SdrL3S46yOq+ltmtsWNtQZ4LiJG30MWacaYm9zGnPUEEk+jqqdkXCd8/H0=
X-Received: by 2002:a17:903:32cf:b0:269:80e2:c5a8 with SMTP id
 d9443c01a7336-27ed4a36556mr59261245ad.7.1758929603929; Fri, 26 Sep 2025
 16:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw> <20250926065556.14250-1-409411716@gms.tku.edu.tw>
In-Reply-To: <20250926065556.14250-1-409411716@gms.tku.edu.tw>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 26 Sep 2025 16:33:12 -0700
X-Gm-Features: AS18NWDAPU1wF1fnKK0roMsQSKKSRQQvsh9BWc75x2xsf5jzdJWlHk7wuynVlkw
Message-ID: <CADUfDZruZWyrsjRCs_Y5gjsbfU7dz_ALGG61pQ8qCM7K2_DjmA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with reverse
 lookup tables
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org, 
	ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com, 
	jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250926_163325_406720_93620288 
X-CRM114-Status: GOOD (  18.92  )
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
> Replace the use of strchr() in base64_decode() with precomputed reverse
> lookup tables for each variant. This avoids repeated string scans and
> improves performance. Use -1 in the tables to mark invalid characters.
>
> Decode:
>   64B   ~1530ns  ->  ~75ns    (~20.4x)
>   1KB  ~27726ns  -> ~1165ns   (~23.8x)
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> ---
>  lib/base64.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 61 insertions(+), 5 deletions(-)
>
> diff --git a/lib/base64.c b/lib/base64.c
> index 1af557785..b20fdf168 100644
> --- a/lib/base64.c
> +++ b/lib/base64.c
> @@ -21,6 +21,63 @@ static const char base64_tables[][65] =3D {
>         [BASE64_IMAP] =3D "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrst=
uvwxyz0123456789+,",
>  };
>
> +static const s8 base64_rev_tables[][256] =3D {
> +       [BASE64_STD] =3D {
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  -1, =
 -1,  -1,  63,
> +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11, =
 12,  13,  14,
> +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37, =
 38,  39,  40,
> +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +       },
> +       [BASE64_URLSAFE] =3D {
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 62,  -1,  -1,
> +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11, =
 12,  13,  14,
> +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1, =
 -1,  -1,  63,
> +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37, =
 38,  39,  40,
> +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +       },
> +       [BASE64_IMAP] =3D {
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  63, =
 -1,  -1,  -1,
> +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11, =
 12,  13,  14,
> +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37, =
 38,  39,  40,
> +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,
> +       },

Do we actually need 3 separate lookup tables? It looks like all 3
variants agree on the value of any characters they have in common. So
we could combine them into a single lookup table that would work for a
valid base64 string of any variant. The only downside I can see is
that base64 strings which are invalid in some variants might no longer
be rejected by base64_decode().

> +};
> +
>  /**
>   * base64_encode() - Base64-encode some binary data
>   * @src: the binary data to encode
> @@ -82,11 +139,9 @@ int base64_decode(const char *src, int srclen, u8 *ds=
t, bool padding, enum base6
>         int bits =3D 0;
>         int i;
>         u8 *bp =3D dst;
> -       const char *base64_table =3D base64_tables[variant];
> +       s8 ch;
>
>         for (i =3D 0; i < srclen; i++) {
> -               const char *p =3D strchr(base64_table, src[i]);
> -
>                 if (src[i] =3D=3D '=3D') {
>                         ac =3D (ac << 6);
>                         bits +=3D 6;
> @@ -94,9 +149,10 @@ int base64_decode(const char *src, int srclen, u8 *ds=
t, bool padding, enum base6
>                                 bits -=3D 8;
>                         continue;
>                 }
> -               if (p =3D=3D NULL || src[i] =3D=3D 0)
> +               ch =3D base64_rev_tables[variant][(u8)src[i]];
> +               if (ch =3D=3D -1)

Checking for < 0 can save an additional comparison here.

Best,
Caleb

>                         return -1;
> -               ac =3D (ac << 6) | (p - base64_table);
> +               ac =3D (ac << 6) | ch;
>                 bits +=3D 6;
>                 if (bits >=3D 8) {
>                         bits -=3D 8;
> --
> 2.34.1
>
>

