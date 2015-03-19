From: sunad.s@samsung.com (Sunad Bhandary)
Date: Thu, 19 Mar 2015 17:27:18 +0530
Subject: [PATCHv2] NVMe: write_long SCSI to NVMe translation implementation
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93BA9AA16@fmsmsx104.amr.corp.intel.com>
References: <1425382201-2556-1-git-send-email-sunad.s@samsung.com>
 <004301d060aa$99924070$ccb6c150$@samsung.com>
 <20150317125914.GB4003@linux.intel.com>
 <001b01d0618e$2535fd90$6fa1f8b0$@samsung.com>
 <B58D82457FDA0744A320A2FC5AC253B93BA9AA16@fmsmsx104.amr.corp.intel.com>
Message-ID: <006701d0623b$e19cb340$a4d619c0$@samsung.com>



-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
Of Busch, Keith
Sent: Wednesday, March 18, 2015 8:55 PM
To: Sunad Bhandary; 'Matthew Wilcox'
Cc: linux-nvme at lists.infradead.org
Subject: RE: [PATCHv2] NVMe: write_long SCSI to NVMe translation
implementation

> > +	case WRITE_LONG:
> > +	case SERVICE_ACTION_OUT_16:
> > +		retcode = nvme_trans_write_long(ns, hdr, cmd);
> > +		break;
> 
> >Umm ... SAO16 can be used for more commands than just Write Long 16.  
> >You
> need to check the Service Action in addition to the opcode.
> 
> I missed the part of SAO16 being used for other commands.
> 
> Currently there seems to be no SCSI macro defined for SOA16 
> corresponding to
> WRITE_LONG_16 or other commands. Any check for the service action out 
> would have to be against hard coded value of 0x11(write_long_16).

>Sounds good. The translation for SERVICE_ACTION_IN_16 in nvme-scsi.c
decodes the SAI_READ_CAPACITY_16, so this isn't any different.

>It's probably okay to add a define for SAO_WRITE_LONG_16 to
include/scsi/scsi.h if you don't want to make it exclusive to nvme-scsi.

Okay, I will make the changes for the SAO comparison for write_long_16
exclusive to nvme-scsi and send out the modified patch in a couple of days.


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
