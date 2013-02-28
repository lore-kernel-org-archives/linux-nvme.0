From: Chayan.Biswas@sandisk.com (Chayan Biswas)
Date: Thu, 28 Feb 2013 19:49:23 +0000
Subject: [PATCH 2/2] Return the result from user admin command IOCTL even in
 case of failure
Message-ID: <E821E2F372F08945977BD15EAE588D61097C57F2@SACMBXIP02.sdcorp.global.sandisk.com>

We copy the result to user irrespective of the completion status of
the user Admin command. The user application may expect the error
code in the result field in case of failure.

Signed-off-by: Chayan Biswas <Chayan.Biswas at sandisk.com>
---
 drivers/block/nvme.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 4b706b5..311d753 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -1248,8 +1248,7 @@ static int nvme_user_admin_cmd(struct nvme_dev *dev,
                nvme_free_iod(dev, iod);
        }

-       if (!status && copy_to_user(&ucmd->result, &cmd.result,
-                                                       sizeof(cmd.result)))
+       if (copy_to_user(&ucmd->result, &cmd.result, sizeof(cmd.result)))
                status = -EFAULT;

        return status;
--
1.7.1


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
