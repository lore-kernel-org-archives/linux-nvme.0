From: hch@lst.de (Christoph Hellwig)
Date: Mon, 24 Apr 2017 09:02:10 +0200
Subject: [PATCH v2 3/4] nvme: enable SG gaps support
In-Reply-To: <9fe3f5fa-4496-3819-0288-08a073dd1a1a@grimberg.me>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
 <1492098977-5231-4-git-send-email-maxg@mellanox.com>
 <2bd673ee-8455-32b7-1bad-34fa9eebb076@grimberg.me>
 <20170421064427.GB6095@lst.de>
 <9ff1a2e8-f84f-c772-e294-2339eee8e37d@grimberg.me>
 <20170423084553.GA24434@lst.de>
 <9fe3f5fa-4496-3819-0288-08a073dd1a1a@grimberg.me>
Message-ID: <20170424070210.GA8719@lst.de>

On Sun, Apr 23, 2017@12:45:39PM +0300, Sagi Grimberg wrote:
>> still would fit NVMe dword-alignment SGLs, though :)
>
> I would say its useful to have, but its only relevant to ioctls as
> normal io we explicitly on sub logical block size alignment.
>
> Anyways, I still think having ctrl->virt_boundary instead of
> ctrl->sg_gap_support is cleaner...

Ok, fine with me.
