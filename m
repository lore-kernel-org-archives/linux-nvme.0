From: jsmart2021@gmail.com (James Smart)
Date: Wed, 13 Jun 2018 14:07:35 -0700
Subject: [PATCH v4 0/4] nvme_fc: asynchronous controller create
Message-ID: <20180613210739.3383-1-jsmart2021@gmail.com>

This patch set modifies the fc transport such that create_ctrl does not
call the controller creation routines inline but rather schedules the
background reconnect thread to perform the initial association connect.
The create_ctrl routine will then synchronously wait for the background
thread complete before returning.  The patchset also contains
several other cleanups found while implementing the asynchronous
connect testing.

There are main reasons why asynchronous controller create uses the
background reconnect thread for processing is the following:
   It simplifies error handling and retries. The initial controller
   connect attempts can be disrupted or by errors as easily as after
   the controller is initially created. As the code currently stands
   there has to be special retry logic and prohibitions around state
   changes if errors occur during the initial connect (which the code
   today does not have). With this patch set, initial connections use
   the same path as a reconnect, and any error handling uses the same
   paths as if the errors occurred post initial connect.

This patchset also adds the change to the transport to regenerate
udev discovery events in case the system missed the events earlier
(such as boot scenarios).

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

v4:
 Followed Christoph's recommendation to synchronously flush the
 connect thread in the create_ctrl path making initial connect
 synchronous. This gains all the advantages of the single code path.
 However, it negates the simple udev scripts as the wait can be
 lengthy. The patchset and this overview was updated to remove
 references to the simplistic udev script, which will be taken up
 in subsequent conversations.

 Added Reviewed-by's for Christoph on those items he indicated looked good.



James Smart (4):
  nvme_fc: remove reinit_request routine
  nvme_fc: change controllers first connect to use reconnect path
  nvme_fc: fix nulling of queue data on reconnect
  nvme_fc: add 'nvme_discovery' sysfs attribute to fc transport device

 drivers/nvme/host/fc.c | 249 +++++++++++++++++++++++++++++++------------------
 1 file changed, 157 insertions(+), 92 deletions(-)

-- 
2.13.1
