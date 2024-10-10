Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61A5CF07B5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 06:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YtBMnssoGmOPP9k5G7rkH9LuSOvCJReyj8Ng4xiAyNw=; b=hy1C751hh/cwX8486E8h2ZJXET
	QcD3r/AiKPsFskbFK1eMp9/ULXvXxHH3mkgDGeEUZ+FXqhVu6BPnBNR33i+mQwiPlWpBy/y0AhRvo
	S5sgNC8xzp8qFZfM9A5OLSao+r6efbF56WUsMw/Bo9ctvgL8Wc4KQYxzmtDo0JrEI6SFGo0sIqu2L
	Y/5+640THMaLvczNFosRg4axOIjDAovb692bWrbm11qPBkr8oYLQfgbG7X9k17mF2VBeaa+ABAnwG
	Hkje0eMZ4cvKULGOPC/wpyvg6Iv+H455yaxnsZynl+bLnKWhZFGyW/62U/Je5KconcV93HhDILebL
	RCWd9D9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1symvr-0000000Biy4-3ZI6;
	Thu, 10 Oct 2024 06:45:55 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1symqi-0000000BiGV-1R9S
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 06:41:03 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5c915308486so674632a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 09 Oct 2024 23:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20230601.gappssmtp.com; s=20230601; t=1728542434; x=1729147234; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtBMnssoGmOPP9k5G7rkH9LuSOvCJReyj8Ng4xiAyNw=;
        b=neyjqZPQfi32a0Ix79iudziF9hQijRJnMbzBh3DXgWTcyE+SZP0+SAHTykgqmfbJgD
         7tOzpLteWDuuhM+i5uZiUl37cTMb1A8sh8zLqbF+GdSOw9/xoFMfH2MXTfKvFvpYT+Ob
         BW1vUMXz4+Pg7UVkp/MLs0NFtjEXQ7FY8lRj+GrxP1xKvq8BhTBPtzEOsi0Yw4wbeuLL
         su917Mgc0DXFk8rg88FyTz0SNMjhWe0iLWelDEUCn9TFd7bpIBChIGr1hYmPDqs2/pG0
         lY2614XChVjO1Cgb6cfrYRgnfQLq5NcqqWYGHOXKGGTaeQsjh7EZE5+ypYXIGxDvfjlp
         jswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728542434; x=1729147234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtBMnssoGmOPP9k5G7rkH9LuSOvCJReyj8Ng4xiAyNw=;
        b=BPV9M3zwXz8V0CJ2CdtndmdDzeQ+zafoCKh3fU6DPLKOTwIBQjReUjcwjW4L1HYARS
         3cXAAvZg14ANJXw5AJskD9X4gIx4XEyKcXhRabs452VV4ogJLWYPahKXMGVnOM9bexcc
         P53JGqS5iLfrr6rtAeT8KBwXKCfw1Lb4s5eWbEkyrjZelKYRZt4vPfT6N4Q3+16TxjWk
         +Isj9lSyzZ0x8SlRvSJzc4rsI8AHP2FIyh+FQUAAs4PLjYs6z/e6ETHrI4llq6X7Slw6
         4J01OV8C00m29hWpVyjD+1T66UB/1Ga1lYzaS40lE1jpVHA8ltQbqmUbokf/4L17ru90
         6LGw==
X-Forwarded-Encrypted: i=1; AJvYcCVTS17/3gW1QWMDdX95bmng1HVuKswiPs1Riy9jjGRkNIxApwPYpcZ5D//fZ/eHv3nHRxvUAF0k1OZR@lists.infradead.org
X-Gm-Message-State: AOJu0YxX/S9eDLQ+waRh0KKCh2jWHro7w4rBaMZ+hZpSU/0CjAPqT84f
	P9kjDHYPIj1jyN4eYEkzAh3QY9rLoZRw2W1zmMRqCBij4lM0WFWgOIGYbHusoHVUfqlZVoUU3hP
	fKQkNh9Hrv/tJDeV73CsN1N8DXdlPet8eWficAw==
X-Google-Smtp-Source: AGHT+IEn+NqBy+r/Wng/w3gclLBwt3fhLmzd3mc6xePFFP+6fFXSWfS6xno7nZU5yEUbpI7xBERaHXpJIGQ6Vg3CZQs=
X-Received: by 2002:a17:907:f14c:b0:a99:9ff2:a85e with SMTP id
 a640c23a62f3a-a999ff2a9b2mr187150166b.39.1728542433849; Wed, 09 Oct 2024
 23:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com>
 <20241003125400.GB17031@lst.de> <c68fef87-288a-42c7-9185-8ac173962838@kernel.dk>
 <CGME20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b@eucas1p2.samsung.com>
 <20241004053121.GB14265@lst.de> <20241004061811.hxhzj4n2juqaws7d@ArmHalley.local>
 <20241004062733.GB14876@lst.de> <20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local>
 <20241004123027.GA19168@lst.de> <20241007101011.boufh3tipewgvuao@ArmHalley.local>
 <CANr-nt3TA75MSvTNWP3SwBh60dBwJYztHJL5LZvROa-j9Lov7g@mail.gmail.com> <97bd78a896b748b18e21e14511e8e0f4@CAMSVWEXC02.scsc.local>
In-Reply-To: <97bd78a896b748b18e21e14511e8e0f4@CAMSVWEXC02.scsc.local>
From: Hans Holmberg <hans@owltronix.com>
Date: Thu, 10 Oct 2024 08:40:21 +0200
Message-ID: <CANr-nt11OJfLRFr=rzH0LyRUzVD9ZFLKsgree=Xqv__nWerVkg@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Javier Gonzalez <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>, 
	Kanchan Joshi <joshi.k@samsung.com>, "hare@suse.de" <hare@suse.de>, 
	"sagi@grimberg.me" <sagi@grimberg.me>, "brauner@kernel.org" <brauner@kernel.org>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>, 
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, "bcrl@kvack.org" <bcrl@kvack.org>, 
	"dhowells@redhat.com" <dhowells@redhat.com>, "bvanassche@acm.org" <bvanassche@acm.org>, 
	"asml.silence@gmail.com" <asml.silence@gmail.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, 
	"gost.dev@samsung.com" <gost.dev@samsung.com>, "vishak.g@samsung.com" <vishak.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_234036_610236_8560A6D2 
X-CRM114-Status: GOOD (  70.29  )
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

On Wed, Oct 9, 2024 at 4:36=E2=80=AFPM Javier Gonzalez <javier.gonz@samsung=
.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Hans Holmberg <hans@owltronix.com>
> > Sent: Tuesday, October 8, 2024 12:07 PM
> > To: Javier Gonzalez <javier.gonz@samsung.com>
> > Cc: Christoph Hellwig <hch@lst.de>; Jens Axboe <axboe@kernel.dk>; Marti=
n K.
> > Petersen <martin.petersen@oracle.com>; Keith Busch <kbusch@kernel.org>;
> > Kanchan Joshi <joshi.k@samsung.com>; hare@suse.de; sagi@grimberg.me;
> > brauner@kernel.org; viro@zeniv.linux.org.uk; jack@suse.cz; jaegeuk@kern=
el.org;
> > bcrl@kvack.org; dhowells@redhat.com; bvanassche@acm.org;
> > asml.silence@gmail.com; linux-nvme@lists.infradead.org; linux-
> > fsdevel@vger.kernel.org; io-uring@vger.kernel.org; linux-block@vger.ker=
nel.org;
> > linux-aio@kvack.org; gost.dev@samsung.com; vishak.g@samsung.com
> > Subject: Re: [PATCH v7 0/3] FDP and per-io hints
> >
> > On Mon, Oct 7, 2024 at 12:10=E2=80=AFPM Javier Gonz=C3=A1lez <javier.go=
nz@samsung.com>
> > wrote:
> > >
> > > On 04.10.2024 14:30, Christoph Hellwig wrote:
> > > >On Fri, Oct 04, 2024 at 08:52:33AM +0200, Javier Gonz=C3=A1lez wrote=
:
> > > >> So, considerign that file system _are_ able to use temperature hin=
ts and
> > > >> actually make them work, why don't we support FDP the same way we =
are
> > > >> supporting zones so that people can use it in production?
> > > >
> > > >Because apparently no one has tried it.  It should be possible in th=
eory,
> > > >but for example unless you have power of 2 reclaim unit size size it
> > > >won't work very well with XFS where the AGs/RTGs must be power of tw=
o
> > > >aligned in the LBA space, except by overprovisioning the LBA space v=
s
> > > >the capacity actually used.
> > >
> > > This is good. I think we should have at least a FS POC with data
> > > placement support to be able to drive conclusions on how the interfac=
e
> > > and requirements should be. Until we have that, we can support the
> > > use-cases that we know customers are asking for, i.e., block-level hi=
nts
> > > through the existing temperature API.
> > >
> > > >
> > > >> I agree that down the road, an interface that allows hints (many m=
ore
> > > >> than 5!) is needed. And in my opinion, this interface should not h=
ave
> > > >> semintics attached to it, just a hint ID, #hints, and enough space=
 to
> > > >> put 100s of them to support storage node deployments. But this nee=
ds to
> > > >> come from the users of the hints / zones / streams / etc,  not fro=
m
> > > >> us vendors. We do not have neither details on how they deploy thes=
e
> > > >> features at scale, nor the workloads to validate the results. Anyt=
hing
> > > >> else will probably just continue polluting the storage stack with =
more
> > > >> interfaces that are not used and add to the problem of data placem=
ent
> > > >> fragmentation.
> > > >
> > > >Please always mentioned what layer you are talking about.  At the sy=
scall
> > > >level the temperatur hints are doing quite ok.  A full stream separa=
tion
> > > >would obviously be a lot better, as would be communicating the zone =
/
> > > >reclaim unit / etc size.
> > >
> > > I mean at the syscall level. But as mentioned above, we need to be ve=
ry
> > > sure that we have a clear use-case for that. If we continue seeing hi=
nts
> > > being use in NVMe or other protocols, and the number increase
> > > significantly, we can deal with it later on.
> > >
> > > >
> > > >As an interface to a driver that doesn't natively speak temperature
> > > >hint on the other hand it doesn't work at all.
> > > >
> > > >> The issue is that the first series of this patch, which is as simp=
le as
> > > >> it gets, hit the list in May. Since then we are down paths that le=
ad
> > > >> nowhere. So the line between real technical feedback that leads to
> > > >> a feature being merged, and technical misleading to make people be=
 a
> > > >> busy bee becomes very thin. In the whole data placement effort, we=
 have
> > > >> been down this path many times, unfortunately...
> > > >
> > > >Well, the previous round was the first one actually trying to addres=
s the
> > > >fundamental issue after 4 month.  And then after a first round of fe=
edback
> > > >it gets shutdown somehow out of nowhere.  As a maintainer and review=
 that
> > > >is the kinda of contributors I have a hard time taking serious.
> > >
> > > I am not sure I understand what you mean in the last sentece, so I wi=
ll
> > > not respond filling blanks with a bad interpretation.
> > >
> > > In summary, what we are asking for is to take the patches that cover =
the
> > > current use-case, and work together on what might be needed for bette=
r
> > > FS support. For this, it seems you and Hans have a good idea of what =
you
> > > want to have based on XFS. We can help review or do part of the work,
> > > but trying to guess our way will only delay existing customers using
> > > existing HW.
> >
> > After reading the whole thread, I end up wondering why we need to rush =
the
> > support for a single use case through instead of putting the architectu=
re
> > in place for properly supporting this new type of hardware from the sta=
rt
> > throughout the stack.
>
> This is not a rush. We have been supporting this use case through passthr=
u for
> over 1/2 year with code already upstream in Cachelib. This is mature enou=
gh as
> to move into the block layer, which is what the end user wants to do eith=
er way.
>
> This is though a very good point. This is why we upstreamed passthru at t=
he
> time; so people can experiment, validate, and upstream only when there is=
 a
> clear path.
>
> >
> > Even for user space consumers of raw block devices, is the last version
> > of the patch set good enough?
> >
> > * It severely cripples the data separation capabilities as only a handf=
ul of
> >   data placement buckets are supported
>
> I could understand from your presentation at LPC, and late looking at the=
 code that
> is available that you have been successful at getting good results with t=
he existing
> interface in XFS. The mapping form the temperature semantics to zones (no=
 semantics)
> is the exact same as we are doing with FDP. Not having to change neither =
in-kernel  nor user-space
> structures is great.

No, we don't map data directly to zones using lifetime hints. In fact,
lifetime hints contribute only a
relatively small part  (~10% extra write amp reduction, see the
rocksdb benchmark results).
Segregating data by file is the most important part of the data
placement heuristic, at least
for this type of workload.

>
> >
> > * It just won't work if there is more than one user application per sto=
rage
> >   device as different applications data streams will be mixed at the nv=
me
> >   driver level..
>
> For now this use-case is not clear. Folks working on it are using passthr=
u. When we
> have a more clear understanding of what is needed, we might need changes =
in the kernel.
>
> If you see a need for this on the work that you are doing, by all means, =
please send patches.
> As I said at LPC, we can work together on this.
>
> >
> > While Christoph has already outlined what would be desirable from a
> > file system point of view, I don't have the answer to what would be the=
 overall
> > best design for FDP. I would like to say that it looks to me like we ne=
ed to
> > consider more than more than the early adoption use cases and make sure=
 we
> > make the most of the hardware capabilities via logical abstractions tha=
t
> > would be compatible with a wider range of storage devices.
> >
> > Figuring the right way forward is tricky, but why not just let it take =
the time
> > that is needed to sort this out while early users explore how to use FD=
P
> > drives and share the results?
>
> I agree that we might need a new interface to support more hints, beyond =
the temperatures.
> Or maybe not. We would not know until someone comes with a use case. We h=
ave made the
> mistake in the past of treating internal research as upstreamable work. I=
 know can see that
> this simply complicates the in-kernel and user-space APIs.
>
> The existing API is usable and requires no changes. There is hardware. Th=
ere are customers.
> There are applications with upstream support which have been tested with =
passthru (the
> early results you mention). And the wiring to NVMe is _very_ simple. Ther=
e is no reason
> not to take this in, and then we will see what new interfaces we might ne=
ed in the future.
>
> I would much rather spend time in discussing ideas with you and others on=
 a potential
> future API than arguing about the validity of an _existing_ one.
>

Yes, but while FDP support could be improved later on(happy to help if
that'll be the case),
I'm just afraid that less work now defining the way data placement is
exposed is going to
result in a bigger mess later when more use cases will be considered.

