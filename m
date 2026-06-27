Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D15BC43458
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2026 04:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PVUT9pVKYl5aTfseZ4Q9L9bZE13G3ny4RYRZZRP5PHw=; b=Z43+ChNUx2o4+MkOdQzcBoMGnv
	PPWzuSpP59g4sW4yd5Q4dqUbCZJEXRxTnrdiwvGehpc/0dCr+NB3PnF++mag3P58HdQEYEOTKkMCv
	2/5uKr68bODNnQkBN8L0uUaeufuIcLyYIhsR1s85fH/LAzoz53KwAgUOkqoVbPFCZuajf5ye1j+vS
	JQI/v/okA8rRHxlkjV1d3C9ZPKJq1f0fJHMPyUM8WPyC+1Zj+1HR/adIQ/FgJ4QgeRrOpaKXFJqo2
	epFn1SCeBJTtQwwvM/xxaaEszdWvN9fnFeWaJFey0H7v9suBtEU90lZep2z3alWwxn/XwR7hrMvGB
	Kf6Ug0KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdKdi-0000000C8VG-3yRo;
	Sat, 27 Jun 2026 04:27:34 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdKdf-0000000C8Un-3UrK
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jun 2026 04:27:33 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-519ff1c8b8bso18009231cf.3
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2026 21:27:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782534449; cv=none;
        d=google.com; s=arc-20260327;
        b=XtiJwYjJxMnA3uFNJ7kuevEBOYMmufhcRtt9rAZqzePSsDrkyimnFBZVKhr/RsaApE
         XoOiflv3h9vAGOGjI3CMl7C3wW9HUXu3pcqnyMyS0xVuDHSAj31X4pJBEAPvQ7C8/N42
         U8xFJTl0fE+jaQBcAflSkh0n7FexPYm2MT87QaYl3BUltgj7Z+cJ5vkR/kGc/WAwZp4e
         DRHvXxbkF7QgPVWz2rKlafB90x9Ll2GccFyJ0Atg0kE5c5RJtgs33aPjjx6qQftlTulZ
         /1ph7YMek/iv+IsleLsNRglFGwrndSnhuSuR30mWqG3YLB4ifY5Te8h5TdurFVKEQ5T+
         kSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PVUT9pVKYl5aTfseZ4Q9L9bZE13G3ny4RYRZZRP5PHw=;
        fh=n1C4m2FPer5EvtDyPPZmCbRzdrtvMV+7gccgnB4U9Kg=;
        b=Sbs9uIbBFX0YBenJgyEWnNyB0StMOpCUMoVK9avAB4m9tkOtOYOKD/fg+ftaifDJSJ
         4pelqbdNFMW+V+eFZPrrXpKLWVggF9JaL6OLPzKvpmmOO1mbxGzyBfZSMplYAVDyeB6C
         iNknbCGtGJMlw2hxI4ydC5h9v/kOkDdkyRULxVFmz6DwhcNZgUdAMhMu4j81WMoERBDH
         GT+RZKJLhSwqu0Jx6VK18p0Xery+ObYCmGOX9p0JlPgLf+bOT1jQFCDi/531BEZvj/Aj
         gGWNcnIkp2UnIoMx4650inkUSHErpXc8afO8BvOvenveWaoBp8OagFKzfQTXlLvl/8rg
         Y4+w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782534449; x=1783139249; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVUT9pVKYl5aTfseZ4Q9L9bZE13G3ny4RYRZZRP5PHw=;
        b=KM7BfxwZP+k5tUtD35MOlciGfYapbMcoDPj5V7jOIY4musiVLoUQrrQRZW2SObhMt8
         EeKWMQW3CuUL/11erxQIfdYWi6Fiv/MERuJ4zHtIvzLSm/tCeeHNBo9o6IkgsGLiu0gf
         3tCpfdUEBF+WtUaZ7BEwhbtUS/mky3YieGkoBUQy0vAMJ7dEwxOur4fEYsC9Sj3GYUis
         xjcCaR+u9Dod05Dm7T+k1y4LWfsvIaxxschALEV8XS+cRaYP0fM8QROQbvx2vVu9Cz4m
         J6B98foI30WM9jMWr462QUy2UAxQTiSgQg+LXmphTFDsHH4o0xPwXWh6sDwxF7PUwa2k
         Jc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782534449; x=1783139249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PVUT9pVKYl5aTfseZ4Q9L9bZE13G3ny4RYRZZRP5PHw=;
        b=bU7fl/dKKVTgMHg80KouIbsCja+XX+c8Vya4Ct5wgsz2jfxpwSUkB8+nzkSVeFyGcm
         ERh7sGazi5mJygAZ8Z4uWXFIgP6tVvIzzJkUEoAATGO55mliFCtnjVcTGlF6Z2jZoZDR
         xGXqHt+4ODuhMGhZZltmnYrGC2OTUhRNav1itljnj7Y3sa5CCsujFRlTpoWtCRyYFdfk
         Qx4RYHdLnBkBIqfV6b3NhU+5N9cnpTbClOVufmXqiWw9G9hWRXTw1kSgCKh/RheuwavR
         pGTz11K8ID1ReGih8/LxhLG9KYgVkzGGg9w8f+AwnDfWpFdisOHPql/KGNoC/5jfZ2+a
         6kdw==
X-Forwarded-Encrypted: i=1; AFNElJ9hga3abi1yZ2dN/wNykscYZwT/09Li7vhvIFHyLGa+r167F0MdM04FSEdTPLWWWr/BvwOZPIAg6oBD@lists.infradead.org
X-Gm-Message-State: AOJu0Yzu0k1uuE3hiYsquwxr34XNwFsh/5tHrqaEkrwWM/NEQ5r4VctQ
	M2ugEHCEtj4j0tJh3lUril5alQdacXxllM7cQ4Gb6RJFUDk7jpIDxUoZh4EXU/ggqv285yo4Nbt
	B44oM0zCBL1XIYMLq81+6HmivSHdb0T+i6seOLZQrVlzpLzIunbfRL1I=
X-Gm-Gg: AfdE7cl09XOOgMgVyo6DkA786oDDA3CAW1DTZoTaLErh6TLrNImWfJzZ+wB03LbeKO0
	cMIfDCO8o4RLTFjdoq1iSZ7/cokb5h4koF/0L4V318moN19v7sFn2VHHc1DeGssrw6V51vpd75z
	HpvxoQn1esloq7GA1zHRvK9hpwDAGJVlj/cbIIwUlE3JWeuUXadoiBqbeksLgY/J/khNRBj1wOL
	3fhugmsuRfoY76YfPlH17B+cQ0yHxHF05veXacGtTiKCKJ3xgoQNQNfJqByu6bmw1wXADbw
X-Received: by 2002:ac8:7d81:0:b0:51a:8f63:9e18 with SMTP id
 d75a77b69052e-51a8f63a7eamr25685661cf.33.1782534449087; Fri, 26 Jun 2026
 21:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260625212722.1302344-1-sgogte@purestorage.com>
 <20260625212722.1302344-3-sgogte@purestorage.com> <20260626074004.GB12072@lst.de>
In-Reply-To: <20260626074004.GB12072@lst.de>
From: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Date: Fri, 26 Jun 2026 21:26:53 -0700
X-Gm-Features: AVVi8CdatJc8oCtpt9Lu4K3xJytFDiv8BvMb2K2B6dC9vDi5AmNL0O7HVp6C39U
Message-ID: <CAMof9cWSDR=z-0ziBj0OV7S95H+uhHX23PMOK65LHNPhFaso3g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] nvme-rdma: parallelize I/O queue allocation and startup
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mkhalfella@purestorage.com, randyj@purestorage.com, adailey@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_212731_883220_24A97F31 
X-CRM114-Status: GOOD (  19.50  )
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

On Fri, Jun 26, 2026 at 12:40=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Thu, Jun 25, 2026 at 03:27:22PM -0600, Surabhi Gogte wrote:
> > -static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
> > +static int nvme_rdma_setup_io_queues(struct nvme_rdma_ctrl *ctrl, unsi=
gned int first,
>
> Overly long line.
>
Yes. My bad, checkpatch didn't catch it. Fixed in v4.

> > +             unsigned int last, size_t queue_size)
> >  {
> > +     ASYNC_DOMAIN_EXCLUSIVE(queue_domain);
> > +     struct nvme_rdma_setup_ctx *ctxs;
> > +     int nr_queues =3D last - first;
> > +     int err =3D 0, i, ret;
> >
> > +     ctxs =3D kmalloc_array(nr_queues, sizeof(*ctxs), GFP_KERNEL);
>
> This should use kmalloc_objs in the brave new world.
>
Done.

> > +     if (!ctxs)
> >               return -ENOMEM;
> >
> > +     for (i =3D 0; i < nr_queues; i++) {
> > +             struct nvme_rdma_queue *queue =3D &ctrl->queues[first + i=
];
> > +
> > +             queue->ctrl =3D ctrl;
> > +             queue->queue_size =3D queue_size;
> > +
> > +             ctxs[i].queue =3D queue;
> > +             ctxs[i].err =3D &err;
> > +             async_schedule_domain(nvme_rdma_setup_queue_async, &ctxs[=
i],
> > +                             &queue_domain);
> >       }
> >
> > +     async_synchronize_full_domain(&queue_domain);
> > +     kfree(ctxs);
>
> It would nice if the async domain had a way to do the error propagation.
> Well, that would be a nice follow on if you're interested.
>
> Talking about follow ons:  do you plan to do a similar change
> to nvme-tcp?  It would be great to keep the setup path for
> both in sync.
>
Yeah, there are plans to expand this to nvme-tcp as well.

