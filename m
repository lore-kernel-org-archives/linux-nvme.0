From: kbusch@kernel.org (Keith Busch)
Date: Mon, 8 Apr 2019 09:07:51 -0600
Subject: A kernel warning when entering suspend
In-Reply-To: <AM6PR06MB50635FC76FFD74DA6C423182A1520@AM6PR06MB5063.eurprd06.prod.outlook.com>
References: <AM6PR06MB50637026B0E7D87341BF47A3A1500@AM6PR06MB5063.eurprd06.prod.outlook.com>
 <20190404085524.GA24927@ming.t460p>
 <dbc75de4-aefc-b7da-e86a-91da37f463cf@oracle.com>
 <alpine.DEB.2.21.1904041812350.1802@nanos.tec.linutronix.de>
 <20190404221948.GB30656@ming.t460p>
 <a72ed150-8210-2dad-fa14-423ae5fd4589@oracle.com>
 <5088f9f9-678d-4e67-daf0-c8f9629baeea@oracle.com>
 <AM6PR06MB50635FC76FFD74DA6C423182A1520@AM6PR06MB5063.eurprd06.prod.outlook.com>
Message-ID: <20190408150750.GB32498@localhost.localdomain>

On Sat, Apr 06, 2019@09:12:12AM -0700, fin4478 fin4478 wrote:
> On Sat, 6 Apr 2019 23:31:51 +0800
> Dongli Zhang <dongli.zhang@oracle.com> wrote:
> 
> 
> > I am not able to reproduce anymore with below patch:
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index a90cf5d..90f6e80 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -1083,6 +1083,9 @@ static int nvme_poll_irqdisable(struct
> > nvme_queue *nvmeq, unsigned int tag)
> >         u16 start, end;
> >         int found;
> > 
> > +       if (!nvme_cqe_pending(nvmeq))
> > +               return 0;
> > +
> >         /*
> >          * For a poll queue we need to protect against the polling
> > thread
> >          * using the CQ lock.  For normal interrupt driven threads we
> > have
> > 
> > Dongli Zhang
> 
> Confirming. This bug is fixed with this patch.

I think the patch makes sense, though you'd still have a problem if
there is a cqe pending when you reach this point.
