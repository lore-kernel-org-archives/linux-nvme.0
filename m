Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B645CEF148
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 10:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F14OcwqLVp3hHp+0VqT30x2kelDO/WiLYxpL7cfOOhI=; b=ZUniFq2ynYPTj4Hq7+r7LBVHdr
	73nGoziPshpHnrb1Qx++vGYi1Jcae+Cjgks3L6bwlSMXPwjY1CnA596OnLVKnQY36KyeZ6BgZbklE
	c9Ngd3FcrtsbGVcWoFDBWD/u+5uQOlGov4Oh4GbYYhZ2P9eYw1L3ZD0IoEQuJ9AwVypsxtJpwKgHN
	qV4Z1AxopPFPayqgh1cyytTSyW0oDeesAPAZiTT0rGdXiTBKf7+4HGDs7UdJNo4ISwD1jNT0TCc4Q
	rOWP9ycXnTwe6mRL7fRyTZAJk2bzcS7oFRM6vNOPNQrKOfL2T+L7wh4AW4bPlEJP1ZK5sciX8g5et
	7z4UEygQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy78Y-00000005PoN-13Du;
	Tue, 08 Oct 2024 10:08:14 +0000
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy77T-00000005PcU-0izE
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 10:07:08 +0000
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-53993564cb1so6024517e87.2
        for <linux-nvme@lists.infradead.org>; Tue, 08 Oct 2024 03:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20230601.gappssmtp.com; s=20230601; t=1728382024; x=1728986824; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F14OcwqLVp3hHp+0VqT30x2kelDO/WiLYxpL7cfOOhI=;
        b=gcOd1BfhyFxLayGUDm1kNPt3Wc/jEmeNfMSQh8GjxkuIOedAoPdWOD/tZ3G5wEYp8+
         EP8KdbDb78tgKVoQsCYckuKnK9z7uS64WDDJiXeJaEja1/Hl6NTQEHvC04O6wITK9fw/
         euh4hXRmXWIVzP3eBgIiNQFXMsdXy3P9t4MlmvRAaHel8wodQWZwfxShVYxTATp/YiI4
         /ar+77SYqL0A+W7GoQ48qnCAqnIZ54uoVWCU2Abr3LI4z12xp8dU+fz9YCOFRewTSaf8
         HUT6uDXEKOqUaR0RU5KLEd32ZEiNkURRPkvixGJmMfA4ltP8BEakX+ZLMwA6Plzk+TvS
         wPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728382024; x=1728986824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F14OcwqLVp3hHp+0VqT30x2kelDO/WiLYxpL7cfOOhI=;
        b=hA/pIQdzxjlmiZgocvTjPZV7IdYWMWlu8lVgZbfD63B8ye3Bkl5HTvuwoVLd0dTQh+
         LBzCtVe/gQKbXQV1UUPfgIuarvJO0ZtmCfM2unq0ICWchOmahP6zbr3JVxA52jMH3dNU
         3m2towTV7n10q9ADsOg9kfBRrYSQfAAQppIaX/dUVolwIZlci25b4gw9e5xUEmXIrCRK
         C+euP4ZoW5cn+YHIM7mRS2pfu38rOHxRr8qDp5w2G7ZRBgRH0kvwCbm7K8ap3qzAWa5P
         URE1yPBfWGEc00k/OuwwY2+P0o2eguvdBoXOXeN4W2aFGPZxb6UOK+6Zd7Yp1h23xhtE
         bmZA==
X-Forwarded-Encrypted: i=1; AJvYcCU1q57BI7VKjBnN8jh87voUcRuXVanvyiJxCDZQvjDEF//x9f9nnqXi5zcEn6WSV6QRDyBnpQc1iq8G@lists.infradead.org
X-Gm-Message-State: AOJu0YwBElQ3TNhmo7B9AccDvXuZEzrMp33y2E/A7AfboF9TKfaklccR
	AjimrUOTTyN4srBaQFrwhN2LGChHYg9hIzs/ustn7bBPNICMEofbrPedkxI3JdMm5wfMg00rW7H
	JgXe6IazhSCGXkiOjO1jGa9VNYnhxaeTMjzEG4A==
X-Google-Smtp-Source: AGHT+IHEOz/KdzlVozdD6OTXUfqUHVvxbJDxNr/5ySZvwaMHkV92VlsUI1hujJ58x1Kd6zWF/HBp1CPSJYsPE68+4OU=
X-Received: by 2002:a05:6512:3088:b0:539:9746:2d77 with SMTP id
 2adb3069b0e04-539ab9c704fmr6383065e87.61.1728382024131; Tue, 08 Oct 2024
 03:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com>
 <20241003125400.GB17031@lst.de> <c68fef87-288a-42c7-9185-8ac173962838@kernel.dk>
 <CGME20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b@eucas1p2.samsung.com>
 <20241004053121.GB14265@lst.de> <20241004061811.hxhzj4n2juqaws7d@ArmHalley.local>
 <20241004062733.GB14876@lst.de> <20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local>
 <20241004123027.GA19168@lst.de> <20241007101011.boufh3tipewgvuao@ArmHalley.local>
In-Reply-To: <20241007101011.boufh3tipewgvuao@ArmHalley.local>
From: Hans Holmberg <hans@owltronix.com>
Date: Tue, 8 Oct 2024 12:06:53 +0200
Message-ID: <CANr-nt3TA75MSvTNWP3SwBh60dBwJYztHJL5LZvROa-j9Lov7g@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>, 
	Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org, 
	dhowells@redhat.com, bvanassche@acm.org, asml.silence@gmail.com, 
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-aio@kvack.org, 
	gost.dev@samsung.com, vishak.g@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_030707_490509_EDEC0C37 
X-CRM114-Status: GOOD (  45.79  )
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

On Mon, Oct 7, 2024 at 12:10=E2=80=AFPM Javier Gonz=C3=A1lez <javier.gonz@s=
amsung.com> wrote:
>
> On 04.10.2024 14:30, Christoph Hellwig wrote:
> >On Fri, Oct 04, 2024 at 08:52:33AM +0200, Javier Gonz=C3=A1lez wrote:
> >> So, considerign that file system _are_ able to use temperature hints a=
nd
> >> actually make them work, why don't we support FDP the same way we are
> >> supporting zones so that people can use it in production?
> >
> >Because apparently no one has tried it.  It should be possible in theory=
,
> >but for example unless you have power of 2 reclaim unit size size it
> >won't work very well with XFS where the AGs/RTGs must be power of two
> >aligned in the LBA space, except by overprovisioning the LBA space vs
> >the capacity actually used.
>
> This is good. I think we should have at least a FS POC with data
> placement support to be able to drive conclusions on how the interface
> and requirements should be. Until we have that, we can support the
> use-cases that we know customers are asking for, i.e., block-level hints
> through the existing temperature API.
>
> >
> >> I agree that down the road, an interface that allows hints (many more
> >> than 5!) is needed. And in my opinion, this interface should not have
> >> semintics attached to it, just a hint ID, #hints, and enough space to
> >> put 100s of them to support storage node deployments. But this needs t=
o
> >> come from the users of the hints / zones / streams / etc,  not from
> >> us vendors. We do not have neither details on how they deploy these
> >> features at scale, nor the workloads to validate the results. Anything
> >> else will probably just continue polluting the storage stack with more
> >> interfaces that are not used and add to the problem of data placement
> >> fragmentation.
> >
> >Please always mentioned what layer you are talking about.  At the syscal=
l
> >level the temperatur hints are doing quite ok.  A full stream separation
> >would obviously be a lot better, as would be communicating the zone /
> >reclaim unit / etc size.
>
> I mean at the syscall level. But as mentioned above, we need to be very
> sure that we have a clear use-case for that. If we continue seeing hints
> being use in NVMe or other protocols, and the number increase
> significantly, we can deal with it later on.
>
> >
> >As an interface to a driver that doesn't natively speak temperature
> >hint on the other hand it doesn't work at all.
> >
> >> The issue is that the first series of this patch, which is as simple a=
s
> >> it gets, hit the list in May. Since then we are down paths that lead
> >> nowhere. So the line between real technical feedback that leads to
> >> a feature being merged, and technical misleading to make people be a
> >> busy bee becomes very thin. In the whole data placement effort, we hav=
e
> >> been down this path many times, unfortunately...
> >
> >Well, the previous round was the first one actually trying to address th=
e
> >fundamental issue after 4 month.  And then after a first round of feedba=
ck
> >it gets shutdown somehow out of nowhere.  As a maintainer and review tha=
t
> >is the kinda of contributors I have a hard time taking serious.
>
> I am not sure I understand what you mean in the last sentece, so I will
> not respond filling blanks with a bad interpretation.
>
> In summary, what we are asking for is to take the patches that cover the
> current use-case, and work together on what might be needed for better
> FS support. For this, it seems you and Hans have a good idea of what you
> want to have based on XFS. We can help review or do part of the work,
> but trying to guess our way will only delay existing customers using
> existing HW.

After reading the whole thread, I end up wondering why we need to rush the
support for a single use case through instead of putting the architecture
in place for properly supporting this new type of hardware from the start
throughout the stack.

Even for user space consumers of raw block devices, is the last version
of the patch set good enough?

* It severely cripples the data separation capabilities as only a handful o=
f
  data placement buckets are supported

* It just won't work if there is more than one user application per storage
  device as different applications data streams will be mixed at the nvme
  driver level..

While Christoph has already outlined what would be desirable from a
file system point of view, I don't have the answer to what would be the ove=
rall
best design for FDP. I would like to say that it looks to me like we need t=
o
consider more than more than the early adoption use cases and make sure we
make the most of the hardware capabilities via logical abstractions that
would be compatible with a wider range of storage devices.

Figuring the right way forward is tricky, but why not just let it take the =
time
that is needed to sort this out while early users explore how to use FDP
drives and share the results?

