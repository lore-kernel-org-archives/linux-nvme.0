From: keith.busch@intel.com (Keith Busch)
Date: Wed, 12 Apr 2017 11:00:37 -0400
Subject: [NVMeF]: Multipathing setup for NVMeF
In-Reply-To: <CAJvSebub-HnRnCpE-z2aTxmkrJLTo7=c9FoBncgJ+BZ_PUYsMQ@mail.gmail.com>
References: <CAJvSebub-HnRnCpE-z2aTxmkrJLTo7=c9FoBncgJ+BZ_PUYsMQ@mail.gmail.com>
Message-ID: <20170412150037.GC623@localhost.localdomain>

On Wed, Apr 12, 2017@02:58:05PM +0530, Ankur Srivastava wrote:
> I have connected my Initiator to both the ports of Ethernet
> Adapter(Target) to get 2 IO Paths, from the above data "/dev/nvme0n1"
> is path 1 and "/dev/nvme1n1" is path 2 for the same namespace.
> 
> Note: I am using Null Block device on the Target Side.
> 
> But still the multipath is showing an error ie no path to Host for All
> the NVMe Drives mapped on the Initiator. Does multipathd supports NVMe
> over Fabric ??
> Or what I am missing from configuration side ??
> 
> Thanks in advance!!

I think you need a udev rule to export the wwn like

  KERNEL=="nvme*[0-9]n*[0-9]", ENV{DEVTYPE}=="disk", ATTRS{wwid}=="?*", ENV{ID_WWN}="$attr{wwid}"

And multipathd conf needs to use that attribute for uid for NVME,
uid_attribute = "ID_WWN".

These should be there by default if you've very recent versions (within
the last 6 weeks) of multipath-tools and systemd installed.

If your kernel has CONFIG_SCSI_DH set, you'll also need this recent
kernel commit:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=857de6e00778738dc3d61f75acbac35bdc48e533
