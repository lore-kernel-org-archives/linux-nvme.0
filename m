From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 1 Nov 2017 08:56:03 -0700
Subject: [PATCH] nvme: freeze IO accesses around format
In-Reply-To: <20171027230756.GA17245@localhost.localdomain>
References: <6951d74c-e765-1b5d-6e39-d88d261bf9b9@kernel.dk>
 <20171027230756.GA17245@localhost.localdomain>
Message-ID: <20171101155603.GC25317@infradead.org>

>     If the controller does not support the command effects log page, the
>     driver will define the effects for known opcodes. The nvme format is
>     the only such command in this patch with known effects.

Sanitize is another one.  Also Format might either affect a single
namespace or the whole controller depending on what it advertises in
FNA.

> +static void nvme_get_admin_effects(struct nvme_ctrl *ctrl, u8 opcode, u32 *effects)

Overly long line.

> +{
> +	if (ctrl->effects)
> +		*effects = le32_to_cpu(ctrl->effects->acs[opcode]);
> +
> +	if (*effects != 0)
> +		return;
> +
> +	/*
> +	 * Set known effects for opcodes if the controller doesn't support
> +	 * reporting the command's effects.
> +	 */
> +	switch (opcode) {
> +	case nvme_admin_format_nvm:
> +		*effects = NVME_CMD_FX_CSUPP | NVME_CMD_FX_LBCC |
> +					NVME_CMD_FX_CSE_MASK;
> +		break;
> +	default:
> +		break;
> +	}
> +}

Hmm.  I'd expect it to be something like:

static u32 nvme_get_admin_effects((struct nvme_ctrl *ctrl, u8 opcode)
{
	if (ctrl->effects)
		return le32_to_cpu(ctrl->effects->acs[opcode]);

	switch (opcode) {
		...
	}
}

That is: a) return the value instead of pass by reference, and
b) if the controller supports the log page rely on it.

Also don't we need to also handle this for I/O commands?  While
non of the currently defined I/O commands would need anything, the
spec defines the mechanism? and it might be useful for vendor
specific commands.

> +static void nvme_passthru_start(struct nvme_ctrl *ctrl, u32 effects)
> +{
> +	if (effects & (NVME_CMD_FX_LBCC | NVME_CMD_FX_CSE_MASK)) {
> +		nvme_start_freeze(ctrl);
> +		nvme_wait_freeze(ctrl);
> +	}
> +}

I'd move the nvme_get_admin_effects call into this, and return the
value from this function to keep the caller a little more uncluttered.

> +	if (effects & NVME_CMD_FX_LBCC) {
> +		struct nvme_ns *ns;
> +
> +		mutex_lock(&ctrl->namespaces_mutex);
> +		list_for_each_entry(ns, &ctrl->namespaces, list) {
> +			if (ns->disk && nvme_revalidate_disk(ns->disk))
> +				nvme_ns_remove(ns);
> +		}
> +		mutex_unlock(&ctrl->namespaces_mutex);
> +	}

Split the code above into a helper?

> +static int nvme_get_log(struct nvme_ctrl *ctrl, u8 log_page, void *log, size_t size)

To loong line again.  Also I think adding this helper should probably
be a preparation patch.

> +{
> +	struct nvme_command c = { };
> +
> +
> +	c.common.opcode = nvme_admin_get_log_page;

Double empty line.

> +static void nvme_scan(struct nvme_ctrl *ctrl)
>  {
> -	struct nvme_ctrl *ctrl =
> -		container_of(work, struct nvme_ctrl, scan_work);
>  	struct nvme_id_ctrl *id;
>  	unsigned nn;
>  
> @@ -2549,6 +2650,14 @@ static void nvme_scan_work(struct work_struct *work)
>  	kfree(id);
>  }
>  
> +static void nvme_scan_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl =
> +		container_of(work, struct nvme_ctrl, scan_work);
> +
> +	nvme_scan(ctrl);
> +}

Why do we do the scan inline here, but not in any other place?

> @@ -267,6 +267,7 @@ enum {
>  	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
>  	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
>  	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
> +	NVME_CTRL_LPA_CMD_FX_LOG		= 1 << 1,

I'd just use the bit directly, given that it doesn't have a name
in the spec either.

>  enum {
> +	NVME_CMD_FX_CSUPP	= 1 << 0,
> +	NVME_CMD_FX_LBCC	= 1 << 1,
> +	NVME_CMD_FX_NCC		= 1 << 2,
> +	NVME_CMD_FX_NIC		= 1 << 3,
> +	NVME_CMD_FX_CCC		= 1 << 4,
> +	NVME_CMD_FX_CSE_MASK	= 3 << 16,

s/NVME_CMD_FX/NVME_CMD_EFFECTS/g ?

> +	NVME_LOG_CMD_FX		= 0x05,

same here.
