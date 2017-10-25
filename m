From: jsmart2021@gmail.com (James Smart)
Date: Wed, 25 Oct 2017 16:43:12 -0700
Subject: [PATCH v4 0/5] nvme_fc: add dev_loss_tmo support
Message-ID: <20171025234317.13302-1-jsmart2021@gmail.com>

FC, on the SCSI side, has long had a device loss timeout which governed
how long it would hide connectivity loss to remote target ports.
The timeout value is maintained in the SCSI FC transport and admins
are used to going there to maintain it.

Eventually, the SCSI FC transport will be moved into something
independent from and above SCSI so that SCSI and NVME protocols can
be peers. In the meantime, to add the functionality now, and sync with
the SCSI FC transport, the LLDD will be used as the conduit. The
initial value for the timeout can be set by the LLDD when it creates
the remoteport via nvme_fc_register_remoteport(). Later, if the value
is updated via the SCSI transport, the LLDD can call a new nvme_fc
routine to update the remoteport's dev_loss_tmo value.

The nvme fabrics implementation already has a similar timer, the
ctrl_loss_tmo, which is distilled into a max_reconnect attempts and
a reconnect_delay between attempts, where the overall duration until
max is hit is the ctrl_loss_tmo.  This was primarily for transports
that didn't have the ability to track device connectivity and would
retry per the delay until finally giving up.

The implementation in this patch set maintains a FC dev_loss_tmo value
at the FC port level. When connectivity to a remoteport is lost, the
future time where dev_loss_tmo will expire is set, and all controllers
on the remoteport are suspended and their associations terminated.
The termination of the controllers will cause their ctrl_loss_tmo
functionality kick in. Reconnect attempts that occur while connectivity
is still lost are terminated and the next reconnect scheduled. If a
reconnect would be rescheduled for a time exceeding the dev_loss_tmo
for the remoteport, the next reconnect is scheduled at dev_loss_tmo.

If connectivity is re-established before ctrl_loss_tmo expires or the
dev_loss_tmo time expires, then the controller is immediately reconnected
and resumed.

If connectivity is not re-established before ctrl_loss_tmo expires or
the dev_loss_tmo time expires, then the controller is deleted.

The patches were cut on the nvme-4.15 branch
Patch 5, which adds the dev_loss_tmo timeout, is dependent on the
nvme_fc_signal_discovery_scan() routine added by this patch:
http://lists.infradead.org/pipermail/linux-nvme/2017-September/012781.html
The patch has been approved but not yet pulled into a tree.

v3:
 In v2, the implementation merged the dev_loss_tmo value into the
 ctlr_loss_tmo in the controller, so only a single timer on each controller
 was running.
 V3 changed to keep the dev_loss_tmo on the FC remoteport and to run it
 independently from the ctrl_loss_tmo timer, excepting for loss of
 connectivity to start both simultaneously.
v4:
 removed the dev_loss_tmo timer on the remote port object. Instead, add
 dev_loss_tmo as a time cap for ctrl_loss_tmo (but now not trashing the
 ctrl_loss_tmo values like early version patches). Thus dev_loss_tmo
 is enforced on a per-controller basis.


James Smart (5):
  nvme core: allow controller RESETTING to RECONNECTING transition
  nvme_fc: change ctlr state assignments during reset/reconnect
  nvme_fc: add a dev_loss_tmo field to the remoteport
  nvme_fc: check connectivity before initiating reconnects
  nvme_fc: add dev_loss_tmo timeout and remoteport resume support

 drivers/nvme/host/core.c       |   1 +
 drivers/nvme/host/fc.c         | 321 ++++++++++++++++++++++++++++++++++++-----
 include/linux/nvme-fc-driver.h |  11 +-
 3 files changed, 291 insertions(+), 42 deletions(-)

-- 
2.13.1
