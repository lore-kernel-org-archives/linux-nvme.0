From: hare@suse.de (Hannes Reinecke)
Date: Fri,  3 May 2019 14:26:40 +0200
Subject: [PATCHv2 0/2] nvme: validate CNTLID
Message-ID: <20190503122642.59317-1-hare@suse.de>

Hi all,

here are two patches to validate correct CNTLID information.
A controller might violate the constrain the each CNTLID has to
be unique within a subsystem, which then would cause the host
to crash.
So these patches prevent this situation by validate the CNTLID
and not use the cntlid as part of the device name.

As usual, comments and reviews are welcome.

Changes to v1:
- split cntlid validation into a separate helper and moved to
  nvme_init_subsystem()

Hannes Reinecke (2):
  nvme-multipath: avoid crash on invalid subsystem cntlid enumeration
  nvme: validate cntlid during controller initialisation

 drivers/nvme/host/core.c      | 27 +++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c |  2 +-
 2 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.16.4
