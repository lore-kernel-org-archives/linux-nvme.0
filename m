From: keith.busch@intel.com (Keith Busch)
Date: Mon, 4 Nov 2013 10:27:29 -0700 (MST)
Subject: [PATCH] NVMe: Add a buffer length parameter to struct
 nvme_user_io.
 Check buffer length in nvme_submit_io to avoid buffer overflow.
In-Reply-To: <1383584556-12121-1-git-send-email-david.darrington@hgst.com>
References: <1383584556-12121-1-git-send-email-david.darrington@hgst.com>
Message-ID: <alpine.LRH.2.03.1311041022000.4763@AMR>

On Mon, 4 Nov 2013, David Darrington wrote:

> Added a buffer length parameter to struct nvme_user_io so that
> nvme_submit_io can prevent writing past the end of the user buffer.

This extra check seems redundant. Doesn't get_user_pages_fast already
fail if the user buffer is too small?

>
> Signed-off-by: David Darrington <david.darrington at hgst.com>
> ---
> drivers/block/nvme-core.c |    6 +++++-
> include/uapi/linux/nvme.h |    4 +++-
> 2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index da52092..2aa4346 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1381,6 +1381,10 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
> 	if (copy_from_user(&io, uio, sizeof(io)))
> 		return -EFAULT;
> 	length = (io.nblocks + 1) << ns->lba_shift;
> +
> +	if (io.dxfer_len < length)
> +		return -EINVAL;
> +
> 	meta_len = (io.nblocks + 1) * ns->ms;
>
> 	if (meta_len && ((io.metadata & 3) || !io.metadata))
> @@ -1390,7 +1394,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
> 	case nvme_cmd_write:
> 	case nvme_cmd_read:
> 	case nvme_cmd_compare:
> -		iod = nvme_map_user_pages(dev, io.opcode & 1, io.addr, length);
> +		iod = nvme_map_user_pages(dev, io.opcode & 1, io.dxferp, length);
> 		break;
> 	default:
> 		return -EINVAL;
> diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
> index 989c04e..40b5b52 100644
> --- a/include/uapi/linux/nvme.h
> +++ b/include/uapi/linux/nvme.h
> @@ -441,7 +441,9 @@ struct nvme_user_io {
> 	__u16	nblocks;
> 	__u16	rsvd;
> 	__u64	metadata;
> -	__u64	addr;
> +	__u32	rsvd1;
> +	__u32	dxfer_len;	/* length of data xfer buffer */
> +	__u64	dxferp;		/* pointer to data xfer buffer */
> 	__u64	slba;
> 	__u32	dsmgmt;
> 	__u32	reftag;
> -- 
> 1.7.1
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
>
