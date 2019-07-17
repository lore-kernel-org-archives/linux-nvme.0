From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 17 Jul 2019 15:50:54 +1000
Subject: nvme-5.3 ssd performance regression
In-Reply-To: <20190717044041.GB4755@lst.de>
References: <798a3907573b910fbb102036afe3dfc1405fb353.camel@kernel.crashing.org>
 <CACVXFVP8w3mzQ8XVgeif=Nq3kyiZopS0XDB+-c2x5CcT9V3djA@mail.gmail.com>
 <6863e5fa43409c370395cc66e7499dd7c150c497.camel@kernel.crashing.org>
 <20190717042646.GA4583@lst.de>
 <a510b276a5c94fa79ec86dfde78fcbc0edb06053.camel@kernel.crashing.org>
 <20190717044041.GB4755@lst.de>
Message-ID: <aa50364acad30e8fcffa93e33e6794bfe65ba66b.camel@kernel.crashing.org>

On Wed, 2019-07-17@06:40 +0200, Christoph Hellwig wrote:


http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-max-mapping-size-fix
> > 
> > With or without
> > 
> >  "nvme-pci: limit max_hw_sectors based on the DMA max mapping size"
> > 
> > ?
> 
> With.  Just pull in the branch :)

Ah oops :-) Brain not engaged clearly ...

I'll get back to you when I get past the lockups caused by the Intel
graphic driver... Something is trying to do synchronous module loads
from async init calls and its' not happy.

Cheers,
Ben.
