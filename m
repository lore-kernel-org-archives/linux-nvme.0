From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 30 May 2017 11:45:25 +0200
Subject: [PATCH 3/7] nvmet: add eui64 field to nvme_ns and populate via
 configfs
In-Reply-To: <20170530092510.GB16736@lst.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <fe6439add636d3fd31ef357230101819ae7f5090.1496131397.git.jthumshirn@suse.de>
 <20170530092510.GB16736@lst.de>
Message-ID: <d2bd7b74-aa81-f00e-282b-ff51deecbe39@suse.de>

On 05/30/2017 11:25 AM, Christoph Hellwig wrote:
> On Tue, May 30, 2017@10:08:18AM +0200, Johannes Thumshirn wrote:
>> Add the EUI-64 field from the NVMe Namespace Identification Descriptor
>> to the nvmet_ns structure and allow it's population via configfs.
> 
> Is there any good use case for bothering with this identifier that's
> too short to actually be useful?

Mostly consistency. The current nvme host code has the EUI sprinkled all
around. Sure I can drop it, but then what's the point in evaluating it
on the host side? Other targets may send it, so we need in on the host
and do we care about potentially awkward host implementations with Linux
as a target? Also it's rather handy for testing as well, after all it's
not too much and complex code.
 --
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
