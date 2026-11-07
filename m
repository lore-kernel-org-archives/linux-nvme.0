Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8B9606A32C
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Nov 2026 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CkHZkaU/;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=g+uCwOxz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6unXmLTVj63gMaJt+DomEkh1Cx4zZ4gKd/LFAI0Dsr0=; b=CkHZkaU/aPopMX
	TZWNQjU5sE4x6LcGOej81LOYERCS8cQFM1aufrCzB3Xiu9nsMu9MnZmYdMSIUtbbw3nW/DYkOyjBR
	5Bz+vUpagBxo68nPNfpTwmiGsn2YfVhBI6iS3YdKxoBKI9t0vt4UeUeR0qGAVTgkEjmS+5+6s/9Lj
	jCYm4Ff1Nu/lFvaxbBme8XilhmCj422INchWwcdPnpuccgNEptdVSIOrYiP6g7cd8tEYMkm5pStcJ
	eVtJ+EM2/5RnXfdBsa4kNS/TrBIGXqEA423UVWjDIJgzu5lfpWgjpznScUYKiHdc4CRpqqeC8vojG
	75rSNe5p4a1tzOz4VX8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPd7X-0000000ERQm-2mJ9;
	Sat, 07 Nov 2026 09:53:59 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPd7P-0000000EROx-1efZ
	for linux-nvme@lists.infradead.org;
	Sat, 07 Nov 2026 09:53:52 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so12281295e9.0
        for <linux-nvme@lists.infradead.org>; Sat, 07 Nov 2026 01:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1794045229; x=1794650029; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6unXmLTVj63gMaJt+DomEkh1Cx4zZ4gKd/LFAI0Dsr0=;
        b=g+uCwOxzcM4gNYJUTmY/qRecRHdunmiBLR7c8p6GrgG9hcvciskXPlFMDKRj39tRxO
         /Yb95VOnc3XGscVeSfSyu8MIgEQrBaVpSTBENbzn+A+LahhkZ8aRJsewziSfa/1NIcmM
         1MH2Yh/PJQmB7lUZrHoe1GFfhCHwaArFFcX3TjHoQq0POeAo26kN0fnIBSLC5bL0NoNu
         QBBhtFtqSLqBjWlzCkU+Aiwlmn1XPQsDbu4sSFTiXSIWoS6WYC8VaYWfErUmvjhPWwqn
         M41+LmhXH7ym73RJ1b8EPnwSsc1dDA+pVELaa/us+9dl+qm0XDrXARZj0zveSE7NiAFk
         wL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794045229; x=1794650029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6unXmLTVj63gMaJt+DomEkh1Cx4zZ4gKd/LFAI0Dsr0=;
        b=W78+5n/wah3zThY8lz0zK72yyXmVyEaXEvebMfKWayCwIr/y+yQQhk16X9CwJ6rWH1
         AbAQR4erkvTK2gE7LhZqkLulOAFxzuLhsfMjZp8DrZbsyQkLQ1Q93TT+L2W0hanT0hEz
         3d+r3NTmK6RKZ4eqYEpiKLh76OYjROPzr2pLVnaGUOfFtjl46FZIbPkvWcQOxDNouo0O
         Pae3TnDgIOVwL9PO18xQWs8139J1zVft/ABkAU35tuQm3waiTfuwD8RceTM4R21O7yeh
         QdZtZiSA/uU6kc5mDlSzUHyEzEF0sbB7xO1IqDFPtdrzaUS6yEpf1hJTA/d5ay9uaSRQ
         b2iQ==
X-Gm-Message-State: APuU4Z8sRu/RMURuvz+x5/TgVDyreGy4z2E2MICVob2piiVoVqeLeCIV
	dhwoRZiMtjPAt5ANrdHpqmHllfaSxuIqbyW6eJniGkpW3867rt68PFzIOgI2ER38GbfmI3hMZdH
	WikGYuRDqYg==
X-Gm-Gg: AYBFou0od4v+DL5I5w2IQT/+u8wzzpjrDMCxQ9wtL+OK0v05oSPbHfcCmVVCLD8f8j0
	/4s0vjHP+F/j7I0xm8jJYwG4kCu0g0k/HYhK4FGnO8dGOJHBEAqioGWhoJgKROmJKefV/4emf2j
	iEtl6HLXO2cuh5S4ZjugTh4h+3fPfxwR2jmvUiiRkTkH3oEQ/t0J/l80ra709SU9JlhX7Bi0KfB
	hsAtg89hcSuF8ReJ7HNyLvdVrKKP3Bid5OHPt77xK8R83jyIz32aCuc7sNXJhR/fTxswqm3LCc5
	8y591iUQ7dhnXmaeS7KH4JyGhA22YAy9Qsg4ieH/Re2m5+jCnnwtRXfWeNLOHwA/3gRsglAPoKf
	w9azLSB/LQ5bwhUAYMB8B79dfHIfN2YynWnT4eChW52xw0xU0oVi+qza+jIQz3PZ+PXFCwZ3z6f
	MNQBBnkQgFgXFw7NNl1jbiUPXWxHeVIxWJlUlqwJRPSZe6s+rET+DkH79Zajc0DQ+Us4EQt4FV8
	jxtRcN+AUOWF6ak859nDFILPhUIb+raeK2jEWIQdIhymXz2t/0yYYDJF+X2IqBpLyXZD6DJ2xNI
	LAPev/9tXz+OEOmFnaifp9R6+oUFRoZ4NflrGHmyNMYRU6ZdL6tom2D8RrYxtSX5p6GELFKoVA=
	=
X-Received: by 2002:a05:600c:4e05:b0:4a2:c2b:a91b with SMTP id 5b1f17b1804b1-4b6de973c54mr78810225e9.10.1794045229548;
        Sat, 07 Nov 2026 01:53:49 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([185.57.101.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b8af10dd35sm37607545e9.4.2026.11.07.01.53.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 01:53:49 -0800 (PST)
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
Subject: [PATCH v8 1/2] nvme: add per-queue sysfs directories
Date: Sat,  7 Nov 2026 09:53:36 +0000
Message-ID: <ce12f1742ea7f8699d85666e4d9d8a2a9d77c90e.1794015622.git.saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794015622.git.saravanand@crusoe.ai>
References: <cover.1794015622.git.saravanand@crusoe.ai>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261107_015351_474399_717B5C55 
X-CRM114-Status: GOOD (  21.87  )
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
 drivers/nvme/host/sysfs.c | 90 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cd0df9b03806..66e1e2c614e8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5208,6 +5208,8 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 	 */
 	cancel_work_sync(&ctrl->async_event_work);
 	nvme_hwmon_exit(ctrl);
+	/* transports remove their queue directories before this point */
+	nvme_queue_dir_destroy(ctrl);
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
@@ -5352,6 +5354,12 @@ int nvme_add_ctrl(struct nvme_ctrl *ctrl)
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
@@ -5364,6 +5372,10 @@ int nvme_add_ctrl(struct nvme_ctrl *ctrl)
 	nvme_get_ctrl(ctrl);
 
 	return 0;
+
+out_del_cdev:
+	cdev_device_del(&ctrl->cdev, ctrl->device);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_add_ctrl);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2543e52d6358..95b598c71b4a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -356,6 +356,28 @@ enum nvme_ctrl_flags {
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
@@ -377,6 +399,7 @@ struct nvme_ctrl {
 	struct srcu_struct srcu;
 	struct device ctrl_device;
 	struct device *device;	/* char device */
+	struct kobject *queues_kobj;
 #ifdef CONFIG_NVME_HWMON
 	struct device *hwmon_device;
 #endif
@@ -675,6 +698,8 @@ struct nvme_ctrl_ops {
 #define NVME_F_BLOCKING			(1 << 2)
 
 	const struct attribute_group **dev_attr_groups;
+	/* attributes of each /sys/class/nvme/nvmeX/queues/<qid>/ directory */
+	const struct attribute_group **queue_attr_groups;
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 3724b5ce03a0..ff81030f161c 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -1311,3 +1311,93 @@ const struct attribute_group *nvme_subsys_attrs_groups[] = {
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
+		goto out_del;
+	return qinfo;
+
+out_del:
+	kobject_del(&qinfo->kobj);
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


