From: Austin.Bolen@dell.com (Austin.Bolen@dell.com)
Date: Wed, 27 Feb 2019 20:04:35 +0000
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
 <f6704855445b44639f023a48f3003309@AUSX13MPC131.AMER.DELL.COM>
Message-ID: <443262761d0e41fbb46a46dab28759c2@AUSX13MPC131.AMER.DELL.COM>

On 2/27/2019 11:56 AM, Bolen, Austin wrote:
> 
> BTW, this patch in particular is complaining about an error for a
> removed device.  The Dell servers referenced in this chain will check if
> the device is removed and if so it will suppress the error so I don't
> think they are susceptible to this particular issue and I agree it is
> broken if they do.  If that is the case we can and will fix it in firmware.
> 

Confirmed this issue does not apply to the referenced Dell servers so I 
don't not have a stake in how this should be handled for those systems. 
It may be they just don't support surprise removal.  I know in our case 
all the Linux distributions we qualify (RHEL, SLES, Ubuntu Server) have 
told us they do not support surprise removal.  So I'm guessing that any 
issues found with surprise removal could potentially fall under the 
category of "unsupported".

Still though, the larger issue of recovering from other types of PCIe 
errors that are not due to device removal is still important.  I would 
expect many system from many platform makers to not be able to recover 
PCIe errors in general and hopefully the new DPC CER model will help 
address this and provide added protection for cases like above as well.

Thanks,
Austin
