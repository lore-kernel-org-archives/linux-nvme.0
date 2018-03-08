From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Mar 2018 08:57:36 +0100
Subject: [PATCH V4 1/5] nvme: do atomically bit operations on
 nvme_request.flags
In-Reply-To: <1520489971-31174-2-git-send-email-jianchao.w.wang@oracle.com>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
 <1520489971-31174-2-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180308075736.GB16084@lst.de>

On Thu, Mar 08, 2018@02:19:27PM +0800, Jianchao Wang wrote:
> Do atomically bit operations on nvme_request.flags instead of
> regular read/write, then we could add other flags and set/clear
> them safely.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>

Looks good, assuming an actual need for this shows up in the next
patches :)

Reviewed-by: Christoph Hellwig <hch at lst.de>

> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index e80fd74..02097e8 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -93,8 +93,8 @@ struct nvme_request {
>  	struct nvme_command	*cmd;
>  	union nvme_result	result;
>  	u8			retries;
> -	u8			flags;
>  	u16			status;
> +	unsigned long flags;

Please align the field name like the others, though.
