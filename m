From: keith.busch@intel.com (Keith Busch)
Date: Tue, 9 Jun 2015 20:07:06 +0000 (UTC)
Subject: [PATCHv3 for-3.20] NVMe: Update SCSI Inquiry VPD 83h translation
In-Reply-To: <BL2PR04MB1632F02C733E740E3FCDEEB92BE0@BL2PR04MB163.namprd04.prod.outlook.com>
References: <1420757697-14839-1-git-send-email-keith.busch@intel.com>
 <alpine.LNX.2.00.1501082307010.4026@localhost.lm.intel.com>
 <BL2PR04MB1632F02C733E740E3FCDEEB92BE0@BL2PR04MB163.namprd04.prod.outlook.com>
Message-ID: <alpine.LNX.2.00.1506091950270.15930@localhost.lm.intel.com>

On Tue, 9 Jun 2015, Jeffrey Lien wrote:
> Keith,
> I applied this patch to our version of the driver and have a question about
> byte ordering.   When I run the command "sg_inq -v /dev/nvme0n1  -p 0x83",
> the data I get (with your patch applied) seems to be in reverse order.
>
> [ddtest at gfox4-71 FIO_TESTS]$ sudo sg_inq -v /dev/nvme0n1 -p 0x83
> VPD INQUIRY: Device Identification page
>    inquiry cdb: 12 01 83 00 fc 00
>  Designation descriptor number 1, descriptor length: 12
>    designator_type: EUI-64 based,  code_set: Binary
>    associated with the addressed logical unit
>      EUI-64 based 8 byte identifier
>      IEEE Company_id: 0x4e01
>      Vendor Specific Extension Identifier: 0x6000ca0c00
>      [0x004e016000ca0c00]
>
> Our company id is 0x0CCA not the 0x4E01 shown above.   Do you agree?

Hm, the EUI-64 type translation is a straight byte copy from what
the controller returned from identify namespace. It sounds like your
controller is returning this field as if it were a little-endian 8-byte
field rather than an a string of eight octets.
