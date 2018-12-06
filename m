From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Dec 2018 21:22:00 +0100
Subject: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
In-Reply-To: <20181206164812.30925-5-cascardo@canonical.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-5-cascardo@canonical.com>
Message-ID: <20181206202200.GA32080@lst.de>

On Thu, Dec 06, 2018@02:48:12PM -0200, Thadeu Lima de Souza Cascardo wrote:
> Without this exposure, lsblk will fail as it tries to find out the
> device's dev_t numbers. This causes a real problem for nvme multipath
> devices, as their slaves are hidden.
> 
> Exposing them fixes the problem, even though trying to open the devices
> returns an error in the case of nvme multipath. So, right now, it's the
> driver's responsibility to return a failure to open hidden devices.

So the problem with this is that it will cause udev to actually create
the /dev/nvmeXcYnZ nodes, which due to the previous patch will always
fail to open, which is a bit confusing.  I guess we could live with this
if we add udev rules to supress the creation or something, but in general
it is a bit ugly.
