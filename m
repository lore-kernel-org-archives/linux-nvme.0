From: hare@suse.de (Hannes Reinecke)
Date: Tue, 2 Oct 2018 16:04:35 +0200
Subject: [PATCH rfc 3/4] nvmet: expose support for fabrics SQ flow control
 disable in treq
In-Reply-To: <20181002001422.9111-4-sagi@grimberg.me>
References: <20181002001422.9111-1-sagi@grimberg.me>
 <20181002001422.9111-4-sagi@grimberg.me>
Message-ID: <21566782-40b7-3fde-070b-bf7d7045a3c1@suse.de>

On 10/2/18 2:14 AM, Sagi Grimberg wrote:
> Technical Proposal introduces an indication for SQ flow control
> disable support. Expose it since we are able to operate in this mode.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/target/configfs.c | 1 +
>   include/linux/nvme.h           | 7 ++++---
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
