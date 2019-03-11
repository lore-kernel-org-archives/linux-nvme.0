From: kbusch@kernel.org (Keith Busch)
Date: Mon, 11 Mar 2019 15:21:37 -0600
Subject: [PATCH v3 1/3] nvme: fail namespace revalidate if block size
 exceeds PAGE_SIZE
In-Reply-To: <20190311211608.16628-2-sagi@grimberg.me>
References: <20190311211608.16628-1-sagi@grimberg.me>
 <20190311211608.16628-2-sagi@grimberg.me>
Message-ID: <20190311212136.GA11299@localhost.localdomain>

On Mon, Mar 11, 2019@02:16:06PM -0700, Sagi Grimberg wrote:
> -static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
> +static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  {
>  	struct nvme_ns *ns = disk->private_data;
>  
> @@ -1644,8 +1644,13 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  	 * block layer can use before failing read/write for 0 capacity.
>  	 */
>  	ns->lba_shift = id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ds;
> -	if (ns->lba_shift == 0)
> +	if (ns->lba_shift > 12) {
> +		dev_err(ns->ctrl->device, "ns lba_shift %d not supported\n",
> +				ns->lba_shift);
> +		return -ENOTSUPP;
> +	} else if (ns->lba_shift == 0) {
>  		ns->lba_shift = 9;
> +	}

Instead of deleting the namespace, can we make this a 0-capacity block
device like we do with extended metadata formats? That will fence it off
from generic read/write where this would cause a problem, and I'd like
to use these namespaces in passthrough mode for product testing purposes.
