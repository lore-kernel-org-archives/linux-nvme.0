From: hare@suse.de (Hannes Reinecke)
Date: Wed, 25 Jul 2018 08:28:35 +0200
Subject: [PATCH 0/5] genhd: implement device_add_disk_with_groups()
Message-ID: <20180725062840.94114-1-hare@suse.de>

When creating a block device some drivers need to create additional sysfs
groups to store driver-specific informations.
With the current workflow of adding these groups with a separate call to
sysfs after the device has been created we are introducing a race with udev,
as the uevent is generated before the sysfs attributes are created, and udev
fails to read the required information.

This patchset adds a new function 'device_add_disk_with_groups()' and converts
the obvious candidates to use this new function.

As usual, comments and reviews are welcome.

Hannes Reinecke (5):
  genhd: drop 'bool' argument from __device_add_disk()
  block: genhd: add device_add_disk_with_groups
  nvme: register ns_id attributes as default sysfs groups
  aoe: use device_add_disk_with_groups()
  zram: use device_add_disk_with_groups()

 block/genhd.c                 | 38 ++++++++++++++++++++++++++++++--------
 drivers/block/aoe/aoe.h       |  1 -
 drivers/block/aoe/aoeblk.c    | 21 +++++++--------------
 drivers/block/aoe/aoedev.c    |  1 -
 drivers/block/zram/zram_drv.c | 28 +++++++---------------------
 drivers/nvme/host/core.c      | 14 +++++++-------
 drivers/nvme/host/multipath.c | 12 +++---------
 drivers/nvme/host/nvme.h      |  2 +-
 include/linux/genhd.h         |  3 +++
 9 files changed, 58 insertions(+), 62 deletions(-)

-- 
2.12.3
