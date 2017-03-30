From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 30 Mar 2017 11:54:14 +0300
Subject: [PATCH 1/3] nvme-rdma: increment request retries counter before
 requeuing
In-Reply-To: <1490810427-27776-2-git-send-email-sagi@grimberg.me>
References: <1490810427-27776-1-git-send-email-sagi@grimberg.me>
 <1490810427-27776-2-git-send-email-sagi@grimberg.me>
Message-ID: <7738203b-f6b7-bc4e-5761-c9213214d3d9@mellanox.com>



On 3/29/2017 9:00 PM, Sagi Grimberg wrote:
> This way our max retry limit holds as well.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---


Looks good

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
