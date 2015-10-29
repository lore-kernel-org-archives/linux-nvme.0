From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 29 Oct 2015 04:55:36 -0700
Subject: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
In-Reply-To: <20151028135922.GA27909@localhost.localdomain>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
Message-ID: <20151029115536.GA28090@infradead.org>

On Wed, Oct 28, 2015@01:59:23PM +0000, Busch, Keith wrote:
> The "new" interface for all the other architectures is the same as the
> old one we've been using for the last 5 years.
> 
> I welcome x86 maintainer feedback to confirm virtual and DMA addresses
> have the same offset at 4k alignment, but I have to insist we don't
> break my currently working hardware to force their attention.

We had a quick cht about this issue and I think we simply should
default to a NVMe controler page size of 4k everywhere as that's the
safe default.  This is also what we do for RDMA Memory reigstrations and
it works fine there for SRP and iSER.
