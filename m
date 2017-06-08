From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Jun 2017 09:44:14 +0200
Subject: [PATCH v6 05/10] nvmet: implement namespace identify
 descriptor list
In-Reply-To: <20170607094536.32419-6-jthumshirn@suse.de>
References: <20170607094536.32419-1-jthumshirn@suse.de>
 <20170607094536.32419-6-jthumshirn@suse.de>
Message-ID: <20170608074414.GD13953@lst.de>

On Wed, Jun 07, 2017@11:45:32AM +0200, Johannes Thumshirn wrote:
> A NVMe Identify NS command with a CNS value of '3' is expecting a list
> of Namespace Identification Descriptor structures to be returned to
> the host for the namespace requested in the namespace identify
> command.
> 
> This Namespace Identification Descriptor structure consists of the
> type of the namespace identifier, the length of the identifier and the
> actual identifier.
> 
> Valid types are NGUID and UUID which we have saved in our nvme_ns
> structure if they have been configured via configfs. If no value has
> been assigened to one of these we return an "invalid opcode" back to
> the host to maintain backward compatibiliy with older implementations
> without Namespace Identify Descriptor list support.
> 
> Also as the Namespace Identify Descriptor list is the only mandatory
> feature change between 1.2.1 and 1.3 we can bump the advertised
> version as well.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>  drivers/nvme/target/admin-cmd.c | 61 +++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/target/core.c      |  3 +-
>  drivers/nvme/target/nvmet.h     |  1 +
>  3 files changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 96c144325443..6f9f0881aa2b 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -367,6 +367,64 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
>  	nvmet_req_complete(req, status);
>  }
>  
> +static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
> +				    void *id, off_t *off)
> +{
> +	struct nvme_ns_id_desc desc = {
> +		.nidt = type,
> +		.nidl = len,
> +	};
> +	u16 status;
> +
> +	status = nvmet_copy_to_sgl(req, *off, &desc, sizeof(desc));
> +	if (status)
> +		return status;
> +	*off += sizeof(desc);
> +
> +	status = nvmet_copy_to_sgl(req, *off, id, len);
> +	if (status)
> +		return status;
> +	*off += len;
> +
> +	return 0;
> +}
> +
> +static void nvmet_execute_identify_desclist(struct nvmet_req *req)
> +{
> +	struct nvmet_ns *ns;
> +	u16 status = 0;
> +	off_t off = 0;
> +
> +	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
> +	if (!ns) {
> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	if (memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {
> +		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
> +						  NVME_NIDT_UUID_LEN,
> +						  &ns->uuid, &off);
> +		if (status)
> +			goto out_put_ns;
> +	}
> +	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid))) {
> +		status = nvmet_copy_ns_identifier(req, NVME_NIDT_NGUID,
> +						  NVME_NIDT_NGUID_LEN,
> +						  &ns->nguid, &off);
> +		if (status)
> +			goto out_put_ns;
> +	}
> +
> +	if (sg_zeroout_area(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE, off)

Shouldn;t the third argument be NVME_IDENTIFY_DATA_SIZE - off in theory?
It's probably fine as is as the S/G helpers deal with overflows
gracefully, but still..

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
