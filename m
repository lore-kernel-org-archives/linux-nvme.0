Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B773CCA470
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EI/Oh8/PCAXf06I9PHPDwi4/0WefIWbrMGoTUuWrnBM=; b=E5UdM4WJ3hjhx4G3bw2rtlBDCe
	0r/7xAEV7PHP+gL82mHQQAXoVY/SGKLc2A8uek6KlbxaTuz4MyE5OMF0E4ppmWL0HoRLmVOp44SWz
	W1vJFxGzdn3UQUadfg45jo/zLPEJDObFyxalxSPla7gqcR73S7gb0gM1rIwc+vEJIUKB6SG5Xx1mP
	ctEa/cF9CfxwSLavsB+TENFzXgpglMTVWBp6gwSRlG6qefzbX1Ip5hzT+HT6lfruQ71X8FAkMbszC
	LJHIFuO7dsDgWxb9MUuRomuZbcDJbp9jbgbmUxg/WdCcsAiq2k+WJGrf1vbXsqP/ZHcVovfLNi//x
	5nmQJC2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3zZK-00000008VcS-3h1N;
	Wed, 01 Oct 2025 16:20:42 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3zZI-00000008Vbv-2HZC
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 16:20:41 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2697051902fso15135925ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 01 Oct 2025 09:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1759335640; x=1759940440; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EI/Oh8/PCAXf06I9PHPDwi4/0WefIWbrMGoTUuWrnBM=;
        b=Lry5YXg4seuiAB9jnERG1ztEAiTd8qxeNi5G3xZANTJn5B8XnTFMru3JV5lhmrzvwX
         IzNkoFHVynh3w2BOrasaOCQ6S7g2JIctGWRiIZ/sderi5PVRpS8rjlKqFgkQXb5+I3qk
         AeuEenaL2MZnCCVdARyPhxVR7YaCMZPIoyu56WVlZXMI0h8edINbkQLEseiGhonoKCjF
         xG9FsyPqum2lvAs9z3XoBnIoldplZMfgFusJuAKny7Mk4s0qTkZ66BC7Dh9ftfDZhUs8
         hN8Ygfku5+LJsWzdWAzyyoVYyxnytCrA+DtVqOZq2ox0t9SI6XeVzadUKSEbT7yL2jkT
         NosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759335640; x=1759940440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EI/Oh8/PCAXf06I9PHPDwi4/0WefIWbrMGoTUuWrnBM=;
        b=qjjXIHH0xdcdNpKSKorEoq5iLYeN8Ku+kTfFxyOgPPS3uqqH0v88vbaZbrFGJompqn
         5JNwfiX0C0n+dTfSbAe9NWWrxCpFkce8tBw5u4p97d17hQpVU9k0mBMpWkho03QMVes9
         T6F/7sBxs8uA/HBao9Pq+PiiAKsUtPnM+mVTDv+q8buF//YMzFnLseGCs/K8vALts1HW
         aM9pT/rdY4RJX5U5BW5b51W9kyQGeJxErCGHAwqqesxTsBQKCVQnQSYt3tnZrmuUspRd
         1d7E/vXPNLga0WFGwsyax8Eqr+3Ve8s/5EI1ChnGVHP41jqIAyniqzTPEmnZpG+gTHaL
         biTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgCY0EY3uVj3it2cH5/kaVYAEsy84uGkSBeDY/cvS45FJ+QYhwyy6Z4mRLBBse3H5pst4lzsxwNLil@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0kN3w2yrqGSZK79otV+Ov+qGxJMap4hRKVz9ZyTkoipdqTnt6
	eyVCRYpJwKEzcVlGEgdcz612791D0b5NTYVvnmyBTH0THslVP6U00zEK0K0wvWSv322/p6uClb0
	GeqAdluUrWiMqFqAj77vt8Zl+JQXBtB+fiNbh8m6y0g==
X-Gm-Gg: ASbGncu26HkVDFkRJf7U0dj7TNwIZkj1SLCSi86iQkogP4Ba3ZMUaqMpH2kVapXJRFf
	+bukeNqr16Fj1DDPC8l038Uvcypp8t1KVoaJTOmYJqSuCxkGs3yU9QW3cQ1nmdw4VRzGBza+9Qg
	FB4SIJA28/k6AjWeDFnAadXIBHy9rmpm7nPBjyjRqm7DC3SSO3JJxNoq7ugKEe9bHbwFyl/qXAU
	l+Z+JZ9Bt8MSuLQQNSZCC3CglzJh0SucfI3AkyMic/Q52MYRqWD8yUAhrtd/w0=
X-Google-Smtp-Source: AGHT+IFEIVnwr9ffJLEbYBthH98BS7huehwg+w3NxStPuNakBsASPv0qGndqlXbX/5EasnFoRUMSG34ReEMFLmrZsgY=
X-Received: by 2002:a17:902:c945:b0:258:a3a1:9aa5 with SMTP id
 d9443c01a7336-28e7ec77957mr31137405ad.0.1759335639054; Wed, 01 Oct 2025
 09:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
 <20250926065556.14250-1-409411716@gms.tku.edu.tw> <CADUfDZruZWyrsjRCs_Y5gjsbfU7dz_ALGG61pQ8qCM7K2_DjmA@mail.gmail.com>
 <aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T>
In-Reply-To: <aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 1 Oct 2025 09:20:27 -0700
X-Gm-Features: AS18NWBzCQmPAr3kMe6kx-SwiJLpviu4tbIvpBzEeM52yLj1pwkHP5C3EVtP6wc
Message-ID: <CADUfDZq4c3dRgWpevv3+29frvd6L8G9RRdoVFpFnyRsF3Eve1Q@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20251001_092040_809214_6C0FBEC0 
X-CRM114-Status: GOOD (  27.50  )
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

On Wed, Oct 1, 2025 at 3:18=E2=80=AFAM Guan-Chun Wu <409411716@gms.tku.edu.=
tw> wrote:
>
> On Fri, Sep 26, 2025 at 04:33:12PM -0700, Caleb Sander Mateos wrote:
> > On Thu, Sep 25, 2025 at 11:59=E2=80=AFPM Guan-Chun Wu <409411716@gms.tk=
u.edu.tw> wrote:
> > >
> > > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> > >
> > > Replace the use of strchr() in base64_decode() with precomputed rever=
se
> > > lookup tables for each variant. This avoids repeated string scans and
> > > improves performance. Use -1 in the tables to mark invalid characters=
.
> > >
> > > Decode:
> > >   64B   ~1530ns  ->  ~75ns    (~20.4x)
> > >   1KB  ~27726ns  -> ~1165ns   (~23.8x)
> > >
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > ---
> > >  lib/base64.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++--=
--
> > >  1 file changed, 61 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/lib/base64.c b/lib/base64.c
> > > index 1af557785..b20fdf168 100644
> > > --- a/lib/base64.c
> > > +++ b/lib/base64.c
> > > @@ -21,6 +21,63 @@ static const char base64_tables[][65] =3D {
> > >         [BASE64_IMAP] =3D "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnop=
qrstuvwxyz0123456789+,",
> > >  };
> > >
> > > +static const s8 base64_rev_tables[][256] =3D {
> > > +       [BASE64_STD] =3D {
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  =
-1,  -1,  -1,  63,
> > > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  =
11,  12,  13,  14,
> > > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  =
37,  38,  39,  40,
> > > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +       },
> > > +       [BASE64_URLSAFE] =3D {
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  62,  -1,  -1,
> > > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  =
11,  12,  13,  14,
> > > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  =
-1,  -1,  -1,  63,
> > > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  =
37,  38,  39,  40,
> > > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +       },
> > > +       [BASE64_IMAP] =3D {
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  =
63,  -1,  -1,  -1,
> > > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  =
11,  12,  13,  14,
> > > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  =
37,  38,  39,  40,
> > > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  =
-1,  -1,  -1,  -1,
> > > +       },
> >
> > Do we actually need 3 separate lookup tables? It looks like all 3
> > variants agree on the value of any characters they have in common. So
> > we could combine them into a single lookup table that would work for a
> > valid base64 string of any variant. The only downside I can see is
> > that base64 strings which are invalid in some variants might no longer
> > be rejected by base64_decode().
> >
>
> In addition to the approach David mentioned, maybe we can use a common
> lookup table for A=E2=80=93Z, a=E2=80=93z, and 0=E2=80=939, and then hand=
le the variant-specific
> symbols with a switch.
>
> For example:
>
> static const s8 base64_rev_common[256] =3D {
>     [0 ... 255] =3D -1,
>     ['A'] =3D 0, ['B'] =3D 1, /* ... */, ['Z'] =3D 25,
>     ['a'] =3D 26, /* ... */, ['z'] =3D 51,
>     ['0'] =3D 52, /* ... */, ['9'] =3D 61,
> };
>
> static inline int base64_rev_lookup(u8 c, enum base64_variant variant) {
>     s8 v =3D base64_rev_common[c];
>     if (v !=3D -1)
>         return v;
>
>     switch (variant) {
>     case BASE64_STD:
>         if (c =3D=3D '+') return 62;
>         if (c =3D=3D '/') return 63;
>         break;
>     case BASE64_IMAP:
>         if (c =3D=3D '+') return 62;
>         if (c =3D=3D ',') return 63;
>         break;
>     case BASE64_URLSAFE:
>         if (c =3D=3D '-') return 62;
>         if (c =3D=3D '_') return 63;
>         break;
>     }
>     return -1;
> }
>
> What do you think?

That adds several branches in the hot loop, at least 2 of which are
unpredictable for valid base64 input of a given variant (v !=3D -1 as
well as the first c check in the applicable switch case). That seems
like it would hurt performance, no? I think having 3 separate tables
would be preferable to making the hot loop more branchy.

Best,
Caleb

