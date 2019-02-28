From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 28 Feb 2019 06:16:55 -0800
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
In-Reply-To: <443262761d0e41fbb46a46dab28759c2@AUSX13MPC131.AMER.DELL.COM>
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
Message-ID: <20190228141655.GA18319@infradead.org>

On Wed, Feb 27, 2019@08:04:35PM +0000, Austin.Bolen@dell.com wrote:
> Confirmed this issue does not apply to the referenced Dell servers so I 
> don't not have a stake in how this should be handled for those systems. 
> It may be they just don't support surprise removal.  I know in our case 
> all the Linux distributions we qualify (RHEL, SLES, Ubuntu Server) have 
> told us they do not support surprise removal.  So I'm guessing that any 
> issues found with surprise removal could potentially fall under the 
> category of "unsupported".
> 
> Still though, the larger issue of recovering from other types of PCIe 
> errors that are not due to device removal is still important.  I would 
> expect many system from many platform makers to not be able to recover 
> PCIe errors in general and hopefully the new DPC CER model will help 
> address this and provide added protection for cases like above as well.

FYI, a related issue I saw about a year two ago with Dell servers was
with a dual ported NVMe add-in (non U.2) card, is that once you did
a subsystem reset, which would cause both controller to retrain the link
you'd run into Firmware First error handling issue that would instantly
crash the system.  I don't really have the hardware anymore, but the
end result was that I think the affected product ended up shipping
with subsystem resets only enabled for the U.2 form factor.
