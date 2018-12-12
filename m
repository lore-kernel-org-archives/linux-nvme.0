From: cascardo@canonical.com (Thadeu Lima de Souza Cascardo)
Date: Wed, 12 Dec 2018 10:39:06 -0200
Subject: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
In-Reply-To: <20181206202200.GA32080@lst.de>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-5-cascardo@canonical.com>
 <20181206202200.GA32080@lst.de>
Message-ID: <20181212123906.GI4269@calabresa>

On Thu, Dec 06, 2018@09:22:00PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 06, 2018@02:48:12PM -0200, Thadeu Lima de Souza Cascardo wrote:
> > Without this exposure, lsblk will fail as it tries to find out the
> > device's dev_t numbers. This causes a real problem for nvme multipath
> > devices, as their slaves are hidden.
> > 
> > Exposing them fixes the problem, even though trying to open the devices
> > returns an error in the case of nvme multipath. So, right now, it's the
> > driver's responsibility to return a failure to open hidden devices.
> 
> So the problem with this is that it will cause udev to actually create
> the /dev/nvmeXcYnZ nodes, which due to the previous patch will always
> fail to open, which is a bit confusing.  I guess we could live with this
> if we add udev rules to supress the creation or something, but in general
> it is a bit ugly.

Well, udev could just look at the hidden attribute. At least to some, the fact
that lsblk would fail was reason enough to revert the patches, so I would
rather apply the entire set.

We could add a message to the log when users try to open them, but given that
some programs (udev is one) would open them without any user interaction, maybe
we shouldn't.

Cascardo.
