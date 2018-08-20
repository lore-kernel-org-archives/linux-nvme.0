From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 19 Aug 2018 20:36:02 -0400
Subject: [PATCH 0/5] nvme-cli: code cleanup, minor fixes
Message-ID: <20180820003607.21899-1-chaitanya.kulkarni@wdc.com>

This patch-series has minor fixes and code cleanups for nvme-cli.

Regards,
Chaitanya

Chaitanya Kulkarni (5):
  nvme-cli: fix scaandir() return value
  nvme-cli: remove always true condition for u8
  nvme-cli: code cleanup for passthru() handlers
  nvme-cli: don't use unsigned for fd in lnvm-nvme.c
  nvme-cli: fix dead-code nvmf log page discovery

 fabrics.c   |  2 +-
 lnvm-nvme.c |  3 ++-
 nvme.c      | 14 ++++++++------
 3 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.14.1
