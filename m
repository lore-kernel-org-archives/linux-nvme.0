From: hare@suse.com (Hannes Reinecke)
Date: Fri, 17 Aug 2018 12:06:53 +0200
Subject: [PATCH 5/6] nvme-list-subsys: Print PCIe controller address
In-Reply-To: <20180817081214.GE13230@lst.de>
References: <20180817072908.56784-1-hare@suse.de>
 <20180817072908.56784-6-hare@suse.de> <20180817081214.GE13230@lst.de>
Message-ID: <a765b740-eab0-c187-4068-fde610699284@suse.com>

On 08/17/2018 10:12 AM, Christoph Hellwig wrote:
> On Fri, Aug 17, 2018@09:29:07AM +0200, Hannes Reinecke wrote:
>> An NVMe PCIe controller doesn't have an address, so we should be
>> using the PCIe bus address.
> 
> Can we do this in the kernel instead of having to fix up every user
> of the sysfs interface?
> 
Sure we can.

I'll be drafting up a patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
