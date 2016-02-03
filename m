From: azher@hep.caltech.edu (Azher Mughal)
Date: Wed, 3 Feb 2016 10:31:45 -0800
Subject: NVMe and IRQ Affinity
In-Reply-To: <20160203143055.GA23910@localhost.localdomain>
References: <CACo6K_bSDJwt61mnKDpYvcXjCVA9UKGO17pythzcJ8Rnjh19sA@mail.gmail.com>
 <20160202234540.GA21046@localhost.localdomain>
 <CACo6K_YGiH2ER4s21OzmD69LDL+ES0PO54jJ_efcSFw7pHADvQ@mail.gmail.com>
 <20160202235818.GB21046@localhost.localdomain>
 <CACo6K_Zry4303xcvjoqMCCnzmxAVrWgT1+JPWGqXObGu9LnU1g@mail.gmail.com>
 <20160203143055.GA23910@localhost.localdomain>
Message-ID: <56B24791.7040807@hep.caltech.edu>

Hi Keith,

I have similar affinity issues in CentOS 7.2. The nvme module is generic
that came along with this distro. Is there a git repo which can be used
with the kernel "3.10.0-327.4.5" ?

Thanks
-Azher

# modinfo nvme
filename:      
/lib/modules/3.10.0-327.4.5.el7.x86_64/kernel/drivers/block/nvme.ko
version:        1.0
license:        GPL
author:         Matthew Wilcox <willy at linux.intel.com>
rhelversion:    7.2
srcversion:     6FE34EC5F6A703F8EDE6C77
alias:          pci:v*d*sv*sd*bc01sc08i02*
depends:       
intree:         Y
vermagic:       3.10.0-327.4.5.el7.x86_64 SMP mod_unload modversions
signer:         CentOS Linux kernel signing key
sig_key:        10:5D:A1:3D:CA:AA:74:AE:50:00:17:E7:D5:2C:DA:9B:7C:C5:10:93
sig_hashalgo:   sha256
parm:           admin_timeout:timeout in seconds for admin commands (byte)
parm:           io_timeout:timeout in seconds for I/O (byte)
parm:           shutdown_timeout:timeout in seconds for controller
shutdown (byte)
parm:           nvme_major:int
parm:           nvme_char_major:int
parm:           use_threaded_interrupts:int


On 2/3/2016 6:30 AM, Keith Busch wrote:
> On Wed, Feb 03, 2016@01:13:23AM +0100, Mark Jacobson wrote:
>> 1. When you say out-of-tree, do you mean a loadable kernel module?
>> (My understanding is that the NVMe driver is now part of the mainline
>> Linux kernel source tree, so I'm a bit confused as to where to nab
>> that from.)
> Yes, a loadable kernel module or a package that can build one. I am not
> aware of any publicly available. Perhaps your vendor provides one.
>
>> 2. Does the upstream 4.4.1 kernel have any of these fixes if I were to
>> build it myself with the appropriate support ticked off?
> The 4.3 kernel has the fixes, and anything newer than that should also
> work. I think it was just the 4.2 kernel that had this wrong (will see
> if there's are any stable patch candidates).
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
