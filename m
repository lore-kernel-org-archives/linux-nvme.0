From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 27 Aug 2018 15:31:25 -0700
Subject: [PATCH 0/4] nvme-cli: cleanup patches
Message-ID: <20180827223129.2741-1-chaitanya.kulkarni@wdc.com>

Hi,

This patch series contains another round of nvme-cli cleanups.

Regards,
Chaitanya

Chaitanya Kulkarni (4):
  nvme-cli: use uniform error message for open
  nvme-cli: fix indentation
  nvme-cli: make wdc plug-in functions static
  nvme-cli: mark functions static

 fabrics.c    |  9 ++++++++-
 nvme-ioctl.c |  2 +-
 nvme-print.c |  2 +-
 nvme.c       | 37 ++++++++++++++++++++++++++-----------
 wdc-nvme.c   | 16 ++++++++--------
 5 files changed, 44 insertions(+), 22 deletions(-)

-- 
2.17.0
