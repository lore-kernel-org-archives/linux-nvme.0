From: jsmart2021@gmail.com (James Smart)
Date: Tue, 26 Sep 2017 21:50:39 -0700
Subject: [PATCH v2 0/7] nvme_fc: add dev_loss_tmo support
Message-ID: <20170927045046.22238-1-jsmart2021@gmail.com>

FC, on the SCSI side, has long had a device loss timeout which governed
how long it would hide connectivity loss to remote targets. The timeout
value is maintained in the SCSI FC transport and admins are used to
going there to maintain it.

Eventually, the SCSI FC transport will be moved into something
independent from and above SCSI so that SCSI and NVME protocols can
be peers. In the meantime, to add the functionality now, and sync with
the SCSI FC transport, the LLDD will be used as the conduit. The
initial value for the timeout can be set by the LLDD when it creates
the remoteport via nvme_fc_register_remoteport(). Later, if the value
is updated via the SCSI transport, the LLDD can call a new nvme_fc
routine to update the remoteport's dev_loss_tmo value, which can then
be propagated to the nvme controllers on the remoteport.

The fabrics implementation already has a similar timer, the
ctrl_loss_tmo. The timer defaults to 60s with reconnect retry intervals
every 10s. The nvme_fc transport will set the ctlr_loss_tmo to the lesser
of the ctrl_loss_tmo set at controller creation and the dev_loss_tmo
value for the remote port the controller is attached via. The nvme_fc
behaves like the other transports - it retries up to the ctrl_loss_tmo
time window, with reconnect retries a periodic intervals. The reconnect
retries will be disabled if there is not connectivity to the remote port.

The patches were cut on the nvme-4.14 branch
Patch 7, which adds the dev_loss_tmo timeout, is dependent on the
nvme_fc_signal_discovery_scan() routine added by this patch:
http://lists.infradead.org/pipermail/linux-nvme/2017-September/012781.html
The patch has been approved but not yet pulled into a tree.

James Smart (7):
  nvme core: allow controller RESETTING to RECONNECTING transition
  nvme_fc: change ctlr state assignments during reset/reconnect
  nvme_fc: add a dev_loss_tmo field to the remoteport
  nvme_fc: add dev_loss_tmo to controller
  nvme_fc: check connectivity before initiating reconnects
  nvme_fc: move remote port get/put/free location
  nvme_fc: add dev_loss_tmo timeout and remoteport resume support

 drivers/nvme/host/core.c       |   1 +
 drivers/nvme/host/fc.c         | 481 +++++++++++++++++++++++++++++++++++------
 include/linux/nvme-fc-driver.h |  11 +-
 3 files changed, 421 insertions(+), 72 deletions(-)

-- 
2.13.1
