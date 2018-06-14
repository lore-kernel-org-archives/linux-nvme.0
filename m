From: james.smart@broadcom.com (James Smart)
Date: Thu, 14 Jun 2018 10:37:14 -0700
Subject: [PATCH 1/3] nvme-fabrics: refactor queue ready check
In-Reply-To: <20180614122215.4395-2-hch@lst.de>
References: <20180614122215.4395-1-hch@lst.de>
 <20180614122215.4395-2-hch@lst.de>
Message-ID: <a7065ad6-6438-b4a7-c3cf-dd7a90b0d092@broadcom.com>



On 6/14/2018 5:22 AM, Christoph Hellwig wrote:
> Move the is_connected check to the fibre channel transport, as it has no
> meaning for other transports.  To facilitate this split out a new
> nvmf_fail_nonready_command helper that is called by the transport when
> it is asked to handle a command on a queue that is not ready.
>
> Also avoid a function call for the queue live fast path by inlining
> the check.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/fabrics.c | 59 +++++++++++++++----------------------
>   drivers/nvme/host/fabrics.h | 13 ++++++--
>   drivers/nvme/host/fc.c      |  9 +++---
>   drivers/nvme/host/rdma.c    |  7 ++---
>   drivers/nvme/target/loop.c  |  7 ++---
>   5 files changed, 45 insertions(+), 50 deletions(-)
>
>

looks good

Reviewed-by:? James Smart?? <james.smart at broadcom.com>
