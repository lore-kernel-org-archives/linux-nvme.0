Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71B8C433E4
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:06:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68A2206C1
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e7WMmlE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68A2206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7fjuTdJno1gzucjboY108ma2cTvZ3Ncig6Lwv5z2Pzc=; b=e7WMmlE+u/B5MTfya9A1vAc6d
	MhHIEp2us4jH8iCdu4hGZxJYJMY5sy5ZuE85XWmqPnSuBe7FUTZ/XnIYVRCD+ta40q/YTPWcdlFNu
	rTtffIUepOAK+/u2fKC+QUI+IqmGrL1sd/Z4X7ccTPaqSws1TceK4865gWpXGzU4dy8092aq5P/uh
	lQVfTRkioGPl2nWsBsyxA9elTR/3K1I1Z27qIbDBZsjV/8noTyZmU55sJmv43YmRCwSuJvLku9umy
	Oevr5wioQhkIwaWXlW7ruUSkY9HZw3aplThTSYH0+LE9zTjeVclIhISAtpWkTvG2ugzpmSZpjHT4h
	YHljiOUMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz6la-0002iR-Ek; Fri, 24 Jul 2020 23:06:14 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz6lX-0002hC-Bo
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 23:06:12 +0000
Received: by mail-pl1-f195.google.com with SMTP id l6so5382263plt.7
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 16:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OgjfSDmbTrrS4mEsCkmF4KKnsg11nGW5aZqbssFyWZ0=;
 b=OOpb6HMcKDLh5IDKmUcEIGKgh02whxe7451rB9hbzTv76MhTaVoHgVv8xivTAGUeU3
 JJtUzNlotIeOkZa961xR/AltTJwgCanHss8VsOy69BRXhk23mmDWc/kRgfdLq7tSO4oc
 Qc+RThu3qhXJR+sRH4iMNpMUTtyb9o1+Lh2Cim9hSTG+FmMzeb4Nff/mjTqrxqWd8RER
 H5WwaHRKF/D17NBvelJ2n5YawnCGypObV6NgmXib0NxwWzJNvrlzP0oH8YvU7QduX2d9
 vy3kHCrBLA7/gceUfETSBGzKVVwhIhOG1L5OnpcGVI3iuUBTZbgdHnNk3IdIW7lSiHWR
 WXOQ==
X-Gm-Message-State: AOAM530EUqekfhZsFlUr5860all9sf9Lgzvuj/oo7RNC+XMHy3G3QjvR
 ClyAkWKMMUFlmOKKu9MY42Ahe7Y7
X-Google-Smtp-Source: ABdhPJzUrUEas/gwLS5xvxN38nNGajaNu/OY9lTmRfgQ+o+VSHIZLfZpMMgvr1ZWTLsMzNgUOz4qAw==
X-Received: by 2002:a17:90a:a68:: with SMTP id
 o95mr8323385pjo.64.1595631970051; 
 Fri, 24 Jul 2020 16:06:10 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:ac47:9fc4:b59:66fa])
 by smtp.gmail.com with ESMTPSA id 129sm7552379pfv.161.2020.07.24.16.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 16:06:09 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH rfc v2 2/4] nvme: improve quiesce for blocking queues
Date: Fri, 24 Jul 2020 16:06:02 -0700
Message-Id: <20200724230604.34625-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724230604.34625-1-sagi@grimberg.me>
References: <20200724230604.34625-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_190611_466473_157CD19F 
X-CRM114-Status: GOOD (  12.56  )
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
 drivers/nvme/host/tcp.c  |  2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c16bfdff2953..2ae8caa4e25f 100644
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
+		blk_mq_quiesce_blocking_queue_async(ns->queue);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_mq_quiesce_blocking_queue_async_wait(ns->queue);
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
index 7953362e7bb5..58ab07edcb4b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1887,7 +1887,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->queue_count <= 1)
 		return;
-	nvme_stop_queues(ctrl);
+	nvme_stop_blocking_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
 	if (ctrl->tagset) {
 		blk_mq_tagset_busy_iter(ctrl->tagset,
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
