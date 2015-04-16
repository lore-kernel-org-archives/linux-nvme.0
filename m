From: sunad.s@samsung.com (Sunad Bhandary)
Date: Thu, 16 Apr 2015 17:34:00 +0530
Subject: [PATCHv3] NVMe: write_long SCSI to NVMe translation implementation
In-Reply-To: <alpine.LNX.2.00.1503241353070.32385@localhost.lm.intel.com>
References: <1427118493-29227-1-git-send-email-sunad.s@samsung.com>
 <006501d06629$b8397550$28ac5ff0$@samsung.com>
 <alpine.LNX.2.00.1503241353070.32385@localhost.lm.intel.com>
Message-ID: <00aa01d0783d$712a4c40$537ee4c0$@samsung.com>

Hi Keith,

I see that this has not been committed yet. Are any changes needed to the
patch from my side ?

Thanks and regards,
Sunad 

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
Of Keith Busch
Sent: Tuesday, March 24, 2015 7:25 PM
To: Sunad Bhandary
Cc: keith.busch at intel.com; linux-nvme at lists.infradead.org
Subject: RE: [PATCHv3] NVMe: write_long SCSI to NVMe translation
implementation

Hi Sunad,

On Tue, 24 Mar 2015, Sunad Bhandary wrote:
> Hi Keith,
>
> I think this patch suffices for the shortcomings of the previous versions.
> Does anything else seem amiss ?
>
> If I am to submit a version of the patch for the legacy-nvme , the 
> SCSI macro SERVICE_ACTION _OUT_16 is not present in the kernel.
> Is it alright to define a Macro  SAO_16(0x9f)  exclusive to nvme-scsi 
> to support WRITE_LONG_16?

Sounds good. Patch v3 looks good to me as well.

Thanks,
Keith

> From: Sunad Bhandary S <sunad.s at samsung.com>
>
> This patch implements the SCSI to NVMe translation for write_long.
> write_long is translated to the NVMe command write_uncorrectable as 
> defined by the translation specification version 1.4.
>
> This patch also indicates the device support for write_uncorrectable 
> method in the response of extended inquiry as defined in the translation
spec.

Acked-by: Keith Busch <keith.busch at intel.com>

> Signed-off-by: Sunad Bhandary S <sunad.s at samsung.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
