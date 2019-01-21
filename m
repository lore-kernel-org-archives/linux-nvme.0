From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 21 Jan 2019 15:07:09 +0200
Subject: [PATCH v3] nvmet-rdma: fix null dereference under heavy load
In-Reply-To: <ed249f9f-44f8-de1f-ba7e-1179317803d8@grimberg.me>
References: <20190103173531.7987-1-rajur@chelsio.com>
 <20190119133410.GA6963@infradead.org>
 <ed249f9f-44f8-de1f-ba7e-1179317803d8@grimberg.me>
Message-ID: <fe7da170-9eea-360d-0ab7-84838b6debac@mellanox.com>


On 1/21/2019 11:10 AM, Sagi Grimberg wrote:
>> This looks ok to me:
>>
>> Reviewed-by: Christoph Hellwig <hch at lst.de>
>
> Applied to nvme-5.0
>
>> In the long run I wonder if we should get rid of the ?tatic
>> preallocation entirely and just use a free pool to avoid constant
>> reallocations..
>
> you mean a kmem_cache? very possible, we can also make the command
> struct to contain the rsp behind it to avoid the extra allocation...

yes, the container idea sounds good..
