From: hare@suse.de (Hannes Reinecke)
Date: Thu, 19 Oct 2017 14:45:03 +0200
Subject: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
In-Reply-To: <20171018165258.23212-7-hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-7-hch@lst.de>
Message-ID: <1d2fe3fa-564f-c056-bbc5-b80282bee912@suse.de>

On 10/18/2017 06:52 PM, Christoph Hellwig wrote:
> With this flag a driver can create a gendisk that can be used for I/O
> submission inside the kernel, but which is not registered as user
> facing block device.  This will be useful for the NVMe multipath
> implementation.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  block/genhd.c         | 53 ++++++++++++++++++++++++++++++++++-----------------
>  include/linux/genhd.h |  1 +
>  2 files changed, 36 insertions(+), 18 deletions(-)
> 
To quote:

On Fri, Oct 06, 2017@09:13 AM, Christoph Hellwig wrote:
> On Fri, Oct 06, 2017@10:39:50AM +1100, NeilBrown wrote:
[ .. ]
>>
>> There is some precedent for hiding things from /proc/partitions.
>> removable devices like CDROMs are hidden, and you can easily hide
>> individual devices by setting GENHD_FL_SUPPRESS_PARTITION_INFO.
>> We might be able to get that through.  It is certainly worth writing
>> a patch and letting people experiment with it.
>
> No way in hell this would get through.  Preemptive NAK right here.
>
> That whole idea is just amazingly stupid, and no one has even
> explained a reason for it.

I wonder what has changed ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
