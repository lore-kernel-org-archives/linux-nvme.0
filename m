From: hch@lst.de (Christoph Hellwig)
Date: Thu, 2 Nov 2017 20:44:08 +0100
Subject: [PATCH 2/2] nvme: Check admin passthru command effects
In-Reply-To: <20171101180400.6619-2-keith.busch@intel.com>
References: <20171101180400.6619-1-keith.busch@intel.com>
 <20171101180400.6619-2-keith.busch@intel.com>
Message-ID: <20171102194408.GB5270@lst.de>

On Wed, Nov 01, 2017@12:04:00PM -0600, Keith Busch wrote:
> The NVMe standard provides a command effects log page so the host may
> be aware of special requirements it may need to do in response to a
> particular command. For example, the command may need to run with IO
> quiesced to prevent timeouts or undefined behavior, or it may change
> the logical block formats that determine how the host needs to construct
> future IO commands.
> 
> This patch saves the nvme command effects log page if the controller
> supports it, and performs appropriate actions before and after an admin
> passthrough command is completed. If the controller does not support the
> command effects log page, the driver will define the effects for known
> opcodes. The nvme format and santize are the only commands in this patch
> with known effects.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h |   1 +
>  include/linux/nvme.h     |  19 ++++++++
>  3 files changed, 136 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index bae987b5dc79..a3444a67b1bc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -72,6 +72,9 @@ static DEFINE_IDA(nvme_instance_ida);
>  static dev_t nvme_chr_devt;
>  static struct class *nvme_class;
>  
> +static void nvme_ns_remove(struct nvme_ns *ns);
> +static int nvme_revalidate_disk(struct gendisk *disk);
> +
>  static __le32 nvme_get_log_dw10(u8 lid, size_t size)
>  {
>  	return cpu_to_le32((((size / 4) - 1) << 16) | lid);
> @@ -990,12 +993,96 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
>  			metadata, meta_len, io.slba, NULL, 0);
>  }
>  
> +static u32 nvme_get_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> +								u8 opcode)
> +{
> +	if (ctrl->effects) {
> +		if (ns)
> +			return le32_to_cpu(ctrl->effects->iocs[opcode]);
> +		return le32_to_cpu(ctrl->effects->acs[opcode]);
> +	}
> +	if (ns)
> +		return 0;

This looks like we should simply have two different versions for
admin vs I/O commands.

> +static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> +								u8 opcode)
> +{
> +	u32 effects = nvme_get_effects(ctrl, ns, opcode);
> +
> +	/*
> +	 * XXX: IO command effects are not handled.
> +	 */
> +	if (ns && (effects & ~NVME_CMD_EFFECTS_CSUPP)) {
> +		dev_warn(ctrl->device,
> +			 "IO command;%02x has unhandled effects:%08x\n",
> +			 opcode, effects);
> +		return 0;
> +	}

Maybe key it odd here:

	if (ns) {
		/*
		 * XXX: IO command effects are not handled.
		 */
		effects = le32_to_cpu(ctrl->effects->iocs[opcode]);
		if (ns && (effects & ~NVME_CMD_EFFECTS_CSUPP)) {
			dev_warn(ctrl->device,
				 "IO command;%02x has unhandled effects:%08x\n",
				 opcode, effects);
			return 0;
		}
	} else {
		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
		if (!effects)
			effects = nvme_known_admin_effects(ctrl, opcode);
	}

Otherwise this looks fine to me.
