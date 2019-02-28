From: kbusch@kernel.org (Keith Busch)
Date: Thu, 28 Feb 2019 16:20:22 -0700
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
In-Reply-To: <883e2fad8f6e4791bfee2ec08992da39@AUSX13MPC131.AMER.DELL.COM>
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
Message-ID: <20190228232020.GB22003@localhost.localdomain>

On Thu, Feb 28, 2019@11:10:11PM +0000, Austin.Bolen@dell.com wrote:
> I'd also note that in PCIe, things that intentionally take the link down 
> like SBR or Link Disable suppress surprise down error reporting.  But 
> NSSR doesn't have this requirement to suppress surprise down reporting. 
> I think that's a gap on the part of the NVMe spec.

SBR and Link Disable are done from the down stream port, though, so the
host can still communicate with the function that took the link down.
That's entirely different than taking the link down from the end device,
so I'm not sure how NVMe can fix that.

But I can't even recall why NVMe defined NSSR to require PCIe LTSSM
Detect. That seems entirely unnecessary and is just asking for trouble.
