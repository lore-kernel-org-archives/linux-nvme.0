Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAC2CCA470
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Oct 2025 14:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qVQVTdLz3JhO8K7IozwO/U1pe3WO/g/3ZfFjqGmOQ1A=; b=k29iIZRDka7SEOKIBwaP/a819x
	fRmAGxLbvj0Sgz6fn02uvBT7Hp3oLhHNsM7l9x+UxVS5yfMUUlQcgvQkmbDE7wcTxIPCe9vbb9lkV
	g22yL3KJimviCXuUhLDDCO4tW6e8IlALWX/iedj+nhPeGl46eGsW6mSZi9e05xLiUhYTkXwA73kfu
	T7zPEnwPYjxCKfAsz2YBPGgNqTXoDVD4CmrbInDhwdsrOQr/QZ8GGNODH3EBxp3vwDhaGn3i1RSNI
	Ncm24jxlbg0F9RYr2QiLVQGoQqYfojbuxVWWeyY5a5543dHQiA83jvLz6qR9Tq+GICE1c07v2rvZ4
	G7IlKekQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6987-00000002E5Z-09ho;
	Tue, 07 Oct 2025 14:57:31 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6984-00000002E4i-3XLs
	for linux-nvme@lists.infradead.org;
	Tue, 07 Oct 2025 14:57:30 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-33833a0a58cso1410303a91.3
        for <linux-nvme@lists.infradead.org>; Tue, 07 Oct 2025 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1759849047; x=1760453847; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVQVTdLz3JhO8K7IozwO/U1pe3WO/g/3ZfFjqGmOQ1A=;
        b=NnaKujGHIxh65eb5T9b/EpjLaq4XX3Jm3CgRT9BuXp742epe5NDGj4yQFgUvvqBwwA
         KA8LGvqaWUbjhNiZmUggpoQ8G2wlBIWyUXn8BBueAtzbfTtqFRsXYExLovT0yzou+wMN
         BDdxS0l1QfwyJGx3LZePLNWh+XZ8fBfIBi8KPhkJ8oGCqB4US7fM3DQs7BsHiFCkpS70
         XVdEmvqUW75YxC1t8ec3Fe56gQ9tkO1cc9CFxg1VLbM02NxhQjqyja7UGQ8+UWmHtXrq
         /z1iL73uBuviI6Gh0PhTGSLzzQsWkX2D4CCOVZYA2NcF6VEAr2j3aatE56+3qXibZ97L
         Jfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759849047; x=1760453847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVQVTdLz3JhO8K7IozwO/U1pe3WO/g/3ZfFjqGmOQ1A=;
        b=GCdXwF37rLYrw+esdz6DkzXKhliKNP9gNK4p78TryjWoL98MoNZ3XqanuSvkotfFj0
         ocw53lsnCAOgQJ9mAvVOO8huc6Mwm+5dLQ+1yA6xzOemDxzz6wXMX4Ix/xsM1aZ6tmzu
         HvFaHnEYHRm9TcEP3//UI6qKPyMpxHT/7TiCHcsUQMYPheRbY0iqfh0psGiyMBgJJmAc
         3REw/4IH+2r9DS0xd6OTgbjqJrRJYhkRBNjwk51WPQZ8CHXBPWUd3ES6wsq+SR6Rf/rk
         L6s6xwo1pbRca3Yu8knsE57SvQsWsw+s/7eVb30GgWnaQH5hEW7vl3O+qkEDbSY8PVN5
         +Lug==
X-Forwarded-Encrypted: i=1; AJvYcCUpwvBiyxF7hZPpjSDxgZgVGkTkOWtNXMwThcp+s875SD7fyemZXpSvToYSU/HykBGQ3GTcZlNnPYMS@lists.infradead.org
X-Gm-Message-State: AOJu0Yze14NG2hzcs/APlHYKyno48AWzlE3iiAXY947tcJGOlOPtI7ux
	HUe7xRoCJUl8Zxlg9xUJ2b0pPblQx30jQvvnBqZ8DGzoQPQ7gGUE1SK49jvacVWdnI4TX4oONCn
	Ck2d68aDhJY/1Di73CTQmdzfqZS7kjBLePvnMNLEO+A==
X-Gm-Gg: ASbGncsIepERFnk6oqdvFU8W0kh12SW3/wEbkpckkPg3kB+Bep2i4kvKFGZgWVNeEkZ
	v/f9LPCjamtX81vkkDE4hdRSG9O8kBamlWHN8zI9yzy0NRMLO/TEZ3TX8UKp5ytVGW20G9W/L+x
	MeyZoTGpWjE5tP2xGRseF+CoRDs5lIbi4ihY0cnskfKJ0/mnVCB52soNZ/KvAmljID4Fuml8hqX
	sy6Nn2Kj2InjLvcE/BkeuBrBWqrD6rigRd8ij7K1dgpw6TD9/MMoTA3oFqmYMSjpaVuLeV2BA==
X-Google-Smtp-Source: AGHT+IEYhWaq4b8LjsaTKtHCBOMQ6ujrAp6CxxaKz4k/uq34nEHmzVPTH9dqGuv8aLeFBZEOCRgXi4zPqI749dfPXeg=
X-Received: by 2002:a17:90b:33c9:b0:330:944e:4814 with SMTP id
 98e67ed59e1d1-339c27b9669mr10779782a91.5.1759849047310; Tue, 07 Oct 2025
 07:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
 <20250926065556.14250-1-409411716@gms.tku.edu.tw> <CADUfDZruZWyrsjRCs_Y5gjsbfU7dz_ALGG61pQ8qCM7K2_DjmA@mail.gmail.com>
 <aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T> <CADUfDZq4c3dRgWpevv3+29frvd6L8G9RRdoVFpFnyRsF3Eve1Q@mail.gmail.com>
 <20251005181803.0ba6aee4@pumpkin> <aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
In-Reply-To: <aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 7 Oct 2025 07:57:16 -0700
X-Gm-Features: AS18NWDbyq1DczXc9CALQ9HeJCtJn-7fS8_x4v7YcPrMpuNbLjPHQxFY5TzoCBQ
Message-ID: <CADUfDZp6TA_S72+JDJRmObJgmovPgit=-Zf+-oC+r0wUsyg9Jg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with reverse
 lookup tables
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: David Laight <david.laight.linux@gmail.com>, akpm@linux-foundation.org, 
	axboe@kernel.dk, ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de, 
	home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org, 
	kbusch@kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251007_075728_927924_150C6A5F 
X-CRM114-Status: GOOD (  49.09  )
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

On Tue, Oct 7, 2025 at 1:28=E2=80=AFAM Guan-Chun Wu <409411716@gms.tku.edu.=
tw> wrote:
>
> On Sun, Oct 05, 2025 at 06:18:03PM +0100, David Laight wrote:
> > On Wed, 1 Oct 2025 09:20:27 -0700
> > Caleb Sander Mateos <csander@purestorage.com> wrote:
> >
> > > On Wed, Oct 1, 2025 at 3:18=E2=80=AFAM Guan-Chun Wu <409411716@gms.tk=
u.edu.tw> wrote:
> > > >
> > > > On Fri, Sep 26, 2025 at 04:33:12PM -0700, Caleb Sander Mateos wrote=
:
> > > > > On Thu, Sep 25, 2025 at 11:59=E2=80=AFPM Guan-Chun Wu <409411716@=
gms.tku.edu.tw> wrote:
> > > > > >
> > > > > > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > >
> > > > > > Replace the use of strchr() in base64_decode() with precomputed=
 reverse
> > > > > > lookup tables for each variant. This avoids repeated string sca=
ns and
> > > > > > improves performance. Use -1 in the tables to mark invalid char=
acters.
> > > > > >
> > > > > > Decode:
> > > > > >   64B   ~1530ns  ->  ~75ns    (~20.4x)
> > > > > >   1KB  ~27726ns  -> ~1165ns   (~23.8x)
> > > > > >
> > > > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > > > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > > > ---
> > > > > >  lib/base64.c | 66 ++++++++++++++++++++++++++++++++++++++++++++=
++++----
> > > > > >  1 file changed, 61 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/lib/base64.c b/lib/base64.c
> > > > > > index 1af557785..b20fdf168 100644
> > > > > > --- a/lib/base64.c
> > > > > > +++ b/lib/base64.c
> > > > > > @@ -21,6 +21,63 @@ static const char base64_tables[][65] =3D {
> > > > > >         [BASE64_IMAP] =3D "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghij=
klmnopqrstuvwxyz0123456789+,",
> > > > > >  };
> > > > > >
> > > > > > +static const s8 base64_rev_tables[][256] =3D {
> > > > > > +       [BASE64_STD] =3D {
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 62,  -1,  -1,  -1,  63,
> > > > > > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9, =
 10,  11,  12,  13,  14,
> > > > > > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35, =
 36,  37,  38,  39,  40,
> > > > > > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +       },
> > > > > > +       [BASE64_URLSAFE] =3D {
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  62,  -1,  -1,
> > > > > > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9, =
 10,  11,  12,  13,  14,
> > > > > > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25, =
 -1,  -1,  -1,  -1,  63,
> > > > > > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35, =
 36,  37,  38,  39,  40,
> > > > > > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +       },
> > > > > > +       [BASE64_IMAP] =3D {
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 62,  63,  -1,  -1,  -1,
> > > > > > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9, =
 10,  11,  12,  13,  14,
> > > > > > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35, =
 36,  37,  38,  39,  40,
> > > > > > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1, =
 -1,  -1,  -1,  -1,  -1,
> > > > > > +       },
> > > > >
> > > > > Do we actually need 3 separate lookup tables? It looks like all 3
> > > > > variants agree on the value of any characters they have in common=
. So
> > > > > we could combine them into a single lookup table that would work =
for a
> > > > > valid base64 string of any variant. The only downside I can see i=
s
> > > > > that base64 strings which are invalid in some variants might no l=
onger
> > > > > be rejected by base64_decode().
> > > > >
> > > >
> > > > In addition to the approach David mentioned, maybe we can use a com=
mon
> > > > lookup table for A=E2=80=93Z, a=E2=80=93z, and 0=E2=80=939, and the=
n handle the variant-specific
> > > > symbols with a switch.
> >
> > It is certainly possible to generate the initialiser from a #define to
> > avoid all the replicated source.
> >
> > > >
> > > > For example:
> > > >
> > > > static const s8 base64_rev_common[256] =3D {
> > > >     [0 ... 255] =3D -1,
> > > >     ['A'] =3D 0, ['B'] =3D 1, /* ... */, ['Z'] =3D 25,
> >
> > If you assume ASCII (I doubt Linux runs on any EBCDIC systems) you
> > can assume the characters are sequential and miss ['B'] =3D etc to
> > reduce the the line lengths.
> > (Even EBCDIC has A-I J-R S-Z and 0-9 as adjacent values)
> >
> > > >     ['a'] =3D 26, /* ... */, ['z'] =3D 51,
> > > >     ['0'] =3D 52, /* ... */, ['9'] =3D 61,
> > > > };
> > > >
> > > > static inline int base64_rev_lookup(u8 c, enum base64_variant varia=
nt) {
> > > >     s8 v =3D base64_rev_common[c];
> > > >     if (v !=3D -1)
> > > >         return v;
> > > >
> > > >     switch (variant) {
> > > >     case BASE64_STD:
> > > >         if (c =3D=3D '+') return 62;
> > > >         if (c =3D=3D '/') return 63;
> > > >         break;
> > > >     case BASE64_IMAP:
> > > >         if (c =3D=3D '+') return 62;
> > > >         if (c =3D=3D ',') return 63;
> > > >         break;
> > > >     case BASE64_URLSAFE:
> > > >         if (c =3D=3D '-') return 62;
> > > >         if (c =3D=3D '_') return 63;
> > > >         break;
> > > >     }
> > > >     return -1;
> > > > }
> > > >
> > > > What do you think?
> > >
> > > That adds several branches in the hot loop, at least 2 of which are
> > > unpredictable for valid base64 input of a given variant (v !=3D -1 as
> > > well as the first c check in the applicable switch case).
> >
> > I'd certainly pass in the character values for 62 and 63 so they are
> > determined well outside the inner loop.
> > Possibly even going as far as #define BASE64_STD ('+' << 8 | '/').
> >
> > > That seems like it would hurt performance, no?
> > > I think having 3 separate tables
> > > would be preferable to making the hot loop more branchy.
> >
> > Depends how common you think 62 and 63 are...
> > I guess 63 comes from 0xff bytes - so might be quite common.
> >
> > One thing I think you've missed is that the decode converts 4 character=
s
> > into 24 bits - which then need carefully writing into the output buffer=
.
> > There is no need to check whether each character is valid.
> > After:
> >       val_24 =3D t[b[0]] | t[b[1]] << 6 | t[b[2]] << 12 | t[b[3]] << 18=
;
> > val_24 will be negative iff one of b[0..3] is invalid.
> > So you only need to check every 4 input characters, not for every one.
> > That does require separate tables.
> > (Or have a decoder that always maps "+-" to 62 and "/,_" to 63.)
> >
> >       David
> >
>
> Thanks for the feedback.
> For the next revision, we=E2=80=99ll use a single lookup table that maps =
both +
> and - to 62, and /, _, and , to 63.
> Does this approach sound good to everyone?

Sounds fine to me. Perhaps worth pointing out that the decision to
accept any base64 variant in the decoder would likely be permanent,
since users may come to depend on it. But I don't see any issue with
it as long as all the base64 variants agree on the values of their
common symbols.

Best,
Caleb

