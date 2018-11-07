From: bdeyal@gmail.com (Eyal BenDavid)
Date: Wed, 7 Nov 2018 19:59:19 +0200
Subject: Question regarding dual-port NVMe drives naming.
In-Reply-To: <20181107173223.dl5fludr3yidnyqi@yadro.com>
References: <20181107155241.ynvixi56i44zeakz@yadro.com>
 <20181107162457.GA15835@localhost.localdomain>
 <20181107173223.dl5fludr3yidnyqi@yadro.com>
Message-ID: <CAPrnrPAm090xkOeo_hawnagYrLi=Ztcba-O4U+OU2kq+77tLHQ@mail.gmail.com>

No, you don't have to rebuild the kernel.

You can add option for modprobe to disable nvme multipath.

# cat /etc/modprobe.d/SOME_NAME.conf
options nvme_core multipath=N

Note that you should regenerate initrd too.

To check if you have native nvme multipathing:
# cat /sys/module/nvme_core/parameters/multipath

Eyal

On Wed, Nov 7, 2018@7:32 PM ???? ???????? <ilya@yadro.com> wrote:
>
> Keith,
> thank you for quick response. Am I correct that to disable it I have to
> recompile kernel with CONFIG_NVME_MULTIPATH=n? No other options to disable it
> quickly exists?
>
> Keith Busch <keith.busch at intel.com> wrote on ?? [2018-???-07 09:24:58 -0700]:
> >On Wed, Nov 07, 2018@06:52:41PM +0300, ???? ???????? wrote:
> >> Hello,
> >> recently I started to use dual-port NVMe drives and faced with behaviour different to single-port drives.
> >>
> >> Dual-port drives have [virtual] Expansion ROM at 3ff083000000 [disabled] [size=128K] while single-port drives does not have expansion ROMs.
> >> In naming of dual-port drives there are new names in sysfs like nvme1c1n1.
> >> Also all dual-port drives in sysfs are located in virtual directory like they don't have any parent bus.
> >>
> >> Could somebody explain this difference or give the direction where to dig?
> >
> >You are using a relatively recent kernel with CONFIG_NVME_MULTIPATH set.
> >This option exposes nvme block devices under their nvme subsystem
> >abstraction rather than under the controller so you see only one block
> >handle per-namespace. The subsystem is presented as a virtual device.
> >
> >The individual block paths are hidden from the user, but the topology
> >is visible in sysfs, like the nvme1c1n1 in your example.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
