From: hare@suse.de (Hannes Reinecke)
Date: Fri, 27 Jul 2018 12:26:26 +0200
Subject: [PATCH 0/6] nvme-cli ANA update
Message-ID: <20180727102632.32455-1-hare@suse.de>

Hi all,

here's a patchset to implement ANA support in nvme-cli.
And also some minor fixes and cleanups.

I did not take Chaitanyas patch, as actually this is based an older patch
which I never sent upstream.
Chaitanya, if you disagree I can easily drop this one and use yours instead.
(But mine has JSON support :-).
And I also added support the for 'RGO' bit, and set the 'RAE' bit on per
default when retrieving the ANA log page; not much point in us clearing
the AEN pending bit.

As usual, comments and reviews are welcome.

Hannes Reinecke (6):
  nvme-discover: sanitize options
  nvme-discover: Retry discovery log if the generation counter changes
  nvme-cli: Add ANA support
  nvme-list-subsys: Add device name argument and print out ANA state
  nvme-cli: Implement ana log page support
  fabrics: display controller ID in discovery log output

 Documentation/nvme-ana-log.txt     |  62 +++++++++++++
 Documentation/nvme-discover.txt    |  13 ++-
 Documentation/nvme-list-subsys.txt |   4 +-
 fabrics.c                          |  16 +++-
 linux/nvme.h                       |  33 ++++++-
 nvme-builtin.h                     |   1 +
 nvme-ioctl.c                       |   9 ++
 nvme-ioctl.h                       |   2 +
 nvme-print.c                       | 140 +++++++++++++++++++++++++++-
 nvme-print.h                       |   2 +
 nvme.c                             | 185 +++++++++++++++++++++++++++++++++++--
 nvme.h                             |   1 +
 12 files changed, 448 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/nvme-ana-log.txt

-- 
2.13.7
