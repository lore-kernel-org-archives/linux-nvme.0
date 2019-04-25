From: hare@suse.de (Hannes Reinecke)
Date: Thu, 25 Apr 2019 16:29:19 +0200
Subject: [PATCHv2] nvmet: make MDTS value configurable
In-Reply-To: <6e30cf78-ed72-4acc-2733-86f258750558@grimberg.me>
References: <20190403230654.109698-1-hare@suse.de>
 <20190404052720.GB7497@lst.de>
 <90391425-546f-61ad-ca9e-890e0246bf3c@mellanox.com>
 <20190408061644.GA26437@lst.de>
 <fb0baf79-abbe-55be-c621-abf4d80355d9@mellanox.com>
 <6e30cf78-ed72-4acc-2733-86f258750558@grimberg.me>
Message-ID: <bde7c290-c068-c352-7cf5-420fd2d02e91@suse.de>

On 4/24/19 7:05 PM, Sagi Grimberg wrote:
> 
>> Yes, from what I saw we don't limit the max_io_size in the target 
>> since we're using the rw-API.
>>
>> In case 1 rdma ctx is not enough (MR page list for example) we use 
>> more ctx's in the rw-API. I think we have a bug there since we don't 
>> check that nr_ops is not to big for transaction.
> 
> What do you mean too big?
> 
>> So probably we need to add some limit int nvmet/RDMA for that as 
>> NFS/RDMA does (let's agree on some value/module_param/tunable).
>>
>> Or we can say that the limit is (if we force MRs for example):
>>
>> rdma_rw_fr_page_list_len(device) * device_page_size * 
>> max_mrs_per_transaction.
> 
> if at all it should probably be:
> rdma_rw_fr_page_list_len(device) * device_page_size * 
> attr->cap.max_rdma_ctxs
> 
>> We also need to calculate mr_pool_size and max_rdma_ctxs more 
>> carefully IMO.
>>
>> So let's agree on the approach and then implement a solution (Sagi, 
>> can you comments on that too please ?)
> 
> I don't think we want a modparam for something this low-level...
> 
> we reserve a qp space and mr pool, we should limit MDTS based on that
> alone.
> 
>> Nevertheless, While digging into it I saw some improvements we can do 
>> to rw-API, so I'm preparing few patches (add static allocations option 
>> instead of allocations in fast-path).
> 
> Note that I still don't understand what is the original issue Hannes
> was trying to resolve...

We've had quite some issues around bio splitting on NVMe (cf Ming Leis 
patchset 'blk-mq: fix races related to freeing queue' and my patch 
'block: use separate bio set for splitting').
These issue only materialized when using a smaller MDTS value (eg 64k), 
so the idea to have a proper blktest reproducer.
Which would require us to be able to set a different MDTS value in the 
first place.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
