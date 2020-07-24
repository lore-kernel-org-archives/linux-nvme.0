Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A69C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 21:55:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7B6206F0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 21:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c+46i7C6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7B6206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TepgvawlQR5kaEO1fRSaVmCANhXixmG0M0AKapcbBpI=; b=c+46i7C62jspOXFIPtX+hNVPR
	hVQQpk50QagmWjr3jAGG2QqN0VBQmSFT7G1E4PDPXf4XIQ567/Pel28y21omib/7zuHnac0k47Gxx
	20cQ9dg/nOVi1+BMkZ0CIHrJdVUtkuGzGwU68GkNUQet9WL7M4813o3lss3r0vKWnogNjXF6Uu8ml
	3q6i057/mr/UWK6DvAElymjmDKLYeMM5OY7gn8RnFrr0jIa56dikJ2teUFCgeXhNl18nXhwm8ewiU
	eox6yeTzJZS4CeTmR5Yz5dNq7tDae+bQV8hYMvzbfJaFpi7GrW7ACfoMA1BvhmsH5VvAq9b8LoW3s
	FWVrwe16g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz5ef-0003Qv-RW; Fri, 24 Jul 2020 21:55:01 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz5ec-0003Pb-N5
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 21:54:59 +0000
Received: by mail-pg1-f193.google.com with SMTP id p3so6164405pgh.3
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 14:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NuffKowLhxuyQzOj9jKw5GkAJ0JSZ87WtDIjMKVk9G0=;
 b=is3uTksi9e70JERoed0AqDQRedqa/yKOKc1oWduG/KPn0C8KgsrNIhou13xd8426Fl
 Y2+2yh5x+gjhP3W3/QcPkcROSCd1L8ntxMYLx/UBM1qI8B07zd6BZJXXU6MjQrxHlrP2
 O5tNysTXb/vp7YpOr5WBa0AUxbQrqkBV5Z+uD0Ie0LB7198K1/fU8i6aDw92ZexoNPhj
 e1M+ddts0Kdc5rhEE7iRR6bh2qyKLFlFyeWIs1KTJLnRpq5+IWyE4SejjPD8oVR2Rp5S
 kkjMOEKu5nXOROqWcbQUhYgDXF+WGjyRQS3bg5evD2eyKt2zAEIFEoW4J+t5QMAPNpRp
 F4jw==
X-Gm-Message-State: AOAM533YYrHsvxlJSF8EedChBc3Jco+8+QSRdsZgdnyXbePfinBaelD3
 Ogep/kqt4dQJhvSfejdNAYnS/1w3
X-Google-Smtp-Source: ABdhPJyPOYaGKevNn/W/oyW8fXb2FOWTtLRVSHZ9oFOiM/UCm++0/hq6daFCPVchoywgtr3/wL1aDQ==
X-Received: by 2002:a63:db57:: with SMTP id x23mr10221325pgi.178.1595627697160; 
 Fri, 24 Jul 2020 14:54:57 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:ac47:9fc4:b59:66fa])
 by smtp.gmail.com with ESMTPSA id 144sm7565112pfb.31.2020.07.24.14.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 14:54:56 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH rfc 2/4] nvme: improve quiesce for blocking queues
Date: Fri, 24 Jul 2020 14:54:50 -0700
Message-Id: <20200724215452.26401-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724215452.26401-1-sagi@grimberg.me>
References: <20200724215452.26401-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_175458_770913_16211200 
X-CRM114-Status: GOOD (  11.22  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme transports that use blocking hw queues (e.g. nvme-tcp) currently
will synchronize queue quiesce for each namespace at once. This can
slow down failover time (which first quiesce all ns queues) if we have
a large amount of namespaces. Instead, we want to use an async interface
and do the namespaces quiesce in parallel rather than serially.

Introduce nvme_stop_blocking_queues for transports that use blocking
hw queues and convert nvme-tcp to use the new interface.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 13 +++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/tcp.c  |  1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c16bfdff2953..f1a76bad226e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4529,6 +4529,19 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
+void nvme_stop_blocking_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		_blk_mq_quiesce_blocking_queue_async(ns->queue);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		_blk_mq_quiesce_blocking_queue_async_wait(ns->queue);
+	up_read(&ctrl->namespaces_rwsem);
+}
+EXPORT_SYMBOL_GPL(nvme_stop_blocking_queues);
+
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1609267a1f0e..f8c36176518e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -568,6 +568,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		volatile union nvme_result *res);
 
+void nvme_stop_blocking_queues(struct nvme_ctrl *ctrl);
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7953362e7bb5..9534626379e7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1887,6 +1887,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->queue_count <= 1)
 		return;
+	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
 	if (ctrl->tagset) {
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
