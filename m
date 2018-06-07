From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 7 Jun 2018 11:27:41 +0300
Subject: [PATCH] nvme: cleanup double shift issue
Message-ID: <20180607081915.j5vl7ibnp5hr3rzr@kili.mountain>

The problem here is that set_bit() and test_bit() take a bit number so
we should be passing 0 but instead we're passing (1 << 0) which leads to
a double shift.  It doesn't cause a runtime bug in the current code
because it's done consistently and we only set that one bit.

I decided to just re-use NVME_AER_NOTICE_NS_CHANGED instead of
introducing a new define for this.

Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>
---
I don't know how this is going to be used, so perhaps my fix isn't the
right thing.  In that case, can you just fix it and give me reported-by
credit?  Or you can email me back how you want me to fix it but these
are trivial changes and it's probably easiest to just do it directly
instead of relaying instructions to me.

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index de24fe77c80b..34df07d44f80 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -194,7 +194,6 @@ struct nvme_ctrl {
 	struct delayed_work ka_work;
 	struct nvme_command ka_cmd;
 	struct work_struct fw_act_work;
-#define EVENT_NS_CHANGED		(1 << 0)
 	unsigned long events;
 
 	/* Power saving configuration */
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c8b30067b6ae..effb1309682e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3245,7 +3245,7 @@ static void nvme_scan_work(struct work_struct *work)
 
 	WARN_ON_ONCE(!ctrl->tagset);
 
-	if (test_and_clear_bit(EVENT_NS_CHANGED, &ctrl->events)) {
+	if (test_and_clear_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events)) {
 		if (nvme_scan_changed_ns_log(ctrl))
 			goto out_sort_namespaces;
 		dev_info(ctrl->device, "rescanning namespaces.\n");
@@ -3386,7 +3386,7 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 {
 	switch ((result & 0xff00) >> 8) {
 	case NVME_AER_NOTICE_NS_CHANGED:
-		set_bit(EVENT_NS_CHANGED, &ctrl->events);
+		set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
 		nvme_queue_scan(ctrl);
 		break;
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
