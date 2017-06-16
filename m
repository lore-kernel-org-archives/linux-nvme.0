From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 16 Jun 2017 11:48:32 +0200
Subject: [PATCH v6 00/10] Implement NVMe Namespace Descriptor
 Identification
In-Reply-To: <20170616094056.GA12465@lst.de>
References: <20170607094536.32419-1-jthumshirn@suse.de>
 <20170615163141.GA27307@lst.de>
 <bab953e9-7026-5833-9f65-1ef8b90433d7@suse.de>
 <20170616094056.GA12465@lst.de>
Message-ID: <905ed2e6-1c1c-f3a3-5391-66e42fb61861@suse.de>

On 06/16/2017 11:40 AM, Christoph Hellwig wrote:
> On Fri, Jun 16, 2017@10:20:04AM +0200, Johannes Thumshirn wrote:
>> Strange, as I tested with nvme-loop all the time...
> 
> Yeah, it's actually there, but for some reason find on sysfs
> behaves strange:
> 
> root at testvm:~# find /sys -name uuid
> root at testvm:~# cat /sys/class/nvme/nvme2/nvme2n1/uuid 
> 6665a65b-f42f-469b-800e-a047238649eb

Wasn't there something that find on sysfs isn't reliable?

Anyways, my shock's gone now.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
