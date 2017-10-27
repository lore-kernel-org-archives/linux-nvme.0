From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 27 Oct 2017 10:35:58 -0600
Subject: [PATCH] nvme: freeze IO accesses around format
Message-ID: <6951d74c-e765-1b5d-6e39-d88d261bf9b9@kernel.dk>

If someone attempts to do IO to a drive while it is under format,
we risk timing out that IO. That potentially leads to the driver
triggering a controller reset, and subsequently the format is ruined and
the device goes away.

Prevents this by freezing IO access to the device around a format.
Without this, the following set of commands can easily make your device
disappear:

parted -s /dev/nvme3n1 mklabel gpt
parted -s /dev/nvme3n1 mkpart primary 0G 100G
parted -s /dev/nvme3n1 rm 1
nvme format /dev/nvme3

since the last partition removal will trigger a udev partition reload,
which happens while the format is running. If the format takes longer
than the normal IO timeout, we start timing it out:

[  456.799438]  nvme3n1:
[  456.833656]  nvme3n1: p1
[  456.842025]  nvme3n1: p1
[  456.887368]  nvme3n1:
[  487.699023] nvme nvme3: I/O 879 QID 12 timeout, aborting
[  518.098840] nvme nvme3: I/O 879 QID 12 timeout, reset controller
[  571.700471] nvme nvme3: Abort status: 0x7
[  571.798306] nvme nvme3: Removing after probe failure status: -22
[  571.811330] nvme3n1: detected capacity change from 4000787030016 to 0
[  571.819189] print_req_error: I/O error, dev nvme3n1, sector 7814036992

and the device is gone, needing a driver reload or reboot to bring it
back. Same thing happens if you just do a dd from the device and then
start a format. Behavior is vendor agnostic, basically just timing
dependent.

Signed-off-by: Jens Axboe <axboe at kernel.dk>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5a14cc7f28ee..13d7fda73fbc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1013,10 +1013,23 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
+	/*
+	 * Freeze current access to the device, and prevent new ones, around
+	 * a format operation.
+	 */
+	if (cmd.opcode == nvme_admin_format_nvm) {
+		nvme_start_freeze(ctrl);
+		nvme_wait_freeze(ctrl);
+	}
+
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
 			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata,
 			0, &cmd.result, timeout);
+
+	if (cmd.opcode == nvme_admin_format_nvm)
+		nvme_unfreeze(ctrl);
+
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
 			return -EFAULT;

-- 
Jens Axboe
