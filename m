From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 25 May 2018 14:53:19 +0200
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180525125322.15398-1-jthumshirn@suse.de>

Hi,

This patch series aims to provide a more fine grained control over
nvme's native multipathing, by allowing it to be switched on and off
on a per-subsystem basis instead of a big global switch.

The prime use-case is for mixed scenarios where user might want to use
nvme's native multipathing on one subset of subsystems and
dm-multipath on another subset.

For example using native for internal the PCIe NVMe and dm-mpath for
the connection to an NVMe over Fabrics Array.

The initial discussion for this was held at this year's LSF/MM and the
architecture hasn't changed to what we've discussed there.

The first patch does the said switch and Mike added two follow up
patches to access the personality attribute from the block device's
sysfs directory as well.

I do have a blktests test for it as well but due to the fcloop but I
reported I'm reluctant to include it in the series (or I would need to
uncomment the rmmods).

Johannes Thumshirn (1):
  nvme: provide a way to disable nvme mpath per subsystem

Mike Snitzer (2):
  nvme multipath: added SUBSYS_ATTR_RW
  nvme multipath: add dev_attr_mpath_personality

 drivers/nvme/host/core.c      | 112 ++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/multipath.c |  34 +++++++++++--
 drivers/nvme/host/nvme.h      |   8 +++
 3 files changed, 144 insertions(+), 10 deletions(-)

-- 
2.16.3
