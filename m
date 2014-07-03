From: keith.busch@intel.com (Keith Busch)
Date: Thu, 3 Jul 2014 09:48:59 -0600 (MDT)
Subject: NVM Express Format
In-Reply-To: <04ac01cf96bf$2cf2e6f0$86d8b4d0$@samsung.com>
References: <8838223D960CB945AFF93D316204C6369D8F16@CFWEX01.americas.cray.com>
 <alpine.LRH.2.03.1406250940180.4699@AMR>
 <04ac01cf96bf$2cf2e6f0$86d8b4d0$@samsung.com>
Message-ID: <alpine.LRH.2.03.1407030942210.4703@AMR>

On Thu, 3 Jul 2014, Indraneel Mukherjee wrote:
> sg_format does not appear to work with the NVMe driver. Reason being that
> before doing the actual format, sg_format issues a MODE_SENSE with Page Code
> 0x1 to get info like current Num Of Blocks, Block Size and Write Protect
> setting for the SCSI disk in question.  The driver does not have
> implementation for Page Code 1 as the current SCSI-NVMe translation spec(Rev
> 1.2) does NOT support Page Code 0x1 (Read-Write Error Recovery mode page).
> The driver cannot be faulted for this.

Thanks for the info. I'll send a proposal to the committee and see if
they'll add translation support for this page in the next revision. I
don't think we need to wait for an official release before adding support
in the driver if it sounds like the proposal is acceptable.
