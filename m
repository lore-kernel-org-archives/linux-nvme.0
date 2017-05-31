From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 31 May 2017 15:32:10 +0200
Subject: [PATCH v1 0/7] Implement NVMe Namespace Descriptor Identification
Message-ID: <cover.1496237370.git.jthumshirn@suse.de>

This patchset implemets NVMe Namespace Descriptor Identification as of
NVMe 1.3. The Namespace Descriptor Identification allows a NVMe host
to query several Namespace Identification mechanisms, such as EUI-64,
NGUID and UUID from the target. If more than one value is set by the
target, it can transmit all set values to the host.

The Namespace Identification Descriptor list is the only way a target
can identify itself via the newly introduced UUID to the host (instead
of the EUI-64 or NGUID).

Both the Host and Target side are implemented. In order to get the
Linux Host to send the Linux target implementation a Namespace
Descriptor Identification command, you have to change the target's
announced version code to at least 1.3. 

Unfortunately the host side already did have a sysfs attribute called
'uuid' which represented the NGUID, so precautions have been taken to
not break any existing userspace.

The code is tested using the nvme-loop loopback target and cut against
the nvme tree's nvme-4.12 branch.

A patch for nvmetcli will follow shortly.

Changes to v0:
* Fixed wrong size of 4069 and replaced it with SZ_4K (Max)
* Add constants for UUID, NGUID and EUI-64 length (Max)
* Drop EUI-64 Support on target side (Christoph)
* Use uuid_be instead of u8[] (Christoph)
* Add ability to override target's version (Hannes)
* Change hard coded magic 4096 and 0x1000 to SZ_4k in drivers/nvme/*

Johannes Thumshirn (7):
  nvme: rename uuid to nguid in nvme_ns
  nvmet: add uuid field to nvme_ns and populate via configfs
  nvmet: implement namespace identify descriptor list
  nvme: get list of namespace descriptors
  nvme: provide UUID value to userspace
  nvme: change magic 4096 to SZ_4K
  nvmet: allow overriding the NVMe VS via configfs

 drivers/nvme/host/core.c        | 123 ++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h        |   1 +
 drivers/nvme/host/pci.c         |   6 +-
 drivers/nvme/target/admin-cmd.c |  67 +++++++++++++++++++++-
 drivers/nvme/target/configfs.c  |  65 +++++++++++++++++++++
 drivers/nvme/target/discovery.c |   2 +-
 drivers/nvme/target/nvmet.h     |   1 +
 include/linux/nvme.h            |  22 +++++++
 8 files changed, 275 insertions(+), 12 deletions(-)

-- 
2.12.0
