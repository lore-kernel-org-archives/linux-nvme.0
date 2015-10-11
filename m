From: lkp@intel.com (Fengguang Wu)
Date: Sun, 11 Oct 2015 22:22:35 +0800
Subject: [kbuild-all] [PATCH 4/5 v2] pseries/iommu: implement DDW-aware
 dma_get_page_shift
In-Reply-To: <1444277187.9940.7.camel@ellerman.id.au>
References: <201510030421.d9fvrbXU%fengguang.wu@intel.com>
 <1444102746.16909.4.camel@ellerman.id.au>
 <20151007135602.GA17377@wfg-t540p.sh.intel.com>
 <1444263119.31685.4.camel@ellerman.id.au>
 <20151008010603.GA24198@wfg-t540p.sh.intel.com>
 <20151008011609.GA25163@wfg-t540p.sh.intel.com>
 <1444277187.9940.7.camel@ellerman.id.au>
Message-ID: <20151011142235.GC17528@wfg-t540p.sh.intel.com>

Hi Michael,

> > > > How did the robot decide to build this series in the first place? Does it build
> > > > everything sent to one of the lists on CC?
> > > 
> > > Yes, currently the following mailing lists are subscribed.  Patches
> > > sent to them will be tested if they can be git-am to RC or linux-next
> > > kernels:
> > > 
> > > kvm
> > > linux-acpi
> > > linux-bluetooth
> > > linux-btrfs
> > > linux-embedded
> > > linux-ext4
> > > linux-fsdevel
> > > linux-media
> > > linux-mmc
> > > linux-nfs
> > > linux-omap
> > > linux-pci
> > > linux-pm
> > > linux-raid
> > > linux-rdma
> > > linux-scsi
> > > linux-usb
> > > linux-wireless
> > > netdev
> > > netfilter-devel
> > > linux-mm
> > > driverdev-devel
> > > intel-gfx
> > 
> > And of course linux-kernel. More lists could be added in future.
> 
> So do you mind adding linuxppc-dev at lists.ozlabs.org ? :)
> 
> It's pretty low traffic compared to lkml.

Sure, I'm subscribing to it. :)

Thanks,
Fengguang
