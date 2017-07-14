From: mwilck@suse.com (Martin Wilck)
Date: Fri, 14 Jul 2017 13:32:05 +0200
Subject: [PATCH 0/4] libmultipath: Fixes for NVME / NVMEoF
Message-ID: <20170714113209.17177-1-mwilck@suse.com>

Current code fails to set up multipath maps for NVME devices in a
Linux target/Linux host combination. This series enables at least
basic operation.

Patch 1/4 fixes a crash that happens if over-long WWIDs are encountered, and
is not specific to NVME as such. Patch 2/4 drops
the broken test uevent_can_discard_by_devpath(). Patch 3/4 compensates
for the additional event processing required by 2/4. Patch 4/4 mangles
overlong "nvme.*" WWIDs to make them usable for multipath (related discussion
in [1]; WWID_SIZE can't be simply increased because it has to match
device mapper's DM_NAME_LEN).

[1] http://lists.infradead.org/pipermail/linux-nvme/2017-July/011960.html

Martin Wilck (4):
  libmultipath: get_udev_uid: make sure pp->wwid is 0-terminated
  libmultipath: drop uevent_can_discard_by_devpath
  libmultipath: only listen for uevents with DEVTYPE=disk
  libmultipath: fix over-long NVME WWIDs

 libmultipath/discovery.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
 libmultipath/uevent.c    | 27 +---------------
 2 files changed, 81 insertions(+), 26 deletions(-)

-- 
2.13.2
