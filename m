From: scott.bauer@intel.com (Scott Bauer)
Date: Tue, 11 Jul 2017 13:44:00 -0600
Subject: kernel BUG at nvme/host/pci.c
In-Reply-To: <20170711194523.GD4604@localhost.localdomain>
References: <28fcb21a-35b6-61c1-29e0-9adcc954c98c@pse-consulting.de>
 <20170710190818.GA13671@localhost.localdomain>
 <64da8c4d-2d69-22fa-06a0-aa4f11903e39@pse-consulting.de>
 <20170711194523.GD4604@localhost.localdomain>
Message-ID: <20170711194358.ifhtp32mxljypnr6@sbauer-Z170X-UD5>

On Tue, Jul 11, 2017@03:45:24PM -0400, Keith Busch wrote:
> On Tue, Jul 11, 2017@09:44:47AM +0200, Andreas Pflug wrote:
> > Tested with 4.12.0, result is
> > 
> >   kernel BUG at drivers/nvme/host/pci.c:610!
> > 
> > Kernel seems to recover from that, but I did a reboot anyway.
>  
> Ugh, still observing invalid scatter lists on 4.12. Definitely recommend
> rebooting after hitting this.
> 
> There should only be two possibilities: either the block layer didn't
> split a bio that it should have, or it merged two that it shouldn't. To
> determine which, could disable merging for NVMe before running your
> test? Something like this should accomplish that:
> 
>   # echo 1 | tee /sys/block/nvme*/queue/nomerge
> 
> On a side note, I think we should make the BUG_ON a WARN_ON, and return
> an IO error. While it'd fail IO, it should leave the system stable to
> do more prodding.

FWIW I agree that switching the BUG_ON to WARN_ON is a good idea.
Linus has ranted numerous times for BUG_ON'ing when a WARN_ON will do.
http://lkml.iu.edu/hypermail/linux/kernel/1610.0/00878.html
