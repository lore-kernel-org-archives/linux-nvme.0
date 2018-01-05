From: james.smart@broadcom.com (James Smart)
Date: Fri, 5 Jan 2018 08:33:35 -0800
Subject: [PATCH v4 3/5] nvmet/fc: Use sgl_alloc() and sgl_free()
In-Reply-To: <20180105162650.31083-4-bart.vanassche@wdc.com>
References: <20180105162650.31083-1-bart.vanassche@wdc.com>
 <20180105162650.31083-4-bart.vanassche@wdc.com>
Message-ID: <b456f605-76e4-d47a-d525-7176a78103e6@broadcom.com>

On 1/5/2018 8:26 AM, Bart Van Assche wrote:
> Use the sgl_alloc() and sgl_free() functions instead of open coding
> these functions.
>
> Signed-off-by: Bart Van Assche <bart.vanassche at wdc.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: James Smart <james.smart at broadcom.com>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/target/Kconfig |  1 +
>   drivers/nvme/target/fc.c    | 36 ++----------------------------------
>   2 files changed, 3 insertions(+), 34 deletions(-)

Reviewed-by:? James Smart <james.smart at broadcom.com>

-- james
