Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433EECCA476
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Oct 2025 18:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eQmS4iGCIsqFscOYPI2pMSI5i8ARz15f5xJppXklNTg=; b=drEtug7BsXQJqeQZHTgyTkKnps
	TyjwXjlZD6vahiL9GpF+Dy6922yxMPSGyxhRGM7+aa0VBs/Cm/1diSotnkON9iYOi3LVRV9BEYAjN
	0ziBHAznkcvRim7FyBtjkCQ30xtpyp53EEvjW9Hn/a2e8SHrvKwvbA+516lfvCbhtEBQWtl1JBCYQ
	NQcyUiwChRWPD0S9wR2C0Rm31rDVcsudupeNFIIMF29wLdeFC+YfjH6y05NOoDLiWVTYqY6H+jJfp
	ZaO/fBBoeoit08C4g3ph96NJ2MSiOyy4yOPcceYgCwODiUkV/r9bQYi+wCzEF6y9vokKIH5KKdcHi
	v20FnpnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6CMO-00000002aDC-3sNs;
	Tue, 07 Oct 2025 18:24:28 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6CMJ-00000002aCO-3MYw
	for linux-nvme@lists.infradead.org;
	Tue, 07 Oct 2025 18:24:24 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-46e6674caa5so907095e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 07 Oct 2025 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759861462; x=1760466262; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQmS4iGCIsqFscOYPI2pMSI5i8ARz15f5xJppXklNTg=;
        b=HkAw6DyAo+zhoJftHYkTplD9fLxrlgaGGQZLVg1bDAJDs2ElqMT+Uzawg4WZPA1nqZ
         cHbhfC4qr6Z9eEHiI7RvyJkoIZlW7BLNX7mYQ1y/iUjmd7o9MNNBDPasUJVH/iEaDie+
         nnUuOP+/W8RkmoWWSDgERA1d4Up2yQWkWNalnS1dArMLBQBxZOqBN4WtlkMGhu9eeXXA
         FlHW2lZ2rt0sDwwHeXHFC8QWdEK1BPpHwO981n474RqGl0KM5nT7QFJjP5OR9IEGFpP7
         nlo/oEhWzsf8VooiaZfpUZJ26LbCc6Hc8qXCVAyhEhhbbgoFTjL4w1Jp7SqysHp1HrAV
         WL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759861462; x=1760466262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQmS4iGCIsqFscOYPI2pMSI5i8ARz15f5xJppXklNTg=;
        b=HtiALHvQsCxb1ipH0CqE2zrRHKwwE5R8YyuXfZNLidVcMmWx11LEgAf8bGkgwNFIra
         EIYTXBZAGW7GvkpIPiL3qp5FLHqGr8Mw0IFojV6KUwgCvOIMcMDIs9QedhAF9waTiUzZ
         xFClC3pkEOm4P0hEOdzUQUjge36CXB9SsMbBLbVkawYkPzfXgN1riHJ40EZPY89lOcjt
         TS9VJPoUI14XXpRvPJ98WeQ2grInMHN4HnmE6HM8FTDriphrqnvWSwSM86n2WhgUDHKz
         8tQNzneB6SllQTnjk63ng9YVUZeeiSwP2hj3WeMHOI+yOyJiMUtvAU+lPzZiJXEJ1rmK
         5Bcw==
X-Forwarded-Encrypted: i=1; AJvYcCUGwk3y52mfEWhSYcKh03R7pJUI+GDjPQMGvQ39MR4ms1aTY2rYeA17nrJ+HqZwEZQ4+eApm6y07IRH@lists.infradead.org
X-Gm-Message-State: AOJu0Yza/msEeC6ksMy+K6dxiUPuFveAwwRhalqacuC8GAWZGwFDqXUb
	Vd49QV49g/9Do8YNhvuAReJ/XZyJbmox5iuleH2srUaPbgJAqJxvkuQR
X-Gm-Gg: ASbGnctskUiHLgbtFIfSz9X69xOmDcQKcT/GmgUSNTSqxKnK2gmg9GNpMvIrkxgnNqQ
	B0s4hhyHySXnVDcJkCbgequ/s0yb4y5BRNYl25hoGboGDUUK8w++YzjvX01uv4dy3zdEvc68RVq
	b9ct16WIVSzj1GBLzaRD+8XimHKnxuZMbjDMXaOtjTb5DMwgOUJOjS58e40TSgoILzmr4cdwwiq
	1TyVTlZl0IodulmYk9Sv/uINjOmy7I5FVmaMs0mxdU0aC8B05kIaUNq/F0W/xBRVwCk+FGYuZiv
	XfVoULeHRzr7Ko2Udklhn7qdJP3Ppj9z4oQtj2SKMxzqMD6bhkN5P+RezIoy7cm/BvFH5aOsRxC
	4J+MZFNSvfzYiMPuye9iwrbwrjvP3mITfQVq4qiDXYEULiW4KLKCMoKdjtCia0SRR+1MTKlKIWq
	9pKGPQeIYaqsoQ
X-Google-Smtp-Source: AGHT+IGj/aZ4dREFNGfXsKOVw/xQDfcBe5qfV06LY9YeLiL2xFcvZXfiVKVcLJWLZMfSJ7R2lbSN1Q==
X-Received: by 2002:a05:600c:458b:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-46fa9e9a2e5mr2597245e9.8.1759861461807;
        Tue, 07 Oct 2025 11:24:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9d6269asm3998165e9.15.2025.10.07.11.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:24:21 -0700 (PDT)
Date: Tue, 7 Oct 2025 19:23:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Guan-Chun Wu <409411716@gms.tku.edu.tw>, akpm@linux-foundation.org,
 axboe@kernel.dk, ceph-devel@vger.kernel.org, ebiggers@kernel.org,
 hch@lst.de, home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
 kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with
 reverse lookup tables
Message-ID: <20251007192327.57f00588@pumpkin>
In-Reply-To: <CADUfDZp6TA_S72+JDJRmObJgmovPgit=-Zf+-oC+r0wUsyg9Jg@mail.gmail.com>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
	<20250926065556.14250-1-409411716@gms.tku.edu.tw>
	<CADUfDZruZWyrsjRCs_Y5gjsbfU7dz_ALGG61pQ8qCM7K2_DjmA@mail.gmail.com>
	<aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T>
	<CADUfDZq4c3dRgWpevv3+29frvd6L8G9RRdoVFpFnyRsF3Eve1Q@mail.gmail.com>
	<20251005181803.0ba6aee4@pumpkin>
	<aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
	<CADUfDZp6TA_S72+JDJRmObJgmovPgit=-Zf+-oC+r0wUsyg9Jg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251007_112423_875609_E7C6A45A 
X-CRM114-Status: GOOD (  53.50  )
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

On Tue, 7 Oct 2025 07:57:16 -0700
Caleb Sander Mateos <csander@purestorage.com> wrote:

> On Tue, Oct 7, 2025 at 1:28=E2=80=AFAM Guan-Chun Wu <409411716@gms.tku.ed=
u.tw> wrote:
> >
> > On Sun, Oct 05, 2025 at 06:18:03PM +0100, David Laight wrote: =20
> > > On Wed, 1 Oct 2025 09:20:27 -0700
> > > Caleb Sander Mateos <csander@purestorage.com> wrote:
> > > =20
> > > > On Wed, Oct 1, 2025 at 3:18=E2=80=AFAM Guan-Chun Wu <409411716@gms.=
tku.edu.tw> wrote: =20
> > > > >
> > > > > On Fri, Sep 26, 2025 at 04:33:12PM -0700, Caleb Sander Mateos wro=
te: =20
> > > > > > On Thu, Sep 25, 2025 at 11:59=E2=80=AFPM Guan-Chun Wu <40941171=
6@gms.tku.edu.tw> wrote: =20
> > > > > > >
> > > > > > > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > > >
> > > > > > > Replace the use of strchr() in base64_decode() with precomput=
ed reverse
> > > > > > > lookup tables for each variant. This avoids repeated string s=
cans and
> > > > > > > improves performance. Use -1 in the tables to mark invalid ch=
aracters.
> > > > > > >
> > > > > > > Decode:
> > > > > > >   64B   ~1530ns  ->  ~75ns    (~20.4x)
> > > > > > >   1KB  ~27726ns  -> ~1165ns   (~23.8x)
> > > > > > >
> > > > > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > > > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > > > > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > > > > ---
> > > > > > >  lib/base64.c | 66 ++++++++++++++++++++++++++++++++++++++++++=
++++++----
> > > > > > >  1 file changed, 61 insertions(+), 5 deletions(-)
> > > > > > >
> > > > > > > diff --git a/lib/base64.c b/lib/base64.c
> > > > > > > index 1af557785..b20fdf168 100644
> > > > > > > --- a/lib/base64.c
> > > > > > > +++ b/lib/base64.c
> > > > > > > @@ -21,6 +21,63 @@ static const char base64_tables[][65] =3D {
> > > > > > >         [BASE64_IMAP] =3D "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefgh=
ijklmnopqrstuvwxyz0123456789+,",
> > > > > > >  };
> > > > > > >
> > > > > > > +static const s8 base64_rev_tables[][256] =3D {
...
> > > > > > Do we actually need 3 separate lookup tables? It looks like all=
 3
> > > > > > variants agree on the value of any characters they have in comm=
on. So
> > > > > > we could combine them into a single lookup table that would wor=
k for a
> > > > > > valid base64 string of any variant. The only downside I can see=
 is
> > > > > > that base64 strings which are invalid in some variants might no=
 longer
> > > > > > be rejected by base64_decode().
> > > > > > =20
> > > > >
> > > > > In addition to the approach David mentioned, maybe we can use a c=
ommon
> > > > > lookup table for A=E2=80=93Z, a=E2=80=93z, and 0=E2=80=939, and t=
hen handle the variant-specific
> > > > > symbols with a switch. =20
> > >
> > > It is certainly possible to generate the initialiser from a #define to
> > > avoid all the replicated source.
> > > =20
> > > > >
> > > > > For example:
> > > > >
> > > > > static const s8 base64_rev_common[256] =3D {
> > > > >     [0 ... 255] =3D -1,
> > > > >     ['A'] =3D 0, ['B'] =3D 1, /* ... */, ['Z'] =3D 25, =20
> > >
> > > If you assume ASCII (I doubt Linux runs on any EBCDIC systems) you
> > > can assume the characters are sequential and miss ['B'] =3D etc to
> > > reduce the the line lengths.
> > > (Even EBCDIC has A-I J-R S-Z and 0-9 as adjacent values)
> > > =20
> > > > >     ['a'] =3D 26, /* ... */, ['z'] =3D 51,
> > > > >     ['0'] =3D 52, /* ... */, ['9'] =3D 61,
> > > > > };
> > > > >
> > > > > static inline int base64_rev_lookup(u8 c, enum base64_variant var=
iant) {
> > > > >     s8 v =3D base64_rev_common[c];
> > > > >     if (v !=3D -1)
> > > > >         return v;
> > > > >
> > > > >     switch (variant) {
> > > > >     case BASE64_STD:
> > > > >         if (c =3D=3D '+') return 62;
> > > > >         if (c =3D=3D '/') return 63;
> > > > >         break;
> > > > >     case BASE64_IMAP:
> > > > >         if (c =3D=3D '+') return 62;
> > > > >         if (c =3D=3D ',') return 63;
> > > > >         break;
> > > > >     case BASE64_URLSAFE:
> > > > >         if (c =3D=3D '-') return 62;
> > > > >         if (c =3D=3D '_') return 63;
> > > > >         break;
> > > > >     }
> > > > >     return -1;
> > > > > }
> > > > >
> > > > > What do you think? =20
> > > >
> > > > That adds several branches in the hot loop, at least 2 of which are
> > > > unpredictable for valid base64 input of a given variant (v !=3D -1 =
as
> > > > well as the first c check in the applicable switch case). =20
> > >
> > > I'd certainly pass in the character values for 62 and 63 so they are
> > > determined well outside the inner loop.
> > > Possibly even going as far as #define BASE64_STD ('+' << 8 | '/').
> > > =20
> > > > That seems like it would hurt performance, no?
> > > > I think having 3 separate tables
> > > > would be preferable to making the hot loop more branchy. =20
> > >
> > > Depends how common you think 62 and 63 are...
> > > I guess 63 comes from 0xff bytes - so might be quite common.
> > >
> > > One thing I think you've missed is that the decode converts 4 charact=
ers
> > > into 24 bits - which then need carefully writing into the output buff=
er.
> > > There is no need to check whether each character is valid.
> > > After:
> > >       val_24 =3D t[b[0]] | t[b[1]] << 6 | t[b[2]] << 12 | t[b[3]] << =
18;
> > > val_24 will be negative iff one of b[0..3] is invalid.
> > > So you only need to check every 4 input characters, not for every one.
> > > That does require separate tables.
> > > (Or have a decoder that always maps "+-" to 62 and "/,_" to 63.)
> > >
> > >       David
> > > =20
> >
> > Thanks for the feedback.
> > For the next revision, we=E2=80=99ll use a single lookup table that map=
s both +
> > and - to 62, and /, _, and , to 63.
> > Does this approach sound good to everyone? =20
>=20
> Sounds fine to me. Perhaps worth pointing out that the decision to
> accept any base64 variant in the decoder would likely be permanent,
> since users may come to depend on it. But I don't see any issue with
> it as long as all the base64 variants agree on the values of their
> common symbols.

If an incompatible version comes along it'll need a different function
(or similar). But there is no point over-engineering it now.

	David


>=20
> Best,
> Caleb


