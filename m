From: Chayan.Biswas@sandisk.com (Chayan Biswas)
Date: Thu, 28 Feb 2013 19:49:01 +0000
Subject: [PATCH 0/2] DMA and Admin IOCTL related patches
Message-ID: <E821E2F372F08945977BD15EAE588D61097C57DF@SACMBXIP02.sdcorp.global.sandisk.com>

We enabled 32 bit DMA.
Also in completion of Admin IOCTL, we copied the result back
even if the command failed. In many cases, the result gives
the error code required by the user application.

Chayan Biswas (2):
  Add support for 32 bit DMA for 32 bit machines
  Return the result from user admin command IOCTL even in case of
    failure

 drivers/block/nvme.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
