From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 May 2017 10:22:02 +0200
Subject: [PATCH 4/7] nvme: also report include the EUI-64 in identify NS
 report
In-Reply-To: <2f6eac411a9ce4c0bdc756e0cb5cfed66208b9d7.1496131397.git.jthumshirn@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <2f6eac411a9ce4c0bdc756e0cb5cfed66208b9d7.1496131397.git.jthumshirn@suse.de>
Message-ID: <ebe7d06c-1839-3134-63c9-9360567b5a06@suse.de>

On 05/30/2017 10:08 AM, Johannes Thumshirn wrote:
> Now that we can configure a namespace's EUI-64, report it back to the
> host in an 'Identify Namespace' command reply.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/target/admin-cmd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index ff1f97006322..60c9eec57986 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -322,6 +322,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>  	id->nmic = (1 << 0);
>  
>  	memcpy(&id->nguid, &ns->nguid, sizeof(uuid_le));
> +	memcpy(&id->eui64, &ns->eui64, sizeof(ns->eui64));
>  
>  	id->lbaf[0].ds = ns->blksize_shift;
>  
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
