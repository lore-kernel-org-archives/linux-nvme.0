From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu,  4 May 2017 11:07:30 -0700
Subject: [RFC 0/7] nvme_fc: add dev_loss_tmo support
Message-ID: <20170504180737.5472-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

FC, on the SCSI side, has long had a device loss timeout which governed
how long it would hide connectivity loss to remote targets. There is a
SCSI FC transport maintaining this value, and SCSI LLDDs are applying
this value (and admins used to configuring it) to FC targets that may
support FC-NVME or both SCSI and FC-NVME. Eventually, the SCSI FC
transport will be moved into something independent from and above SCSI
so that SCSI and NVME protocols can be peers. That's fairly distant.
In the meantime, to add the functionality now, and sync with the SCSI
FC transport, the LLDD will be used as the conduit. The LLDD can specify
the initial value at nvme_fc_register_remoteport() by the LLDD, and if
the value changes via the SCSI FC transport (or by LLDD desire), the
LLDD can call a nvme_fc transport routine to update the value.

The more interesting part, and why this is an RFC, is that there are
conflicting items in the exiting nvme fabrics implementation.
Fabrics currently specify a similar window to devloss for the
controller at connect time, via options parameters. Should the
transport have the port setting override the connect parameters or
should the connect parameters for the individual controller override
the port setting ?  Also, a reconnect window only makes sense if
the target stays alive for the duration of the window. Currently,
there is no attempt to set KATO so that it is aligned with the window.
In fact, in most cases, KATO is set far smaller than reconnect windows.
There's also no way currently, other than snooping, for the transport
to know the KATO value set in the connect command.

So, what is proposed for FC is, it sets the lowest window of the three
items. Please refer to the third patch "add dev_loss_tmo to controller"
for more details.

Comments are appreciated.

-- james


James Smart (7):
  nvme_fc: change ctlr state assignments during reset/reconnect
  nvme_fc: add a dev_loss_tmo field to the remoteport
  nvme_fc: add dev_loss_tmo to controller
  nvme_fc: check connectivity before initiating reconnects
  nvme_fc: change failure code on remoteport connectivity loss
  nvme_fc: move remote port get/put/free location
  nvme_fc: add dev_loss_tmo timeout and remoteport resume support

 drivers/nvme/host/fc.c         | 487 +++++++++++++++++++++++++++++++++++------
 include/linux/nvme-fc-driver.h |  11 +-
 2 files changed, 432 insertions(+), 66 deletions(-)

-- 
2.11.0
