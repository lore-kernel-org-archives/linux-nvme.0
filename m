Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E274C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Dec 2022 20:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qFTi/EIm231UDoHzwjip2wcifKLUtbEyBimAW5q1nBE=; b=YDtgk6sAIDGPMMfRfENf/VuD33
	ZIJbfBqoG8ycPhZqY3kxss8c1ouRUwdxS/T7ZrjlMot3pAJTHIZ255rl2CiurYQ7M96cTWwxrXQct
	A8yegZ1wOTGmIHEpSx3+ZSlgpUayXNt0kHL97nNtPKFGGSDqdGUnDaWX0wygtdYakpKWTgpeWlkEO
	Gp+AtfRKBL0+xkIUKX4x8DoDHGPgHB9UDsNUYd3SL8aq1o1vjLI7+Z/lxVQ26iuchYm4FjvzRDHDp
	6Fq7vQj6SemoehyaCwv6bKf+sDmd1YI4dRXfy8Y0vKmp1gGbvE2TkFDfMarMasTB4gUP3ojz1JZ8m
	Bs82Yptw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2IBp-00ALj7-HN; Mon, 05 Dec 2022 20:35:49 +0000
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2IBm-00ALXZ-24
	for linux-nvme@lists.infradead.org; Mon, 05 Dec 2022 20:35:47 +0000
Received: by mail-vs1-xe29.google.com with SMTP id d185so12309011vsd.0
        for <linux-nvme@lists.infradead.org>; Mon, 05 Dec 2022 12:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFTi/EIm231UDoHzwjip2wcifKLUtbEyBimAW5q1nBE=;
        b=G9/2zHyJAXWcLuG4CYYyDjsG3wMQ+Os78SrW5PLI0KZyqUQjyjJZWffOpaCYYaa7MU
         yJANfMjLRG8buM1qJRbmILUqUfPnAFeQA1F0rEa1D3JT6KED/tfkZow4zbXMtCKFV6OD
         1GvXvG995vkCUOe4/QGVnnXXgb5WxIRtRwC+rbj1M5ZRSI0nVc5sEfhNPNTf+OawlBFX
         gPzpi4SSqAIYKEZjgN/zEJNeTqGl6zPS7nFdofdcc5ViXPF95cdbLpxH+ZztK+PvZYHZ
         jw7mNAVQUcSxpAzEJwScRLj7Bxuy0Y9vxkuz/6G3412+YK+BEu/6Glz92iyCcjjY30qE
         F8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFTi/EIm231UDoHzwjip2wcifKLUtbEyBimAW5q1nBE=;
        b=4+hCZjoGFEWKgnMWkfnpbHW4oNo9hWx4ghPBs9G8FF727uawFDlorflbKeyN9ln7bG
         J3VEHLgUYneJI1w2u99JPfr56DyyembF2JU5czQGbfzD3ooMxH/NzkgPY0QH7WRiTsTy
         NqEDoPTbygJakaciP1ruTf9d27dX6avIiALS8Q2nC8V8JREqzKC/qNgDkgY59O/d/QL6
         LgLKazBlFMT8j9GzIRMW4F5yHaY2Qt4qsvrJgMkQKlr5zbDDvBm/NePbbHSi1iqpCfmr
         djKZLccJ5tV7IVrm1YslWUo16XB/Y6WY0P9XAc2vq+kP2JyHndPFw1ty0AO1BFTQrmLI
         rtCw==
X-Gm-Message-State: ANoB5pnp1s1tCVeQ/affEFZhIFGagIDrCq1Vf7sC5PSlF9SEJNO+e1dA
	ln1VXSuFr2FBksUDON8QyfDaYoTy1KP3uQkifQa2iQ==
X-Google-Smtp-Source: AA0mqf7MB2LLmyAgUEmc373KKoUMFotSP/Hm9OtWsUgrY1RZnvtlRZ/+/FkhUm+SUZshtLHs/8QlYlIHB++A57PkUUg=
X-Received: by 2002:a67:f88c:0:b0:3b0:dbae:4115 with SMTP id
 h12-20020a67f88c000000b003b0dbae4115mr12656784vso.32.1670272539806; Mon, 05
 Dec 2022 12:35:39 -0800 (PST)
MIME-Version: 1.0
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <fe2800f1-aaae-33e8-aaf0-83fd034162d5@kernel.dk> <CAJs=3_AKOMWBpvKqvX6_c=zN1cwEM7x9dzGr7na=i-5_16rdEg@mail.gmail.com>
 <23c98c7c-3ed0-0d26-24c0-ed8a63266dcc@kernel.dk> <20221205152708-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221205152708-mutt-send-email-mst@kernel.org>
From: Enrico Granata <egranata@google.com>
Date: Mon, 5 Dec 2022 13:35:28 -0700
Message-ID: <CAPR809siFTeKSVxGPmnWpbyKHKoiVY-YYVV+Wzv2bVtvc4XBfA@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	dm-devel@redhat.com, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_123546_123100_835BC0C1 
X-CRM114-Status: GOOD (  24.96  )
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

The original definitions for these fields come from JESD84-B50, which
is what eMMC storage uses. It has been a while, but I recall UFS doing
something pretty similar.
Systems that don't have a well defined notion of durability would just
not expose the flag (e.g. a spinning disk), and going for what
eMMC/UFS expose already would make implementations fairly seamless for
a lot of common embedded scenarios.

Of course, if you see room for improvement to the spec, I'd be very
interested in hearing your thoughts

Thanks,
- Enrico

Thanks,
- Enrico


On Mon, Dec 5, 2022 at 1:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Dec 05, 2022 at 11:53:51AM -0700, Jens Axboe wrote:
> > On 12/5/22 11:36=E2=80=AFAM, Alvaro Karsz wrote:
> > > Hi,
> > >
> > >> Is this based on some spec? Because it looks pretty odd to me. There
> > >> can be a pretty wide range of two/three/etc level cells with wildly
> > >> different ranges of durability. And there's really not a lot of slc
> > >> for generic devices these days, if any.
> > >
> > > Yes, this is based on the virtio spec
> > > https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd0=
1.html
> > > section  5.2.6
> >
> > And where did this come from?
>
>
> Here's the commit log from the spec:
>         In many embedded systems, virtio-blk implementations are
>         backed by eMMC or UFS storage devices, which are subject to
>         predictable and measurable wear over time due to repeated write
>         cycles.
>
>         For such systems, it can be important to be able to track
>         accurately the amount of wear imposed on the storage over
>         time and surface it to applications. In a native deployments
>         this is generally handled by the physical block device driver
>         but no such provision is made in virtio-blk to expose these
>         metrics for devices where it makes sense to do so.
>
>         This patch adds support to virtio-blk for lifetime and wear
>         metrics to be exposed to the guest when a deployment of
>         virtio-blk is done over compatible eMMC or UFS storage.
>
>         Signed-off-by: Enrico Granata <egranata@google.com>
>
> Cc Enrico Granata as well.
>
>
> > --
> > Jens Axboe
> >
>

