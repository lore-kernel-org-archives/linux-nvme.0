From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 4 Apr 2017 11:21:58 -0600
Subject: [RFC 6/8] nvmet: Be careful about using iomem accesses when
 dealing with p2pmem
In-Reply-To: <20170404154629.GA13552@obsidianresearch.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-7-git-send-email-logang@deltatee.com>
 <080b68b4-eba3-861c-4f29-5d829425b5e7@grimberg.me>
 <20170404154629.GA13552@obsidianresearch.com>
Message-ID: <c5638d51-d43f-f30e-f32c-531b3091bd49@deltatee.com>



On 04/04/17 04:59 AM, Sagi Grimberg wrote:
> We can never ever get here from an IO command, and that is a good thing
> because it would have been broken if we did, regardless of what copy
> method we use...

Yes, I changed this mostly for admin commands. I did notice connect
commands do end up reading from the p2mem and this patchset correctly
switches it to iomemcpy. However, based on Cristoph's comment, I hope to
make it more general such that iomem is hidden within sgls and any
access will either be correct or create a warning.


On 04/04/17 09:46 AM, Jason Gunthorpe wrote:
> Transactions might not complete at the NVMe device before the CPU
> processes the RDMA completion, however due to the PCI-E ordering rules
> new TLPs directed to the NVMe will complete after the RMDA TLPs and
> thus observe the new data. (eg order preserving)
> 
> It would be very hard to use P2P if fabric ordering is not preserved..

Yes, my understanding is the same, the PCI-E ordering rules save us here.

Thanks,

Logan
