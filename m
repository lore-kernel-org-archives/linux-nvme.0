From: kbusch@kernel.org (Keith Busch)
Date: Thu, 28 Feb 2019 17:30:26 -0700
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
In-Reply-To: <680f55f95e7547bdaffddce49772a5b7@AUSX13MPC131.AMER.DELL.COM>
References: <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
 <f6704855445b44639f023a48f3003309@AUSX13MPC131.AMER.DELL.COM>
 <443262761d0e41fbb46a46dab28759c2@AUSX13MPC131.AMER.DELL.COM>
 <20190228141655.GA18319@infradead.org>
 <883e2fad8f6e4791bfee2ec08992da39@AUSX13MPC131.AMER.DELL.COM>
 <20190228232020.GB22003@localhost.localdomain>
 <680f55f95e7547bdaffddce49772a5b7@AUSX13MPC131.AMER.DELL.COM>
Message-ID: <20190301003026.GA22712@localhost.localdomain>

On Thu, Feb 28, 2019@11:43:46PM +0000, Austin.Bolen@dell.com wrote:
> On 2/28/2019 5:20 PM, Keith Busch wrote:
> > SBR and Link Disable are done from the down stream port, though, so the
> > host can still communicate with the function that took the link down.
> > That's entirely different than taking the link down from the end device,
> > so I'm not sure how NVMe can fix that.
> > 
> 
> Agreed it is different.  Here is one way they could have solved it: host 
> writes magic value to NSSRC but device latches this instead of 
> resetting.  Then require host to do SBR.  When device sees SBR with 
> magic value in NSSRC it does an NSSR.

For single port drives, yes, but that wouldn't work so well for multi-port
devices connected to different busses, maybe even across multiple hosts.
The equivalent of an FLR across all ports should have been sufficient,
IMO.
