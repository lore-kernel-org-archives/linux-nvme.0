From: rakesh@tuxera.com (Rakesh Pandit)
Date: Wed, 24 May 2017 17:25:27 +0300
Subject: [PATCH V2 0/1] nvme: fix multiple ctrl removal scheduling
Message-ID: <20170524142525.GA27669@dhcp-216.srv.tuxera.com>

Updated previous patch with correct fix (suggested by Christoph
Hellwig) and tested.

Rakesh Pandit (1):
  nvme: fix multiple ctrl removal scheduling

 drivers/nvme/host/pci.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

-- 
2.5.5
