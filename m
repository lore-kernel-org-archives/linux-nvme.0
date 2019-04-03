From: hare@suse.de (Hannes Reinecke)
Date: Thu,  4 Apr 2019 00:41:56 +0200
Subject: [PATCH 0/2] nvme: validate CNTLID
Message-ID: <20190403224158.58106-1-hare@suse.de>

Hi all,

here are two patches to validate correct CNTLID information.
A controller might violate the constrain the each CNTLID has to
be unique within a subsystem, which then would cause the host
to crash.
So these patches prevent this situation by validate the CNTLID
and not use the cntlid as part of the device name.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  nvme-multipath: avoid crash on invalid subsystem cntlid enumeration
  nvme: validate cntlid during controller initialisation

 drivers/nvme/host/core.c      | 16 +++++++++++++++-
 drivers/nvme/host/multipath.c |  2 +-
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.16.4
