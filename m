From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Dec 2018 09:32:16 +0100
Subject: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
In-Reply-To: <20181206202200.GA32080@lst.de>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-5-cascardo@canonical.com>
 <20181206202200.GA32080@lst.de>
Message-ID: <20181212083216.GA30124@lst.de>

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

Thadeu (or other distro folks), any comments on this issue?  If not
I'd like to just move forward with the first two patches for now,
and it would be good to have some reviews for them.
