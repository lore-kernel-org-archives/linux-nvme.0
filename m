From: hch@lst.de (Christoph Hellwig)
Date: Wed, 17 Jul 2019 06:26:46 +0200
Subject: nvme-5.3 ssd performance regression
In-Reply-To: <6863e5fa43409c370395cc66e7499dd7c150c497.camel@kernel.crashing.org>
References: <798a3907573b910fbb102036afe3dfc1405fb353.camel@kernel.crashing.org>
 <CACVXFVP8w3mzQ8XVgeif=Nq3kyiZopS0XDB+-c2x5CcT9V3djA@mail.gmail.com>
 <6863e5fa43409c370395cc66e7499dd7c150c497.camel@kernel.crashing.org>
Message-ID: <20190717042646.GA4583@lst.de>

On Wed, Jul 17, 2019@10:15:00AM +1000, Benjamin Herrenschmidt wrote:
> Yes. Reverting this brings the speed back to 2GB/s

Thanks.  Can you try this series as well:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-max-mapping-size-fix
