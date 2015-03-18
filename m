From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Mar 2015 16:21:18 +0000 (UTC)
Subject: [PATCHv2] NVMe: Spliting large i/o in the ioctl path [for-linus
 branch]
In-Reply-To: <1424779243-14951-1-git-send-email-sathya.m@samsung.com>
References: <1424779243-14951-1-git-send-email-sathya.m@samsung.com>
Message-ID: <alpine.LNX.2.00.1503181525200.32385@localhost.lm.intel.com>

On Tue, 24 Feb 2015, Sathayavathi M wrote:
> From: Sathyavathi M <sathya.m at samsung.com>
>
> The NVME_IOCTL_SUBMIT_IO allows arbitrarily large i/o cmds if mdts is zero.
> If the mdts has a limit, there is no check to verify if the cmd sent to device
> is within the max transfer limit. This patch splits arbitrarily  large size i/o
> to max_hw_sectors before submitting to device. If metadata (extended and
> separate) is present then the i/o is split by considering both data+metadata.

The spec says MDTS applies to metadata when it is interleaved, but not
when separated.

I was actually hoping we could simplify this whole thing to not allocate
two nvme_iod's for separate metadata since we added a metadata sg
element to the iod. Can we take advantage of that and clean up this
routine?

> +	u32 tfr_sectors;
> +	u32 max_tfr_sectors, num_split_cmds, offset = 0;
> +	u64 nxt_map_addr, nxt_meta_map_addr = 0;
> +	struct nvme_iod *iod = NULL, *meta_iod = NULL;
> 	dma_addr_t meta_dma_addr;
> 	void *meta, *uninitialized_var(meta_mem);
> +	bool ext_lba = ns->flbas & EXT_LBA;
>
> 	if (copy_from_user(&io, uio, sizeof(io)))
> 		return -EFAULT;
> -	length = (io.nblocks + 1) << ns->lba_shift;
> -	meta_len = (io.nblocks + 1) * ns->ms;
> +	max_tfr_sectors = dev->max_hw_sectors;

Your offset, max_tfr_sectors and tfr_sectors are counted as units of
512b sectors, but you're using it as if it is the device's physical
sector size when you set SLBA and NLB.

> -	switch (io.opcode) {
> -	case nvme_cmd_write:
> -	case nvme_cmd_read:
> -	case nvme_cmd_compare:
> -		iod = nvme_map_user_pages(dev, io.opcode & 1, io.addr, length);
> -		break;
> -	default:
> +	if (io.opcode != nvme_cmd_write && io.opcode != nvme_cmd_read &&
> +						io.opcode != nvme_cmd_compare)
> 		return -EINVAL;
> -	}

I don't think this change above is any clearer than what we had
before. Just remove allocating the iod from the switch, right?

> +		num_split_cmds = DIV_ROUND_UP(((io.nblocks + 1)
> +			<< ns->lba_shift), (max_tfr_sectors << ns->lba_shift));

The nblocks and max_tfr_sectors may not be the same unit size in your
setup, so this division may not make sense for some formats.

> +	/* Increase max transfer size if device reports MDTS=0 */
> 	if (ctrl->mdts)
> 		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
> +	else
> +		dev->max_hw_sectors = 1024;

I didn't realize the block layer imposed such a low limit when the
driver doesn't specify one. If the device doesn't have a limit though,
why not use UINT_MAX?

> +enum {
> +	EXT_LBA		= 0x10
> +};

This enum is unnecessary. It already exists in the enum with the rest
of the identify namespace FLBAS flags in the latest kernel.
