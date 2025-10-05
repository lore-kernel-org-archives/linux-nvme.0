Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A16CAC5B8
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Oct 2025 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J0ULdM4RO6Y+nM8oAEAyBDinfjXj2njenLfdZojAe+c=; b=cgiCZtxnI9KiwSly15rTZbvcx0
	1QyzXgiRLr9IA6Efk6HNJWHJ6IuHGhSCTtQA22gliv5UH9yRO5ncP9PkBy71JeB5oedSvO5x0P9aa
	2HxedpnTK+ZjzmKMciOjSk4Xksl6DIhrlicBlS8d7f75jc97M+nHTYcqnEmD4LPSEqtGAkMaIbh8+
	Bm59PixBmsp4s18tHeXRHKpSIRxS4kyG+03HUOnf8U4Lzt8UBWYFzLcWCwbGUxVJb+QfRYxCvjoDj
	nludJQBOy/4FQx1eCxq12qTivNQiFEKmeZAcsU1o+AcxJaSC1N9gH3U51ClmTNVoJBr/WBBS+1dVQ
	klEonetA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5SNu-0000000G0Fk-3sRK;
	Sun, 05 Oct 2025 17:18:58 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5SNo-0000000G0Ek-2rpm
	for linux-nvme@lists.infradead.org;
	Sun, 05 Oct 2025 17:18:53 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-46b303f755aso31014715e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 05 Oct 2025 10:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759684730; x=1760289530; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0ULdM4RO6Y+nM8oAEAyBDinfjXj2njenLfdZojAe+c=;
        b=Ot3sQP74S3cWRsVoUF1U1O4u8wZJqvSfiRUnmeOQBlMTFhjRxzso/dBYOJ6HpN2ha4
         WuLXYt6f7YVSB6pyz2PYCpspfOzlSYD152L3jjPhXe+s37oUxp3S5CntOTngMWvtjsbX
         Eu1a0S7yp3M+GqfrddpdO7/l88EuDOD5h1EEIh98So1gQ/XaS9IZ8QHm5nIzBdJsU3Um
         lI/Fc2IJUHFyUkJn7AQjyW2ymH8n4r0xNlz7q/pUCZzHl0UXPtS/ACIPvjmTPRwF4jVJ
         uC6sYcjeodGXiwsf8qW9bD+V2Rb6rYVJe5K6i+JB1RyDmMm2diojAlFMC/2jXZ69JZJK
         jM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759684730; x=1760289530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0ULdM4RO6Y+nM8oAEAyBDinfjXj2njenLfdZojAe+c=;
        b=bv29++Y51/hPnXlb1IcgXwCniZoDZYB/4wpuh2KDGhvLSBIhawjnbpKSM2xQQDONEs
         DiukNpdmef79OfKzpKbCLNU8iewon59nYW7zMExza6Ufj+8WbDKOKv/2+mV1aM/soton
         qp1NAGNJJGPVLlV2MPMI+7Q+i/GLlCcRDyinuYdXUcdXdu/MCRuxR9Q1sPYxOdyT+9Yi
         /2UzYBEIfmHOTNqrn8UHBqrI+n45yhrn0+fIlqdK39o1DTJCVTt61eyS1U0KGPV+iCjG
         X5hdVIis5t+pOahOwVrEL/F7UvTR7DFeDLZZna0o7EEqW6p3+5/hJ4jZDq5lIYGSaTnm
         jC+A==
X-Forwarded-Encrypted: i=1; AJvYcCV7jCDeBNxhA31U4plox5JloeAJAG5jrWeGokp5T77MpF/y737r5oZHHRMzsQwh2qXCxdwVIfnaEIWh@lists.infradead.org
X-Gm-Message-State: AOJu0Yws44mlJppbKFa9f8B5WB8Xip7dM3Ab3LjBCaPw4bomgwyyHegc
	0UaFEL6GWekZLtBDyysEaU2Xrc8LaPysP/br9E1cwa/vvAZnY+eHqlQS
X-Gm-Gg: ASbGncuMdSva6aqkgVX7V6YYHTMOBymzxqbiXigjxT6hAhT6Qo73oD6HdVPcs1mypRq
	gx1WoG8oMa/68p28k8J5iGgsN9axfU8EXWfTg5RPpsL549ugDiTOWZnBzbaFyIJE3bSyWPn+EI/
	FN/ltHzutQ8RklFlRPntbpXe+L2WK5pIVINAYfJXW44h73wZAiJnLVbMpXNgKtZ+XMbtdXQZHLw
	xlqkqVxubAPgraRBxAlNPFt1h1S7P24Z5n5CcI6CJ5YzG9SY/oN0ZJG5gzCOPgREoqliuP3KMXx
	NG0HU95XuGMupVYW7/QpnMQpNErKJVWyKZg8uW1bsrxMl0POW6icLLiaDlezLJn/9OFldS6y8vp
	QcdIDHxC1lA/eK8mOVvhYePqU3ZUFrcvj2/2z+afo2h9YB01pD2ikHrJNSVz3NMP+XHvNd+/XH1
	/vdscY/RKh79B6
X-Google-Smtp-Source: AGHT+IGVjN1kbt6UIzDiRaCKMzUM7GpwndVH8xqVRWPwdEAZd+Z/455EHR7od34KWx6ewjDoMtzyzw==
X-Received: by 2002:a05:600c:a14:b0:46e:3403:63df with SMTP id 5b1f17b1804b1-46e711043a5mr72182845e9.8.1759684730254;
        Sun, 05 Oct 2025 10:18:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f02a8sm17320240f8f.39.2025.10.05.10.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 10:18:49 -0700 (PDT)
Date: Sun, 5 Oct 2025 18:18:03 +0100
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
Message-ID: <20251005181803.0ba6aee4@pumpkin>
In-Reply-To: <CADUfDZq4c3dRgWpevv3+29frvd6L8G9RRdoVFpFnyRsF3Eve1Q@mail.gmail.com>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
	<20250926065556.14250-1-409411716@gms.tku.edu.tw>
	<CADUfDZruZWyrsjRCs_Y5gjsbfU7dz_ALGG61pQ8qCM7K2_DjmA@mail.gmail.com>
	<aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T>
	<CADUfDZq4c3dRgWpevv3+29frvd6L8G9RRdoVFpFnyRsF3Eve1Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251005_101852_773006_E232CC5A 
X-CRM114-Status: GOOD (  36.39  )
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

On Wed, 1 Oct 2025 09:20:27 -0700
Caleb Sander Mateos <csander@purestorage.com> wrote:

> On Wed, Oct 1, 2025 at 3:18=E2=80=AFAM Guan-Chun Wu <409411716@gms.tku.ed=
u.tw> wrote:
> >
> > On Fri, Sep 26, 2025 at 04:33:12PM -0700, Caleb Sander Mateos wrote: =20
> > > On Thu, Sep 25, 2025 at 11:59=E2=80=AFPM Guan-Chun Wu <409411716@gms.=
tku.edu.tw> wrote: =20
> > > >
> > > > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > >
> > > > Replace the use of strchr() in base64_decode() with precomputed rev=
erse
> > > > lookup tables for each variant. This avoids repeated string scans a=
nd
> > > > improves performance. Use -1 in the tables to mark invalid characte=
rs.
> > > >
> > > > Decode:
> > > >   64B   ~1530ns  ->  ~75ns    (~20.4x)
> > > >   1KB  ~27726ns  -> ~1165ns   (~23.8x)
> > > >
> > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > ---
> > > >  lib/base64.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++=
----
> > > >  1 file changed, 61 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/lib/base64.c b/lib/base64.c
> > > > index 1af557785..b20fdf168 100644
> > > > --- a/lib/base64.c
> > > > +++ b/lib/base64.c
> > > > @@ -21,6 +21,63 @@ static const char base64_tables[][65] =3D {
> > > >         [BASE64_IMAP] =3D "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmn=
opqrstuvwxyz0123456789+,",
> > > >  };
> > > >
> > > > +static const s8 base64_rev_tables[][256] =3D {
> > > > +       [BASE64_STD] =3D {
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,=
  -1,  -1,  -1,  63,
> > > > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,=
  11,  12,  13,  14,
> > > > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,=
  37,  38,  39,  40,
> > > > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +       },
> > > > +       [BASE64_URLSAFE] =3D {
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  62,  -1,  -1,
> > > > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,=
  11,  12,  13,  14,
> > > > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,=
  -1,  -1,  -1,  63,
> > > > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,=
  37,  38,  39,  40,
> > > > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +       },
> > > > +       [BASE64_IMAP] =3D {
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,=
  63,  -1,  -1,  -1,
> > > > +        52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,=
  11,  12,  13,  14,
> > > > +        15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,=
  37,  38,  39,  40,
> > > > +        41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +        -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,=
  -1,  -1,  -1,  -1,
> > > > +       }, =20
> > >
> > > Do we actually need 3 separate lookup tables? It looks like all 3
> > > variants agree on the value of any characters they have in common. So
> > > we could combine them into a single lookup table that would work for a
> > > valid base64 string of any variant. The only downside I can see is
> > > that base64 strings which are invalid in some variants might no longer
> > > be rejected by base64_decode().
> > > =20
> >
> > In addition to the approach David mentioned, maybe we can use a common
> > lookup table for A=E2=80=93Z, a=E2=80=93z, and 0=E2=80=939, and then ha=
ndle the variant-specific
> > symbols with a switch.

It is certainly possible to generate the initialiser from a #define to
avoid all the replicated source.

> >
> > For example:
> >
> > static const s8 base64_rev_common[256] =3D {
> >     [0 ... 255] =3D -1,
> >     ['A'] =3D 0, ['B'] =3D 1, /* ... */, ['Z'] =3D 25,

If you assume ASCII (I doubt Linux runs on any EBCDIC systems) you
can assume the characters are sequential and miss ['B'] =3D etc to
reduce the the line lengths.
(Even EBCDIC has A-I J-R S-Z and 0-9 as adjacent values)

> >     ['a'] =3D 26, /* ... */, ['z'] =3D 51,
> >     ['0'] =3D 52, /* ... */, ['9'] =3D 61,
> > };
> >
> > static inline int base64_rev_lookup(u8 c, enum base64_variant variant) {
> >     s8 v =3D base64_rev_common[c];
> >     if (v !=3D -1)
> >         return v;
> >
> >     switch (variant) {
> >     case BASE64_STD:
> >         if (c =3D=3D '+') return 62;
> >         if (c =3D=3D '/') return 63;
> >         break;
> >     case BASE64_IMAP:
> >         if (c =3D=3D '+') return 62;
> >         if (c =3D=3D ',') return 63;
> >         break;
> >     case BASE64_URLSAFE:
> >         if (c =3D=3D '-') return 62;
> >         if (c =3D=3D '_') return 63;
> >         break;
> >     }
> >     return -1;
> > }
> >
> > What do you think? =20
>=20
> That adds several branches in the hot loop, at least 2 of which are
> unpredictable for valid base64 input of a given variant (v !=3D -1 as
> well as the first c check in the applicable switch case).

I'd certainly pass in the character values for 62 and 63 so they are
determined well outside the inner loop.
Possibly even going as far as #define BASE64_STD ('+' << 8 | '/').

> That seems like it would hurt performance, no?
> I think having 3 separate tables
> would be preferable to making the hot loop more branchy.

Depends how common you think 62 and 63 are...
I guess 63 comes from 0xff bytes - so might be quite common.

One thing I think you've missed is that the decode converts 4 characters
into 24 bits - which then need carefully writing into the output buffer.
There is no need to check whether each character is valid.
After:
	val_24 =3D t[b[0]] | t[b[1]] << 6 | t[b[2]] << 12 | t[b[3]] << 18;
val_24 will be negative iff one of b[0..3] is invalid.
So you only need to check every 4 input characters, not for every one.
That does require separate tables.
(Or have a decoder that always maps "+-" to 62 and "/,_" to 63.)

	David

>=20
> Best,
> Caleb
>=20


