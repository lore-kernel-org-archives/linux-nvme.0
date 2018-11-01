From: cascardo@canonical.com (Thadeu Lima de Souza Cascardo)
Date: Thu, 1 Nov 2018 20:31:30 -0300
Subject: [PATCH] nvme: create 'paths' entries for hidden controllers
In-Reply-To: <20181005073245.GA24224@lst.de>
References: <20180928191720.3461-1-cascardo@canonical.com>
 <20181005073245.GA24224@lst.de>
Message-ID: <20181101233129.GB4249@calabresa>

On Fri, Oct 05, 2018@09:32:45AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 28, 2018@04:17:20PM -0300, Thadeu Lima de Souza Cascardo wrote:
> > When using initramfs-tools with only the necessary dependencies to mount
> > the root filesystem, it will fail to include nvme drivers for a root on a
> > multipath nvme. That happens because the slaves relationship is not
> > present.
> > 
> > As discussed in [1], using slaves will break lsblk, because the slaves are
> > hidden from userspace, that is, they have no real block device, just an
> > entry under sysfs.
> > 
> > Introducing the paths subdir and using that on initramfs-tools makes it
> > possible to now boot a system with nvme multipath as root.
> 
> Do we need documentation how these paths links are supposed to work?
> Who is going to parse them?

Hi, Christoph.

I have just sent a v2 against block/for-next with a Documentation file
describing it. The first intended user is initramfs-tools, documented there as
well.

Thanks.
Cascardo.
