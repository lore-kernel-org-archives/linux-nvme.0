From: hare@suse.de (Hannes Reinecke)
Date: Mon, 20 Aug 2018 12:34:05 +0200
Subject: [PATCH 0/2] nvme-discover: Use 'nvme_info' sysfs attribute for fc
 transport
Message-ID: <20180820103407.92783-1-hare@suse.de>

Hi all,

here's a small patchset to use the 'nvme_info' sysfs attribute from the SCSI
host to provide the parameters for 'nvme discover'.
So with this patch it's sufficient to state

nvme discover -t fc

and all discovery log entries are returned.

I know that sysfs attribute is non-standard, but I'll be working on a patch
to implement it for qla2xxx, too.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  nvme-discover: use ASCII characters in documentation
  nvme-discover: parse 'nvme_info' sysfs attribute for fc transport

 Documentation/nvme-discover.txt |   7 +-
 fabrics.c                       | 193 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 198 insertions(+), 2 deletions(-)

-- 
2.16.4
