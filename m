From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 30 May 2017 10:08:15 +0200
Subject: [PATCH 0/7] Implement NVMe Namespace Descriptor Identification
Message-ID: <cover.1496131397.git.jthumshirn@suse.de>

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

A patch for nvmetcli will follow shortly.

Johannes Thumshirn (7):
  nvme: rename uuid to nguid in nvme_ns
  nvmet: add uuid field to nvme_ns and populate via configfs
  nvmet: add eui64 field to nvme_ns and populate via configfs
  nvme: also report include the EUI-64 in identify NS report
  nvmet: implement namespace identify descriptor list
  nvme: get list of namespace descriptors
  nvme: provide UUID value to userspace

 drivers/nvme/host/core.c        | 116 ++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h        |   1 +
 drivers/nvme/target/admin-cmd.c |  76 ++++++++++++++++++++++++++
 drivers/nvme/target/configfs.c  |  96 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     |   2 +
 include/linux/nvme.h            |  14 +++++
 6 files changed, 301 insertions(+), 4 deletions(-)

-- 
2.12.0
