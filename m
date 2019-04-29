From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 28 Apr 2019 20:24:39 -0700
Subject: [PATCH 0/3] nvme: improve logging
Message-ID: <20190429032442.5923-1-chaitanya.kulkarni@wdc.com>

These code changes are originally posted by
Hannes Reinecke <hare at suse.com> :-
http://lists.infradead.org/pipermail/linux-nvme/2019-April/023336.html

I've added all the comments posted on this patch-series along with my
signoff to the patches. Please keep my sign off if Hannes is okay
with it.

Regards,
-Chaitanya

Changes from V1:
1. Move the NVMe ctrl state array of string to the header file whee
   all controller states are defined.
2. Remvoe extra state_name variable and use the
   nvme_get_ctrl_state_name() when reporting the ctrl state.
3. Add "nvme-mp" prefix to the debug message for multipating code. 
Chaitanya Kulkarni (3):
  nvme: introduce nvme-ctrl state name string array
  nvme: improve logging
  nvme-multipath: improve logging

 drivers/nvme/host/core.c      | 41 ++++++++++++++++++++---------------
 drivers/nvme/host/multipath.c |  5 ++++-
 drivers/nvme/host/nvme.h      | 10 +++++++++
 3 files changed, 37 insertions(+), 19 deletions(-)

-- 
2.17.0
