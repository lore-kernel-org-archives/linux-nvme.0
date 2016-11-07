From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 07 Nov 2016 10:50:16 -0800
Subject: nvmet_rdma crash - DISCONNECT event with NULL queue
In-Reply-To: <20161107184126.GA4400@lst.de>
References: <01d101d2345e$2f054390$8d0fcab0$@opengridcomputing.com>
 <dbe5f18d-7928-f065-920f-753b30fb99a2@grimberg.me>
 <01d901d2345f$da0d2e00$8e278a00$@opengridcomputing.com>
 <1d09c064-1cbe-7e6e-43d2-cfa6cf0c19ea@grimberg.me>
 <024e01d23476$6668b890$333a29b0$@opengridcomputing.com>
 <3512b8bb-4d29-b90a-49e1-ebf1085c47d7@grimberg.me>
 <004601d2351a$d9db85b0$8d929110$@opengridcomputing.com>
 <20161102151540.GB14825@lst.de>
 <bd82c206-668a-0794-2d51-3c48058350d3@grimberg.me>
 <1478543378.3350.17.camel@linux.intel.com> <20161107184126.GA4400@lst.de>
Message-ID: <1478544616.3350.29.camel@linux.intel.com>

On Mon, 2016-11-07@19:41 +0100, 'Christoph Hellwig' wrote:
> On Mon, Nov 07, 2016@10:29:38AM -0800, J Freyensee wrote:
> > 
> > The way I interpret the spec, ctrlid (I'm assuming you mean cntlid)
> > is
> > allocated on a NVM subsystem basis. ?For example, Figure 34 of the
> > Discovery Log Page entry and Figure 20 of the Connect Command
> > implies
> > to me CNTLID values are allocated on a NVM Subsystem granular-level
> > when I see statements such as:
> 
> It is per-subsystem.??But nothing in the spec prohibits and
> implementation
> that has multiple subsystems to simply not allocate cntlids that
> would conflict betweens it's subsystems.

OK, so basically the nvmet change would be to make sure unique cntlids
are used across all NVM subsystems within the NVMe Target then?


> 
> And in fact there is a TP in the working group that would require
> implementations not to reuse cntlids for it to work.??We'll probably
> hear more about that once it's published.
