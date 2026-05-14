Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F27BCD4851
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 08:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kl8oYHOa+9QeXk0zlcbCA7YB/ZcqkYf/81401hTaUNc=; b=P0SKmXUckXbk2ZINGF71AZNak/
	eWck6IPIqtww2rDHW04O54+eLqCjZIP88Uw/LP4Y20r31jApMWeN5TINB5Kp85x8eW31821hN9FRz
	0VwYuBOeoZ9qShcieG8rMWFGFKZ1E6OI2PZmEjwC7SuQX+8AnbJDXg+fjDSYkq+yE6aZUVrqfDDQq
	Btr8FPcgV8VKZLa6I1au6KX5TNHW3kG9IpjxzRE1nToQN9sYjdL/nuPQ0RY7RAUspXenggUi4Ybl0
	Oyy04VgrgjMwTJ7yaNx8n8/ia37S5P1MyV+k1rAFNvUbBFhvRNrVYhG27VL0y3KyASMpGIwIy5TlH
	xCzv0dqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNRVN-00000004wwa-22Cw;
	Thu, 14 May 2026 08:33:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNRVK-00000004wuY-0mvs
	for linux-nvme@lists.infradead.org;
	Thu, 14 May 2026 08:33:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778747593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kl8oYHOa+9QeXk0zlcbCA7YB/ZcqkYf/81401hTaUNc=;
	b=IIjVJwP4LlfGKYZyeugGI/TD3RCMlmYbyy0AbBNy3OMWm1cEn21SR+Q1bo1baYPOfoUxWH
	hlSVnnBeGGrYdZaldpeof++jlLGFKauIfHQQWMcUd+57DGmIyVXo/enxHoKHY9u6tDZZAp
	PwX2H/B69coY3r+NQO1Zu94gzQlIcFw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-DUG1DtI-OaKldTTLd2_giQ-1; Thu,
 14 May 2026 04:33:11 -0400
X-MC-Unique: DUG1DtI-OaKldTTLd2_giQ-1
X-Mimecast-MFC-AGG-ID: DUG1DtI-OaKldTTLd2_giQ_1778747589
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64E15195609E;
	Thu, 14 May 2026 08:33:09 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.48.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBFB11956053;
	Thu, 14 May 2026 08:33:05 +0000 (UTC)
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
Subject: [PATCH V5 2/7] nvme: remove redundant timeout argument from nvme_wait_freeze_timeout
Date: Thu, 14 May 2026 10:32:50 +0200
Message-ID: <20260514083255.41109-3-mlombard@redhat.com>
In-Reply-To: <20260514083255.41109-1-mlombard@redhat.com>
References: <20260514083255.41109-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oXmEhkjYpoqVeMiSPaiE8EXeDTA3Zqny9v0-VZROtCc_1778747589
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_013314_296645_687E1459 
X-CRM114-Status: GOOD (  12.05  )
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

All callers of nvme_wait_freeze_timeout() currently pass the exact same
NVME_IO_TIMEOUT default as their timeout argument.

Remove it and use a local variable.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/apple.c | 2 +-
 drivers/nvme/host/core.c  | 3 ++-
 drivers/nvme/host/nvme.h  | 2 +-
 drivers/nvme/host/pci.c   | 2 +-
 drivers/nvme/host/rdma.c  | 2 +-
 drivers/nvme/host/tcp.c   | 2 +-
 6 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 423c9c628e7b..e77c47408102 100644
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
index 6c75253d2866..84f295e3bf08 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5250,8 +5250,9 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
-int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
+int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl)
 {
+	unsigned long timeout = NVME_IO_TIMEOUT;
 	struct nvme_ns *ns;
 	int srcu_idx;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ccd5e05dac98..6f9ecb4948f4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -900,7 +900,7 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
-int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
+int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 static inline enum req_op nvme_req_op(struct nvme_command *cmd)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 139a10cd687f..8dc353451b21 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3278,7 +3278,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
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
index 15d36d6a728e..0552aa8a1150 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2208,7 +2208,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	if (!new) {
 		nvme_start_freeze(ctrl);
 		nvme_unquiesce_io_queues(ctrl);
-		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
+		if (!nvme_wait_freeze_timeout(ctrl)) {
 			/*
 			 * If we timed out waiting for freeze we are likely to
 			 * be stuck.  Fail the controller initialization just
-- 
2.54.0


