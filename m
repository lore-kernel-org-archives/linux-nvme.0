From: Chayan.Biswas@sandisk.com (Chayan Biswas)
Date: Wed, 22 May 2013 22:34:49 +0000
Subject: [PATCH v2] Return the result from user admin command IOCTL even in
 case of failure
Message-ID: <E821E2F372F08945977BD15EAE588D611A05EE87@MILMBXIP01.sdcorp.global.sandisk.com>

We copy the result to user if the command is completed from the
controller even if it completes with failure (non-zero) status.
A return status of < 0 indicates the command was not completed
by the controller. The user application may expect the error code
in the result field in case of failure.


Signed-off-by: Chayan Biswas <Chayan.Biswas at sandisk.com>
---
 drivers/block/nvme-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 42abf72..8493708 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1439,7 +1439,7 @@ static int nvme_user_admin_cmd(struct nvme_dev *dev,
                nvme_free_iod(dev, iod);
        }

-       if (!status && copy_to_user(&ucmd->result, &cmd.result,
+       if ((status >= 0) && copy_to_user(&ucmd->result, &cmd.result,
                                                        sizeof(cmd.result)))
                status = -EFAULT;

--
1.7.1


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
