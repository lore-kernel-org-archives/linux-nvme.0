From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Nov 2018 10:16:28 +0100
Subject: [PATCH v2] nvme: create 'paths' entries for hidden controllers
In-Reply-To: <20181101232955.19329-1-cascardo@canonical.com>
References: <20181101232955.19329-1-cascardo@canonical.com>
Message-ID: <20181108091628.GA4217@lst.de>

On Thu, Nov 01, 2018@08:29:55PM -0300, Thadeu Lima de Souza Cascardo wrote:
> When using initramfs-tools with only the necessary dependencies to mount
> the root filesystem, it will fail to include nvme drivers for a root on a
> multipath nvme. That happens because the slaves relationship is not
> present.
> 
> As discussed in [1], using slaves will break lsblk, because the slaves are
> hidden from userspace, that is, they have no real block device, just an
> entry under sysfs.

I wonder if the better way would be to unhide the slaves, but always
have a claim on them, so that others can't really use them?  While the
hiding idea seamed very neat it seems to cause a fair amount of problems
after all.
