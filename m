From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 30 Mar 2017 11:54:31 +0300
Subject: [PATCH 2/3] nvme-loop: increment request retries counter before
 requeuing
In-Reply-To: <1490810427-27776-3-git-send-email-sagi@grimberg.me>
References: <1490810427-27776-1-git-send-email-sagi@grimberg.me>
 <1490810427-27776-3-git-send-email-sagi@grimberg.me>
Message-ID: <21b651ff-b12f-5399-a0c8-5a16be7a9cae@mellanox.com>



On 3/29/2017 9:00 PM, Sagi Grimberg wrote:
> This way our max retry limit holds as well.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---

Looks good

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
