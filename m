From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 1 Mar 2018 15:56:38 -0700
Subject: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
In-Reply-To: <20180301224540.GL19007@ziepe.ca>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
Message-ID: <cd55324c-f5bb-6bfb-a7b3-e128c797ca6b@deltatee.com>



On 01/03/18 03:45 PM, Jason Gunthorpe wrote:
> I can appreciate you might have some special use case for that, but it
> absolutely should require special configuration and not just magically
> happen.

Well if driver doesn't want someone doing p2p transfers with the memory 
it shouldn't publish it to be used for exactly that purpose.

> You bring up IB adaptor memory - if we put that into the allocator
> then what is to stop the NMVe driver just using it instead of the CMB
> buffer? That would be totally wrong in almost all cases.

If you mean for SQEs in the NVMe driver, look at the code, it 
specifically allocates it from it's own device. If you mean the 
nvmet-rdma then it's using that memory exactly as it was meant to. 
Again, if the IB driver doesn't want someone to use that memory for P2P 
transfers it shouldn't publish it as such.

> Seems like a very subtle and hard to debug performance trap to leave
> for the users, and pretty much the only reason to use P2P is
> performance... So why have such a dangerous interface?

It's not at all dangerous, the code specifically only uses P2P memory 
that's local enough. And the majority of the code is there to make sure 
it will all work in all cases.

Honestly, though, I'd love to go back to the case where the user selects 
which p2pmem device to use, but that was very unpopular last year. It 
would simplify a bunch of things though.

Also, no, the reason to use P2P is not performance. Only if you have 
very specific hardware can you get a performance bump and it isn't all 
that significant. The reason to use P2P is so you can design performant 
systems with small CPUs, less or slower DRAM, and low lane counts to the 
CPU, etc.

Logan
