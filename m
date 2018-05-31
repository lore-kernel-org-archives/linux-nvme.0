From: hch@lst.de (Christoph Hellwig)
Date: Thu, 31 May 2018 07:47:39 +0200
Subject: [PATCH rfc] nvme-pci: make sure to flush sqe writes before db
 record update
In-Reply-To: <84ebcf65-d1a2-2ee5-d4d7-b96d61ed3c16@grimberg.me>
References: <20180307175626.15222-1-sagi@grimberg.me>
 <20180308155147.GD3766@localhost.localdomain>
 <20180308172018.GA6785@ziepe.ca>
 <c6a92092-f1f0-cf3c-3f34-fe5904d9718b@grimberg.me>
 <84ebcf65-d1a2-2ee5-d4d7-b96d61ed3c16@grimberg.me>
Message-ID: <20180531054739.GA30923@lst.de>

On Thu, May 31, 2018@02:34:33AM +0300, Sagi Grimberg wrote:
> resurrecting this one...
>
> Can anyone say why this is _not_ needed?

>From Documentation/memory-barriers.txt in linux-next, where this was
discussed once more not too log ago:

  Note that, when using writel(), a prior wmb() is not needed to guarantee
  that the cache coherent memory writes have completed before writing to
  the MMIO region.
