From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 21 Jan 2019 09:46:02 -0600
Subject: [PATCH v3] nvmet-rdma: fix null dereference under heavy load
In-Reply-To: <ed249f9f-44f8-de1f-ba7e-1179317803d8@grimberg.me>
References: <20190103173531.7987-1-rajur@chelsio.com>
 <20190119133410.GA6963@infradead.org>
 <ed249f9f-44f8-de1f-ba7e-1179317803d8@grimberg.me>
Message-ID: <b44f3efa-8a62-8a54-dfd9-ac36975e3f0f@opengridcomputing.com>


On 1/21/2019 3:10 AM, Sagi Grimberg wrote:
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


Hey guys,

If every command struct requires a rsp, then it seems simpler to contain
it in the command struct.

My 2 cents...

Steve.
