From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 21 Jan 2019 01:10:42 -0800
Subject: [PATCH v3] nvmet-rdma: fix null dereference under heavy load
In-Reply-To: <20190119133410.GA6963@infradead.org>
References: <20190103173531.7987-1-rajur@chelsio.com>
 <20190119133410.GA6963@infradead.org>
Message-ID: <ed249f9f-44f8-de1f-ba7e-1179317803d8@grimberg.me>

> This looks ok to me:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Applied to nvme-5.0

> In the long run I wonder if we should get rid of the ?tatic
> preallocation entirely and just use a free pool to avoid constant
> reallocations..

you mean a kmem_cache? very possible, we can also make the command
struct to contain the rsp behind it to avoid the extra allocation...
