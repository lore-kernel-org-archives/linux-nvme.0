Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934C2C9830E
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2026 07:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BIYDdjJ1rcyjUwNCj55QdTfFyOHRu8zxJh3wOv/c/fY=; b=nLhgR3YEuhlQHA57cc8KtjwCPU
	EHtYyd3cjmOvZqepIIBP95pLPr8OmmETk4lx/0ospZbgiZ/yqxd/MzxOgIT8gSBVuC44K279givvF
	o2MdWK4N2M+Q6jh9cA9gRYuscpRoCmqJM+HcbnjdmPYgE7ea2uhwlvbbVjoLsJo2x1Rix879z4ypL
	OpWSxK7gX1evp0e+wodTzcaJNPZVo9PyDpSmIHHMWD318bRhqGAl7qEJjVlJux3AKGfiNSubNjkFD
	zTorFqRl4YnEa/fdtTSNvlNMkB5l9NpDJq6IsRSfQrfHHTmMO893qgo8+o66dJLbaaVTvj2xR8Ptd
	crpVbRTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAj13-0000000G5iK-0WXf;
	Sun, 27 Sep 2026 07:09:41 +0000
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAj0w-0000000G5gf-3htw
	for linux-nvme@lists.infradead.org;
	Sun, 27 Sep 2026 07:09:36 +0000
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-33c24422d4dso2547952eec.2
        for <linux-nvme@lists.infradead.org>; Sun, 27 Sep 2026 00:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1790492973; x=1791097773; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BIYDdjJ1rcyjUwNCj55QdTfFyOHRu8zxJh3wOv/c/fY=;
        b=XNA58MotZjU+h7CqrP8IaHwF93DcQCDCLmBtKuYXvDoE3M1uP27Ksxlc+CXNilfVyK
         m2n6sdlvaOeeUo6knz6REaME/gMA5WWuf2kDtRAut9EucDbAvQAYp7nut4hcyHIOjQEu
         CzfHk1CE8s6gQdKzrFZABKUj9HYX2oGG4U26pDX9pN6TIFgCFgI4ytpblcyvSsNDPKN2
         qGesytDBLnOjclpvZHF9eisZ4Bcsgfvs9LDNtXavisFCI0BI2TN1hLZKQdoiRZAY0N05
         P3vGOr54Q1IsAMk4kPV0msTtm8mQdHHEdhTojVgpjjfG1O7nmuZOiWom0OQyePjP6UWN
         +QHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790492973; x=1791097773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BIYDdjJ1rcyjUwNCj55QdTfFyOHRu8zxJh3wOv/c/fY=;
        b=s0k6+z//Y5FkuADTc4UwpLUlG9lQ1LofceW+GCVPH8TmsGUHHOkEx+k4tQp2xp6U3O
         kZIFtPE64IQ5OkzWxr6KgBynAKPn0G2x8opnnCA8BdNh/XufsLwZR5uoGgbXlAUX+At4
         oSJ5IHMFTMhyS88pcKfHIrw28LX3qSA5la3LIk2XHhY7a2bNVxOb9nyDqpAzk7Ql7kVa
         gU+x0fdrfERg7lqEYdIdggne6WAx1c2dXk9W689jm32Eu4PbD3eAHc0+8W53Ug4yj/oG
         zNMgE1WOhAxpjVQJ3ON2qZB10nxrVdxFrMv6katwoycnt1H4Sx5O47iApF/wyhw502n2
         H14w==
X-Gm-Message-State: AFuF++k/V17o1SrslA8NNuC9wTAuM1VRU268IoxZLZZb2nd5hrlZt93/
	/eZS2MozDxFH9uMpJ3hBVfTHUpeJglV6f2lQXmpuavoZu9hNzYoJ4EdonTSTuhmwfx5gUDFEQJF
	6tAL4ZGc=
X-Gm-Gg: AYBFou0KfzQ9a2A4QBz26j5IhyrsBKjBSvA66GZEC1x0wt5ZxT5mzTnVchbM13ocNzv
	60Z0RZrKbNZ76uXPw7TtzsSdEYTHtVJedwnNHKBSnQLjjJpSOYnJPnk8zGR2NcAgH867LN+v6Z+
	/BhJGIs1kEZbzoRjYT0L4r9czB/XIroTUPDeDKReN/vX9yhwUkrejSjLOdvSDQr73oiEgnAE/gB
	XoP9+lR0bpPg0I8wqmmRksunlxkdOvT2qxrEPu3iPBFbsThPLJh5sh7Tr1eAShkLLdUTUAC94LK
	FPmKxBRQiLuEvmaxHJ5xlrkvsZHhXL7YTlpQKBf2a3a1ptK6x6sYlkCE60J8hiyYffavFECL058
	NiQZf1wLoAPV2jbguvytC4QWTZJxRwByHhzpO1Iui9F0kX/Mim/Ff0ZgrqSvV4lMTg33qsAOXiS
	e6Ij6xm5hzO7zqg9SOYwJUd5e7Uj6K/9MPic3tFKpjEsYE7gydmSKoApAhnE/jB/TQlCk1JBdux
	q/EkvHIwz9jljL6hw5t+NYs2GuwtCczlxy5uxWyWo/Iauyzfh9gcg==
X-Received: by 2002:a05:7022:5f1c:b0:144:c122:6cc6 with SMTP id a92af1059eb24-146d01af925mr4979747c88.32.1790492973282;
        Sun, 27 Sep 2026 00:09:33 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([2601:647:4380:3400:cdfd:5309:3fdc:3b4e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm10322371c88.9.2026.09.27.00.09.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 00:09:32 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	nilay@linux.ibm.com,
	dwagner@suse.de,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sj@kernel.org,
	Saravanan D <saravanand@crusoe.ai>
Subject: [PATCH v4 1/2] nvme: add per-queue sysfs directories
Date: Sun, 27 Sep 2026 00:09:24 -0700
Message-ID: <20260927070925.47209-2-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260927070925.47209-1-saravanand@crusoe.ai>
References: <20260927070925.47209-1-saravanand@crusoe.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260927_000934_925872_3EDD9E6A 
X-CRM114-Status: GOOD (  18.07  )
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

Transports have per I/O queue state worth exposing, the nvme-tcp
io_cpu to begin with, but the core has no representation of an
individual queue and no place under the controller device to hang
per queue attributes.

Add a small nvme_queue_info that a transport embeds in its queue
structure, and helpers that register it as

  /sys/class/nvme/nvmeX/queues/<qid>/

with a transport provided ktype. The queues directory is created on
the first registration and released with the controller device.
Registration is expected once per controller lifetime, so the
directories persist while the transport's queues cycle across
reconnects.

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Link: https://lore.kernel.org/linux-nvme/13c160d0-0657-47ce-9a16-58d348267ab0@grimberg.me/
Assisted-by: Claude:claude-opus-4-8 [Claude Code]
Signed-off-by: Saravanan D <saravanand@crusoe.ai>
---
 drivers/nvme/host/core.c  |  2 ++
 drivers/nvme/host/nvme.h  | 23 +++++++++++++++++++++
 drivers/nvme/host/sysfs.c | 42 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index beea23d04a70..211d05a1cc48 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5197,6 +5197,8 @@ static void nvme_free_ctrl(struct device *dev)
 
 	ctrl->ops->free_ctrl(ctrl);
 
+	kobject_put(ctrl->queues_kobj);
+
 	if (subsys)
 		nvme_put_subsystem(subsys);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bac25b287d25..20410f0d6118 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -339,6 +339,28 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_FROZEN		= 6,
 };
 
+enum nvme_queue_info_flags {
+	NVME_QUEUE_INFO_REGISTERED	= 0,
+	NVME_QUEUE_INFO_IO_CPU_USER	= 1,
+};
+
+/*
+ * Common per-queue state, embedded in the transport's queue structure and
+ * backing the /sys/class/nvme/nvmeX/queues/<qid>/ directory.
+ */
+struct nvme_queue_info {
+	struct kobject		kobj;
+	unsigned int		qid;
+	unsigned long		flags;
+};
+
+struct nvme_ctrl;
+
+int nvme_register_queue_info(struct nvme_ctrl *ctrl,
+			     struct nvme_queue_info *qinfo, unsigned int qid,
+			     const struct kobj_type *ktype);
+void nvme_unregister_queue_info(struct nvme_queue_info *qinfo);
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
index 4ac3ea3a86fd..a2780445c33e 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -1313,3 +1313,45 @@ const struct attribute_group *nvme_subsys_attrs_groups[] = {
 	&nvme_subsys_attrs_group,
 	NULL,
 };
+
+/*
+ * Per-queue sysfs directories under /sys/class/nvme/nvmeX/queues/. The
+ * transport backing the controller registers a directory for each of its
+ * queues and provides the attributes through the ktype. Registration is
+ * expected once per controller lifetime, so the directories persist while
+ * the transport's queues cycle across reconnects. The queues directory
+ * itself is released with the controller device.
+ */
+int nvme_register_queue_info(struct nvme_ctrl *ctrl,
+			     struct nvme_queue_info *qinfo, unsigned int qid,
+			     const struct kobj_type *ktype)
+{
+	int ret;
+
+	if (!ctrl->queues_kobj) {
+		ctrl->queues_kobj = kobject_create_and_add("queues",
+							   &ctrl->device->kobj);
+		if (!ctrl->queues_kobj)
+			return -ENOMEM;
+	}
+
+	qinfo->qid = qid;
+	ret = kobject_init_and_add(&qinfo->kobj, ktype, ctrl->queues_kobj,
+				   "%u", qid);
+	if (ret) {
+		kobject_put(&qinfo->kobj);
+		return ret;
+	}
+
+	set_bit(NVME_QUEUE_INFO_REGISTERED, &qinfo->flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_register_queue_info);
+
+void nvme_unregister_queue_info(struct nvme_queue_info *qinfo)
+{
+	if (!test_and_clear_bit(NVME_QUEUE_INFO_REGISTERED, &qinfo->flags))
+		return;
+	kobject_put(&qinfo->kobj);
+}
+EXPORT_SYMBOL_GPL(nvme_unregister_queue_info);
-- 
2.55.0


