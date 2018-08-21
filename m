From: hare@suse.de (Hannes Reinecke)
Date: Tue, 21 Aug 2018 15:43:25 +0200
Subject: [RFC PATCH 0/4] nvme async-connect and discovery uevents
Message-ID: <20180821134329.69577-1-hare@suse.de>

Hi all,

here's my next attempt to solve the auto-connect issue. The overall idea
is to have an 'async_connect' option to the nvme cli, which would return
immediately from the ioctl without waiting for any I/O to complete.
With that we're safe to call 'nvme connect' or 'nvme discover' from udev
rules, and don't run into the risk of accidentally stalling udev as the
nvme cli call doesn't return.
As we then can't return the discovery log anymore (as the connect hasn't
happened by the time we're returning from the 'connect' ioctl) I've also
implemented discovery uevents for each entry in the discovery log page.
And while I've been at it I've also implemented a 'discovery' sysfs attribute
for the discovery controller, holding all found discovery records.

With these patches we can implement a simple autoconnect:

1) call 'nvme discover --async_connect --trtype ...'.
2) The discovery log is fetched from the kernel, and an uevent for each
discovery record is generated:

UDEV  [1920.740092] change   /devices/virtual/nvme-fabrics/ctl/nvme0 (nvme)
ACTION=change
DEVNAME=/dev/nvme0
DEVPATH=/devices/virtual/nvme-fabrics/ctl/nvme0
MAJOR=244
MINOR=0
NVME_DISCOVERY_ADRFAM=fc
NVME_DISCOVERY_HOST_TRADDR=nn-0x20000090fae06325:pn-0x10000090fae06325
NVME_DISCOVERY_SUBNQN=blktests-subsys
NVME_DISCOVERY_TRADDR=nn-0x200200a09890f5bf:pn-0x200300a09890f5bf
NVME_DISCOVERY_TRSVCID=none
NVME_DISCOVERY_TRTYPE=fc
NVME_EVENT=discovery
SEQNUM=6940
SUBSYSTEM=nvme
USEC_INITIALIZED=1920739942

3) The uevent is evaluated with a simple udev rule, which essentially just
calls 'nvme connect --async_connect' with the parameters from the uevent:

SUBSYSTEM=="nvme", ACTION=="change", RUN+="/usr/sbin/nvme connect --async_connect --transport=$env{NVME_DISCOVERY_TRTYPE} --traddr=$env{NVME_DISCOVERY_TRADDR} --host-traddr=$env{NVME_DISCOVERY_HOST_TRADDR} --nqn=$env{NVME_DISCOVERY_SUBNQN}"

4) The connection is established, all namespaces are parsed etc.
5) After two minutes the discovery controller is removed.

As usual, comments and reviews are welcome.

Hannes Reinecke (4):
  nvme-rdma: use reconnect_work for initial connect
  nvme: implement 'async_connect' cli option
  nvme: implement 'discovery' sysfs entry and discovery uevents
  nvme: delete discovery controller after 2 minutes

 drivers/nvme/host/core.c    | 168 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fabrics.c |   9 ++-
 drivers/nvme/host/fabrics.h |   6 ++
 drivers/nvme/host/fc.c      |   3 +-
 drivers/nvme/host/nvme.h    |   2 +
 drivers/nvme/host/rdma.c    |  21 ++++--
 6 files changed, 198 insertions(+), 11 deletions(-)

-- 
2.16.4
