From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 May 2018 14:57:13 +0200
Subject: [PATCH 10/10] nvmet: set 'nuse' and 'nsze' to zero for
 inaccessible paths
In-Reply-To: <20180529101431.62271-11-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
 <20180529101431.62271-11-hare@suse.de>
Message-ID: <20180529125713.GJ7376@lst.de>

On Tue, May 29, 2018@12:14:31PM +0200, Hannes Reinecke wrote:
> According to the ANA base specification the 'nuse' and 'nsze' values
> can be set to '0' for 'inaccessible' or 'persistent-loss' path states.

No.  It applies to NUSE and NVMCAP.  We don't report NVMCAP, so we
only need this tweak for NUSE.

> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -371,6 +371,18 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>  	id->ncap = id->nuse = id->nsze =
>  		cpu_to_le64(ns->size >> ns->blksize_shift);
>  
> +	if (ns->anagrpid) {
> +		enum nvme_ana_state ana_state =
> +			req->port->ana_state[ns->anagrpid];
> +
> +		/*
> +		 * nuse and nsze should be zero for inaccessible or
> +		 * persistent loss ANA state.
> +		 */
> +		if ((ana_state == NVME_ANA_INACCESSIBLE) ||
> +		    (ana_state == NVME_ANA_PERSISTENT_LOSS))

Please remove the inner braces.

We don't need the anagrpid check, because we a) always set it to
a non-zero value, and b) would not be able to have a non-optimized
state anyway.

So just something like:

	id->ncap = id->nsze = cpu_to_le64(ns->size >> ns->blksize_shift);

	switch (req->port->ana_state[ns->anagrpid]) {
	case NVME_ANA_INACCESSIBLE:
	case NVME_ANA_PERSISTENT_LOSS:
		break;
	default:
		id->nuse = id->nsze;
		break;
	}
