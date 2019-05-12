From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 12 May 2019 11:58:14 -0700
Subject: [PATCH 0/6] nvme-cli: code cleanup
Message-ID: <20190512185820.20098-1-chaitanya.kulkarni@wdc.com>

Hi,

This is a small code cleanup patch-series for nvme-cli.

Regards,
Chaitanya

Chaitanya Kulkarni (6):
  nvme-cli: cmbloc code cleanup
  nvme-cli: code cleanup adjust if statement
  nvme-cli: remove trailing space
  nvme-cli: use uniform if .. else format
  nvme-cli: use uniform if .. else format
  nvme-cli: use uniform if .. else format

 nvme-ioctl.c    | 2 +-
 nvme-lightnvm.c | 3 +--
 nvme-models.c   | 3 +--
 nvme-print.c    | 7 +++----
 nvme.c          | 6 ++----
 5 files changed, 8 insertions(+), 13 deletions(-)

-- 
2.17.0
