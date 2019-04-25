From: hare@suse.de (Hannes Reinecke)
Date: Thu, 25 Apr 2019 08:06:00 +0200
Subject: [PATCH] block: use static bio_set for bio_split() calls
In-Reply-To: <1556135351.161891.138.camel@acm.org>
References: <20190418140632.60606-1-hare@suse.de>
 <1556135351.161891.138.camel@acm.org>
Message-ID: <3ff02420-8063-490a-271d-b7032c9d3b42@suse.de>

On 4/24/19 9:49 PM, Bart Van Assche wrote:
> On Thu, 2019-04-18@16:06 +0200, Hannes Reinecke wrote:
>> +static int __init blk_bio_split_init(void)
>> +{
>> +       return bioset_init(&bio_split_bio_set, BIO_POOL_SIZE, 0,
>> +                          BIOSET_NEED_BVECS);
>> +}
> 
> The slab allocator uses __init for some of its initialization. Can it happen
> that blk_bio_split_init() is called before slab initialization has finished?
> 
> Otherwise this patch looks fine to me.
> 
Most unlikely.
We have another static bioset (fs_bio_set in block/bio.c) which is 
initialised in the same manner.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
