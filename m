From: hch@lst.de (Christoph Hellwig)
Date: Thu, 10 May 2018 19:40:45 +0200
Subject: [PATCH V3] nvmet: add simple file backed ns support
In-Reply-To: <CAK0tqimM8W5DHfg=UbvHdTKCNsM3cqqqDZYMnLkVK=EC06Qv-A@mail.gmail.com>
References: <20180508053829.406-1-chaitanya.kulkarni@wdc.com>
 <5ed5899b-e0be-aa94-ea5f-6f8220bf38db@grimberg.me>
 <CAK0tqimM8W5DHfg=UbvHdTKCNsM3cqqqDZYMnLkVK=EC06Qv-A@mail.gmail.com>
Message-ID: <20180510174045.GA29461@lst.de>

On Wed, May 09, 2018@08:59:39PM -0700, chaitany kulkarni wrote:
> Also for bvec_alloc() we have to maintain the mempool_t, can we not
> add more members
> when we can get away with kmalloc_array()?
> 
> Do you see any performance advantage/difference when using
> bvec_alloc() vs kmalloc_array()?

The mempool is required to make guranteed forward progress under
memory reclaim.  For nvmet this only really matters for nvme-loop,
but I suspect we should still fix it.

Just use a global mempool - bvec_alloc isn't even exported and I'd
like to keep it this way.  One easy way to piggy back on the block
layer would be to always allocate bios, even for the file backed
code and then just use the bvecs.
