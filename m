From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 20 Aug 2017 09:35:25 +0300
Subject: [PATCH 2/3] nvme: introduce max_segments controller attribute
In-Reply-To: <20170817074034.GC24372@lst.de>
References: <1502878860-11750-1-git-send-email-maxg@mellanox.com>
 <1502878860-11750-2-git-send-email-maxg@mellanox.com>
 <390a1e0d-8b83-576f-1e9a-c9136b7daf39@grimberg.me>
 <ea59ff5e-5bcc-9dfc-a248-ef02f977dafc@mellanox.com>
 <bd77f99f-67c9-b648-1b93-43d3a6feb414@grimberg.me>
 <20170817074034.GC24372@lst.de>
Message-ID: <39824829-4a0c-6418-2de7-719461fb3662@grimberg.me>


>>>> Why is this needed with patches 1,3 applied?
>>>>
>>>> We set the page_size and we set max_hw_sectors accordingly.
>>>
>>> We didn't touch the ctrl->page_size. It's always 4k (the target checks it).
>>> This may cause max_segments to be bigger than hw limitation (in PPC for
>>> example).
>>
>> Right, got confused for a second, but why shouldn't we modify the
>> ctrl page_size in rdma? Its not really a controller attribute, but
>> rather the local HCA attribute really.
> 
> But the controller needs to support it, and NVMe controllers are
> only required to support a 4k page size, the rest is optional.

How exacly is the controller required to support the pag_size for
fabrics?

It could have implications on mdts, but AFAIR, mdts is reported in
units of MPSMIN so I'm not exactly sure how exactly the controller
needs to support it.

>> Or, we could simply fix nvme-core to take PAGE_SIZE if supported by
>> the ctrl and fallback to 4k otherwise.
> 
> For PCIe (before fabrics existed) we used to do that, but we changed
> it for ppc64 in this commit:
> 
> c5c9f25b98 ("NVMe: default to 4k device page size")

Yea... I'm wandering if this is specific to NVMe or it can trigger
in RDMA as well.

Note that for iSER we always use 4k page vectors, but that was
historically done before we had gaps detection in the block layer
and we had higher chance to do bounce buffering in iSER.
