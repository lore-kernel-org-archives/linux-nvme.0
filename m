From: hare@suse.de (Hannes Reinecke)
Date: Wed, 3 Oct 2018 10:41:01 +0200
Subject: [PATCH v2 4/4] nvme: disable fabrics SQ flow control when asked
 by the user
In-Reply-To: <20181003081323.7504-5-sagi@grimberg.me>
References: <20181003081323.7504-1-sagi@grimberg.me>
 <20181003081323.7504-5-sagi@grimberg.me>
Message-ID: <63123a17-d0a0-a800-fe3f-53d2afe3b6a0@suse.de>

On 10/3/18 10:13 AM, Sagi Grimberg wrote:
> As for now, we don't care about sq_head pointer updates anyway, so
> at least allow the controller to micro-optimize by omiting this update.
> 
> Note that we will probably need to support it when a controller
> that requires this comes along.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/fabrics.c | 13 +++++++++++++
>   drivers/nvme/host/fabrics.h |  2 ++
>   2 files changed, 15 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
