From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 17 Mar 2015 08:59:14 -0400
Subject: [PATCHv2] NVMe: write_long SCSI to NVMe translation implementation
In-Reply-To: <004301d060aa$99924070$ccb6c150$@samsung.com>
References: <1425382201-2556-1-git-send-email-sunad.s@samsung.com>
 <004301d060aa$99924070$ccb6c150$@samsung.com>
Message-ID: <20150317125914.GB4003@linux.intel.com>

On Tue, Mar 17, 2015@05:34:40PM +0530, Sunad Bhandary wrote:
> Hi Keith,
> 
> Any comments/updates on this ?
> 
>  	id_ctrl = mem;
>  	v_sup = id_ctrl->vwc;
> +	(id_ctrl->oncs & NVME_CTRL_ONCS_WRITE_UNCORRECTABLE) ?
> +				(wrt_uncor = 0x01) : (wrt_uncor = 0);

This is a weird way of writing it.  Either do it like this:

	if (id_ctrl->oncs & NVME_CTRL_ONCS_WRITE_UNCORRECTABLE)
		wrt_uncor = 0x01;
	else
		wrt_uncor = 0;

Or this:

	wrt_uncor = (id_ctrl->oncs & NVME_CTRL_ONCS_WRITE_UNCORRECTABLE) ? 1 : 0;

(and what's with the 'hex for one, decimal for the other' decision you
made there?)

> @@ -3001,6 +3059,10 @@ static int nvme_scsi_translate(struct nvme_ns *ns,
> struct sg_io_hdr *hdr)
>  	case UNMAP:
>  		retcode = nvme_trans_unmap(ns, hdr, cmd);
>  		break;
> +	case WRITE_LONG:
> +	case SERVICE_ACTION_OUT_16:
> +		retcode = nvme_trans_write_long(ns, hdr, cmd);
> +		break;

Umm ... SAO16 can be used for more commands than just Write Long 16.  You need
to check the Service Action in addition to the opcode.
