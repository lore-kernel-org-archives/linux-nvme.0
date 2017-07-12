From: a.dawn@samsung.com (Arnav Dawn)
Date: Wed, 12 Jul 2017 16:09:56 +0530
Subject: [PATCH v5 0/2] Add Support for FW activation without reset
In-Reply-To: <1499780675-9869-1-git-send-email-a.dawn@samsung.com>
References: <1499780675-9869-1-git-send-email-a.dawn@samsung.com>
 <CGME20170712103833epcas1p27a75eeadc18428fc5c94c00b64933898@epcas1p2.samsung.com>
Message-ID: <1499855996-29214-1-git-send-email-a.dawn@samsung.com>

This adds Support for handling FW activation without reset.

Changes since last version:
1> minor clean up
2> define  NVME_NSID_ALL for nsid "0xffffffff"

Arnav Dawn (2):
  nvme: Add support for FW activation without reset
  nvme: Define NVME_NSID_ALL

 drivers/nvme/host/core.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  2 ++
 include/linux/nvme.h     | 11 +++++++
 3 files changed, 90 insertions(+), 2 deletions(-)

-- 
1.9.1
