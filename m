Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C93C04FFE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 18:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9vm7+VMJI/p0xhaVdX07ViEoUrsc6h67q1AxKlBgBZ8=; b=eTtq/ByprxDn67uOwbAZufGC3Q
	oczdoWh2R6jI1npgnxASMLc6wtOHzYrKVuVpTc9ZEG6nsAME9g/p4pJXj/jlUPeX+nExUHhYeYn1v
	cFqDgTJlOek7gKN2oO2mXQk717MaUWjDmXLpT18em6dPMrbDAVngy+WxqiXakLdx21ec0IWWc3vP2
	mXjdC+CyNiJHHtZ0/jVAj8d5V9hEghogxqskZQORKM3tt0m7yZ3eBUwF2tcsfguJJBTc8xUU4belC
	XtT23shUaSdGlox2XiI1IKnjJ1AMY4/P2r0GHVWXyrer6mgde+JzsEWbVPVnsTUMAa4d0eWBvydi9
	apIhaC9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6xCQ-0000000GtLD-0Y2s;
	Tue, 14 May 2024 18:48:30 +0000
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6xCN-0000000GtKY-21lC
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 18:48:28 +0000
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-23f0d54c5ffso3839597fac.1
        for <linux-nvme@lists.infradead.org>; Tue, 14 May 2024 11:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715712504; x=1716317304; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vm7+VMJI/p0xhaVdX07ViEoUrsc6h67q1AxKlBgBZ8=;
        b=HGf/NPXHjR2lNawNpk6ic0G+B4woWgszbusA0THaFoQ0le2KFXEC35fjAbtBxna0fT
         EB16qiXZCpZVTgVD7vSba86KoJ8m2Ud8BitSIpZl/tPM/Fiuz8BE/cYxkUj1jHHR8mnV
         ixQ+LiEqbJWfso2mcZNBdCpkoEAHzYsrCT65kJqsjuYguJdzQi2jPjUAJ83DWibLqHzw
         z8Gf+kRq6NryoDP9OAuqj1AwHjvx+3KIQEs46cJhFePmU6JP3ACYQVjanK5VSIFuTPsY
         DJYLIM4V9+1BB83d8YsbL4llqqQYbFxHdyAr5v47SawFJ5rU5wxY1yYjV3KcC9jlz4yK
         eWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715712504; x=1716317304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vm7+VMJI/p0xhaVdX07ViEoUrsc6h67q1AxKlBgBZ8=;
        b=dWEzr34czJnWuuUI7uOiQXChDyoH8osPnt2K+KGkSmcj7x6NhdD+kdgx71S054bfBH
         jfSFYCJyhMXcwnGNZlcbbve4Bs3iwlScZNnjtD7rLqPudPqif8jT25HI4QApehsnLpvP
         J2ciJcyYxJxEC5+YRK9lu60hLtyMpUeJlRM3v6Pd0rWPZJj+p9PlqJbsHP2eM5+maNpH
         GrGevYGOmJT9Nait5FWkHa6fhZnaTCN8K4HlOC6nCXfhYk2CC54oPrt1qBAiwpabs5BU
         EVkl89NipKPZEh5vPw1bPQsjgPwBA7SWh/eCw5cZWdRBR4E+czI52r98fZSG4ghTuP2d
         /aTA==
X-Forwarded-Encrypted: i=1; AJvYcCURgKoBEVzzbvmdB2IiQziUctL9iSjv2iiMy2opYak6Fa5gMQye+3bxQXyUZTrziNuAqOqsty7P+zdZCTxx+FzzxS/3+v4b66rAcJfHW2s=
X-Gm-Message-State: AOJu0YzSTmAEC2+YN7IgMU1+7FTAjhhidl9QEM5COleyR9dgjz4V/yfu
	PR2q0+QR5Uyhs89094pX46H/KrFsOixNqq5xMbPUMumz1FjXaLsh3d2d7QQiR+H93mOvNI4FxhY
	ws0NrJbJ83f+4etjdxrLsvH6d2cc=
X-Google-Smtp-Source: AGHT+IFTQ7WgnbVLfRh0vq9jLeG2jKiPAvDtPHj0qMEaP/Z4591SQ00dylSYeDQjDQGRWtYT5tsDRKs6U0EZSj2FSxw=
X-Received: by 2002:a05:6870:c0c8:b0:233:b5ef:3bab with SMTP id
 586e51a60fabf-24172a3d9famr14795380fac.3.1715712503908; Tue, 14 May 2024
 11:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
 <20240510134015.29717-1-joshi.k@samsung.com> <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
In-Reply-To: <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 14 May 2024 12:47:57 -0600
Message-ID: <CA+1E3rLxUnuv9E_BxCFj1aodOTp3yrOEh7cFYt_j-Yz+_0q29g@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240514_114827_547711_3F0BA570 
X-CRM114-Status: GOOD (  18.29  )
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

On Mon, May 13, 2024 at 2:04=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
>
>
> > On May 10, 2024, at 4:40 PM, Kanchan Joshi <joshi.k@samsung.com> wrote:
> >
> > Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
> > to control the placement of logical blocks so as to reduce the SSD WAF.
> >
> > Userspace can send the data lifetime information using the write hints.
> > The SCSI driver (sd) can already pass this information to the SCSI
> > devices. This patch does the same for NVMe.
> >
> > Fetches the placement-identifiers (plids) if the device supports FDP.
> > And map the incoming write-hints to plids.
> >
>
>
> Great! Thanks for sharing  the patch.
>
> Do  we have documentation that explains how, for example, kernel-space
> file system can work with block layer to employ FDP?

This is primarily for user driven/exposed hints. For file system
driven hints, the scheme is really file system specific and therefore,
will vary from one to another.
F2FS is one (and only at the moment) example. Its 'fs-based' policy
can act as a reference for one way to go about it.

