Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262DEFA375B
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4MGhDbI33Dz5JKvbtcv4lgQFECUNZsq7TZReFY7+5Wk=; b=jPEeVvuslyQ2JI9+Hm/f86hWhp
	AZr9xU48vtw4OawQ/wAcHnivez0st800wqlFrcEY/E9gMB4RcSpaHrNmOu4z0IzLN+kVbrOSeFtv1
	grUAkUGTd67Mhm1O6+6iaSjFYjR3rOpJ4MpmVptDOUI3xmobTbxp3clq3g8O5g0L5uRKBk6zGM4Ng
	QAfiioZL00zmIvmMYPO+61fc2ZL5bsWrHYCOcLhf0Z5p1nJ4XNOf2x/jnxsDZOwi7VvKoL+2a6uzI
	GjzlTLJMafQzP1uxkD0ww34UgHDLjuv0NO2OD0kkUju8OlW0TBFfi6/o5m8XVzEgz55mOHkw3J8Rv
	xZMVf/pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6bl-0000000G4bK-150T;
	Fri, 13 Sep 2024 13:45:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6bf-0000000G4Z8-3KmK
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 13:45:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726235103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4MGhDbI33Dz5JKvbtcv4lgQFECUNZsq7TZReFY7+5Wk=;
	b=gj7ARMrxK9Iievx414wEa9R+AShES4n/X5wvQlRWVmzUJjDt6wRe+euVPks7vEKIVt263H
	Tx36tCvvdU8jG4hluqNA8DfhSvRsRs6m5RLj6oQOx2K3Gc9mtraUtR+7kCkfTrkBswlj9d
	NpwCRfbp18MnQEqh4h07QeMquxt3MKQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-i2gXMJkgNWid-hohhZYQ9Q-1; Fri,
 13 Sep 2024 09:44:57 -0400
X-MC-Unique: i2gXMJkgNWid-hohhZYQ9Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7722219560B2;
	Fri, 13 Sep 2024 13:44:56 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.65.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9D5E30001AB;
	Fri, 13 Sep 2024 13:44:54 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: Keith Busch <kbusch@kernel.org>,
	ens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	David Jeffery <djeffery@redhat.com>
Subject: [PATCH 4/4] nvme: use per device timeout waits over depending on global default value
Date: Fri, 13 Sep 2024 09:44:30 -0400
Message-ID: <20240913134430.5416-5-djeffery@redhat.com>
In-Reply-To: <20240913134430.5416-1-djeffery@redhat.com>
References: <20240913134430.5416-1-djeffery@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_064503_935791_1A8917A7 
X-CRM114-Status: GOOD (  15.69  )
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
nvme_wait_freeze_timeout, use the largest timeout value from all the
namespaces for the nvme controller. This will match the wait to the
configuration of the devices instead of assuming a single value can
fulfill the needs of all devices on the system.

Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/nvme/host/apple.c |  2 +-
 drivers/nvme/host/core.c  | 10 +++++++++-
 drivers/nvme/host/nvme.h  |  2 +-
 drivers/nvme/host/pci.c   |  2 +-
 drivers/nvme/host/rdma.c  |  2 +-
 drivers/nvme/host/tcp.c   |  2 +-
 6 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index b1387dc459a3..37333de2accc 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -820,7 +820,7 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 	 * doing a safe shutdown.
 	 */
 	if (!dead && shutdown && freeze)
-		nvme_wait_freeze_timeout(&anv->ctrl, NVME_IO_TIMEOUT);
+		nvme_wait_freeze_timeout(&anv->ctrl);
 
 	nvme_quiesce_io_queues(&anv->ctrl);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7ad83d443101..398e1f5de33f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4843,12 +4843,20 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
-int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
+int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 	int srcu_idx;
+	long timeout = 0;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
+
+	/* find largest I/O timeout */
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+		if (ns->queue->rq_timeout > timeout)
+			timeout = ns->queue->rq_timeout;
+	}
+
 	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
 		if (timeout <= 0)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index da57947130cc..859b70733b99 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -813,7 +813,7 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
-int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
+int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 static inline enum req_op nvme_req_op(struct nvme_command *cmd)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 823476f4e42f..43d0ac4a5065 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2646,7 +2646,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		 * if doing a safe shutdown.
 		 */
 		if (!dead && shutdown)
-			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
+			nvme_wait_freeze_timeout(&dev->ctrl);
 	}
 
 	nvme_quiesce_io_queues(&dev->ctrl);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2eb33842f971..ac9c788ad5a2 100644
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
index a2a47d3ab99f..641202eca0b5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2040,7 +2040,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	if (!new) {
 		nvme_start_freeze(ctrl);
 		nvme_unquiesce_io_queues(ctrl);
-		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
+		if (!nvme_wait_freeze_timeout(ctrl)) {
 			/*
 			 * If we timed out waiting for freeze we are likely to
 			 * be stuck.  Fail the controller initialization just
-- 
2.46.0


