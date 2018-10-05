From: hch@lst.de (Christoph Hellwig)
Date: Fri, 5 Oct 2018 09:32:45 +0200
Subject: [PATCH] nvme: create 'paths' entries for hidden controllers
In-Reply-To: <20180928191720.3461-1-cascardo@canonical.com>
References: <20180928191720.3461-1-cascardo@canonical.com>
Message-ID: <20181005073245.GA24224@lst.de>

On Fri, Sep 28, 2018@04:17:20PM -0300, Thadeu Lima de Souza Cascardo wrote:
> When using initramfs-tools with only the necessary dependencies to mount
> the root filesystem, it will fail to include nvme drivers for a root on a
> multipath nvme. That happens because the slaves relationship is not
> present.
> 
> As discussed in [1], using slaves will break lsblk, because the slaves are
> hidden from userspace, that is, they have no real block device, just an
> entry under sysfs.
> 
> Introducing the paths subdir and using that on initramfs-tools makes it
> possible to now boot a system with nvme multipath as root.

Do we need documentation how these paths links are supposed to work?
Who is going to parse them?
