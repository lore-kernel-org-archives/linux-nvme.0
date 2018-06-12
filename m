From: jsmart2021@gmail.com (James Smart)
Date: Tue, 12 Jun 2018 16:50:24 -0700
Subject: [PATCH v3 0/4] nvme_fc: asynchronous controller create and simple
 discovery
Message-ID: <20180612235028.17969-1-jsmart2021@gmail.com>

This patch set modifies the fc transport such that create_ctrl results
in the OS's controller creation only and does not initially connect
to the device on the wire inline to the create_ctrl call. Instead, the
initial connect immediately schedules the background reconnect thread
to perform the initial association connect. The patchset also contains
several other cleanups found while implementing the asynchronous
connect testing.

There are two main reasons why asynchronous controller create is done:
1) It simplifies error handling and retries. The initial controller
   connect attempts can be disrupted or by errors as easily as after
   the controller is initially created. As the code currently stands
   there has to be special retry logic and prohibitions around state
   changes if errors occur during the initial connect (which the code
   today does not have). With this patch set, initial connections use
   the same path as a reconnect, and any error handling uses the same
   paths as if the errors occurred post initial connect.
2) As the create_ctrl() call is now very fast, simplistic udev rules
   can be used for auto-connect rather than involving systemd to work
   around long initial connect times, especially if errors in initial
   connect occur.

However, several hurdles in the common infrastructure need to be changed
in order to make this work. The initial controller creation expects the
controller to be fully connected and live on the wire before it returns
back to the cli.  This gave a lot of time for the udev event to be
generated and serviced to create the corresponding /dev file.  The cli
now has to be prepared that it may access the /dev file before the event
had been serviced. The cli has been updated to accomodate this.
Additionally, operations such as connect-all may occur while there is
a connectivity disturbance with the discovery controller, thus the
discovery log read may fail. To circumvent the side effects of giving
up and not connecting, the cli needs to retry the discovery log reads.
The cli has been updated to accomodate this.

Therefore, this patch set is dependent on the following modifications
that have been made to the cli:
  nvme-cli: Wait for device file if not present after successful add_ctrl
     github repo commit id: bb2d87d7f386
  nvme-cli: Add ioctl retry support for "connect-all"
     github repo commit id: d8f949c21e9d


As the patchset allows simplistic udev scripting, this patchset also
adds the change to the transport to regenerate udev discovery events in
case the system missed the events earlier (such as boot scenarios).

v2:
  added Reviewed-by's
  Reworked 2nd patch to change nvme_set_queue_count() behavior rather
    than add additional validation in the fc transport.

v3:
 Patch 1 (remove unnecessary subnqn validation) and 3 (remove DNR on
   exception) of the v2 set were committed individually
 Patch 2 (revise set_queue_count) was dropped from the set.
 Repost remaining patches. AFAIK there were no disagreements.
 There was one comment on also looking to remove reinit_request from
  core and block - which can be done independently from this patch set.


James Smart (4):
  nvme_fc: remove reinit_request routine
  nvme_fc: change controllers first connect to use reconnect path
  nvme_fc: fix nulling of queue data on reconnect
  nvme_fc: add 'nvme_discovery' sysfs attribute to fc transport device

 drivers/nvme/host/fc.c | 247 +++++++++++++++++++++++++++++++------------------
 1 file changed, 155 insertions(+), 92 deletions(-)

-- 
2.13.1
