From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 29 Mar 2017 20:39:28 +0300
Subject: [PATCH] nvme: make nvme error status codes converted to errno
 detailed
In-Reply-To: <1490782103-14668-1-git-send-email-guanjunxiong@huawei.com>
References: <1490782103-14668-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <8bf05c27-b44d-906d-2c79-0e31db9ac0c3@grimberg.me>



On 29/03/17 13:08, Guan Junxiong wrote:
> From: Junxiong Guan <guanjunxiong at huawei.com>
>
> For more detailed information about nvme error status when ending
> blk_mq request,some of nvme error status codes can be categorized into
> different errnos explicitly. For example, NVME_SC_ACCESS_DENIED and
> NVME_SC_CONNECT_CTRL_BUSY can be converted to EACCESS and EBUSY repec-
> tively.This patch makes conversion from those nvme error status to errno
> detailed.

This makes sense to me, see comments below.

> ---
>  drivers/nvme/host/nvme.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a3da1e90b99d..be699ca38cc8 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -255,7 +255,37 @@ static inline int nvme_error_status(u16 status)
>  	case NVME_SC_SUCCESS:
>  		return 0;
>  	case NVME_SC_CAP_EXCEEDED:
> +	case NVME_SC_NS_INSUFFICENT_CAP:
>  		return -ENOSPC;

why is this ENOSPC?

Maybe we can add also some fabrics status codes?

> +	case NVME_SC_READ_ONLY:
> +	case NVME_SC_ACCESS_DENIED:
> +		return -EACCES;
> +	case NVME_SC_LBA_RANGE:
> +		return -EFAULT;
> +	case NVME_SC_CONNECT_CTRL_BUSY:
case NVME_SC_CONNECT_CTRL_BUSY:

> +		return -EBUSY;



> +	case NVME_SC_INVALID_OPCODE:
> +	case NVME_SC_INVALID_FIELD:
> +	case NVME_SC_INVALID_NS:
> +	case NVME_SC_SGL_INVALID_LAST:
> +	case NVME_SC_SGL_INVALID_COUNT:
> +	case NVME_SC_SGL_INVALID_DATA:
> +	case NVME_SC_SGL_INVALID_METADATA:
> +	case NVME_SC_SGL_INVALID_TYPE:
> +	case NVME_SC_SGL_INVALID_OFFSET:
> +	case NVME_SC_SGL_INVALID_SUBTYPE:
> +	case NVME_SC_CQ_INVALID:
> +	case NVME_SC_QID_INVALID:
> +	case NVME_SC_QUEUE_SIZE:
> +	case NVME_SC_FIRMWARE_SLOT:
> +	case NVME_SC_FIRMWARE_IMAGE:
> +	case NVME_SC_INVALID_VECTOR:
> +	case NVME_SC_INVALID_LOG_PAGE:
> +	case NVME_SC_INVALID_FORMAT:
> +	case NVME_SC_CTRL_LIST_INVALID:
case NVME_SC_BAD_ATTRIBUTES:
case NVME_SC_INVALID_PI:
case NVME_SC_CONNECT_FORMAT:
case NVME_SC_CONNECT_INVALID_PARAM:
case NVME_SC_CONNECT_INVALID_HOST:

> +		return -EINVAL;
> +	case NVME_SC_CMD_SEQ_ERROR:
> +		return -EPROTO;
>  	default:
>  		return -EIO;
>  	}
>

It'll also be useful if we can log the specific error (as a human
readable string).
