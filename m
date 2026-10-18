Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACB1CCF2C7
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Oct 2026 01:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PivaMmF9oZn4Vnk3j4KO7AvXjPFZ8gVgtvOFy1s1a9k=; b=0+wRIj06TZdObHjJ+3W/eA2hy3
	VBkhqQIHI5E5QNGfWlZcSDCN/kGcyiusJpSR8sxR46nQoY4IsLhIB6n2TsGTKYUfqQwXdGLcmkXO/
	UhBaast5ezmcgn1wTL0bGqsAhToOB6RKGYkDe/4Qv3wzig57aMQuyiz1cIATktVLoIrgHQKTXiVBu
	lsappDy+NmbHiHfvS0g0SMawdMI/cuFbWjpkYaKXOMIjTnQaHmScJG7dEgrJS21WepynIiKPr7Oz+
	ffDie/emUmiFz8qexu+d04MOBT75Yo9ZHv+GqRXzCi4AMJEtZrgu3eV0kSh1TakBxio9oeODmFiyG
	8VzZz6Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIFH5-00000005O8d-2agU;
	Sun, 18 Oct 2026 01:01:19 +0000
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIFH3-00000005O87-1mE4
	for linux-nvme@lists.infradead.org;
	Sun, 18 Oct 2026 01:01:18 +0000
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso2565677eec.1
        for <linux-nvme@lists.infradead.org>; Sat, 17 Oct 2026 18:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1792285277; x=1792890077; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PivaMmF9oZn4Vnk3j4KO7AvXjPFZ8gVgtvOFy1s1a9k=;
        b=RUaWK8M9HBzMjruY8F9/2AD8msina4LE9oLA2ocrqOe85QovJfTY/d44OJhurbsnH8
         AcFadzYV0p+tfrLK2P3hkbKQAYPz+fxkEMoCYYeMGbnsLsDXODel3FmlW4DNgthf+rZV
         WF6ZwgdbjHBaQ5mhekHTvmAc4FE8lUYYBorfH9kFVrRXvEqQnLukbK48rCCARPPsCorQ
         QaGAnBAQw7OiXU1y6jugccNvXqst/GIwp4tBAJ4oz4tPUejmQkT+k77bNgLJY7iSHJtZ
         pa8WPgFVneAgWC0sao0m0PGERozaV6JxevQTcEgAgG/qNd56YYUxEiMQJERWwWYZu/wE
         Ji1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792285277; x=1792890077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PivaMmF9oZn4Vnk3j4KO7AvXjPFZ8gVgtvOFy1s1a9k=;
        b=0MYr8z2hrdKG7YwD9RPOOr+bwEfIKr2agEFFPHk5iEgNKbvXiOxnBJ5JSlqAFDtegq
         ojCRYY8CgIQGdg2sPBZgARb5H1VE6GBlThVJVdumqqJdshTvTQ6xZP0oy+HXT0FwxxBO
         8GhJ+309RHdNyVZwTwnaX8hBgzbsOjJrjTw9vwhMl7vUB2ytbHXuL5DI2xulAuxSAgSu
         Zo6mkrTwHPYcoRzJyIesxKOdj0nBIUXBjxaOPS43T03llyrQy/kUSuPDewdzgXC/Aq9g
         laj0bFTG/atkhtDgJ0wCKuazTZ7/AIxw5Rtp+FnZ2GVuWYvVlJ4PX64QrSrDuKdnt4nE
         A9mQ==
X-Gm-Message-State: AFq9FYI9g4IphryRGg2x7fgGJdH6qcrkhxjZeUYBzqCGSpyPvtdc+C/2
	YB/nwr6eKeWxUOK7utOh1OFD+W0BSK9/yI0LTa66yxl1nC3+Qy04tQmhmQvGN4Np6KgSLs580ba
	pMqzyoT3ogA==
X-Gm-Gg: AYBFou3t08m6ZJKL1Krxs695kJQSs/fpIj7al9hSMegg4xllwtosIwaJy7IqAdVQQYB
	LGOPUdSXv6Rm5liE8znXHXfRdiAo9+MEot1iGPxsQK3l7zkTfXkOv532FwVxr61gmMTcRkefaN9
	ipqGluFXu4l0+4T/Mva6Ec0gktK4eE1qUhSHYiErvN7tb5G/ygkDC7QlaIZA/v+jRKlWYkx7fe3
	IXz85o/E3frPyM7b1IGTX4hoi6ZTolqfQSA1FnTB7/Xwyez5MXqSfwh2yS0/I5UsV62AV70tSeC
	BYvBIdtICs7BvArqh2DF2nRetFkG+cGBgrEoOPfv9BquQTyFWCHmZkrbhO3/O8lZ4l15klbeN0P
	7lG+yulMsnJnq8TcglPj6bXE9uUOlhygYZUXwkcYhtqJ4hQN5KZNDeDdH0WzoUbHWEXVP5glkax
	0NHWQKFulrp+WBwXwiMPjQshukkhlR1+8OyPy+xqb7GXKKJwrRNM+mR5agnCGZsflLl/zEV/Xk9
	n0Tm3XeW6+u4yShJ3QbDCalC9aNt7ZZpkRm2ngYs70=
X-Received: by 2002:a05:693c:88d0:20b0:35e:f4ac:5f8e with SMTP id 5a478bee46e88-3619b8fc307mr5225921eec.0.1792285276746;
        Sat, 17 Oct 2026 18:01:16 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([71.202.170.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm24198870eec.20.2026.10.17.18.01.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:01:16 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	Saravanan D <saravanand@crusoe.ai>
Subject: [PATCH v5 1/2] nvme: add per-queue sysfs directories
Date: Sat, 17 Oct 2026 18:00:58 -0700
Message-ID: <20261018010059.83120-2-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018010059.83120-1-saravanand@crusoe.ai>
References: <20261018010059.83120-1-saravanand@crusoe.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261017_180117_468421_4FA280C6 
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

Per I/O queue transport state, such as the nvme-tcp io_cpu, has
nowhere to live in sysfs, since the core has no directory for
individual queues.

Add helpers that create the controller's queues directory and add or
remove one directory per queue

  /sys/class/nvme/nvmeX/queues/<qid>/

carrying attributes provided by the transport. The transport creates
the queues directory from its controller setup path, adds a queue's
directory when it allocates the queue and removes it when it frees
the queue, so the directories follow the queues across reconnects and
changes in the queue count. The core allocates each queue directory
and its release frees only that allocation. Removal waits for running
attribute callbacks, so the transport may tear the queue down once it
returns.

The queues directory holds a reference on the controller device, so
nvme_uninit_ctrl() deletes it after the transport has removed the
queue directories.

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Link: https://lore.kernel.org/linux-nvme/13c160d0-0657-47ce-9a16-58d348267ab0@grimberg.me/
Assisted-by: Claude:claude-opus-5-5 [Claude Code]
Signed-off-by: Saravanan D <saravanand@crusoe.ai>
---
 drivers/nvme/host/core.c  |  6 +++
 drivers/nvme/host/nvme.h  | 23 ++++++++++
 drivers/nvme/host/sysfs.c | 88 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 531f9bb14bab..41e1c9d0ee58 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5153,6 +5153,12 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_stop_keep_alive(ctrl);
 	nvme_hwmon_exit(ctrl);
+	/* transports remove their queue directories before this point */
+	if (ctrl->queues_kobj) {
+		kobject_del(ctrl->queues_kobj);
+		kobject_put(ctrl->queues_kobj);
+		ctrl->queues_kobj = NULL;
+	}
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a8ef62b8e34b..d198214d7f8b 100644
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
+struct nvme_queue_info *
+nvme_add_queue_info(struct nvme_ctrl *ctrl, unsigned int qid,
+		    const struct attribute_group **groups, void *data);
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
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 5224597a32f1..cf62ff905a35 100644
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
+/**
+ * nvme_queue_dir_create - create the controller's queues directory
+ * @ctrl: controller
+ *
+ * Creates /sys/class/nvme/nvmeX/queues/ if it does not exist yet. The
+ * transport calls this from its controller setup path, which must not run
+ * it concurrently for the same controller. nvme_uninit_ctrl() deletes the
+ * directory.
+ */
+int nvme_queue_dir_create(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->queues_kobj)
+		return 0;
+
+	ctrl->queues_kobj = kobject_create_and_add("queues",
+						   &ctrl->device->kobj);
+	if (!ctrl->queues_kobj)
+		return -ENOMEM;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_queue_dir_create);
+
+/**
+ * nvme_add_queue_info - add a directory for one queue
+ * @ctrl: controller, whose queues directory must exist
+ * @qid: queue id, used as the directory name
+ * @groups: attributes provided by the transport
+ * @data: transport data, returned by nvme_queue_info_data()
+ *
+ * Adds /sys/class/nvme/nvmeX/queues/<qid>/. Calls for different queues of
+ * the same controller may run concurrently. Returns the queue info, to be
+ * passed to nvme_remove_queue_info(), or an ERR_PTR().
+ */
+struct nvme_queue_info *
+nvme_add_queue_info(struct nvme_ctrl *ctrl, unsigned int qid,
+		    const struct attribute_group **groups, void *data)
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
+	ret = sysfs_create_groups(&qinfo->kobj, groups);
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
2.55.0


