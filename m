From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 23 Oct 2017 17:42:55 +0300
Subject: [PATCH v2] nvme-rdma: fix possible hang when issuing commands
 during ctrl removal
In-Reply-To: <1508763851-15338-1-git-send-email-sagi@grimberg.me>
References: <1508763851-15338-1-git-send-email-sagi@grimberg.me>
Message-ID: <1bfc4bbb-b841-c547-8c08-c259996c7e59@mellanox.com>


> 
> Reported-by: Bart Van Assche <bart.vanassche at wdc.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> Changes from v1:
> - squashed to ctrl state conditions in nvme_rdma_queue_is_ready
> 
>   drivers/nvme/host/rdma.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 

Looks good,
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
