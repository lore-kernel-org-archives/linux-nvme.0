From: Austin.Bolen@dell.com (Austin.Bolen@dell.com)
Date: Thu, 28 Feb 2019 23:10:11 +0000
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
References: <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
 <f6704855445b44639f023a48f3003309@AUSX13MPC131.AMER.DELL.COM>
 <443262761d0e41fbb46a46dab28759c2@AUSX13MPC131.AMER.DELL.COM>
 <20190228141655.GA18319@infradead.org>
Message-ID: <883e2fad8f6e4791bfee2ec08992da39@AUSX13MPC131.AMER.DELL.COM>

On 2/28/2019 8:17 AM, Christoph Hellwig wrote:
> 
> [EXTERNAL EMAIL]
> 
> On Wed, Feb 27, 2019@08:04:35PM +0000, Austin.Bolen@dell.com wrote:
>> Confirmed this issue does not apply to the referenced Dell servers so I
>> don't not have a stake in how this should be handled for those systems.
>> It may be they just don't support surprise removal.  I know in our case
>> all the Linux distributions we qualify (RHEL, SLES, Ubuntu Server) have
>> told us they do not support surprise removal.  So I'm guessing that any
>> issues found with surprise removal could potentially fall under the
>> category of "unsupported".
>>
>> Still though, the larger issue of recovering from other types of PCIe
>> errors that are not due to device removal is still important.  I would
>> expect many system from many platform makers to not be able to recover
>> PCIe errors in general and hopefully the new DPC CER model will help
>> address this and provide added protection for cases like above as well.
> 
> FYI, a related issue I saw about a year two ago with Dell servers was
> with a dual ported NVMe add-in (non U.2) card, is that once you did
> a subsystem reset, which would cause both controller to retrain the link
> you'd run into Firmware First error handling issue that would instantly
> crash the system.  I don't really have the hardware anymore, but the
> end result was that I think the affected product ended up shipping
> with subsystem resets only enabled for the U.2 form factor.
> 

Yes, that's another good one.  For add-in cards, they are not 
hot-pluggable and so the platform will not set the Hot-Plug Surprise bit 
in the port above them.  So when the surprise link down happens the 
platform will generate a fatal error.  For U.2, the Hot-Plug Surprise 
bit is set on these platforms which suppresses the fatal error.  It's ok 
to suppress in this case since OS will get notified via hot-plug 
interrupt.  In the case of the add-in card there is no hot-plug 
interrupt and so the platform has no idea if the OS will handle the 
surprise link down or not so platform has to err on the side of caution. 
  This is another case where the new containment error recovery model 
will help by allowing platform to know if OS can recover from this error 
or not.

Even if the system sets the Hot-Plug Surprise bit, the system can still 
crater if OS does an NSSR and then some sort of MMIO is generated to the 
downed port.  Platforms that suppress errors for removed devices will 
still escalate this error as fatal since the device is still present. 
But again the error containment model should protect this case as well.

I'd also note that in PCIe, things that intentionally take the link down 
like SBR or Link Disable suppress surprise down error reporting.  But 
NSSR doesn't have this requirement to suppress surprise down reporting. 
I think that's a gap on the part of the NVMe spec.

-Austin
