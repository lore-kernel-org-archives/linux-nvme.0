From: javier@javigon.com (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Fri, 13 Apr 2018 13:42:59 +0200
Subject: [RFC PATCH] nvme: allow to handle AER events by kernel drivers
Message-ID: <1523619780-10882-1-git-send-email-javier@cnexlabs.com>

In the current AER path, the kernel just picks up the event and re-sends
the async event command to allow the device to report a new event.
Sending the get log page to manage the event itself and clear the device
flag is left to user space for what I can see.

In OCSSD we require some of these events to be handled by LightNVM
targets, thus we need to pull the AER event up the stack in a meaningful
way. The main challenge as I see it is moving the event in a clean way
to the right driver.

This patch is a sketch on how to do this, very much work in progress. If
we could add a bit to the result carried into nvme_result to signal
which events are handled by the kernel, this would be much cleaner. From
here on, drivers could register for specific events and then handled
them accordingly.

Feedback at this early stage is very much appreciated.

Thanks!
Javier

Javier Gonz?lez (1):
  nvme: allow lightnvm to have visibility over AER events

 drivers/nvme/host/core.c     | 37 +++++++++++++++++++++----
 drivers/nvme/host/lightnvm.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h     |  3 ++
 include/linux/lightnvm.h     | 24 ++++++++++++++++
 include/linux/nvme.h         |  1 +
 5 files changed, 125 insertions(+), 5 deletions(-)

-- 
2.7.4
