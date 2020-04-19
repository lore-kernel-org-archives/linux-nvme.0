Return-Path: <SRS0=4bXW=6D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311BBC38A29
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:49:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41E2212CC
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Apr 2020 23:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U2nXMvCC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nEe+/tL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41E2212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aBXLCnhXm1f/pUDVcos5vm/GhNtGZOK8dAAF04YJlro=; b=U2nXMvCCntNMiC
	kVDWmzZ9FnAAyDbgM0eDvUAQ9yRhFGAXz7L35EpE0xUxGWMmTYRLF9K99cCnk4ZwJkUX3cuopPqkW
	NWfDI6vxCMgFjuaannRsYc8PW8PN2wX893hfgA/VwV/vdlBNcVVza8tsCqw7FcYXKU+6hwe+Pk3qS
	Es3WDe6Ia4rLmE/wNI5wsiBrxODTKNh8sX+bH9+g6MJxuN5c2fg3jNVFWPZikLwe1DtDkFH51iSxK
	+u4w3F7wrG2wDKXyCIUyzQMRGE/hHmqGoYuF3ifBx6mO5x6oYoo71SIsleVgzuxyBWOXByh0bJPCD
	tv8ZPnTDAWV26b5X/0iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQJgo-0005Ut-S9; Sun, 19 Apr 2020 23:49:30 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQJgj-0005Ok-LL
 for linux-nvme@lists.infradead.org; Sun, 19 Apr 2020 23:49:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587340172; x=1618876172;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5ODV5qJtroKwV/tFTNeR6QoBUMFb2KUiyAyyLyShfwE=;
 b=nEe+/tL/JkLGcddKZUMw7MdM6mS0ZBv6MpS1BHrZwdH+WR7nc33ZiCFL
 06IYkhlY9Rb3FZDLIEu8n6L/y6RxBn4QyvylNMjLPZvx8g+/9taKHQ0ac
 j9ShA8DMdV+khS/ZXZSp46IPnWf24ft9tiqcTZBmP0/btSRB06LYDt9K3
 i49gjFb8nrLSPMmGVA0CXvgd3i4k4NAVmqJfwvvZ51i3NnaesIY0VUcf2
 icxZ3eLXLWRksoDCDIY/yvT71KTCZfFS9iy3/rDf58ihZOFShoHyT64US
 EmC9mSi3P5yDXDNn7EWJrnBnqemLUvq6D5U1ViysfRjbb2CBHaOrJQ0X9 w==;
IronPort-SDR: OWFULC7CmBlgvVEZHqh48AEfcB4Rb93J/4wPLRNA+bgbqOnsYP98IUpwE4F9s8Y+v3P9FjPcZe
 dC8mPaCVdTh9M9A0M6EW3z3t8OgDNmC1fv4nfdN/fZiDvsamW3sXqVK6JsShuS4RHLzD6Lq9ny
 pfKDko2VWk7enepkryvh1d5ZlFSiQVJIbzMUoFr03PnBEZsqOtdnXIS18/fgoa1+SRLgZ0/+Hp
 ZdBVpqoRvi8t/RjmBUW/iN85vs81AbHO6aHimT63nWa/wuPKW7BAEQYprk/6S+/byBqLp7aHyv
 qqs=
X-IronPort-AV: E=Sophos;i="5.72,404,1580745600"; d="scan'208";a="238116468"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 07:49:27 +0800
IronPort-SDR: 62tmCJTVdJfR8S2Zpc+jpWHO7+g57U60YuTA4cZETvQIsAjc9WsuOtZv2fFyvT4nb9p5glEy7m
 S7LgtnYki/239B5Lq+zpJrJNR3HpO1X3o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 16:39:43 -0700
IronPort-SDR: Z1HH311pBeqrQMJZKqpQQmuIT/3JBQOwLrAZ5O+D3iYXZbuSPbObuouYzZscY0GeUxFTmag/D5
 DPFGD7lnD81Q==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2020 16:49:21 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 2/7] nvmet: add global thread for ns-resize AEN
Date: Sun, 19 Apr 2020 16:48:51 -0700
Message-Id: <20200419234856.59901-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200419234856.59901-1-chaitanya.kulkarni@wdc.com>
References: <20200419234856.59901-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200419_164925_791899_6D1ECB39 
X-CRM114-Status: GOOD (  18.65  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The change of size detection on the target should generate an AEN to
the host. Right now there is no generic mechanism that allows us to add
callbacks for the block and file backend so that we will get the
notification for change of the size for block device and file backend.
This patch adds global maintenance thread that checks for the size
change and generates AEN when needed. This also adds a required lock
needed to protect the ns->size variable which is updated under
nvmet_ns_enable().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c   |   7 +-
 drivers/nvme/target/configfs.c    |   2 +-
 drivers/nvme/target/core.c        | 129 ++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c |   9 ++-
 drivers/nvme/target/io-cmd-file.c |  15 ++--
 drivers/nvme/target/nvmet.h       |  22 ++++-
 6 files changed, 170 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 4c79aa804887..a3bc2987c72a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -486,10 +486,9 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	if (!ns)
 		goto done;
 
-	if (ns->bdev)
-		nvmet_bdev_ns_revalidate(ns);
-	else
-		nvmet_file_ns_revalidate(ns);
+	mutex_lock(&ns->subsys->lock);
+	nvmet_ns_revalidate(ns);
+	mutex_unlock(&ns->subsys->lock);
 
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 58cabd7b6fc5..b0e84027b3bc 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1469,7 +1469,7 @@ int __init nvmet_init_configfs(void)
 	return 0;
 }
 
-void __exit nvmet_exit_configfs(void)
+void nvmet_exit_configfs(void)
 {
 	configfs_unregister_subsystem(&nvmet_configfs_subsystem);
 }
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b685f99d56a1..c42d24c1728e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -9,12 +9,15 @@
 #include <linux/rculist.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/scatterlist.h>
+#include <linux/delay.h>
+#include <uapi/linux/sched/types.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
 #include "nvmet.h"
 
+struct nvmet_resize_monitor *monitor;
 struct workqueue_struct *buffered_io_wq;
 static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
 static DEFINE_IDA(cntlid_ida);
@@ -514,6 +517,59 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
 		ns->nsid);
 }
 
+bool nvmet_ns_revalidate(struct nvmet_ns *ns)
+{
+	if (ns->bdev)
+		return nvmet_bdev_ns_revalidate(ns);
+
+	return nvmet_file_ns_revalidate(ns);
+}
+
+static void __nvmet_handle_resize_ns(struct nvmet_subsys *s)
+{
+	struct nvmet_ns *ns;
+
+	mutex_lock(&s->lock);
+	list_for_each_entry_rcu(ns, &s->namespaces, dev_link, 1) {
+		if (nvmet_ns_revalidate(ns))
+			nvmet_ns_changed(ns->subsys, ns->nsid);
+	}
+	mutex_unlock(&s->lock);
+}
+
+static int nvmet_ns_resize_monitor(void *data)
+{
+	struct sched_param p = { .sched_priority = monitor->sched_priority };
+	struct nvmet_subsys_link *link;
+	struct nvmet_port *port;
+	u32 msec;
+
+	complete(&monitor->wait);
+	sched_setscheduler(current, monitor->sched_policy, &p);
+
+	while (!kthread_should_park()) {
+		down_read(&nvmet_config_sem);
+		list_for_each_entry(port, nvmet_ports, global_entry)
+			list_for_each_entry(link, &port->subsystems, entry)
+				__nvmet_handle_resize_ns(link->subsys);
+		up_read(&nvmet_config_sem);
+		schedule();
+		/* XXX: use better sleep wakeup mechanism */
+
+		/*
+		 * This allows user to change the sleep timtout without
+		 * stopping monitor thread.
+		 */
+		mutex_lock(&monitor->control_lock);
+		msec = monitor->msec;
+		mutex_unlock(&monitor->control_lock);
+		msleep(msec);
+	}
+
+	kthread_parkme();
+	return 0;
+}
+
 int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
@@ -1480,6 +1536,71 @@ void nvmet_subsys_put(struct nvmet_subsys *subsys)
 	kref_put(&subsys->ref, nvmet_subsys_free);
 }
 
+bool nvmet_enable_ns_resize_monitor(void)
+{
+	lockdep_assert_held(&monitor->control_lock);
+
+	if (monitor->thread)
+		goto out;
+
+	monitor->thread = kthread_create(nvmet_ns_resize_monitor, NULL,
+				       "nvmet_ns_resize");
+	if (monitor->thread) {
+		wake_up_process(monitor->thread);
+		wait_for_completion(&monitor->wait);
+		pr_debug("ns monitor thread started successfully\n");
+	}
+
+out:
+	return monitor->thread ? true : false;
+}
+
+bool nvmet_disable_ns_resize_monitor(void)
+{
+	bool ret = false;
+
+	lockdep_assert_held(&monitor->control_lock);
+
+	if (monitor->thread) {
+		kthread_park(monitor->thread);
+		kthread_stop(monitor->thread);
+		monitor->thread = NULL;
+		ret = true;
+	}
+
+	kfree(monitor->thread);
+	return ret;
+}
+
+int nvmet_init_ns_resize_monitor(void)
+{
+	int ret;
+
+	monitor = kzalloc(sizeof(*monitor), GFP_KERNEL);
+	if (!monitor)
+		return -ENOMEM;
+
+	monitor->msec = NVMET_RESIZE_MON_MSEC;
+	monitor->sched_policy = SCHED_IDLE;
+	monitor->sched_priority = 0;
+	mutex_init(&monitor->control_lock);
+	init_completion(&monitor->wait);
+
+	mutex_lock(&monitor->control_lock);
+	ret = nvmet_enable_ns_resize_monitor() ? 0 : -ENOMEM;
+	mutex_unlock(&monitor->control_lock);
+
+	return ret;
+}
+
+void nvmet_exit_ns_resize_monitor(void)
+{
+	mutex_lock(&monitor->control_lock);
+	nvmet_disable_ns_resize_monitor();
+	mutex_unlock(&monitor->control_lock);
+	kfree(monitor);
+}
+
 static int __init nvmet_init(void)
 {
 	int error;
@@ -1500,8 +1621,15 @@ static int __init nvmet_init(void)
 	error = nvmet_init_configfs();
 	if (error)
 		goto out_exit_discovery;
+
+	error = nvmet_init_ns_resize_monitor();
+	if (error)
+		goto out_exit_configfs;
+
 	return 0;
 
+out_exit_configfs:
+	nvmet_exit_configfs();
 out_exit_discovery:
 	nvmet_exit_discovery();
 out_free_work_queue:
@@ -1512,6 +1640,7 @@ static int __init nvmet_init(void)
 
 static void __exit nvmet_exit(void)
 {
+	nvmet_exit_ns_resize_monitor();
 	nvmet_exit_configfs();
 	nvmet_exit_discovery();
 	ida_destroy(&cntlid_ida);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0427e040e3dd..3cca08e9ad90 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -75,9 +75,16 @@ void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 	}
 }
 
-void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
+bool nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
 {
+	bool change;
+
+	lockdep_assert_held(&ns->subsys->lock);
+
+	change = ns->size != i_size_read(ns->bdev->bd_inode) ? true : false;
 	ns->size = i_size_read(ns->bdev->bd_inode);
+
+	return change;
 }
 
 static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 14364383d2fe..a2d82e55858b 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -80,15 +80,20 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	return ret;
 }
 
-void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
+bool nvmet_file_ns_revalidate(struct nvmet_ns *ns)
 {
+	struct path *f_path = &ns->file->f_path;
+	bool change = false;
 	struct kstat stat;
 
-	if (vfs_getattr(&ns->file->f_path, &stat, STATX_SIZE,
-			AT_STATX_FORCE_SYNC))
-		return;
+	lockdep_assert_held(&ns->subsys->lock);
 
-	ns->size = stat.size;
+	if (vfs_getattr(f_path, &stat, STATX_SIZE, AT_STATX_FORCE_SYNC) == 0) {
+		change = ns->size != stat.size ? true : false;
+		ns->size = stat.size;
+	}
+
+	return change;
 }
 
 static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8b479d932a7b..7fe6d705cbf1 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -23,6 +23,7 @@
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
 #define NVMET_NO_ERROR_LOC		((u16)-1)
+#define NVMET_RESIZE_MON_MSEC		500
 #define NVMET_DEFAULT_CTRL_MODEL	"Linux"
 
 /*
@@ -50,6 +51,17 @@
 #define IPO_IATTR_CONNECT_SQE(x)	\
 	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
 
+struct nvmet_resize_monitor {
+	u32			sched_priority;
+	u32			sched_policy;
+	struct mutex		control_lock;
+	struct task_struct	*thread;
+	struct completion	wait;
+	u32			msec;
+};
+
+extern struct nvmet_resize_monitor *monitor;
+
 struct nvmet_ns {
 	struct list_head	dev_link;
 	struct percpu_ref	ref;
@@ -477,7 +489,7 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 #define NVMET_DISC_KATO_MS		120000
 
 int __init nvmet_init_configfs(void);
-void __exit nvmet_exit_configfs(void);
+void nvmet_exit_configfs(void);
 
 int __init nvmet_init_discovery(void);
 void nvmet_exit_discovery(void);
@@ -498,8 +510,12 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns);
 u16 nvmet_bdev_flush(struct nvmet_req *req);
 u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
-void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
-void nvmet_file_ns_revalidate(struct nvmet_ns *ns);
+bool nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
+bool nvmet_file_ns_revalidate(struct nvmet_ns *ns);
+bool nvmet_ns_revalidate(struct nvmet_ns *ns);
+
+bool nvmet_enable_ns_resize_monitor(void);
+bool nvmet_disable_ns_resize_monitor(void);
 
 static inline u32 nvmet_rw_len(struct nvmet_req *req)
 {
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
