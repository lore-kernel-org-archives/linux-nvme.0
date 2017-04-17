From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 17 Apr 2017 09:45:19 -0700
Subject: [PATCH V2] nvme: make use of nvme error status codes in block
 layer
In-Reply-To: <1492434939-12308-1-git-send-email-guanjunxiong@huawei.com>
References: <1492434939-12308-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <1492447519.3123.6.camel@linux.intel.com>

On Mon, 2017-04-17@21:15 +0800, Guan Junxiong wrote:
> From: Junxiong Guan <guanjunxiong at huawei.com>
> 
> For more detailed information about nvme error status when ending
> blk_mq request,some of nvme error status codes can be categorized into
> different errnos explicitly.This patch makes conversion from those nvme
> error status to errno detail so that block layer can make use of the
> detailed error information.


This is a good list but it's not the complete list.  It also seems to be
somewhat arbitrary list of chosen NVMe error codes to convert, with respect
to include/linux/nvme.h, which is a little tedious to track.

How about fold the conversion based on how the NVMe errors are grouped in
nvme.h?  So there would be one patch for:

	/*
	 * Generic Command Status:
	 */

one patch for:

	/*
	 * Command Specific Status:
	 */

etc...

This would make it easier to track and maintain what NVMe errors have been
accounted for the errno conversion between submitted patches and what is
implemented in the code.

Thanks,
Jay



> ---
> ?drivers/nvme/host/core.c | 29 +++++++++++++++++++++++++++++
> ?1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9bf758e3c911..95180ac0c710 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -73,6 +73,35 @@ static int nvme_error_status(struct request *req)
> ?		return 0;
> ?	case NVME_SC_CAP_EXCEEDED:
> ?		return -ENOSPC;
> +	case NVME_SC_READ_ONLY:
> +	case NVME_SC_ACCESS_DENIED:
> +		return -EACCES;
> +	case NVME_SC_LBA_RANGE:
> +		return -EFAULT;
> +	case NVME_SC_CONNECT_CTRL_BUSY:
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
> +		return -EINVAL;
> +	case NVME_SC_CMD_SEQ_ERROR:
> +		return -EPROTO;
> ?	default:
> ?		return -EIO;
> ?	}
