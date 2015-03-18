From: keith.busch@intel.com (Busch, Keith)
Date: Wed, 18 Mar 2015 15:24:31 +0000
Subject: [PATCHv2] NVMe: write_long SCSI to NVMe translation implementation
In-Reply-To: <001b01d0618e$2535fd90$6fa1f8b0$@samsung.com>
References: <1425382201-2556-1-git-send-email-sunad.s@samsung.com>
 <004301d060aa$99924070$ccb6c150$@samsung.com>
 <20150317125914.GB4003@linux.intel.com>
 <001b01d0618e$2535fd90$6fa1f8b0$@samsung.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93BA9AA16@fmsmsx104.amr.corp.intel.com>

> > +	case WRITE_LONG:
> > +	case SERVICE_ACTION_OUT_16:
> > +		retcode = nvme_trans_write_long(ns, hdr, cmd);
> > +		break;
> 
> >Umm ... SAO16 can be used for more commands than just Write Long 16.  You
> need to check the Service Action in addition to the opcode.
> 
> I missed the part of SAO16 being used for other commands.
> 
> Currently there seems to be no SCSI macro defined for SOA16 corresponding to
> WRITE_LONG_16 or other commands. Any check for the service action out
> would have to be against hard coded value of 0x11(write_long_16).

Sounds good. The translation for SERVICE_ACTION_IN_16 in nvme-scsi.c
decodes the SAI_READ_CAPACITY_16, so this isn't any different.

It's probably okay to add a define for SAO_WRITE_LONG_16 to
include/scsi/scsi.h if you don't want to make it exclusive to
nvme-scsi.
