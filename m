From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu,  1 Jun 2017 13:17:42 +0200
Subject: [PATCH v2 0/8] Implement NVMe Namespace Descriptor Identification
Message-ID: <20170601111750.20880-1-jthumshirn@suse.de>

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

While I was already touching the relevant code paths, I decided to
also include the EUI-64 in the 'Identify Namespace' command response.

The code is tested using the nvme-loop loopback target and cut against
the nvme tree's nvme-4.12 branch.

Patches for nvmetcli and nvme-cli will follow shortly.

Changes to v1:
* Added Reviewed-by tags from Christoph and Hannes for unchanged patches
* Added patch introducing new structs at the beginning (Christoph)
* Dropped SZ_4K patch
* Got rid of dynamic memory allocation on the target side (Christoph)
* Reworked host side parser (Christoph)
* Check length inside type check in the host parser (Max)

Changes to v0:
* Fixed wrong size of 4069 and replaced it with SZ_4K (Max)
* Add constants for UUID, NGUID and EUI-64 length (Max)
* Drop EUI-64 Support on target side (Christoph)
* Use uuid_be instead of u8[] (Christoph)
* Add ability to override target's version (Hannes)
* Change hard coded magic 4096 and 0x1000 to SZ_4k in drivers/nvme/*

Johannes Thumshirn (8):
  nvme: introduce NVMe Namespace Identification Descriptor structures
  nvme: rename uuid to nguid in nvme_ns
  nvmet: implement namespace identify descriptor list
  nvmet: add uuid field to nvme_ns and populate via configfs
  nvme: get list of namespace descriptors
  nvme: provide UUID value to userspace
  nvmet: allow overriding the NVMe VS via configfs
  nvmet: use NVME_IDENTIFY_DATA_SIZE

 drivers/nvme/host/core.c        | 118 ++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h        |   1 +
 drivers/nvme/target/admin-cmd.c |  57 ++++++++++++++++++-
 drivers/nvme/target/configfs.c  |  65 ++++++++++++++++++++++
 drivers/nvme/target/core.c      |   2 +-
 drivers/nvme/target/discovery.c |   2 +-
 drivers/nvme/target/nvmet.h     |   1 +
 include/linux/nvme.h            |  23 ++++++++
 8 files changed, 261 insertions(+), 8 deletions(-)

-- 
2.12.0
