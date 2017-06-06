From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue,  6 Jun 2017 16:36:08 +0200
Subject: [PATCH v5 0/9] Implement NVMe Namespace Descriptor Identification
Message-ID: <20170606143617.32143-1-jthumshirn@suse.de>

This patchset implemets NVMe Namespace Descriptor Identification as of
NVMe 1.3. The Namespace Descriptor Identification allows a NVMe host
to query several Namespace Identification mechanisms, such as EUI-64,
NGUID and UUID from the target. If more than one value is set by the
target, it can transmit all set values to the host.

The Namespace Identification Descriptor list is the only way a target
can identify itself via the newly introduced UUID to the host (in
addition to the EUI-64 or NGUID).

Both the Host and Target side are implemented. In order to get the
Linux Host to send the Linux target implementation a Namespace
Descriptor Identification command, you have to change the target's
announced version code to at least 1.3. 

Unfortunately the host side already did have a sysfs attribute called
'uuid' which represented the NGUID, so precautions have been taken to
not break any existing userspace.

The code is tested using the nvme-loop loopback target and cut against
Christoph's uuid/for-next branch.

A patch for nvmetcli and nvme-cli will follow shortly.

Changes to v4:
* Add nvmet_copy_ns_identifier() helper (Christoph)
* Move 'nvmet: use NVME_IDENTIFY_DATA_SIZE' to beginning of series (Christoph)
* Protect subsystem version with nvmet_config_sem (Christoph)
* Get rid of local variables in nvmet_subsys_version_show (Christoph)
* Included dots in subsystem version (Sagi)
* Merge nvme_parse_ns_descs() into nvme_identify_ns_descs() (Christoph)
* Skip unknown NS descriptors in nvme_identify_ns_descs() (Christoph)
* Add sg_zeroout_area() helper to lib/scatterlist.c (Christoph)
* I'm not sure if I shall use nvme_ns_identifier_hdr or nvme_ns_id_desc
* Rebased on Christoph's uuid/for-next branch
* Collected Acks

Changes to v3:
* Autogenerate UUID on target NS allocation (Sagi)

Changes to v2:
* Added Max's Reviewed-by
* Make series bisectable

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

Johannes Thumshirn (9):
  scatterlist: add sg_zeroout_area() helper
  nvmet: use NVME_IDENTIFY_DATA_SIZE
  nvme: introduce NVMe Namespace Identification Descriptor structures
  nvme: rename uuid to nguid in nvme_ns
  nvmet: implement namespace identify descriptor list
  nvmet: add uuid field to nvme_ns and populate via configfs
  nvme: get list of namespace descriptors
  nvme: provide UUID value to userspace
  nvmet: allow overriding the NVMe VS via configfs

 drivers/nvme/host/core.c        | 110 ++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h        |   1 +
 drivers/nvme/target/admin-cmd.c |  65 +++++++++++++++++++++++-
 drivers/nvme/target/configfs.c  |  68 +++++++++++++++++++++++++
 drivers/nvme/target/core.c      |   3 +-
 drivers/nvme/target/discovery.c |   2 +-
 drivers/nvme/target/nvmet.h     |   1 +
 include/linux/nvme.h            |  23 +++++++++
 include/linux/scatterlist.h     |   3 ++
 lib/scatterlist.c               |  37 ++++++++++++++
 10 files changed, 305 insertions(+), 8 deletions(-)

-- 
2.12.3
