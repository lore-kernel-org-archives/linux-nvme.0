From: luto@kernel.org (Andy Lutomirski)
Date: Wed, 24 May 2017 15:06:29 -0700
Subject: [PATCH 0/2] nvme APST fixes
Message-ID: <cover.1495663545.git.luto@kernel.org>

This should fix all known regressions.

Andy Lutomirski (2):
  nvme: Wait at least 6000ms before entering the deepest idle state
  nvme: Quirk APST on Intel 600P/P3100 devices

 drivers/nvme/host/core.c | 38 +++++++++++++++++++++++++++++++-------
 drivers/nvme/host/pci.c  |  2 ++
 2 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.9.4
