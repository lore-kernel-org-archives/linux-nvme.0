From: hch@lst.de (Christoph Hellwig)
Date: Thu, 31 May 2018 18:36:03 +0200
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <f084e3bc-77af-4268-c882-7b0737e45f3b@grimberg.me>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <20180530220206.GA7037@redhat.com>
 <f084e3bc-77af-4268-c882-7b0737e45f3b@grimberg.me>
Message-ID: <20180531163603.GC30954@lst.de>

On Thu, May 31, 2018@11:37:20AM +0300, Sagi Grimberg wrote:
>> the same host with PCI NVMe could be connected to a FC network that has
>> historically always been managed via dm-multipath.. but say that
>> FC-based infrastructure gets updated to use NVMe (to leverage a wider
>> NVMe investment, whatever?) -- but maybe admins would still prefer to
>> use dm-multipath for the NVMe over FC.
>
> You are referring to an array exposing media via nvmf and scsi
> simultaneously? I'm not sure that there is a clean definition of
> how that is supposed to work (ANA/ALUA, reservations, etc..)

It seems like this isn't what Mike wanted, but I actually got some
requests for limited support for that to do a storage live migration
from a SCSI array to NVMe.  I think it is really sketchy, but if
doable if you are careful enough.  It would use dm-multipath, possibly
even on top of nvme multipathing if we have multiple nvme paths.
