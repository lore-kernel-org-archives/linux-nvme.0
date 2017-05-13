From: jsmart2021@gmail.com (James Smart)
Date: Sat, 13 May 2017 12:07:14 -0700
Subject: [PATCH 0/8] nvme_fc: add dev_loss_tmo support
Message-ID: <20170513190722.25536-1-jsmart2021@gmail.com>

FC, on the SCSI side, has long had a device loss timeout which governed
how long it would hide connectivity loss to remote targets. The timeout
value is maintained in the SCSI FC transport and admins are used to
going there to maintain it.

Eventually, the SCSI FC transport will be moved into something
independent from and above SCSI so that SCSI and NVME protocols can
be peers. That's fairly distant. In the meantime, to add the
functionality now, and sync with the SCSI FC transport, the LLDD will
be used as the conduit. The initial value for the timeout can be set
by the LLDD when it creates the remoteport via
nvme_fc_register_remoteport(). Later, if the value is updated via the
SCSI transport, the LLDD can call a new nvme_fc routine to update
the remoteport's dev_loss_tmo value, which can then be propagated to
the controllers on the remoteport.

As the fabrics implementation already has a similar behavior
introduced on rdma, the ctrl_loss_tmo, which may be set on a
controller basis (finer granularity than the FC port used for the
connection), the nvme_fc transport will mediate and choose the lesser
of the controllers value and the remoteports value.

The patches were cut on nvme-4.12 after applying the patches in
http://lists.infradead.org/pipermail/linux-nvme/2017-May/010156.html
and
http://lists.infradead.org/pipermail/linux-nvme/2017-May/010166.html

James Smart (8):
  nvme core: allow controller RESETTING to RECONNECTING transition
  nvme_fc: change ctlr state assignments during reset/reconnect
  nvme_fc: add a dev_loss_tmo field to the remoteport
  nvme_fc: add dev_loss_tmo to controller
  nvme_fc: check connectivity before initiating reconnects
  nvme_fc: change failure code on remoteport connectivity loss
  nvme_fc: move remote port get/put/free location
  nvme_fc: add dev_loss_tmo timeout and remoteport resume support

 drivers/nvme/host/core.c       |   1 +
 drivers/nvme/host/fc.c         | 465 +++++++++++++++++++++++++++++++++++------
 include/linux/nvme-fc-driver.h |  11 +-
 3 files changed, 411 insertions(+), 66 deletions(-)

-- 
2.11.0
