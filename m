Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAFB606A31B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 23:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aoKYhnbm;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=KA/mzVU/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9UHLjeKrYRjfbnwwuY8ZM/Qh+DkT6uaF+f3tpZdmmVI=; b=aoKYhnbm2YvSl4
	8EiZKRsJn+WkO43j9VWrCK1jdstyFp3jvSyTiEHN65nUWIt7AOGK0867msHdjut5De8APmBEFtSSJ
	UlZ9zScYiMOB7VOUlUVoWyRnGwb6B/+fIBI6BI9/3tY5K9N+7G1MrBZ9QEqRmopAZ+lWkWDI4MFU4
	Qugj140SiuqGuj48/Ww0zSVPrOqmXrLzXnwEFGxfzEf/WU26bWDKx/H6t2w+F0Kr6s47JcuUOIL5o
	EDDC1pbwrnEXJNYKwRG7C3VtZ6e4ZSFATbYb+XW9P4hU7V9ianNdNBv5G9FiSfe6vwLZoAr0EnvZT
	6dY9CpZDLiKfqwIKBpuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKOJs-0000000H8j0-3k3l;
	Fri, 23 Oct 2026 23:05:04 +0000
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKOJp-0000000H8hZ-2R4I
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 23:05:02 +0000
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2489001eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2026 16:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1792796701; x=1793401501; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9UHLjeKrYRjfbnwwuY8ZM/Qh+DkT6uaF+f3tpZdmmVI=;
        b=KA/mzVU/Ptl6g7A1s2PhIFFSGMFiGCsiuDFHMbe/AXTn5+nCGdU3m3NxzhCo8qjS45
         1V7/Bgxy+ho+hHYnhuI6ZIuW7dcPfmBRP+/m7YvYF2e5qKb1H0caXbbrI5yjPn/tgRuc
         e0aVVtMKWaZ+cK0KsCxuMt3WNhPpwPEpo3KoPajYWldFVAfeNHoqgBaJQ4mQ0nd4R7AA
         Gjcckw4OhQWiL2T9QMs6aU1loggc6YCwXPwx7gtCh36xV6gbdMyWu45gKEs9+nwETo/s
         Dx1QmzpDC1sqv07RuheABB2Cx+AR9/WGeecANHHM2ni6aUauNBJDAMNaQYrKLmI20yM9
         dBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792796701; x=1793401501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9UHLjeKrYRjfbnwwuY8ZM/Qh+DkT6uaF+f3tpZdmmVI=;
        b=iAZvdFJIqgrmdUAtzJSutdjRe2NOdMbU7Cue2ZJ7fYtnSoMMEeWTYmKGn4c0csa3qF
         AtwyxqwtlXLbOP3i3pgV7w5GDF8mJmSpWciDCeWDJiN+OrxZ6OKuWbhnHSdfvqUHzPz3
         fpaI0MrI1HszmCzlW5DQSYL8xR3zUStjLYprP7OW1wAuhHS77ouQPa7y+BuFJaFC/Q5C
         r3qLcJrHvowK2WiZFVIbap3rAYrcWF26bhPLpY7J5VLlf8NbR8tkEdAOayvdrUFaypEj
         qDKBtfN2RL8iPVnw9Q6AYsQBHRYrrVVJZvPJy0OZ6iB0k/TL2kOa0N/KybgMrVPetaj3
         gO1w==
X-Gm-Message-State: AFq9FYJF1Aiv8Mkc6WTAl4bm4ghUL7RTXT7sdiig/YKVmD/bbhyTVhp9
	RXq3e1rqcuGTeJPj/PbiM/gFhjSSCctPwS0i5ix6P8IxKM/L/lehthPYutR8pcsL+kbN232g5mV
	wWIyUtzE=
X-Gm-Gg: AYBFou2Ptpnd+2TSOZ+rcLoyl4S57KP3xOB63/5zms17Sk7AZ5s0ug1q0s1mJJxuI4K
	3HVg+wr0AORk4A/ARJI1ivgEakV6sQEuVuB4PsplGV0h+c8wbrgllDxWCFhp9ujhIcKHXTtxlIh
	ODWL61UJOqsnhpf9dqkqc/hbeZGE67PR89TdN090M+cz2000lGc2vTSaON9Y/g967SmfH7pf3fy
	QRy/aHtRSnpSAWd5sixhoy363dPB+D3wTQ0tWBZ6PJz9A5lz83ZopRkVTend94atiAY4L7lHzvR
	WtbOzPBl/YlFOScVftE4GfWvgNA7JuZFEIQi1VoPzFeL5qm+u8Xw7ZBwSowU6IAuPydwrksmW8o
	ihKVcqufRSUqM9fHeYlYesylIN/RrgPaYPWxYPuifCkc53VdQKSIJ3X6bOrlhEh+1cq9NWWBP9F
	NOOzZ0ZKAPQEcsWiQAGketF6OX9ur7oYgnHOBR+LxnGDnkOgWLfXaL1ZCwjNzsOYEazyo8j9mqW
	ZfgJb2Mn3OwIyK9qRp1EoBRrsQXacRz66fhJYMxaBTQ2YpgIM143vnSmEP9UgoDHg0oHbuido6E
	I40RsNj3xjI1dNjnw2Ho0w7Fjw==
X-Received: by 2002:a05:7300:105:b0:366:913f:4d27 with SMTP id 5a478bee46e88-369e85027a5mr811308eec.30.1792796700299;
        Fri, 23 Oct 2026 16:05:00 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([67.208.231.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ecf087sm1356203eec.27.2026.10.23.16.04.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 16:04:59 -0700 (PDT)
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
Subject: [PATCH v6 1/2] nvme: add per-queue sysfs directories
Date: Fri, 23 Oct 2026 16:04:25 -0700
Message-ID: <20261023230426.6425-2-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023230426.6425-1-saravanand@crusoe.ai>
References: <20261023230426.6425-1-saravanand@crusoe.ai>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_160501_633081_9E787064 
X-CRM114-Status: GOOD (  21.36  )
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

carrying attributes provided by the transport. The transport creates
the queues directory from its controller setup path, adds a queue's
directory when it sets the queue up and removes it when it frees the
queue, so the directories follow the queues across reconnects and
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


