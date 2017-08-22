From: hch@lst.de (Christoph Hellwig)
Date: Tue, 22 Aug 2017 08:32:15 +0200
Subject: [PATCH 2/3] nvme: introduce max_segments controller attribute
In-Reply-To: <39824829-4a0c-6418-2de7-719461fb3662@grimberg.me>
References: <1502878860-11750-1-git-send-email-maxg@mellanox.com>
 <1502878860-11750-2-git-send-email-maxg@mellanox.com>
 <390a1e0d-8b83-576f-1e9a-c9136b7daf39@grimberg.me>
 <ea59ff5e-5bcc-9dfc-a248-ef02f977dafc@mellanox.com>
 <bd77f99f-67c9-b648-1b93-43d3a6feb414@grimberg.me>
 <20170817074034.GC24372@lst.de>
 <39824829-4a0c-6418-2de7-719461fb3662@grimberg.me>
Message-ID: <20170822063215.GA6627@lst.de>

On Sun, Aug 20, 2017@09:35:25AM +0300, Sagi Grimberg wrote:
>> But the controller needs to support it, and NVMe controllers are
>> only required to support a 4k page size, the rest is optional.
>
> How exacly is the controller required to support the pag_size for
> fabrics?

It doesn't matter at all, except as the scaling factor for a few
reported values.

>> For PCIe (before fabrics existed) we used to do that, but we changed
>> it for ppc64 in this commit:
>>
>> c5c9f25b98 ("NVMe: default to 4k device page size")
>
> Yea... I'm wandering if this is specific to NVMe or it can trigger
> in RDMA as well.

As far as I can tell we could hit it with RDMA under the same
circumstances (weird iommu with a smaller page size than the system
page size), but for RDMA the nvme controller page size isn't the
one that matter, but rather the MR page size.

So for now to be safe it might be a good idea to always use a 4k
MR page size..
