Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC0CC04FFE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 21:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZurqd/gZ6QFwdhwsizttTDWmPh16bUHHZCUzWs7aTQ=; b=3ZpzYOd/a5Cd1l1Bpn33oUfxgn
	GnDMKNo2FhWsTjtS222pUtT4f2a644M7LmpP7jKEGUQAcMoM1nT20e16uo1GJB8YLavaTWJv2mheY
	7BZ26VY5c60ap5BHMf6VTCquuTVXN9QZ9Evu3UXf7fm7JQ6iJtPtB7PuDlvQ4BuGbEKl9xktMuyzV
	Wxmx/zlpnL8nBEoJBaKBcYTqIMZMVycG05LiHaDH4wu1QYJOZyHG2Rcqmc4XeXHXzocT1ph3gqxt7
	nddmrso4IJVKaVvQNCODYEM1o+c1ZpDSSa7+T6zMUeuXd/T08vCgK+OjX6ZispglosDX1wI8sYeqL
	9fJXZVcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6zjK-0000000HDLe-1uCx;
	Tue, 14 May 2024 21:30:38 +0000
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6zjH-0000000HDJ6-1VtQ
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 21:30:36 +0000
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-23dd4dca5dbso1918769fac.0
        for <linux-nvme@lists.infradead.org>; Tue, 14 May 2024 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715722230; x=1716327030; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZurqd/gZ6QFwdhwsizttTDWmPh16bUHHZCUzWs7aTQ=;
        b=PMU/3x4xsO/Rj/hRbEauLli8mkqdIOKtQMB7ii5a3eMjtVpZIi6VRsrjbiIO+MZgLW
         vPnOPrsisJx88XrrZrAJZBSdRbMTMgAxBTL0KKy6n5BExojmUOug08hOgRUELJwWL/Yn
         JyEBRysfDu632mCN1/HKETMjK6KhWRrSMS2agToEbetb8WAb1AABCjZtK6CWjk2KuTPs
         kWI+OfMrQgT56BEGKNUnExKXdl6WND4iZ40M4VkojyCKU2MrjNrmB3e5oRNZ+PBeb4dZ
         7ribBiS+/Nb0dzA4R4iyjBJ/l1IkWM5oW8UST3w+5FGK9Q0//+DlR/U8DF6iQ1Hmskdc
         XurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715722230; x=1716327030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZurqd/gZ6QFwdhwsizttTDWmPh16bUHHZCUzWs7aTQ=;
        b=duvEjgXMPGt+rFZMEF2syHlZpYAcEq0SrKwPJt3nXJZxPecYGw8+Sul7GSXtgBOyrM
         fXWUU7ubQP2AMCvCNI7py73IoQMXGscN1whLnyeuhjnSDPfZj0nPv6Rf4OyeNaM6EOsU
         LwUfd6glGCN2tBjAlq4wCHasJ6yyrsB927d5cnkcR7ddCZXD487dTZisEG3+8u0/M2bA
         U8Iby0phfUKRwErIwSk4vM7UQ/3CStTppw1CL3Bpfi9a02vOYd+ltYQDeqeR2OVMKq/Z
         M/93wowjP0IQr4gowijmIxQtosNcmMgncJESWLkap8pM+OC60qoNiaQTuBlsupl7gIDf
         zX8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQhPtoPUiVntDhfoJhRfCB47M0qrzS60gknNgYm9tJjJVzAzZ3GS9EVHM67j41wkbSWg5HGJ0HB3NhjvHnbHEfqxGwg80SJtR74AVgeo4=
X-Gm-Message-State: AOJu0YzcsfCs9L6nVyCLKzRHkL6qOhPyeCo7DeEl+gA2t6SNVxTSAfXa
	OVjGMWl67OxXeBWI2P+IiOC7CIKrbXrUQyhb7yDIfm9vkc7wRPUP6PQkWhViDngWCQRlguRGfGQ
	LkOCjcCJl/74wAgHqIzmh4OpxCAo=
X-Google-Smtp-Source: AGHT+IEycJcbPG5zfCZqWOSZZTQntcgwvQT5RiO9XocQJvPSCsd1FEQKQGkcgRfm9DqQvfwhKyHU5zzYSuTd6dAI5uE=
X-Received: by 2002:a05:6871:e01c:b0:232:f9e0:e4da with SMTP id
 586e51a60fabf-24171730217mr6811949fac.1.1715722230103; Tue, 14 May 2024
 14:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
 <20240510134015.29717-1-joshi.k@samsung.com> <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
 <CA+1E3rLxUnuv9E_BxCFj1aodOTp3yrOEh7cFYt_j-Yz+_0q29g@mail.gmail.com> <88421397-1B95-4B2A-A302-55A919BCE98E@dubeyko.com>
In-Reply-To: <88421397-1B95-4B2A-A302-55A919BCE98E@dubeyko.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 14 May 2024 21:30:03 -0600
Message-ID: <CA+1E3rJtJpxk3EmTmtJWDFwP8km0xqRPt2QeQTRar7sTHtdD2Q@mail.gmail.com>
Subject: Re: [PATCH] nvme: enable FDP support
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>, 
	Bart Van Assche <bvanassche@acm.org>, david@fromorbit.com, gost.dev@samsung.com, 
	Hui Qi <hui81.qi@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_143035_430992_900204D6 
X-CRM114-Status: GOOD (  26.58  )
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

On Tue, May 14, 2024 at 1:00=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
> > On May 14, 2024, at 9:47 PM, Kanchan Joshi <joshiiitr@gmail.com> wrote:
> >
> > On Mon, May 13, 2024 at 2:04=E2=80=AFAM Viacheslav Dubeyko <slava@dubey=
ko.com> wrote:
> >>
> >>
> >>
> >>> On May 10, 2024, at 4:40 PM, Kanchan Joshi <joshi.k@samsung.com> wrot=
e:
> >>>
> >>> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the ho=
st
> >>> to control the placement of logical blocks so as to reduce the SSD WA=
F.
> >>>
> >>> Userspace can send the data lifetime information using the write hint=
s.
> >>> The SCSI driver (sd) can already pass this information to the SCSI
> >>> devices. This patch does the same for NVMe.
> >>>
> >>> Fetches the placement-identifiers (plids) if the device supports FDP.
> >>> And map the incoming write-hints to plids.
> >>>
> >>
> >>
> >> Great! Thanks for sharing  the patch.
> >>
> >> Do  we have documentation that explains how, for example, kernel-space
> >> file system can work with block layer to employ FDP?
> >
> > This is primarily for user driven/exposed hints. For file system
> > driven hints, the scheme is really file system specific and therefore,
> > will vary from one to another.
> > F2FS is one (and only at the moment) example. Its 'fs-based' policy
> > can act as a reference for one way to go about it.
>
> Yes, I completely see the point. I would like to employ the FDP in my
> kernel-space file system (SSDFS). And I have a vision how I can do it.
> But I simply would like to see some documentation with the explanation of
> API and limitations of FDP for the case of kernel-space file systems.

Nothing complicated for early experimentation.
Once FS has determined the hint value, it can put that into
bio->bi_write_hint and send bio down.

If SSDFS cares about user-exposed hints too, it can choose different
hint values than what is exposed to user-space.
Or it can do what F2FS does - use the mount option as a toggle to
reuse the same values either for user-hints or fs-defined hints.

