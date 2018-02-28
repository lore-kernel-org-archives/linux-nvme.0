From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 27 Feb 2018 22:46:32 -0500
Subject: [RFC PATCH] nvme-pci: Bounce buffer for interleaved metadata
In-Reply-To: <5662c6d9-0c87-6074-12b8-39db53ce3c7f@grimberg.me> (Sagi
 Grimberg's message of "Sun, 25 Feb 2018 19:30:48 +0200")
References: <20180224000547.7252-1-keith.busch@intel.com>
 <5662c6d9-0c87-6074-12b8-39db53ce3c7f@grimberg.me>
Message-ID: <yq1371l4vzb.fsf@oracle.com>


Sagi,

> It makes sense for FC (and few RDMA devices) that already get
> interleaved metadata from the wire to keep it as is instead of
> scattering it if the backend nvme device supports interleaved mode...

Yeah, assuming that the PI doesn't have to get translated.

> I would say that this support for this is something that belongs in
> the block layer. IIRC mkp also expressed interest in using
> preadv2/pwritev2 to for user-space to use DIF with some accounting on
> the iovec

Indeed.

> so maybe we can add a flag for interleaved metadata.

What would the use case be for this? Userspace target driver? I know
lots of widgets that rely on interleaved but they are all using SPDK.

-- 
Martin K. Petersen	Oracle Linux Engineering
