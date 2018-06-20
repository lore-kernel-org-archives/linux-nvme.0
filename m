From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 20 Jun 2018 09:02:31 -0500
Subject: [PATCH v4 0/3] NVMF/RDMA 16K Inline Support
In-Reply-To: <20180620082444.GB3033@lst.de>
References: <cover.1528219321.git.swise@opengridcomputing.com>
 <4f16cd07-015e-d1cf-f8fd-069c460ee2a6@opengridcomputing.com>
 <3f3b2259-b41b-59bd-c7b6-b5102849aec4@opengridcomputing.com>
 <20180619054056.GB23184@lst.de>
 <68434eaa-ab12-35a2-2625-55978b9a7cf8@opengridcomputing.com>
 <20180619174313.GP27457@mellanox.com> <20180620082444.GB3033@lst.de>
Message-ID: <2e71b891-be57-2f36-28f5-ffdafc76db96@opengridcomputing.com>



On 6/20/2018 3:24 AM, Christoph Hellwig wrote:
> On Tue, Jun 19, 2018@11:43:13AM -0600, Jason Gunthorpe wrote:
>>> +doug and jason.
>>>
>>> There is one merge issue: This series will require the max_send/recv_sge
>>> commit, which is merged in rdma-next [1] just recently. Perhaps you can
>>> pull that from the linux-rdma repo if and when these 2 nvme patches are
>>> pulled into your repo? I think that will allow easy merging when the
>>> block and rdma repos get merged into Linus' repo.
>> Pulling the rdma tree into nvme is probably not something anyone would
>> want to do..
>>
>> Can we take these patches through rdma instead?
> There are chances for various conflicts as well.  I think the best
> is to just apply the patches without using the new split fields to
> the nvme tree and then carry the fixup to max_send_sge/max_recv_sge
> in linux-next.

Ok, I'll remove the dependency in the next version.

Thanks,

Steve.
