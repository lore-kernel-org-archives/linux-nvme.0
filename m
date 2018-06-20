From: hch@lst.de (Christoph Hellwig)
Date: Wed, 20 Jun 2018 14:29:34 +0200
Subject: [PATCH 1/7] nvme-rdma: fix possible double free condition when
 failing to create a controller
In-Reply-To: <be2a572c-6e6e-8a1c-608e-457fbd8cb01b@grimberg.me>
References: <20180619123415.25077-1-sagi@grimberg.me>
 <20180619123415.25077-2-sagi@grimberg.me>
 <0af01f6d-75f3-3a8c-bcca-abd6a8da3920@mellanox.com>
 <be2a572c-6e6e-8a1c-608e-457fbd8cb01b@grimberg.me>
Message-ID: <20180620122934.GB13858@lst.de>

On Wed, Jun 20, 2018@01:41:29PM +0300, Sagi Grimberg wrote:
>> can you explain this error flow ? we'll never free the queues since the 
>> list &ctrl->list is empty. I guess a fix to nvme_rdma_free_ctrl is needed 
>> in this case.
>
> Good catch! I lost this in the rebase:

Thanks, folded.
