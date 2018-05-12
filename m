From: jsmart2021@gmail.com (James Smart)
Date: Fri, 11 May 2018 17:50:21 -0700
Subject: [PATCH v2 0/7] nvme_fc: asynchronous controller create and simple
 discovery
Message-ID: <20180512005028.29661-1-jsmart2021@gmail.com>

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
had been serviced.  There is also a check in the fabrics layer to validate
the controller subnqn is what the connect request asked for. With this
patch set, FC will return before the initial connect is complete thus
the controller field being checked is not yet set.  There is no reason
that it wouldn't be as the request will be what the fabric connect
requests are based off, so this checking of the nqn should be removed.
Additionally, operations such as connect-all may occur while there is
a connectivity disturbance with the discovery controller, thus the
discovery log read may fail. To circumvent the side effects of giving
up and not connecting, the cli needs to retry the discovery log reads.

Therefore, this patch set is dependent on the following modifications
that have been made to the cli:
  nvme-cli: Wait for device file if not present after successful add_ctrl
     github repo commit id: bb2d87d7f386
  nvme-cli: Add ioctl retry support for "connect-all"
     github repo commit id: d8f949c21e9d


As the patchset now allows simplistic udev scripting, this patchset also
adds the change to the transport to regenerate udev discovery events in
case the system missed the events earlier (such as boot scenarios).

v2:
  added Reviewed-by's
  Reworked 2nd patch to change nvme_set_queue_count() behavior rather
    than add additional validation in the fc transport.


James Smart (7):
  nvme: remove unnecessary controller subnqn validation
  nvme: revise nvme_set_queue_count to return error on some nvme status
    codes
  nvme_fc: remove setting DNR on exception conditions
  nvme_fc: remove reinit_request routine
  nvme_fc: change controllers first connect to use reconnect path
  nvme_fc: fix nulling of queue data on reconnect
  nvme_fc: add 'nvme_discovery' sysfs attribute to fc transport device

 drivers/nvme/host/core.c    |   3 +-
 drivers/nvme/host/fabrics.c |  10 --
 drivers/nvme/host/fc.c      | 257 ++++++++++++++++++++++++++------------------
 3 files changed, 157 insertions(+), 113 deletions(-)

-- 
2.13.1
