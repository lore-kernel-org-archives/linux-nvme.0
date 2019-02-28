From: Austin.Bolen@dell.com (Austin.Bolen@dell.com)
Date: Thu, 28 Feb 2019 23:43:46 +0000
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
References: <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
 <f6704855445b44639f023a48f3003309@AUSX13MPC131.AMER.DELL.COM>
 <443262761d0e41fbb46a46dab28759c2@AUSX13MPC131.AMER.DELL.COM>
 <20190228141655.GA18319@infradead.org>
 <883e2fad8f6e4791bfee2ec08992da39@AUSX13MPC131.AMER.DELL.COM>
 <20190228232020.GB22003@localhost.localdomain>
Message-ID: <680f55f95e7547bdaffddce49772a5b7@AUSX13MPC131.AMER.DELL.COM>

On 2/28/2019 5:20 PM, Keith Busch wrote:
> 
> [EXTERNAL EMAIL]
> 
> On Thu, Feb 28, 2019@11:10:11PM +0000, Austin.Bolen@dell.com wrote:
>> I'd also note that in PCIe, things that intentionally take the link down
>> like SBR or Link Disable suppress surprise down error reporting.  But
>> NSSR doesn't have this requirement to suppress surprise down reporting.
>> I think that's a gap on the part of the NVMe spec.
> 
> SBR and Link Disable are done from the down stream port, though, so the
> host can still communicate with the function that took the link down.
> That's entirely different than taking the link down from the end device,
> so I'm not sure how NVMe can fix that.
> 

Agreed it is different.  Here is one way they could have solved it: host 
writes magic value to NSSRC but device latches this instead of 
resetting.  Then require host to do SBR.  When device sees SBR with 
magic value in NSSRC it does an NSSR.

> But I can't even recall why NVMe defined NSSR to require PCIe LTSSM
> Detect. That seems entirely unnecessary and is just asking for trouble.
> 

Not sure why but maybe they wanted a full reset of everything including 
the PCIe block.  I can ask around.  Also agree it is asking for trouble 
to have device take the link down without parent bridge knowing what's 
going on.  There are new mechanism being proposed in NVMe that would 
also allow the device to initiate link down with no co-ordination with 
the parent bridge so may need to think on ways to avoid this issue for 
these new similar mechanisms.

-Austin
