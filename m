From: hare@suse.de (Hannes Reinecke)
Date: Tue, 18 Jun 2019 09:48:59 +0200
Subject: [PATCH] PCI: Add Intel remapped NVMe device support
In-Reply-To: <CAOSXXT7eV4SBSkoKoOKAPaUQxczrD3rAvpz=12LTQenvRjCYRw@mail.gmail.com>
References: <20190610074456.2761-1-drake@endlessm.com>
 <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
 <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
 <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>
 <20190613085402.GC13442@lst.de>
 <CAD8Lp47Vu=w+Lj77_vL05JYV1WMog9WX3FHGE+TseFrhcLoTuA@mail.gmail.com>
 <CAOSXXT4Ba_6xRUyaQBxpq+zdG9_itXDhFJ5EFZPv3CQuJZKHzg@mail.gmail.com>
 <20190614200557.GS13533@google.com>
 <CAOSXXT7eV4SBSkoKoOKAPaUQxczrD3rAvpz=12LTQenvRjCYRw@mail.gmail.com>
Message-ID: <0edd328f-4040-73ec-39fc-50d1ea785fb9@suse.de>

On 6/14/19 11:05 PM, Keith Busch wrote:
> On Fri, Jun 14, 2019@2:06 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> Ugh.  Are you saying the installation instructions for Linux will say
>> "change the BIOS setting to AHCI"?  That's an unpleasant user
>> experience, especially if the installation fails if the user hasn't
>> read the instructions.
> 
> :) That is essentially what the dmesg currently says when Linux
> detects this, from drivers/ata/ahci.c:ahci_remap_check()
> 
>   "Switch your BIOS from RAID to AHCI mode to use them (remapped NVMe devices)"
> 
> Unpleasant yes, but what's the lesser of two evils? Recommend the
> supported full featured mode, or try to support with degraded
> capabilities?
> 
... and we already had several customer calls because of this.
Quite tedious, and completely unneccesary IMO.
The time for having the interface changed has passed, and we have to
live with it.
I still do prefer to have a driver for it, just to smooth the initial
user experience.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
