From: hare@suse.de (Hannes Reinecke)
Date: Thu, 30 Nov 2017 16:08:49 +0100
Subject: [PATCH] nvme-fc: don't require user to enter host_traddr
In-Reply-To: <20171130145615.7506-1-jthumshirn@suse.de>
References: <20171130145615.7506-1-jthumshirn@suse.de>
Message-ID: <ed7d5ef0-ef9f-3f3e-0ae5-9714ab83bf16@suse.de>

On 11/30/2017 03:56 PM, Johannes Thumshirn wrote:
> One major usability difference between NVMf RDMA and FC is resolving
> the default host transport address in RDMA. This is perfectly doable
> in FC as well, as we already have all possible lport <-> rport
> combinations pre-populated so we can pick the first lport that has a
> connection to our desired rport per default or optionally use the user
> supplied lport if we have one.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> Cc: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/host/fc.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 7ab0be55c7d0..46ab900bbe26 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3328,15 +3328,19 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
>  	if (ret || !raddr.nn || !raddr.pn)
>  		return ERR_PTR(-EINVAL);
>  
> -	ret = nvme_fc_parse_traddr(&laddr, opts->host_traddr, NVMF_TRADDR_SIZE);
> -	if (ret || !laddr.nn || !laddr.pn)
> -		return ERR_PTR(-EINVAL);
> +	if (opts->mask & NVMF_OPT_HOST_TRADDR) {
> +		ret = nvme_fc_parse_traddr(&laddr, opts->host_traddr,
> +					   NVMF_TRADDR_SIZE);
> +		if (ret || !laddr.nn || !laddr.pn)
> +			return ERR_PTR(-EINVAL);
> +	}
>  
>  	/* find the host and remote ports to connect together */
>  	spin_lock_irqsave(&nvme_fc_lock, flags);
>  	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
> -		if (lport->localport.node_name != laddr.nn ||
> -		    lport->localport.port_name != laddr.pn)
> +		if ((laddr.nn || laddr.pn) &&
> +		    (lport->localport.node_name != laddr.nn ||
> +		     lport->localport.port_name != laddr.pn))
>  			continue;
>  
>  		list_for_each_entry(rport, &lport->endp_list, endp_list) {
We need both, 'laddr.nn' and 'laddr.pn'. So this statement is wrong.

You probably need something like

if (!laddr.nn || !laddr.pn || ....)

Cheers,

Hannes

-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
