From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 1 Mar 2018 11:22:52 +0200
Subject: [RFC PATCH] nvme-pci: Bounce buffer for interleaved metadata
In-Reply-To: <yq1371l4vzb.fsf@oracle.com>
References: <20180224000547.7252-1-keith.busch@intel.com>
 <5662c6d9-0c87-6074-12b8-39db53ce3c7f@grimberg.me>
 <yq1371l4vzb.fsf@oracle.com>
Message-ID: <1a85219a-330e-aece-c1cf-62812b916506@grimberg.me>

> Sagi,
> 
>> It makes sense for FC (and few RDMA devices) that already get
>> interleaved metadata from the wire to keep it as is instead of
>> scattering it if the backend nvme device supports interleaved mode...
> 
> Yeah, assuming that the PI doesn't have to get translated.

 From what I am aware of, devices can translate the PI and even the block
size and still keep it interleaved on the host memory layout. At least
that was the case in the one implementation I was involved with.

>> I would say that this support for this is something that belongs in
>> the block layer. IIRC mkp also expressed interest in using
>> preadv2/pwritev2 to for user-space to use DIF with some accounting on
>> the iovec
> 
> Indeed.
> 
>> so maybe we can add a flag for interleaved metadata.
> 
> What would the use case be for this? Userspace target driver? I know
> lots of widgets that rely on interleaved but they are all using SPDK.

Didn't came from me...
