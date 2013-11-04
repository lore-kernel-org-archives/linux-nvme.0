From: keith.busch@intel.com (Keith Busch)
Date: Mon, 4 Nov 2013 10:12:27 -0700 (MST)
Subject: [PATCH]: NVMe: ioctl support for FLUSH command
In-Reply-To: <1383582865-4538-1-git-send-email-dmilburn@redhat.com>
References: <1383582865-4538-1-git-send-email-dmilburn@redhat.com>
Message-ID: <alpine.LRH.2.03.1311040952040.4763@AMR>

On Mon, 4 Nov 2013, David Milburn wrote:
> Support for user space application to submit FLUSH command.
>
> Signed-off-by: David Milburn <dmilburn at redhat.com>
> ---
> drivers/block/nvme-core.c |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index da52092..4fab135 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1392,6 +1392,10 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
> 	case nvme_cmd_compare:
> 		iod = nvme_map_user_pages(dev, io.opcode & 1, io.addr, length);
> 		break;
> +	case nvme_cmd_flush:
> +		nvmeq = get_nvmeq(dev);
> +		status = nvme_submit_flush_data(nvmeq, ns);
> +		return status;

I'm not sure this is the right way to go. The other nvme passthrough
commands are synchronous where this would be asynchronous, so the user
can't get the nvme status with a flush command.

If async flush is okay, the nvmeq->q_lock needs to be held around
nvme_submit_flush_data, and call put_nvmeq() before returning status.

I think we might want to rethink this whole user io ioctl to take any
nvme io command including vendor unique ones. ?

> 	default:
> 		return -EINVAL;
> 	}
>
