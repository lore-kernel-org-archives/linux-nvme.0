Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31909CA600D
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2026 14:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2AOdtfe+YngmHP+/rnhkczaw3OqI2GufIwxv4z5Xa+0=; b=3sBITvnphITjYtlC6NWRUSFHvi
	WKDYhvG+8xrtCOjtE5ha7dcmc47imZh1zEt3ab2vEXjwn2IfMny81UR4Twdu3cgMAe3nGG+3Rvalo
	bRbbfDee8301VNU4uCwHlEYd3u326Kn5NRJnjhoIriVOdl68misL82zOYHUa7RGwi/MCjgjISHJSw
	/kpfJj2Ta/Cz7l/oLFbNwatjstmH6bHv8EX/cSz0z6UutqDfTXJwb9ttzV2U5/uoRduXtMSGYEgIt
	JXppHO7vfbuap5PUM+4m4r22Ol5/K6D8CwqrenmLGNBrqFnKBFd8tVjZbWCnwaOMaYybDpPwY9TuT
	KzQMOTyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEosz-00000004WI9-1Y27;
	Thu, 08 Oct 2026 14:14:17 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEosw-00000004WGm-2CwI
	for linux-nvme@lists.infradead.org;
	Thu, 08 Oct 2026 14:14:15 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4a02753c04fso17452455e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2026 07:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1791468852; x=1792073652; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2AOdtfe+YngmHP+/rnhkczaw3OqI2GufIwxv4z5Xa+0=;
        b=RVIu4Y04tOIK8J+bqZ7Hf6h0a+DMAqqvTXrE9LPpWLOgcy2NSZGEz67JTQ9TRj/z24
         zDQbmhiDiA1X0V5nfDskXurOf60t0Kw6s1swycgHpm6IPIds2vj7diNDqBlVCFhRew8y
         Ax92gbY4jEQynMaOU1kb5OZ7ba4dqB3KE2z9R8nE72SgV9v2pEVTBDjd98XG759cTnba
         8RPBGAtsc9KPssnHc19Zp9cJbuI3dF8z5nJo+p9amgQpQsSKkHpWTl1ZUq18qxkHYoUK
         +7mNcPU8qB7z3gDElPOKuxOyHwehv0g6tItPGP8gygCyggcgQYUsKIrdmRUoMD3Q2EIM
         SrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791468852; x=1792073652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2AOdtfe+YngmHP+/rnhkczaw3OqI2GufIwxv4z5Xa+0=;
        b=qRapUr6jlHJRjG9KSP+/bhtq1BiXx4Wbo8inv3ZyOseY+RUqQePB5WZJsx73dnl7+9
         7wVHpBcpMzfzXOUQQTuKjyb2TvxtIns7dBIsIpfEhXWnJlqCztxlZAhHtjbR3e2YHVGn
         VHlACJYwU369dyu7dSTxjuW9/q8SzMiJBSHvtPHJeORYeG7kNjBQWTgSGTIqwsQsHNra
         LtyhhSNzT5AxF0f/2ur06klpVLJiMf7JwqoAsf/uLAmNx+6Iopl8Tet+/ZW9sL24k9E/
         pIQoFEQZe/gLi/b3ebNTzRZF6gmmveMl5hvvTXiLAl0IHfbf+DXbBVYAKRJUz5mLozH3
         HC+w==
X-Gm-Message-State: AFuF++nD0AYhOoOkxrENC4j24V0Y951lV8s/3tvH057+gMJOuzViaHcE
	jKyciV7L5WJTg8c+f0ILijXmAfvc4zDgkYO4nXLcvIM2TRoLaVnNOlB1aKg+xGkLMmk=
X-Gm-Gg: AYBFou1bHDbNR4kcFw+zj4p9pLkBsxl6z9ZfuQSdAct1ql4zoBdcevNDpoijvub9kEB
	0la0Doh3IFhNEgRmqR1NV2W0ES1pMsHXsnRVWE7a6j7/iGRkggFXx8hBYVOlms7yoLV+1jdogS4
	d9bb9w1Cp94UcqZSy5r2W7n378XHgYXhKWwG22uj7rcLzmHx6VpacQkW9t9Dh/1q2SC+rOwXDBy
	E2uVocUoGOuWvCgOaRYikkMgDFYK5XWZLMZbeqQv9pCcQbse0M486Sh5aQk4wiN3aj72r9PmC3a
	eznEW3ps6V3J/yBrrcT7yMSaPbKWFl7+8u0gi9iZFJjsJY+Cl3hO3LfslRnLsh48uKPOIvKmmDT
	gUXG0a1NCRZUbobJ1vZeMZKN3lI1Fno8nGV2/D8u6UWGgCiYtfaEpCY+4lCPnXxUdVYY4xSuxW/
	cxY2a//wz4R/0c+NXE1a4HX43tvQ03nLIGlxZSp44MGW/czzDnmWplZNoaqlZNWODAHOiA0aIw+
	vvHNZikk+9OwYoLtrX11WKP5l8iZX4TWIs=
X-Received: by 2002:a05:600c:8218:b0:4a0:1f9e:5f7d with SMTP id 5b1f17b1804b1-4a1802e9661mr105955535e9.7.1791468852466;
        Thu, 08 Oct 2026 07:14:12 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([80.95.100.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a185d914fdsm113358935e9.7.2026.10.08.07.14.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 07:14:12 -0700 (PDT)
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
Subject: [PATCH v5 2/2] nvme-multipath: add fail_on_ctrl_loss sysfs attribute
Date: Thu,  8 Oct 2026 07:14:07 -0700
Message-ID: <20261008141407.22992-3-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008141407.22992-1-kiyer@crusoe.ai>
References: <20261008141407.22992-1-kiyer@crusoe.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_071414_630172_F83337C5 
X-CRM114-Status: GOOD (  21.12  )
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

Add a fail_on_ctrl_loss attribute on the ns-head disk: a persistent
per-namespace policy to fail parked and newly arriving I/O instead of
queueing it when no usable path exists. It is the namespace-scoped
counterpart to the controller-scoped fast_io_fail_tmo: the trigger is
an event userspace observes (a consumer known to be gone, for us a
SIGKILLed VM the host must reap), not a duration picked up front, and
sibling namespaces behind the same controllers keep queueing and ride
out the outage.

A CONNECTING controller stops counting as an available path, and with
no controllers left the policy overrides the delayed_removal_secs
queue-if-no-path window; the two are opposites, so fail_on_ctrl_loss
takes precedence when both are set. ANA change and controller resetting
still queue, since both are transient. Controller state is untouched and
reconnects continue. Like dm-multipath, the policy is transport
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
index a0bb88ca1694..20f398b1bcb1 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -358,6 +358,22 @@ Description:
 		is deferred. Only visible on multipath head devices.
 		Requires CONFIG_NVME_MULTIPATH.
 
+What:		/sys/block/nvmeXnY/fail_on_ctrl_loss
+Date:		October 2026
+KernelVersion:	7.4
+Contact:	Krishna Iyer <kiyer@crusoe.ai>
+Description:
+		Shows or sets the fail-on-ctrl-loss policy of the multipath
+		head device ("on" or "off", default "off"). When on, I/O
+		queued or arriving while no usable path exists is failed
+		immediately instead of being queued. This is the opposite of
+		the queue-if-no-path behavior enabled by a nonzero
+		delayed_removal_secs: when both are set fail_on_ctrl_loss takes
+		precedence and the parked I/O is failed rather than held for
+		the delayed_removal_secs window. Reconnect attempts are not
+		affected. Only visible on multipath head devices.
+		Requires CONFIG_NVME_MULTIPATH.
+
 What:		/sys/block/nvmeXnY/csi
 What:		/sys/block/nvmeXnY/metadata_bytes
 What:		/sys/block/nvmeXnY/nuse
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0d6c05f0808b..7e5b50f158cf 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -517,6 +517,8 @@ static inline bool nvme_state_is_live(enum nvme_ana_state state)
 static bool nvme_available_path(struct nvme_ns_head *head)
 	__must_hold_shared(&head->srcu)
 {
+	bool fail_on_ctrl_loss = test_bit(NVME_NSHEAD_FAIL_ON_CTRL_LOSS,
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
+			if (!fail_on_ctrl_loss)
+				return true;
+			continue;
 		default:
 			break;
 		}
 	}
 
-	if (failfast)
+	if (failfast || fail_on_ctrl_loss)
 		return false;
 
 	/*
@@ -1242,6 +1247,47 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 
 DEVICE_ATTR_RW(delayed_removal_secs);
 
+static ssize_t fail_on_ctrl_loss_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	return sysfs_emit(buf, test_bit(NVME_NSHEAD_FAIL_ON_CTRL_LOSS,
+			&head->flags) ? "on\n" : "off\n");
+}
+
+static ssize_t fail_on_ctrl_loss_store(struct device *dev,
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
+		if (test_and_set_bit(NVME_NSHEAD_FAIL_ON_CTRL_LOSS, &head->flags))
+			return count;
+	} else {
+		if (!test_and_clear_bit(NVME_NSHEAD_FAIL_ON_CTRL_LOSS,
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
+DEVICE_ATTR_RW(fail_on_ctrl_loss);
+
 static ssize_t multipath_failover_count_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bac25b287d25..a8ef62b8e34b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -589,6 +589,7 @@ struct nvme_ns_head {
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 #define NVME_NSHEAD_CDEV_LIVE		2
+#define NVME_NSHEAD_FAIL_ON_CTRL_LOSS	3
 	struct nvme_ns __rcu_guarded	*current_path[];
 #endif
 };
@@ -1097,6 +1098,7 @@ extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_path_state;
 extern struct device_attribute dev_attr_delayed_removal_secs;
+extern struct device_attribute dev_attr_fail_on_ctrl_loss;
 extern struct device_attribute dev_attr_multipath_failover_count;
 extern struct device_attribute dev_attr_io_requeue_no_usable_path_count;
 extern struct device_attribute dev_attr_io_fail_no_available_path_count;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 4ac3ea3a86fd..b3abb852a3ec 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -265,6 +265,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_numa_nodes.attr,
 	&dev_attr_path_state.attr,
 	&dev_attr_delayed_removal_secs.attr,
+	&dev_attr_fail_on_ctrl_loss.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	NULL,
@@ -302,7 +303,8 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
-	if (a == &dev_attr_delayed_removal_secs.attr) {
+	if (a == &dev_attr_delayed_removal_secs.attr ||
+	    a == &dev_attr_fail_on_ctrl_loss.attr) {
 		struct gendisk *disk = dev_to_disk(dev);
 
 		if (!nvme_disk_is_ns_head(disk))
-- 
2.54.0


