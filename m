From: Austin.Bolen@dell.com (Austin.Bolen@dell.com)
Date: Fri, 1 Mar 2019 01:52:02 +0000
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
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
 <20190301003026.GA22712@localhost.localdomain>
Message-ID: <06eb10e5a7324bb5ac537fd57e015d73@AUSX13MPC131.AMER.DELL.COM>

On 2/28/2019 6:30 PM, Keith Busch wrote:
> 
> For single port drives, yes, but that wouldn't work so well for multi-port
> devices connected to different busses, maybe even across multiple hosts.
> The equivalent of an FLR across all ports should have been sufficient,
> IMO.
> 

In that case I'd argue that it really is a surprise down to the other 
host and escalating as such is appropriate.  Agree that something like 
FLR that reset everything in the subsystem but kept link up may have 
been sufficient.
