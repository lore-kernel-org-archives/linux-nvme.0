From: jsmart2021@gmail.com (James Smart)
Date: Fri,  7 Jul 2017 18:08:24 -0700
Subject: [PATCH 0/2] nvme-fc: Create Association corrections
Message-ID: <20170708010826.12448-1-jsmart2021@gmail.com>

The FC-NVME spec changed between 1.14 and 1.15 and will again in 1.16
to adjust the Create Association LS. The main change was to reduce
the HostID field from 64bytes to 16bytes. This change was picked up in
a linux by checkin in march. However, the 1.15 spec added pad that the
checkin didn't have and added additional pad it shouldn't have, causing
it to exceed the desired 1Kbytes max payload size for FC-NVME LS's.
1.16 will revise the pad such that the overall LS is 1024 bytes in length.

This patch updates the headers for the spec mod and also modifies the
target such that it will accept a variable amount of pad. This allows
older initiators to still connect.


James Smart (2):
  nvme_fc/nvmet_fc: revise Create Association descriptor length
  nvmet_fc: Accept variable pad lengths on Create Association LS

 drivers/nvme/target/fc.c | 20 +++++++++++++-------
 include/linux/nvme-fc.h  | 23 ++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 8 deletions(-)

-- 
2.11.0
