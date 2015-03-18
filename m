From: sunad.s@samsung.com (Sunad Bhandary)
Date: Wed, 18 Mar 2015 20:43:45 +0530
Subject: [PATCHv2] NVMe: write_long SCSI to NVMe translation implementation
In-Reply-To: <20150317125914.GB4003@linux.intel.com>
References: <1425382201-2556-1-git-send-email-sunad.s@samsung.com>
 <004301d060aa$99924070$ccb6c150$@samsung.com>
 <20150317125914.GB4003@linux.intel.com>
Message-ID: <001b01d0618e$2535fd90$6fa1f8b0$@samsung.com>



-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
Of Matthew Wilcox
Sent: Tuesday, March 17, 2015 6:29 PM
To: Sunad Bhandary
Cc: keith.busch at intel.com; linux-nvme at lists.infradead.org
Subject: Re: [PATCHv2] NVMe: write_long SCSI to NVMe translation
implementation

> +	(id_ctrl->oncs & NVME_CTRL_ONCS_WRITE_UNCORRECTABLE) ?
> +				(wrt_uncor = 0x01) : (wrt_uncor = 0);

>This is a weird way of writing it.  Either do it like this:

>	if (id_ctrl->oncs & NVME_CTRL_ONCS_WRITE_UNCORRECTABLE)
>		wrt_uncor = 0x01;
>	else
>		wrt_uncor = 0;

>Or this:

>	wrt_uncor = (id_ctrl->oncs & NVME_CTRL_ONCS_WRITE_UNCORRECTABLE) ? 1
: 0;

>(and what's with the 'hex for one, decimal for the other' decision you made
there?)


-There is nothing to the decision. I happened to pick up bits from the
protect variable in the same function.


> +	case WRITE_LONG:
> +	case SERVICE_ACTION_OUT_16:
> +		retcode = nvme_trans_write_long(ns, hdr, cmd);
> +		break;

>Umm ... SAO16 can be used for more commands than just Write Long 16.  You
need to check the Service Action in addition to the opcode.

I missed the part of SAO16 being used for other commands.

Currently there seems to be no SCSI macro defined for SOA16 corresponding to
WRITE_LONG_16 or other commands. Any check for the service action out
would have to be against hard coded value of 0x11(write_long_16).
_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
