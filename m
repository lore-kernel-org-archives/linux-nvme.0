Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49546EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OrGOHwUvVCHIPFTnIzT2FxebPW9DsMQFnupZBbKGLgU=; b=JcEw0KxX1woPRE9sLi7lDdGGml
	lXrsXVXZ1mRXvVDs8LRYbKtnunztOm+o6dblocox68HxjvmC6CjifaI3C2w2VlDpoiB7EFjRIU61S
	a0fYo+fUY+DKX/UyRIFt3t1QMf9yjscssin+yU6ML3hmBcNEW7shwPCR8coWLVl+SZs1d8/GLfK1u
	F2IaqlWcrdAdT97WcS81cAgQkly/QhMiRg6c0uDw+zagjE9LqeHqammE2lr7qztdtcYHy8fx8AykM
	kzz55JVwMvZYnWClKkHQvXGyC5guszsCJd3AuD5eJCM2MY+W65wukFfEjxoFScrPJ5efWTW7Iz/Cg
	szYf+RHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9o2z-00F9Nq-28;
	Thu, 15 Jun 2023 14:34:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9o2x-00F9M5-25
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 14:34:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686839638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrGOHwUvVCHIPFTnIzT2FxebPW9DsMQFnupZBbKGLgU=;
	b=MNJTfe0OrD0wCh8R/FXEtozevsScjzRYMTxxNfJrLDcsthHWMexXrrJ+rce2K/0ExhkdJJ
	kGKPkhhavMlMQrJu+a2U2v87j/L2aM3ru9VeffIG+oXLqoARs0REXc9JeGhsolImY7I1hV
	Gorba/iHyUXL0DcawtIAUbSdyT3sI7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-8YhGaOtjO8S5rL-1hc7tsg-1; Thu, 15 Jun 2023 10:33:41 -0400
X-MC-Unique: 8YhGaOtjO8S5rL-1hc7tsg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96AB88352DB;
	Thu, 15 Jun 2023 14:32:58 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AFCA440C20F4;
	Thu, 15 Jun 2023 14:32:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/4] nvme: unquiesce io queues when removing namespaces
Date: Thu, 15 Jun 2023 22:32:36 +0800
Message-Id: <20230615143236.297456-5-ming.lei@redhat.com>
In-Reply-To: <20230615143236.297456-1-ming.lei@redhat.com>
References: <20230615143236.297456-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_073359_759140_9926E24D 
X-CRM114-Status: GOOD (  16.95  )
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

Error recovery can be interrupted by controller removal, then the
controller is left as quiesced, and IO hang can be caused.

Fix the issue by unquiescing controller unconditionally when removing
namespaces.

Reported-by: Chunguang Xu <brookxu.cn@gmail.com>
Closes: https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ec7bd33b7e5f..6d58b30ea835 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4648,6 +4648,12 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	/* unfreeze queues which may be frozen from error recovery */
 	nvme_unfreeze_force(ctrl);
 
+	/*
+	 * Unquiesce io queues so any pending IO won't hang, especially
+	 * those submitted from scan work
+	 */
+	nvme_unquiesce_io_queues(ctrl);
+
 	/* prevent racing with ns scanning */
 	flush_work(&ctrl->scan_work);
 
@@ -4657,10 +4663,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 * removing the namespaces' disks; fail all the queues now to avoid
 	 * potentially having to clean up the failed sync later.
 	 */
-	if (ctrl->state == NVME_CTRL_DEAD) {
+	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_mark_namespaces_dead(ctrl);
-		nvme_unquiesce_io_queues(ctrl);
-	}
 
 	/* this is a no-op when called from the controller reset handler */
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
-- 
2.40.1


