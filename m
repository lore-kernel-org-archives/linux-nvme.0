From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 19 Oct 2016 09:29:07 +0200
Subject: [PATCH 6/6] nvme/rdma: Make nvme_rdma_conn_rejected() more
 informative
In-Reply-To: <66e66d19-5a2a-e867-401a-1ede0c845b3e@sandisk.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <66e66d19-5a2a-e867-401a-1ede0c845b3e@sandisk.com>
Message-ID: <20161019072907.slv54jpzh4aef2gc@linux-x5ow.site>

On Tue, Oct 18, 2016@01:12:03PM -0700, Bart Van Assche wrote:
> While I was figuring out how to make the nvme-rdma driver log in to
> the nvmet-rdma driver, the following message appeared in the system
> log:
> 
>     nvme nvme0: Connect rejected, status 0.
> 
> That message is not very helpful. Hence this patch that makes the
> messages reported by nvme_rdma_conn_rejected() more informative.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
