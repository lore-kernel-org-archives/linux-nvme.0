From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 17 Jul 2019 16:19:24 +1000
Subject: nvme-5.3 ssd performance regression
In-Reply-To: <20190717042646.GA4583@lst.de>
References: <798a3907573b910fbb102036afe3dfc1405fb353.camel@kernel.crashing.org>
 <CACVXFVP8w3mzQ8XVgeif=Nq3kyiZopS0XDB+-c2x5CcT9V3djA@mail.gmail.com>
 <6863e5fa43409c370395cc66e7499dd7c150c497.camel@kernel.crashing.org>
 <20190717042646.GA4583@lst.de>
Message-ID: <78e76d9ba48e6b1feefaab30882f735326a2d819.camel@kernel.crashing.org>

On Wed, 2019-07-17@06:26 +0200, Christoph Hellwig wrote:
> On Wed, Jul 17, 2019 at 10:15:00AM +1000, Benjamin Herrenschmidt
> wrote:
> > Yes. Reverting this brings the speed back to 2GB/s
> 
> Thanks.  Can you try this series as well:
> 
> 
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-max-mapping-size-fix

This works. The performance is normal.

Cheers,
Ben.
