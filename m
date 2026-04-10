Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC07E9904A
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 07:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+eWrIywFrS+62GNyPsS0dezlJg/iXu6nQsIf8NoPoG0=; b=XBCisci5juCyhE3OqTRqe33tJD
	lIk99qACEKtq3w0Na+0gKtw6bochBcqo+DDyZ0AADL6dBTeTzblCtXAFK+RGDAlYjK230Dv9QmXJa
	V3Hshu40g0Q/pz6c0wp2AA/b15j2y6myZDO7k/OAvABDju4UYUW3e4E8RONlFT0M4pJlm0XUOhG5G
	QQrsuGu6+BmwoLMCV3ixWjyLuf3nzWSVHa1GelZIkzOgujhfiZDMQc//DrQvXpK8W6js4XFIVSw9f
	ataRdpKLHWEe+nT8yRRtU80rvz0K8PLL4ZQyXYJtwHMyBQDvrdd5KjNueebXpxJhs2psVSd4mJN94
	u4V7xjtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6T8-0000000Bl9Y-3nt9;
	Fri, 10 Apr 2026 07:39:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6T6-0000000Bl6W-2DIb
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 07:39:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775806795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eWrIywFrS+62GNyPsS0dezlJg/iXu6nQsIf8NoPoG0=;
	b=RQeKhck7zfg+nMl+3QOkRKjC08XZa7w1ux5cYVfkRBYdQ6gYdzyO+Z0uP/kSrv5ZCR/Xns
	yYmNGzPtNEthO+P9Vj145dia9ZvdkZ8naQd438zUEmfzYHnhYQutlLL8IX/49NOA0M+W7H
	rOZwqk7HZIM8KPCOrPL/Bn5hBJkhhKw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-NcxwDrD4NKC3Xb75ndQAkg-1; Fri,
 10 Apr 2026 03:39:52 -0400
X-MC-Unique: NcxwDrD4NKC3Xb75ndQAkg-1
X-Mimecast-MFC-AGG-ID: NcxwDrD4NKC3Xb75ndQAkg_1775806790
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4B4419560A3;
	Fri, 10 Apr 2026 07:39:50 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41C101801AD0;
	Fri, 10 Apr 2026 07:39:47 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mheyne@amazon.de,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@arkamax.eu,
	mkhalfella@purestorage.com,
	chaitanyak@nvidia.com,
	hare@kernel.org,
	hch@lst.de
Subject: [PATCH V3 5/8] nvme: use per controller timeout waits over depending on global default
Date: Fri, 10 Apr 2026 09:39:21 +0200
Message-ID: <20260410073924.61078-6-mlombard@redhat.com>
In-Reply-To: <20260410073924.61078-1-mlombard@redhat.com>
References: <20260410073924.61078-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AJg6HRTjyFjX9w66rszCaGWVuRyCpuse3l21WREedxE_1775806790
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_003956_638086_73D8653B 
X-CRM114-Status: GOOD (  11.86  )
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

Instead of passing NVME_IO_TIMEOUT as a parameter with every call to
nvme_wait_freeze_timeout, use the controller's preferred timeout.

Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/apple.c | 2 +-
 drivers/nvme/host/core.c  | 5 +++--
 drivers/nvme/host/nvme.h  | 2 +-
 drivers/nvme/host/pci.c   | 2 +-
 drivers/nvme/host/rdma.c  | 2 +-
 drivers/nvme/host/tcp.c   | 2 +-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index ed61b97fde59..1958f39484d9 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -858,7 +858,7 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 	 * doing a safe shutdown.
 	 */
 	if (!dead && shutdown && freeze)
-		nvme_wait_freeze_timeout(&anv->ctrl, NVME_IO_TIMEOUT);
+		nvme_wait_freeze_timeout(&anv->ctrl);
 
 	nvme_quiesce_io_queues(&anv->ctrl);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1b676fd4d454..f801d5475cd6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5244,8 +5244,9 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
-int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
+int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl)
 {
+	unsigned long timeout = ctrl->io_timeout;
 	struct nvme_ns *ns;
 	int srcu_idx;
 
@@ -5253,7 +5254,7 @@ int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
 				 srcu_read_lock_held(&ctrl->srcu)) {
 		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
-		if (timeout <= 0)
+		if (!timeout)
 			break;
 	}
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a6d998c2e0e5..9ccaed0b9dbf 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -902,7 +902,7 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
-int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
+int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 static inline enum req_op nvme_req_op(struct nvme_command *cmd)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 379c75c6d35a..dcc554895429 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3273,7 +3273,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		 * if doing a safe shutdown.
 		 */
 		if (!dead && shutdown)
-			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
+			nvme_wait_freeze_timeout(&dev->ctrl);
 	}
 
 	nvme_quiesce_io_queues(&dev->ctrl);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f77c960f7632..bf73135c1439 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -888,7 +888,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 	if (!new) {
 		nvme_start_freeze(&ctrl->ctrl);
 		nvme_unquiesce_io_queues(&ctrl->ctrl);
-		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
+		if (!nvme_wait_freeze_timeout(&ctrl->ctrl)) {
 			/*
 			 * If we timed out waiting for freeze we are likely to
 			 * be stuck.  Fail the controller initialization just
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 02c95c32b07e..e921130ec25f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2194,7 +2194,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	if (!new) {
 		nvme_start_freeze(ctrl);
 		nvme_unquiesce_io_queues(ctrl);
-		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
+		if (!nvme_wait_freeze_timeout(ctrl)) {
 			/*
 			 * If we timed out waiting for freeze we are likely to
 			 * be stuck.  Fail the controller initialization just
-- 
2.53.0


