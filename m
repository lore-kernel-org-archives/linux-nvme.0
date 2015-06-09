From: Jeff.Lien@hgst.com (Jeffrey Lien)
Date: Tue, 9 Jun 2015 19:45:35 +0000
Subject: [PATCHv3 for-3.20] NVMe: Update SCSI Inquiry VPD 83h translation
In-Reply-To: <alpine.LNX.2.00.1501082307010.4026@localhost.lm.intel.com>
References: <1420757697-14839-1-git-send-email-keith.busch@intel.com>
 <alpine.LNX.2.00.1501082307010.4026@localhost.lm.intel.com>
Message-ID: <BL2PR04MB1632F02C733E740E3FCDEEB92BE0@BL2PR04MB163.namprd04.prod.outlook.com>

Keith,
I applied this patch to our version of the driver and have a question about byte ordering.   When I run the command "sg_inq -v /dev/nvme0n1  -p 0x83", the data I get (with your patch applied) seems to be in reverse order.   

[ddtest at gfox4-71 FIO_TESTS]$ sudo sg_inq -v /dev/nvme0n1 -p 0x83
VPD INQUIRY: Device Identification page
    inquiry cdb: 12 01 83 00 fc 00 
  Designation descriptor number 1, descriptor length: 12
    designator_type: EUI-64 based,  code_set: Binary
    associated with the addressed logical unit
      EUI-64 based 8 byte identifier
      IEEE Company_id: 0x4e01
      Vendor Specific Extension Identifier: 0x6000ca0c00
      [0x004e016000ca0c00]

Our company id is 0x0CCA not the 0x4E01 shown above.   Do you agree?      

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Thursday, January 8, 2015 5:10 PM
To: Keith Busch
Cc: linux-nvme at lists.infradead.org
Subject: Re: [PATCHv3 for-3.20] NVMe: Update SCSI Inquiry VPD 83h translation

Sorry, I submitted the patch from my dev machine, not the patch from the tested machine. The designator type is incorrect here, but the attached patch is correct. Only difference is using designator type 2h instead of 3h.

On Thu, 8 Jan 2015, Keith Busch wrote:
> +		inq_response[4] = 0x01;    /* Proto ID=0h | Code set=1h */
> +		inq_response[5] = 0x03;    /* PIV=0b | Asso=00b | Designator Type=3h */
> +		inq_response[6] = 0x00;    /* Rsvd */
> +		inq_response[7] = len;     /* Designator Length */
> +		memcpy(&inq_response[8], eui, len);
