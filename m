From: mwilck@suse.com (Martin Wilck)
Date: Fri, 14 Jul 2017 00:25:30 +0200
Subject: [PATCH 0/3] Improve readbility of NVME "wwid" attribute
Message-ID: <20170713222533.30794-1-mwilck@suse.com>

With the current implementation, the default "fallback" WWID generation
code (if no nguid, euid etc. are defined) for Linux NVME host and target
results in the following WWID format:

nvme.0000-3163653363666438366239656630386200-4c696e75780000000000000000000000000000000000000000000000000000000000000000000000-00000002

This is not only hard to read, it poses real problems for multipath
(dm WWIDs are limited to 128 characters), and it's not fully standards
compliant.

With this patch series, the WWID on a Linux host connected to a Linux target
looks like this:
nvme.0000-d319fc8b2883bfec-4c696e7578-00000001

Martin Wilck (3):
  nvmet: identify controller: improve standard compliance
  nvme: wwid_show: strip trailing 0-bytes
  nvme: wwid_show: copy hex string verbatim

 drivers/nvme/host/core.c        | 30 ++++++++++++++++++++++++++----
 drivers/nvme/target/admin-cmd.c | 21 ++++++++++++++-------
 2 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.13.2
