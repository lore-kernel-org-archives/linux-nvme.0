Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7087BCF11CD
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 10:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G4qXWkDsZyoJRaoY97fcsqUYiGuQpt1fh3a0qCsfxsA=; b=zuELC+mRqSdt5bt1fEI0pkAqfv
	qJ0v7tMENk+RXGY+8aixx6/NCitiB21F9xnuuu6ruX5kZuHSgPUZVgxxrxmCpHh6XsdRmdxILmtDA
	rCtAgUoTOW2pfm0DAaL2lRcTqWgvKu86olFPYX5/oSL16bzdHxXReDeWBDmXyKrJYn7ccyKXbCZWI
	a7WdeGUkRr39pmsorUMtGuOaXqHeRFbX46A5iyjxPNg+stwVcg/IwJYOCy84/OwZFNOxtXypvFOFM
	IYVRh+72wtNiuLsMGPRZ88tX7NSEofc1NnnJzPX4Ko9wEspl46sRvRHv/QjkgrzUgH6L/FxL2hfd6
	meI7OfSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syqmf-0000000CSyi-0kYH;
	Thu, 10 Oct 2024 10:52:41 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syqhH-0000000CSOh-0PLh
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 10:47:09 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a993302fa02so125036766b.0
        for <linux-nvme@lists.infradead.org>; Thu, 10 Oct 2024 03:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20230601.gappssmtp.com; s=20230601; t=1728557225; x=1729162025; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4qXWkDsZyoJRaoY97fcsqUYiGuQpt1fh3a0qCsfxsA=;
        b=y7JxtzKhWwSSecxC9MNaIpMUZiDU3B1jIjlh2KGqa9DtCk0QCxTw3ahMIzcW6/LzQp
         73+luyJdCpPkx/rwQSQnTz9wqN2EkNPKN4upJWTf71mmWVkEiscXxaM9BbQ+/4G865V9
         I6rHigAGDoi1UEzhxnkzAB817IPswMEl2uNH5nr0ssJEUrem1U4S/BMz8QbcZlnXPWpz
         5uvxdCTGyBM+DEFtm+4HLHwsp45jEBfijhwbFZIcZ/XBr1wJE9KW85dBtVoQ8NA/aPSl
         Sg1W8QDzM/7gfjgBLN48mvrd5ThQlNlLloBV6QO/ykCR9rPfrsKJTUzfGiTyxm9khP9l
         VubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728557225; x=1729162025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4qXWkDsZyoJRaoY97fcsqUYiGuQpt1fh3a0qCsfxsA=;
        b=R4mZhO6667QrSzvwhG1Yw8NnCbwfMCnRYuOaxtlCQzJCP2x9GrxIHXBXW0fi9KbbjR
         3V3B7kdb0VR8GKrosOXfJMZCKWy9VvnY4djU7f5ceV+HCySYFn2UO8ZXcn9AKMWxjymC
         psl21B9nhupB249B6sWM5ezO7pKV5tqUlV3ZUNFsS44nVtBjSbA76+QaWtA64RkPFuK2
         1h0Ha8VcZ4NCMvaq0tkk0+GAN+37TsJ7BEM+3WB9maBYLtlX9lRPGEh8RZPP4zy3Yh9M
         Yo7vB8tmAU+yUj7WJQe1TJvjFKDeTzL5YPfcBORurK1Sn3zyy8+SqH9CIup8p0ulFGjS
         Aw4A==
X-Forwarded-Encrypted: i=1; AJvYcCXnWqjAa027SS8cbxiKwUKlffGKek9MC4QLelmpLtHu3FBI1jTKkbpaTw5+OqrsygwIDK8K5LbUJSKG@lists.infradead.org
X-Gm-Message-State: AOJu0YxTb/YRdMYKBIo3bGa8+uHbITeBsEcId1gH0d4nwGFKrRwVMXSA
	wkqEK4/Wq8HRPiVXcJhYSz6vZ2bjWbyTWCnEaRzfGPqXNfWEk8qr8ykxRJ6bo+kZm/0G6QL3/Ft
	rjfUc2WFpHYwC5Es8THUWqOBhFk3Thjn57FMz4Q==
X-Google-Smtp-Source: AGHT+IEI4Ku1pnkQvzw6BWVoEuWOMiAJsD24gneKHuvxfF17lxen+n5Q5JR6BhI9gX4nvsGLmKedVn4u5BlAe9fJmwo=
X-Received: by 2002:a17:907:9801:b0:a99:3546:b50e with SMTP id
 a640c23a62f3a-a998d3477cbmr510267966b.53.1728557224743; Thu, 10 Oct 2024
 03:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b@eucas1p2.samsung.com>
 <20241004053121.GB14265@lst.de> <20241004061811.hxhzj4n2juqaws7d@ArmHalley.local>
 <20241004062733.GB14876@lst.de> <20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local>
 <20241004123027.GA19168@lst.de> <20241007101011.boufh3tipewgvuao@ArmHalley.local>
 <CANr-nt3TA75MSvTNWP3SwBh60dBwJYztHJL5LZvROa-j9Lov7g@mail.gmail.com>
 <97bd78a896b748b18e21e14511e8e0f4@CAMSVWEXC02.scsc.local> <CANr-nt11OJfLRFr=rzH0LyRUzVD9ZFLKsgree=Xqv__nWerVkg@mail.gmail.com>
 <20241010071327.rnh2wsuqdvcu2tx4@ArmHalley.local>
In-Reply-To: <20241010071327.rnh2wsuqdvcu2tx4@ArmHalley.local>
From: Hans Holmberg <hans@owltronix.com>
Date: Thu, 10 Oct 2024 12:46:53 +0200
Message-ID: <CANr-nt2=Lee8B94DMPY6yDaGaBD=Lt9qdG2TzGhAwU=ddZxckg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20241010_034707_489945_EF33ADCA 
X-CRM114-Status: GOOD (  76.96  )
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

On Thu, Oct 10, 2024 at 9:13=E2=80=AFAM Javier Gonzalez <javier.gonz@samsun=
g.com> wrote:
>
> On 10.10.2024 08:40, Hans Holmberg wrote:
> >On Wed, Oct 9, 2024 at 4:36=E2=80=AFPM Javier Gonzalez <javier.gonz@sams=
ung.com> wrote:
> >>
> >>
> >>
> >> > -----Original Message-----
> >> > From: Hans Holmberg <hans@owltronix.com>
> >> > Sent: Tuesday, October 8, 2024 12:07 PM
> >> > To: Javier Gonzalez <javier.gonz@samsung.com>
> >> > Cc: Christoph Hellwig <hch@lst.de>; Jens Axboe <axboe@kernel.dk>; Ma=
rtin K.
> >> > Petersen <martin.petersen@oracle.com>; Keith Busch <kbusch@kernel.or=
g>;
> >> > Kanchan Joshi <joshi.k@samsung.com>; hare@suse.de; sagi@grimberg.me;
> >> > brauner@kernel.org; viro@zeniv.linux.org.uk; jack@suse.cz; jaegeuk@k=
ernel.org;
> >> > bcrl@kvack.org; dhowells@redhat.com; bvanassche@acm.org;
> >> > asml.silence@gmail.com; linux-nvme@lists.infradead.org; linux-
> >> > fsdevel@vger.kernel.org; io-uring@vger.kernel.org; linux-block@vger.=
kernel.org;
> >> > linux-aio@kvack.org; gost.dev@samsung.com; vishak.g@samsung.com
> >> > Subject: Re: [PATCH v7 0/3] FDP and per-io hints
> >> >
> >> > On Mon, Oct 7, 2024 at 12:10=E2=80=AFPM Javier Gonz=C3=A1lez <javier=
.gonz@samsung.com>
> >> > wrote:
> >> > >
> >> > > On 04.10.2024 14:30, Christoph Hellwig wrote:
> >> > > >On Fri, Oct 04, 2024 at 08:52:33AM +0200, Javier Gonz=C3=A1lez wr=
ote:
> >> > > >> So, considerign that file system _are_ able to use temperature =
hints and
> >> > > >> actually make them work, why don't we support FDP the same way =
we are
> >> > > >> supporting zones so that people can use it in production?
> >> > > >
> >> > > >Because apparently no one has tried it.  It should be possible in=
 theory,
> >> > > >but for example unless you have power of 2 reclaim unit size size=
 it
> >> > > >won't work very well with XFS where the AGs/RTGs must be power of=
 two
> >> > > >aligned in the LBA space, except by overprovisioning the LBA spac=
e vs
> >> > > >the capacity actually used.
> >> > >
> >> > > This is good. I think we should have at least a FS POC with data
> >> > > placement support to be able to drive conclusions on how the inter=
face
> >> > > and requirements should be. Until we have that, we can support the
> >> > > use-cases that we know customers are asking for, i.e., block-level=
 hints
> >> > > through the existing temperature API.
> >> > >
> >> > > >
> >> > > >> I agree that down the road, an interface that allows hints (man=
y more
> >> > > >> than 5!) is needed. And in my opinion, this interface should no=
t have
> >> > > >> semintics attached to it, just a hint ID, #hints, and enough sp=
ace to
> >> > > >> put 100s of them to support storage node deployments. But this =
needs to
> >> > > >> come from the users of the hints / zones / streams / etc,  not =
from
> >> > > >> us vendors. We do not have neither details on how they deploy t=
hese
> >> > > >> features at scale, nor the workloads to validate the results. A=
nything
> >> > > >> else will probably just continue polluting the storage stack wi=
th more
> >> > > >> interfaces that are not used and add to the problem of data pla=
cement
> >> > > >> fragmentation.
> >> > > >
> >> > > >Please always mentioned what layer you are talking about.  At the=
 syscall
> >> > > >level the temperatur hints are doing quite ok.  A full stream sep=
aration
> >> > > >would obviously be a lot better, as would be communicating the zo=
ne /
> >> > > >reclaim unit / etc size.
> >> > >
> >> > > I mean at the syscall level. But as mentioned above, we need to be=
 very
> >> > > sure that we have a clear use-case for that. If we continue seeing=
 hints
> >> > > being use in NVMe or other protocols, and the number increase
> >> > > significantly, we can deal with it later on.
> >> > >
> >> > > >
> >> > > >As an interface to a driver that doesn't natively speak temperatu=
re
> >> > > >hint on the other hand it doesn't work at all.
> >> > > >
> >> > > >> The issue is that the first series of this patch, which is as s=
imple as
> >> > > >> it gets, hit the list in May. Since then we are down paths that=
 lead
> >> > > >> nowhere. So the line between real technical feedback that leads=
 to
> >> > > >> a feature being merged, and technical misleading to make people=
 be a
> >> > > >> busy bee becomes very thin. In the whole data placement effort,=
 we have
> >> > > >> been down this path many times, unfortunately...
> >> > > >
> >> > > >Well, the previous round was the first one actually trying to add=
ress the
> >> > > >fundamental issue after 4 month.  And then after a first round of=
 feedback
> >> > > >it gets shutdown somehow out of nowhere.  As a maintainer and rev=
iew that
> >> > > >is the kinda of contributors I have a hard time taking serious.
> >> > >
> >> > > I am not sure I understand what you mean in the last sentece, so I=
 will
> >> > > not respond filling blanks with a bad interpretation.
> >> > >
> >> > > In summary, what we are asking for is to take the patches that cov=
er the
> >> > > current use-case, and work together on what might be needed for be=
tter
> >> > > FS support. For this, it seems you and Hans have a good idea of wh=
at you
> >> > > want to have based on XFS. We can help review or do part of the wo=
rk,
> >> > > but trying to guess our way will only delay existing customers usi=
ng
> >> > > existing HW.
> >> >
> >> > After reading the whole thread, I end up wondering why we need to ru=
sh the
> >> > support for a single use case through instead of putting the archite=
cture
> >> > in place for properly supporting this new type of hardware from the =
start
> >> > throughout the stack.
> >>
> >> This is not a rush. We have been supporting this use case through pass=
thru for
> >> over 1/2 year with code already upstream in Cachelib. This is mature e=
nough as
> >> to move into the block layer, which is what the end user wants to do e=
ither way.
> >>
> >> This is though a very good point. This is why we upstreamed passthru a=
t the
> >> time; so people can experiment, validate, and upstream only when there=
 is a
> >> clear path.
> >>
> >> >
> >> > Even for user space consumers of raw block devices, is the last vers=
ion
> >> > of the patch set good enough?
> >> >
> >> > * It severely cripples the data separation capabilities as only a ha=
ndful of
> >> >   data placement buckets are supported
> >>
> >> I could understand from your presentation at LPC, and late looking at =
the code that
> >> is available that you have been successful at getting good results wit=
h the existing
> >> interface in XFS. The mapping form the temperature semantics to zones =
(no semantics)
> >> is the exact same as we are doing with FDP. Not having to change neith=
er in-kernel  nor user-space
> >> structures is great.
> >
> >No, we don't map data directly to zones using lifetime hints. In fact,
> >lifetime hints contribute only a
> >relatively small part  (~10% extra write amp reduction, see the
> >rocksdb benchmark results).
> >Segregating data by file is the most important part of the data
> >placement heuristic, at least
> >for this type of workload.
>
> Is this because RocksDB already does seggregation per file itself? Are
> you doing something specific on XFS or using your knoledge on RocksDB to
> map files with an "unwritten" protocol in the midde?

Data placement by-file is based on that the lifetime of a file's data
blocks are strongly correlated. When a file is deleted, all its blocks
will be reclaimable at that point. This requires knowledge about the
data placement buckets and works really well without any hints
provided.
The life-time hint heuristic I added on top is based on rocksdb
statistics, but designed to be generic enough to work for a wider
range of workloads (still need to validate this though - more work to
be done).

>
>     In this context, we have collected data both using FDP natively in
>     RocksDB and using the temperatures. Both look very good, because both
>     are initiated by RocksDB, and the FS just passes the hints directly
>     to the driver.
>
> I ask this to understand if this is the FS responsibility or the
> application's one. Our work points more to letting applications use the
> hints (as the use-cases are power users, like RocksDB). I agree with you
> that a FS could potentially make an improvement for legacy applications
> - we have not focused much on these though, so I trust you insights on
> it.

The big problem as I see it is that if applications are going to work
well together on the same media we need a common placement
implementation somewhere, and it seems pretty natural to make it part
of filesystems to me.


>
> >>
> >> >
> >> > * It just won't work if there is more than one user application per =
storage
> >> >   device as different applications data streams will be mixed at the=
 nvme
> >> >   driver level..
> >>
> >> For now this use-case is not clear. Folks working on it are using pass=
thru. When we
> >> have a more clear understanding of what is needed, we might need chang=
es in the kernel.
> >>
> >> If you see a need for this on the work that you are doing, by all mean=
s, please send patches.
> >> As I said at LPC, we can work together on this.
> >>
> >> >
> >> > While Christoph has already outlined what would be desirable from a
> >> > file system point of view, I don't have the answer to what would be =
the overall
> >> > best design for FDP. I would like to say that it looks to me like we=
 need to
> >> > consider more than more than the early adoption use cases and make s=
ure we
> >> > make the most of the hardware capabilities via logical abstractions =
that
> >> > would be compatible with a wider range of storage devices.
> >> >
> >> > Figuring the right way forward is tricky, but why not just let it ta=
ke the time
> >> > that is needed to sort this out while early users explore how to use=
 FDP
> >> > drives and share the results?
> >>
> >> I agree that we might need a new interface to support more hints, beyo=
nd the temperatures.
> >> Or maybe not. We would not know until someone comes with a use case. W=
e have made the
> >> mistake in the past of treating internal research as upstreamable work=
. I know can see that
> >> this simply complicates the in-kernel and user-space APIs.
> >>
> >> The existing API is usable and requires no changes. There is hardware.=
 There are customers.
> >> There are applications with upstream support which have been tested wi=
th passthru (the
> >> early results you mention). And the wiring to NVMe is _very_ simple. T=
here is no reason
> >> not to take this in, and then we will see what new interfaces we might=
 need in the future.
> >>
> >> I would much rather spend time in discussing ideas with you and others=
 on a potential
> >> future API than arguing about the validity of an _existing_ one.
> >>
> >
> >Yes, but while FDP support could be improved later on(happy to help if
> >that'll be the case),
> >I'm just afraid that less work now defining the way data placement is
> >exposed is going to
> >result in a bigger mess later when more use cases will be considered.
>
> Please, see the message I responded on the other thread. I hope it is a
> way to move forward and actually work together on this.

