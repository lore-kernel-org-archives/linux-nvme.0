From: hare@suse.de (Hannes Reinecke)
Date: Thu, 20 Sep 2018 11:09:33 +0200
Subject: [PATCH 0/6] nvme-cli: fixup large log page transfer
Message-ID: <20180920090939.6348-1-hare@suse.de>

Hi all,

on large installations the MDTS value might prevent the controller to
transfer the entire log page in one go. This patchset updates nvme_get_log()
to retrieve the log page in 4k chunks so as having to avoid checking the
MDTS value.
I've also added an 'rae' field to nvme_get_log() to avoid it accidentally
clearing outstanding AENs.
And the seagate plugin has been cleaned up :-)

As usual, comments and reviews are welcome.

Hannes Reinecke (6):
  nvme-discover: Retry discovery log if the generation counter changes
  nvme-ioctl: retrieve log pages in 4k chunks
  nvme-discover: Re-check generation counter after log page transfer
  seagate-nvme: fixup coding style
  nvme-cli: Add 'rae' argument to nvme_get_log()
  nvme-cli: kill nvme_passthru_admin()

 fabrics.c       |   89 ++-
 intel-nvme.c    |   12 +-
 memblaze-nvme.c |    3 +-
 nvme-ioctl.c    |   63 +-
 nvme-ioctl.h    |   11 +-
 seagate-nvme.c  | 2223 +++++++++++++++++++++++++++----------------------------
 toshiba-nvme.c  |    2 +-
 wdc-nvme.c      |   10 +-
 8 files changed, 1183 insertions(+), 1230 deletions(-)

-- 
2.13.7
