From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 11 Oct 2017 21:38:19 +0300
Subject: [PATCH 1/7] nvme-rdma: pass tagset to directly
 nvme_rdma_free_tagset
In-Reply-To: <1507724952-13917-2-git-send-email-sagi@grimberg.me>
References: <1507724952-13917-1-git-send-email-sagi@grimberg.me>
 <1507724952-13917-2-git-send-email-sagi@grimberg.me>
Message-ID: <91983fd0-074d-3600-e043-08a9c41110b7@mellanox.com>



On 10/11/2017 3:29 PM, Sagi Grimberg wrote:
> Instead of flagging admin/io.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/rdma.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 

Looks good,
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
