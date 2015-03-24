From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 24 Mar 2015 12:23:01 -0400
Subject: [PATCHv3] NVMe: write_long SCSI to NVMe translation implementation
In-Reply-To: <1427118493-29227-1-git-send-email-sunad.s@samsung.com>
References: <1427118493-29227-1-git-send-email-sunad.s@samsung.com>
Message-ID: <20150324162301.GN4003@linux.intel.com>

On Mon, Mar 23, 2015@07:18:13PM +0530, Sunad Bhandary S wrote:
> +	case WRITE_LONG:
> +		retcode = nvme_trans_write_long(ns, hdr, cmd);
> +		break;
> +	case SERVICE_ACTION_OUT_16:
> +		if (IS_WRITE_LONG_16(cmd))
> +			retcode = nvme_trans_write_long(ns, hdr, cmd);
> +		else
> +			goto out;
> +		break;
>  	default:
>   out:

Umm, why not simply:

	case SERVICE_ACTION_OUT_16:
		if (IS_WRITE_LONG_16(cmd))
			retcode = nvme_trans_write_long(ns, hdr, cmd);
		break;
