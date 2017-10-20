From: james.smart@broadcom.com (James Smart)
Date: Fri, 20 Oct 2017 16:06:34 -0700
Subject: [PATCHv2 2/5] nvme/fc: remove unused "queue_size" field
In-Reply-To: <20171020221924.30659-3-keith.busch@intel.com>
References: <20171020221924.30659-1-keith.busch@intel.com>
 <20171020221924.30659-3-keith.busch@intel.com>
Message-ID: <bb21869c-0e51-af12-1070-c7f0c6de30d3@broadcom.com>

On 10/20/2017 3:19 PM, Keith Busch wrote:
> This was being saved in a structure, but never used anywhere. The queue
> size is obtained through other means, so there's no reason to duplicate
> this without a user for it.
>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/fc.c | 9 +++------
>

Looks good. This stuff was left over when queuesize moved into the nvme 
ctrl.

-- james

Reviewed-by: James Smart <james.smart at broadcom.com>
