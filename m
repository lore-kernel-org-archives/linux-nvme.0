From: cascardo@canonical.com (Thadeu Lima de Souza Cascardo)
Date: Fri, 14 Dec 2018 07:06:57 -0200
Subject: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
In-Reply-To: <20181214085606.GD5321@calabresa>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-5-cascardo@canonical.com>
 <b3ef062d-3bc3-fdf8-f395-31d1822a3192@suse.de>
 <20181213143218.GA8723@lst.de> <20181213152532.GA5321@calabresa>
 <35acb1b3-77f5-29cf-b92d-5171f4ad6450@suse.de>
 <20181214085606.GD5321@calabresa>
Message-ID: <20181214090656.GE5321@calabresa>

On Fri, Dec 14, 2018@06:56:06AM -0200, Thadeu Lima de Souza Cascardo wrote:
> On Fri, Dec 14, 2018@08:47:20AM +0100, Hannes Reinecke wrote:
> > But you haven't answered my question:
> > 
> > Why can't we patch 'lsblk' to provide the required information even with the
> > current sysfs layout?
> > 
> 

Just to be clear here. If with 'current sysfs layout' you mean without any of
the patches we have been talking about, lsblk is not broken. It just works with
nvme multipath enabled. It will show the multipath paths and simply ignore the
underlying/hidden ones. If we hid them, we meant for them to be hidden, right?

What I am trying to fix here is how to find out which PCI device/driver is
needed to get to the block device holding the root filesystem, which is what
initramfs needs. And the nvme multipath device is a virtual device, pointing to
no driver at all, and no relation to its underlying devices, needed for it to
work.

Cascardo.

> I think we could, but with my Ubuntu hat on, after the kernel fix for
> initramfs-tools, that is, slaves/holders links, the user will get an updated
> kernel that breaks the current lsblk on Bionic (Ubuntu 18.04). That will
> require that we backport the lsblk fix, which is not only more work, but there
> may be users who only update from -security, which is where kernel updates end
> regularly, but not this lsblk fix.
> 
> And that kernel update is a regression against that old lsblk version.
> 
> Cascardo.
> 
> > Cheers,
> > 
> > Hannes
> > -- 
> > Dr. Hannes Reinecke		   Teamlead Storage & Networking
> > hare at suse.de			               +49 911 74053 688
> > SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
> > GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
> > HRB 21284 (AG N?rnberg)
