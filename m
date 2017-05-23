From: rakesh@tuxera.com (Rakesh Pandit)
Date: Wed, 24 May 2017 01:14:14 +0300
Subject: [PATCH 0/2] nvme: fix multiple ctrl removal scheduling and warning
Message-ID: <20170523221412.GA23931@dhcp-216.srv.tuxera.com>

The first patch tries to address the repeated queuing of reset work
into queue when frequency of I/O is high.  Details are in log
message. Second one adress a status message which allows one if
failure (removal of controller) was due to failure to change state or
something else.

Rakesh Pandit (2):
  nvme: fix multiple ctrl removal scheduling
  nvme: fix status message while removing controller

 drivers/nvme/host/pci.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.5.5
