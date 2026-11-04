Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B980606A330
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qbk5V7rn;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=Y6wZf9zH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GDa77zPiXxM3itv0C4+65k7d0sCF8HaG3BofMHNFQUg=; b=qbk5V7rnTIdbFK
	TCFQuUAw05aqMwheMB+doxxzJDFVy6CwWweNBjUTO+XlWjBYYnJUToCHDRmoWQycDOoZpfvSXAkmd
	J3YCIJHWESLiw785Z434iJVk5ZK1fwRhT6qDK0mc2QyEj9ZvomrewyyQCEmr8Y9vsZKo2CNeoBeul
	JKLXSM8yAu9yE6YIfClOHk6JRNHDZvzOW0DTSVqSSGGRtSRQyQWCrlAh/yyyCjxQmOSqHQ+ByxdTn
	vnsgGn6gd/kN7wE4pGXpIKDDQF+wGClGoAsCWXU6pfTOGy0325SX1ov5vM/16s+tL9awB/XOVDUDJ
	HZ3E5SLIhcjIYEfsrGYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObe8-00000005ZPu-2y3Y;
	Wed, 04 Nov 2026 14:07:24 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObdy-00000005ZII-3LVP
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 14:07:22 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-170135e43c7so1101501c88.0
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 06:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1793801234; x=1794406034; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GDa77zPiXxM3itv0C4+65k7d0sCF8HaG3BofMHNFQUg=;
        b=Y6wZf9zH9JwNUbgX7V280stCHXvC9InZuhKbEnfccRB28ijpVzCnnNx8ESdMN9LAJw
         frXBUChdgz1bMgr6JjLrX/PVbe20q40tpen27PAF5ygSrCQSKxJrrdE0LMBMoOuat4Il
         64lyOCpIp2AtuZxLXyi7UKul69DW3Htx0N1Gc0t+tP0C0JC8weeH/ShRs65mSB0F+cfE
         NzJVtNbwz3bRttJCEOQbanEip0gp6n8pLGt8PFdsLiXeSgtcHWuTvCfNYAmv7P5i3mFk
         rcYIc20sK2HyBsTqqiwIZikkAechdMqKp6F2vJdnmDtXCZXwCtg9kQm3I3FG2Z7FEr0B
         1jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801234; x=1794406034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GDa77zPiXxM3itv0C4+65k7d0sCF8HaG3BofMHNFQUg=;
        b=g9JBZUSDQVQs2b5khsVitNuFUWi9f+IHrVGuVQXGBIwDiZNVEAF6UrSss8LNxSLKGj
         ttZ3yZlSfrVlGcDljxoli0Jwai3Ug5bVEWk+krP2TigvKdgUU+jGROIjfUu21MGQy2Qx
         Lnt0VvLRuz3VUGbLiR+ukfyH9uVJv5H9kS9ZYTCjm4TGiG9d22PV4mDtp0ndFBTKsE5H
         gBpsLSNoeDhXozZbSp8v6r+fFvtszhxA45NjtS+NTfonHrSzCYJ9afyXTxUNxnJYfgE6
         2ovsHBeGwqDz+GHwEoVEFBkyU4VByjBIvIps2oN4RaEKn034kptJCthkArdIH7TFfFxP
         E2zw==
X-Gm-Message-State: APuU4Z8UyGVo0I7rWAPLV/Pjj09nS8zd8jM36Cw3wC9ox+9++xqPWvth
	jgAoqnbCGmsEUGPRXVmOxA+bAzDHqFUsLtR2QKsLlofZzH5rYAtlLT2UPUuf3kh0U5/CYav+dym
	V+JUW4Jw=
X-Gm-Gg: AYBFou0G75WQx5/DDyoFrbbgg2OAguF4yNjiz9rXpFC1Ts4IBHeQWUZDLO+xyK0OoG6
	CTT6BwVIrLxg71QpMThGeUKqyJLLHmBXZuC6/s8Cgb9s8moTZkeTXs7BNgkZ0sagA6X+GJMsWhX
	Kp86Vrle+SAYkBzykuKLSa9+bYG0+BZTIc7z9DSjiADKUSSCxLgpZHct9kKF5MtyuA5p3R5H0bN
	wS7xnHPbr/SUPyzgNdhDLQGlHwcmD8tqStEEfRb6HJQmqDc3CoRun2bCx+PamL0HVr65LkDCWhl
	O7LkLO/s65PpL1pWB4gT7IEHHzE1xpmfuvoB3wdo0LqmK+5T/wyAF5hxceufb6gG+GhKcwSxcG7
	TIdbv4bhNs955rUF6nh7MbKDfD64vzVJpKA4hNBjFSu1dkQl60ToNjRtxqSVDXfSfX0hZEeDS2f
	mmF6aBdh0hikUMYY4qdvFjVJfOuBchldwFPni5eh9Cx822/HoKkVRRCtvt94apvZavXyuUpQ2a6
	AM1plTPGmOBvU7kmwu7qe0Ncf4YFHuaPBhknePvCaoMvTBMTOcmArUK5EJZOY3UNZwxyuYM7QFw
	0UVOtZ4Bz10y7Vo2ybTMSH2+3EbcJSyW6wnxTK5lLUt/R7vk9b8MgjZLG05IEdTiPhRXt65kqQ=
	=
X-Received: by 2002:a05:701b:4519:20b0:17b:fea8:1425 with SMTP id a92af1059eb24-1ac5da753f6mr23409689c88.30.1793801233256;
        Wed, 04 Nov 2026 06:07:13 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([71.202.170.54])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c748eesm7938399c88.23.2026.11.04.06.07.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 06:07:12 -0800 (PST)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	nilay@linux.ibm.com,
	dwagner@suse.de,
	sgogte@purestorage.com,
	hare@kernel.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai,
	Saravanan D <saravanand@crusoe.ai>
Subject: [PATCH v7 1/2] nvme: add per-queue sysfs directories
Date: Wed,  4 Nov 2026 06:06:29 -0800
Message-ID: <656dac7329c8452efe786b0c76a3b8c0bbf53159.1793800758.git.saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793800758.git.saravanand@crusoe.ai>
References: <cover.1793800758.git.saravanand@crusoe.ai>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_060714_875631_D4A8561D 
X-CRM114-Status: GOOD (  22.85  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Per I/O queue transport state, such as the nvme-tcp io_cpu, has
nowhere to live in sysfs, since the core has no directory for
individual queues.

Add helpers that create the controller's queues directory and add or
remove one directory per queue

  /sys/class/nvme/nvmeX/queues/<qid>/

carrying the attributes a transport sets in the new queue_attr_groups
member of struct nvme_ctrl_ops. For such transports nvme_add_ctrl()
creates the queues directory. It holds a reference on the controller
device, so nvme_uninit_ctrl() deletes it before deleting the device,
after the transport has removed the queue directories.

The transport adds a queue's directory when it sets the queue up and
removes it when it frees the queue, so the directories follow the
queues across reconnects and changes in the queue count. The core
allocates each queue directory and its release frees only that
allocation. Removal waits for running attribute callbacks, so the
transport may tear the queue down once it returns.

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Link: https://lore.kernel.org/linux-nvme/13c160d0-0657-47ce-9a16-58d348267ab0@grimberg.me/
Assisted-by: Claude:claude-opus-5-5 [Claude Code]
Signed-off-by: Saravanan D <saravanand@crusoe.ai>
---
 drivers/nvme/host/core.c  | 12 ++++++
 drivers/nvme/host/nvme.h  | 25 +++++++++++
 drivers/nvme/host/sysfs.c | 88 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9ea9db0271c2..7246502f1e66 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5183,6 +5183,8 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_stop_keep_alive(ctrl);
 	nvme_hwmon_exit(ctrl);
+	/* transports remove their queue directories before this point */
+	nvme_queue_dir_destroy(ctrl);
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
@@ -5327,6 +5329,12 @@ int nvme_add_ctrl(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
+	if (ctrl->ops->queue_attr_groups) {
+		ret = nvme_queue_dir_create(ctrl);
+		if (ret)
+			goto out_del_cdev;
+	}
+
 	/*
 	 * Initialize latency tolerance controls.  The sysfs files won't
 	 * be visible to userspace unless the device actually supports APST.
@@ -5339,6 +5347,10 @@ int nvme_add_ctrl(struct nvme_ctrl *ctrl)
 	nvme_get_ctrl(ctrl);
 
 	return 0;
+
+out_del_cdev:
+	cdev_device_del(&ctrl->cdev, ctrl->device);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_add_ctrl);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 92c048002ecd..017e23e449e6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -339,6 +339,28 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_FROZEN		= 6,
 };
 
+/*
+ * Per-queue directory /sys/class/nvme/nvmeX/queues/<qid>/, allocated by the
+ * core and carrying attributes provided by the transport.
+ */
+struct nvme_queue_info {
+	struct kobject		kobj;
+	void			*data;
+};
+
+static inline void *nvme_queue_info_data(struct kobject *kobj)
+{
+	return container_of(kobj, struct nvme_queue_info, kobj)->data;
+}
+
+struct nvme_ctrl;
+
+int nvme_queue_dir_create(struct nvme_ctrl *ctrl);
+void nvme_queue_dir_destroy(struct nvme_ctrl *ctrl);
+struct nvme_queue_info *
+nvme_add_queue_info(struct nvme_ctrl *ctrl, unsigned int qid, void *data);
+void nvme_remove_queue_info(struct nvme_queue_info *qinfo);
+
 struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
@@ -360,6 +382,7 @@ struct nvme_ctrl {
 	struct srcu_struct srcu;
 	struct device ctrl_device;
 	struct device *device;	/* char device */
+	struct kobject *queues_kobj;
 #ifdef CONFIG_NVME_HWMON
 	struct device *hwmon_device;
 #endif
@@ -658,6 +681,8 @@ struct nvme_ctrl_ops {
 #define NVME_F_BLOCKING			(1 << 2)
 
 	const struct attribute_group **dev_attr_groups;
+	/* attributes of each /sys/class/nvme/nvmeX/queues/<qid>/ directory */
+	const struct attribute_group **queue_attr_groups;
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 10018c6356b6..8a982453cb69 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -1313,3 +1313,91 @@ const struct attribute_group *nvme_subsys_attrs_groups[] = {
 	&nvme_subsys_attrs_group,
 	NULL,
 };
+
+static void nvme_queue_info_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct nvme_queue_info, kobj));
+}
+
+static const struct kobj_type nvme_queue_info_ktype = {
+	.sysfs_ops	= &kobj_sysfs_ops,
+	.release	= nvme_queue_info_release,
+};
+
+/*
+ * nvme_add_ctrl() creates /sys/class/nvme/nvmeX/queues/ for transports that
+ * provide queue attributes, and nvme_uninit_ctrl() destroys it.
+ */
+int nvme_queue_dir_create(struct nvme_ctrl *ctrl)
+{
+	ctrl->queues_kobj = kobject_create_and_add("queues",
+						   &ctrl->device->kobj);
+	if (!ctrl->queues_kobj)
+		return -ENOMEM;
+	return 0;
+}
+
+void nvme_queue_dir_destroy(struct nvme_ctrl *ctrl)
+{
+	if (!ctrl->queues_kobj)
+		return;
+
+	kobject_del(ctrl->queues_kobj);
+	kobject_put(ctrl->queues_kobj);
+	ctrl->queues_kobj = NULL;
+}
+
+/**
+ * nvme_add_queue_info - add a directory for one queue
+ * @ctrl: controller, whose queues directory must exist
+ * @qid: queue id, used as the directory name
+ * @data: transport data, returned by nvme_queue_info_data()
+ *
+ * Adds /sys/class/nvme/nvmeX/queues/<qid>/ carrying the transport's
+ * queue_attr_groups. Calls for different queues of
+ * the same controller may run concurrently. Returns the queue info, to be
+ * passed to nvme_remove_queue_info(), or an ERR_PTR().
+ */
+struct nvme_queue_info *
+nvme_add_queue_info(struct nvme_ctrl *ctrl, unsigned int qid, void *data)
+{
+	struct nvme_queue_info *qinfo;
+	int ret;
+
+	if (WARN_ON_ONCE(!ctrl->queues_kobj))
+		return ERR_PTR(-EINVAL);
+
+	qinfo = kzalloc_obj(*qinfo);
+	if (!qinfo)
+		return ERR_PTR(-ENOMEM);
+	qinfo->data = data;
+
+	ret = kobject_init_and_add(&qinfo->kobj, &nvme_queue_info_ktype,
+				   ctrl->queues_kobj, "%u", qid);
+	if (ret)
+		goto out_put;
+
+	ret = sysfs_create_groups(&qinfo->kobj, ctrl->ops->queue_attr_groups);
+	if (ret)
+		goto out_put;
+	return qinfo;
+
+out_put:
+	kobject_put(&qinfo->kobj);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(nvme_add_queue_info);
+
+/**
+ * nvme_remove_queue_info - remove a queue directory
+ * @qinfo: queue info returned by nvme_add_queue_info()
+ *
+ * Waits for running attribute callbacks, so none run once this returns
+ * and the transport data may be torn down.
+ */
+void nvme_remove_queue_info(struct nvme_queue_info *qinfo)
+{
+	kobject_del(&qinfo->kobj);
+	kobject_put(&qinfo->kobj);
+}
+EXPORT_SYMBOL_GPL(nvme_remove_queue_info);
-- 
2.56.0


