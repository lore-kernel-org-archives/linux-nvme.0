Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8EBCA5FCF
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2026 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hNO0JbRYef2qlds0guIph9NYLgasvSXqBVD4E4nG1zE=; b=ZZNi6cnPss4qcWZ6V5zlfimKfj
	NeidZfMvxXRyvFInt5WTEkgFuDt2av4xYwGoKNRhiSHPCyhJbhEvo1yb6LmLn4bwup4ldYoBZOHxJ
	aEnNwsR+61lCmwKsRueTKqq3rMdJQXJGICx1Zep04csMK8TeGoTf2cW4X6Hpx1yup8/JP/jwaTFla
	lW2zf5LYlPBYPm0vLOPWDIMTMlPOUfLGm9zLqW/UVd6fgiFZ8GOW84OxIyhAhXTWQNrqGEYaDiELW
	+zIh/ZMWm9iC0AEI3dYTeYKYuw5lwNjtpFPhnXUcXjeknCQ3eqlLHEpxxoJe1Dd/EWSzH8Imy3vS/
	pyZYhjUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCDPZ-00000008QD0-311y;
	Thu, 01 Oct 2026 09:49:09 +0000
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCDPS-00000008QC4-2mrm
	for linux-nvme@lists.infradead.org;
	Thu, 01 Oct 2026 09:49:03 +0000
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49fff72474fso28611835e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 01 Oct 2026 02:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1790848141; x=1791452941; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hNO0JbRYef2qlds0guIph9NYLgasvSXqBVD4E4nG1zE=;
        b=Kh389Y4QqaRYut2z9tI+W2zZrfLsWDWioAQhlONOfqUtkmJ8+ogDMLHOCBCIr2Sl7n
         Jql8tOpb0EF5PW/DM0k9se9EnUAFKyw+Xm2c0oBw32zqLCXtPawZTAEosBoI5O+KtFZF
         c7O1yjgvIGqzOHGo61lZmFVaYoW0Y5PSQbYGT6b+cTAk2ZyURMcmMHQQ7gAn2Oip8LKk
         s945YTYikdq7vO5aGyLFlX8e+W0gXf8LV34RxSq6oTFGn3r296UTdJ+fK9i4jYOdf4oJ
         qaKLAu2ByIHExCjU65PJBA9/8Okbls5bjMwCAJCJUag3Q4KrlV5xAIgXS4+S+f0mYqks
         Uaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790848141; x=1791452941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hNO0JbRYef2qlds0guIph9NYLgasvSXqBVD4E4nG1zE=;
        b=A37IwzwxX1dKIlmdcxCEN/RzBIfpFp0i8WaihyTBkXHHQsMWBlYd/4Z/3ls7s2qggY
         yMuxKCV0wdKrtsfZy7AYIzZfQaZRUG4KGLDpLwdCzpA6hn3Nv3D0gv/gBlL3OfNcYPw7
         L7gSzIOGlW7zMhIBdSxhjVuY4oX8e8cWPO2wSAeU+73B/W/eqQU/xPC8KiDhg+SMS6s1
         yMItA43YfKSjSjcgwzEJYLA2r6IIYxW5n3ucl9fcLczu9RXs7xb64vH2w1zQBDkxYBp0
         vDDHzc3l8wcQM3CqxsIbLkJDojfjF8F0EXVDvxPBrNtmvYbOqm5KEpnBS7allQWyt1qB
         x4Aw==
X-Gm-Message-State: AFuF++kyKc97+XyIz20++ymjstZvht4kDYj3HNNE6H2PHzvJgRmiQR2P
	LauzO2tB7AbIqaOELc2D4mIke8QVbR6x8w5NSNAjKESW40rjzlO81udqi/NiQX+0OMg=
X-Gm-Gg: AYBFou1WZherOpV4zgsGsJ/jedhzo1V7CgMQIp9FZAIZPdwLfozepbA9LbgXpoRnbuq
	lYhS4Gq7luZQUESyt0sXkFmFcbtxl0b+B2OWC168Y3owTaAddz9mv8ObdydJBTVkpx6+bVQ8LhN
	gczaew6zwcSsU2AHHhm+YM4DNPvPHgn6iy1+DfxASJmni05TsthP4NdfaRMBQc6mcWPt2NYdqJy
	dhkyXH+oorlns7bzn6dQ+6dguEqhfv14Mz9oLROBgup8FfdIcrnvLm8CuLNPCBttGAaX3KIizkn
	vu7JcNe4MxaiW9pPwoktjusXcN4mJmwEkV6L9X9UC3lfA7h43t5x18jiOXbFdzyrG7KW9f0Dn1x
	kuQAgnMMkcQFmz0+/h19T2RU0GIPrKh+SC2VLvA3s4uMxK+O4MNh2BOsT0AWYX5XgVVpFdvt2Vm
	0DHWaHVRWuylBpcb4eNbAIqbUhfsl8VfXyyCcFli4j/XaopyL4+BPAzYnhwV0RFuF+mue7/A7bY
	PTX+OjSW1KSeMeHIe2jzsUgqEjJYhpQib8=
X-Received: by 2002:a05:600c:c3cb:20b0:49f:ce78:3567 with SMTP id 5b1f17b1804b1-4a01b11eb84mr51772945e9.24.1790848140848;
        Thu, 01 Oct 2026 02:49:00 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([83.71.242.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0db6de0dsm1938341f8f.43.2026.10.01.02.48.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Oct 2026 02:49:00 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nilay@linux.ibm.com,
	hare@suse.de,
	saravanand@crusoe.ai,
	sjpark@crusoe.ai,
	Krishna Iyer <kiyer@crusoe.ai>
Subject: [PATCH v4 2/2] nvme-multipath: add fail_if_no_path sysfs attribute
Date: Thu,  1 Oct 2026 02:48:57 -0700
Message-ID: <20261001094857.74567-3-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261001094857.74567-1-kiyer@crusoe.ai>
References: <20261001094857.74567-1-kiyer@crusoe.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_024902_746923_750757C8 
X-CRM114-Status: GOOD (  21.76  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When no usable path exists, I/O on a multipath namespace is queued
until a path returns. With ctrl_loss_tmo=-1 that can be forever:
during a long fabric outage any process waiting on the I/O is stuck in
D state. We hit this on virtualization hosts, where a SIGKILLed VM
process cannot exit while draining I/O to an unreachable NVMe/TCP
target.

Nothing can fail this I/O without tearing something down: controller
deletion takes every namespace on the controller with it.

Add a fail_if_no_path attribute on the ns-head disk: a persistent
per-namespace policy to fail parked and newly arriving I/O instead of
queueing it when no usable path exists. It is the namespace-scoped
counterpart to the controller-scoped fast_io_fail_tmo: the trigger is
an event userspace observes (a consumer known to be gone, for us a
SIGKILLed VM the host must reap), not a duration picked up front, and
sibling namespaces behind the same controllers keep queueing and ride
out the outage.

A CONNECTING controller stops counting as an available path, and with
no controllers left the policy overrides the delayed_removal_secs
queue-if-no-path window; the two are opposites, so fail_if_no_path takes
precedence when both are set. ANA change and controller resetting still
queue, since both are transient. Controller state is untouched and
reconnects continue. Like dm's fail_if_no_path, the policy is transport
agnostic.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
---
 Documentation/ABI/stable/sysfs-nvme | 16 +++++++++
 drivers/nvme/host/multipath.c       | 50 +++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h            |  2 ++
 drivers/nvme/host/sysfs.c           |  4 ++-
 4 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index a0bb88ca1694..448692dcb117 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -358,6 +358,22 @@ Description:
 		is deferred. Only visible on multipath head devices.
 		Requires CONFIG_NVME_MULTIPATH.
 
+What:		/sys/block/nvmeXnY/fail_if_no_path
+Date:		October 2026
+KernelVersion:	7.4
+Contact:	Krishna Iyer <kiyer@crusoe.ai>
+Description:
+		Shows or sets the fail-if-no-path policy of the multipath
+		head device ("on" or "off", default "off"). When on, I/O
+		queued or arriving while no usable path exists is failed
+		immediately instead of being queued. This is the opposite of
+		the queue-if-no-path behavior enabled by a nonzero
+		delayed_removal_secs: when both are set fail_if_no_path takes
+		precedence and the parked I/O is failed rather than held for
+		the delayed_removal_secs window. Reconnect attempts are not
+		affected. Only visible on multipath head devices.
+		Requires CONFIG_NVME_MULTIPATH.
+
 What:		/sys/block/nvmeXnY/csi
 What:		/sys/block/nvmeXnY/metadata_bytes
 What:		/sys/block/nvmeXnY/nuse
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0d6c05f0808b..e43b0f43e73e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -517,6 +517,8 @@ static inline bool nvme_state_is_live(enum nvme_ana_state state)
 static bool nvme_available_path(struct nvme_ns_head *head)
 	__must_hold_shared(&head->srcu)
 {
+	bool fail_if_no_path = test_bit(NVME_NSHEAD_FAIL_IF_NO_PATH,
+					&head->flags);
 	bool failfast = false;
 	struct nvme_ns *ns;
 
@@ -536,14 +538,17 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 				continue;
 			return true;
 		case NVME_CTRL_RESETTING:
-		case NVME_CTRL_CONNECTING:
 			return true;
+		case NVME_CTRL_CONNECTING:
+			if (!fail_if_no_path)
+				return true;
+			continue;
 		default:
 			break;
 		}
 	}
 
-	if (failfast)
+	if (failfast || fail_if_no_path)
 		return false;
 
 	/*
@@ -1242,6 +1247,47 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 
 DEVICE_ATTR_RW(delayed_removal_secs);
 
+static ssize_t fail_if_no_path_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	return sysfs_emit(buf, test_bit(NVME_NSHEAD_FAIL_IF_NO_PATH,
+			&head->flags) ? "on\n" : "off\n");
+}
+
+static ssize_t fail_if_no_path_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret < 0)
+		return ret;
+
+	if (enable) {
+		if (test_and_set_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags))
+			return count;
+	} else {
+		if (!test_and_clear_bit(NVME_NSHEAD_FAIL_IF_NO_PATH,
+					&head->flags))
+			return count;
+	}
+
+	synchronize_srcu(&head->srcu);
+
+	if (enable)
+		kblockd_schedule_work(&head->requeue_work);
+
+	return count;
+}
+
+DEVICE_ATTR_RW(fail_if_no_path);
+
 static ssize_t multipath_failover_count_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bac25b287d25..71ec72306c9c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -589,6 +589,7 @@ struct nvme_ns_head {
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 #define NVME_NSHEAD_CDEV_LIVE		2
+#define NVME_NSHEAD_FAIL_IF_NO_PATH	3
 	struct nvme_ns __rcu_guarded	*current_path[];
 #endif
 };
@@ -1097,6 +1098,7 @@ extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_path_state;
 extern struct device_attribute dev_attr_delayed_removal_secs;
+extern struct device_attribute dev_attr_fail_if_no_path;
 extern struct device_attribute dev_attr_multipath_failover_count;
 extern struct device_attribute dev_attr_io_requeue_no_usable_path_count;
 extern struct device_attribute dev_attr_io_fail_no_available_path_count;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 4ac3ea3a86fd..fe1e5305880e 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -265,6 +265,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_numa_nodes.attr,
 	&dev_attr_path_state.attr,
 	&dev_attr_delayed_removal_secs.attr,
+	&dev_attr_fail_if_no_path.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	NULL,
@@ -302,7 +303,8 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
-	if (a == &dev_attr_delayed_removal_secs.attr) {
+	if (a == &dev_attr_delayed_removal_secs.attr ||
+	    a == &dev_attr_fail_if_no_path.attr) {
 		struct gendisk *disk = dev_to_disk(dev);
 
 		if (!nvme_disk_is_ns_head(disk))
-- 
2.54.0


