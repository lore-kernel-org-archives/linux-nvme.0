Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F2AC54756
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 03:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HBScnbgXfYg1npgwMt1RM7LKDOWbnQ9o/suv1Pq/r6w=; b=MK6W5WkZ0fcxJnhrYh2ifr+bNa
	DCRFmZALRnGtiU0AQZLP3mkJjHLKjD2nJIkJozX24N+Cgw9J3BDwAhJr3eH13mqgNBIliSqHSM96d
	/9+tvpjDfh1nC1NhDtPZrS4Wd74nCGZOTCzbjLl98UbItl0ewbfi8dl8QrPYVS5n+O/komEHFiuJc
	oxBZqiXSSK2Br/QGpECNHL6QylCsjnYcvm/AFuxSWowRihbFzVklpN8AH4R4qQPuOfc3hyuEVFiN3
	hGJuYmXrN2ZHLRe91fdkDQLrAwyV8xR2MXHdTb0hMnxzdwJcB3zgNtk7Dv42Boh3+99mdd0RnKOSy
	bPhnYJSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHwod-0000000HM3a-2Cvy;
	Thu, 22 May 2025 03:41:55 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHwoa-0000000HM3C-3Ol0
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 03:41:54 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-30eccc61f96so868407a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 21 May 2025 20:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747885312; x=1748490112; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBScnbgXfYg1npgwMt1RM7LKDOWbnQ9o/suv1Pq/r6w=;
        b=a651iD8ou3dkT3irh55EgIG7OQ2irMoglGjvSdNNgYIoLNxYiOSWrJ1M59lvNoOnHR
         i9dRPkcBgsAROhY2wwelgmGQ9U0JvCn8DC1dzvP55AfIi7Vj47mbA+Bf5qFpR48JAY7A
         c/kOkHekjGQ6mBQS4r4EZOT5cpGg6/Cq044oZpG7jJXFQwc7T5eaim6cSqdpBk8JS4Ud
         dBuVDtbS0mcbF1QqiYXIJrdqldK7fgsSOfcxRfhd11f9l1LfvYzrh43oPMfeFAc+RLnD
         jO95R0mxObvrOZ1cl/koU8LXgHWtGaI4kQXp7Jp0V9Pj1apjuy6oX+ak5TUwlrhkSW/v
         cB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747885312; x=1748490112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBScnbgXfYg1npgwMt1RM7LKDOWbnQ9o/suv1Pq/r6w=;
        b=nYzU4mLaiRJP30JMMqtdgME2ql2FNuqTOMjiB8l1acEE9O1uxdGRvxk66o6QJ1JAV7
         h/ZFZ+aLfLl8TPEfms6EqV+UXWhbULXO3hq27JQyV9/jF2CYUiOwdNi8pDckkZBYLDOw
         zLFmX048doGzNX/e6H5gfHC+Ao8QUo4KOzB4+Me9GB7VsjC9UiuzWfZhPEILScpNQdRS
         h07LzJQ/f7gH/+7MjjFItsvf5d+99CQqpL4Z8ORhQd2yldtIlMQQOM4d72DbgASbBjnk
         3SpKh/7VOgUi/LWlRIrF3dV+JzoFWJHt+cKrzOWGUD5SYHk5ygzx5Yxv8A42WUEo/KHz
         6fog==
X-Forwarded-Encrypted: i=1; AJvYcCXXRV8QYRTLTppwOQ2Xu7W2S6IBrLUs1Xp6pjnp1wsqko0pEZZxMbCWNXo3IHqtvhXP/zMnL1A4QIYz@lists.infradead.org
X-Gm-Message-State: AOJu0YyozOFKC/Mnzbk8EkxyqLDiHWHhvPEM2hl8lXsr91/LeaqdpKXW
	1tmGbndbj7AQHYSItOM8NY4fPWGf0M1/8nwZSVXKRVqQqfyobCCA5GtSCP3OePponwWI5/EszGq
	16iG5fxsuYZrw3VG86gUMM9dA0NXzeBuQap6B3IhIsQ==
X-Gm-Gg: ASbGncsQBe285IecdaKnVwHIrM+GnjhumvtitKN3BqGvogjqDGL+Brxp7x0N7aoaey7
	/iDepNKdlc9uPF20QPW1V0pHNuM4n7rOzsnStm3E8ekSDxtN82e1QmzoDxDsBTeB5DgvnZ0vMND
	pkdMoAZrs9zK7NXYNsp8XG+yqtbtLc4pk=
X-Google-Smtp-Source: AGHT+IGda+5bq83C2vCx6Qhv8W1Rt9AFozwlZQHFi8YdLSvUxrGZKF3CwqMWcxGA9bKJgBLgVx39dE+l/sNjWXxBNn8=
X-Received: by 2002:a17:902:d54c:b0:224:10a2:cad1 with SMTP id
 d9443c01a7336-231d45168bcmr132689515ad.10.1747885311779; Wed, 21 May 2025
 20:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250521223107.709131-1-kbusch@meta.com> <20250521223107.709131-4-kbusch@meta.com>
 <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
 <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com> <aC6Ymfrn1cZablbE@kbusch-mbp>
In-Reply-To: <aC6Ymfrn1cZablbE@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 21 May 2025 20:41:40 -0700
X-Gm-Features: AX0GCFsQfzu0SNWx-sq1Kg89QEuY68BuwaPPePwdWhEJwqQoCBv44eCGmxTu4u8
Message-ID: <CADUfDZr8DJUPhLvVFK9OPSv015VDSBGNv7z_rrioHFAqOALUOg@mail.gmail.com>
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_204152_887239_24F00736 
X-CRM114-Status: GOOD (  21.34  )
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

On Wed, May 21, 2025 at 8:23=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, May 21, 2025 at 05:51:03PM -0700, Caleb Sander Mateos wrote:
> > On Wed, May 21, 2025 at 5:47=E2=80=AFPM Caleb Sander Mateos
> > >
> > > alloc_size should be sizeof(*range) * i? Otherwise this exceeds the
> > > amount of data used by the Copy command, which not all controllers
> > > support (see bit LLDTS of SGLS in the Identify Controller data
> > > structure). We have seen the same behavior with Dataset Management
> > > (always specifying 4 KB of data), which also passes the maximum size
> > > of the allocation to bvec_set_virt().
> >
> > I see that was added in commit 530436c45ef2e ("nvme: Discard
> > workaround for non-conformant devices"). I would rather wait for
> > evidence of non-conformant devices supporting Copy before implementing
> > the same spec-noncompliant workaround. It could be a quirk if
> > necessary.
>
> Right, that's exactly why I didn't bother allocating tighter to what the
> command actually needs. The number of devices that would have needed a
> DSM quirk for the full 4k was untenable, so making the quirk behavior
> the default was a sane compromise. I suppose Copy is a more enterprisey
> feature in comparison, so maybe we can count on devices doing dma
> correctly?

For the record, that change broke Linux hosts sending DSM commands to
our NVMe controller, which was validating that the SGL length exactly
matches the number of data bytes implied by the command. I'm sure
we're in the minority of NVMe controller vendors in aggressively
validating the NVMe command parameters, but it was unfortunate to
discover this change in Linux's behavior. We have since relaxed the
validation on the controller, so we wouldn't reject these Copy
commands. But the extra data in the NVMe command is still wasteful for
transports like NVMe/TCP in-capsule data where the entire data is
unconditionally transferred to the controller.
It would be great to start with a presumption of spec compliance. But
by all means, if we find a significant fraction of controller
implementations can't tolerate a sub-page data buffer, we can apply
the workaround from DSM.

Best,
Caleb

