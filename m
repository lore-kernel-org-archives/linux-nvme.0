From: Sriram.Popuri@netapp.com (Popuri, Sriram)
Date: Sat, 26 May 2018 12:05:02 +0000
Subject: [PATCH 13/14] nvme: use the changed namespaces list log to clear
 ns data changed AENs
In-Reply-To: <20180526102735.31404-14-hch@lst.de>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-14-hch@lst.de>
Message-ID: <BN7PR06MB403359D8914D0A17425C037E92680@BN7PR06MB4033.namprd06.prod.outlook.com>

Reading the spec it looks like ns log is alternate approach:

"Namespace Attribute Changed: The Identify Namespace data structure for one or more namespaces, as well as the Namespace List returned when the Identify command is issued with the CNS field set to 02h, have changed. Host software may use this event as an indication that it should read the Identify Namespace data structures for each namespace to determine what has changed.

Alternatively, host software may request the Changed Namespace List (Log Identifier 04h) to determine which namespaces in this controller have changed Identify Namespace information since the last time the log page was read."

My question is: Does the target needs to implement log page 04h as this is an optional log page and the text above suggests its used in alternate way?

If target is not required to implement, then I guess your change should still work because if log page 04h fails, it fails back to rescan. Correct?
I think you can optimize this by checking the "Log Page Identifier" field in your result and accordingly setting EVENT_NS_CHANGED. I assume target would clear this if log page 04h is not supported.

"23:16      Log Page Identifier: Indicates the log page associated with the asynchronous event. This log page needs to be read by the host to clear the event"

Regards,
~Sriram

-----Original Message-----
From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> On Behalf Of Christoph Hellwig
Sent: Saturday, May 26, 2018 3:58 PM
To: linux-nvme at lists.infradead.org
Cc: Jens Axboe <axboe at kernel.dk>; Keith Busch <keith.busch at intel.com>; linux-block at vger.kernel.org; Sagi Grimberg <sagi at grimberg.me>; Hannes Reinecke <hare at suse.de>
Subject: [PATCH 13/14] nvme: use the changed namespaces list log to clear ns data changed AENs

Per section 5.2 we need to issue the corresponding log page to clear an AEN, so for a namespace data changed AEN we need to read the changed namespace list log.  And once we read that log anyway we might as well use it to optimize the rescan.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 51 ++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c index 06cd04dcffbc..1ae77428a1a5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3194,6 +3194,42 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl, unsigned nn)
 	nvme_remove_invalid_namespaces(ctrl, nn);  }
 
+static bool nvme_scan_changed_ns_log(struct nvme_ctrl *ctrl) {
+	size_t log_size = NVME_MAX_CHANGED_NAMESPACES * sizeof(__le32);
+	__le32 *log;
+	int error, i;
+	bool ret = false;
+
+	log = kzalloc(log_size, GFP_KERNEL);
+	if (!log)
+		return false;
+
+	error = nvme_get_log(ctrl, NVME_LOG_CHANGED_NS, log, log_size);
+	if (error) {
+		dev_warn(ctrl->device,
+			"reading changed ns log failed: %d\n", error);
+		goto out_free_log;
+	}
+
+	if (log[0] == cpu_to_le32(0xffffffff))
+		goto out_free_log;
+
+	for (i = 0; i < NVME_MAX_CHANGED_NAMESPACES; i++) {
+		u32 nsid = le32_to_cpu(log[i]);
+
+		if (nsid == 0)
+			break;
+		dev_info(ctrl->device, "rescanning namespace %d.\n", nsid);
+		nvme_validate_ns(ctrl, nsid);
+	}
+	ret = true;
+
+out_free_log:
+	kfree(log);
+	return ret;
+}
+
 static void nvme_scan_work(struct work_struct *work)  {
 	struct nvme_ctrl *ctrl =
@@ -3206,6 +3242,12 @@ static void nvme_scan_work(struct work_struct *work)
 
 	WARN_ON_ONCE(!ctrl->tagset);
 
+	if (test_and_clear_bit(EVENT_NS_CHANGED, &ctrl->events)) {
+		if (nvme_scan_changed_ns_log(ctrl))
+			goto out_sort_namespaces;
+		dev_info(ctrl->device, "rescanning namespaces.\n");
+	}
+
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
 
@@ -3213,14 +3255,15 @@ static void nvme_scan_work(struct work_struct *work)
 	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
 	    !(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)) {
 		if (!nvme_scan_ns_list(ctrl, nn))
-			goto done;
+			goto out_free_id;
 	}
 	nvme_scan_ns_sequential(ctrl, nn);
- done:
+out_free_id:
+	kfree(id);
+out_sort_namespaces:
 	down_write(&ctrl->namespaces_rwsem);
 	list_sort(NULL, &ctrl->namespaces, ns_cmp);
 	up_write(&ctrl->namespaces_rwsem);
-	kfree(id);
 }
 
 /*
@@ -3340,7 +3383,7 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)  {
 	switch ((result & 0xff00) >> 8) {
 	case NVME_AER_NOTICE_NS_CHANGED:
-		dev_info(ctrl->device, "rescanning\n");
+		set_bit(EVENT_NS_CHANGED, &ctrl->events);
 		nvme_queue_scan(ctrl);
 		break;
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h index 11681278fdf6..07e8bfe705c6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -189,6 +189,8 @@ struct nvme_ctrl {
 	struct delayed_work ka_work;
 	struct nvme_command ka_cmd;
 	struct work_struct fw_act_work;
+#define EVENT_NS_CHANGED		(1 << 0)
+	unsigned long events;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
--
2.17.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
