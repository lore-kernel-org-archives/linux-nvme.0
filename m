From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 31 May 2017 13:24:03 +0200
Subject: [PATCH 3/7] nvmet: add eui64 field to nvme_ns and populate via
 configfs
In-Reply-To: <20170531094631.GC10718@lst.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <fe6439add636d3fd31ef357230101819ae7f5090.1496131397.git.jthumshirn@suse.de>
 <20170530092510.GB16736@lst.de>
 <d2bd7b74-aa81-f00e-282b-ff51deecbe39@suse.de>
 <20170531094631.GC10718@lst.de>
Message-ID: <51b921ed-e9f9-0eb2-7625-6053dbca6a82@suse.de>

On 05/31/2017 11:46 AM, Christoph Hellwig wrote:
> On Tue, May 30, 2017@11:45:25AM +0200, Johannes Thumshirn wrote:
>> Mostly consistency. The current nvme host code has the EUI sprinkled all
>> around. Sure I can drop it, but then what's the point in evaluating it
>> on the host side? Other targets may send it, so we need in on the host
>> and do we care about potentially awkward host implementations with Linux
>> as a target? Also it's rather handy for testing as well, after all it's
>> not too much and complex code.
> 
> There's only one place in the host code proper (discounting the
> scsi translation mess), and that's because the field is still better
> than not having any uniqueue identifier.  But I don't think we should
> spread it any further.

OK I'll drop it in my next re-send (which should hopefully be somewhen
today)

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
