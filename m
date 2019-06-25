From: zwp10758@gmail.com (Weiping Zhang)
Date: Tue, 25 Jun 2019 22:55:10 +0800
Subject: [PATCH v3 4/5] genirq/affinity: allow driver's discontigous
 affinity set
In-Reply-To: <alpine.DEB.2.21.1906250811150.32342@nanos.tec.linutronix.de>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <1ead341c6d603cf138aed62e31091f257cb19981.1561385989.git.zhangweiping@didiglobal.com>
 <alpine.DEB.2.21.1906241740320.32342@nanos.tec.linutronix.de>
 <20190625021411.GD23777@ming.t460p>
 <alpine.DEB.2.21.1906250811150.32342@nanos.tec.linutronix.de>
Message-ID: <CAA70yB7xNf14-Ex1zq3mbBm_EEtLspmDDYBjOXibrMZS8r7ODQ@mail.gmail.com>

Thomas Gleixner <tglx at linutronix.de> ?2019?6?25??? ??3:36???
>
> MIng,
>
> On Tue, 25 Jun 2019, Ming Lei wrote:
> > On Mon, Jun 24, 2019@05:42:39PM +0200, Thomas Gleixner wrote:
> > > On Mon, 24 Jun 2019, Weiping Zhang wrote:
> > >
> > > > The driver may implement multiple affinity set, and some of
> > > > are empty, for this case we just skip them.
> > >
> > > Why? What's the point of creating empty sets? Just because is not a real
> > > good justification.
> >
> > Patch 5 will add 4 new sets for supporting NVMe's weighted round robin
> > arbitration. It can be a headache to manage so many irq sets(now the total
> > sets can become 6) dynamically since size of anyone in the new 4 sets can
> > be zero, so each particular set is assigned one static index for avoiding
> > the management trouble, then empty set will be seen by
> > irq_create_affinity_masks().
> >
> > So looks skipping the empty set makes sense because the API will become
> > easier to use than before.
>
Hello Ming,
Thanks your detail explanation.

> That makes sense, but at least some of that information wants to be in the
> change log and not some uninformative description of what the patch does.
>
> I was not Cc'ed on the rest of the patches so I had exactly zero context.
>
Hello Thomas,

I am sorry I didn't cc you the full patchset, I will add more detail
description in
commit message at V4.

> Thanks,
>
>         tglx
