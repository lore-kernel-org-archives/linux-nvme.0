Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFC3E9904A
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 07:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rRKUOyrUASXElE3+z8OE2ycES92LiexFJkmFrYKvp0c=; b=bbhhjuaRFMb7/3mlNHPSrGFzTk
	vv/cxCCnn8QLN22MlqXTesKZcJzYpdD2ljIy8IfndlDRLfSwM/VBM1cOAjH7dEGghCuZPcD6WzbRC
	ZbhDFp/m4ajbRP/ch0y0O+s/xjH71AQ0xzY2KsEIug3DqE9tDhwbZz98hJ0eBGPLMI+8SZVyMRiL2
	H8rL19qkQGQWp03sZgq9iFWi3r3UPKFpHMAoiOBO0o2kc2xeK+ag5BBg8J6s7g6CFKsOXCHUu7/6j
	ImexfUv5IqIydOagRE/mUAi9maKmDAszmauR0LJzUTZkd1Jjg/iUBeumc4Od5x6vJT2V443Do7hyf
	swG9ZFOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6TE-0000000BlEW-12UL;
	Fri, 10 Apr 2026 07:40:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6TB-0000000BlBO-0AB0
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 07:40:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775806800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRKUOyrUASXElE3+z8OE2ycES92LiexFJkmFrYKvp0c=;
	b=F2zXXae1bMFbrXI96fStP7I/EZYjVCVN1GNbUKNXnmWAZhIqlxMvZDTdf6mkhgNAjHKYhT
	LhmOMdkkN1QJ73vG2H3fQxPudHsUtk6GUMvBgkMrIARbqh1QVAAls9N20XdNZWzzO7NFRi
	Ns/P2ua1hxAIhhxncT6nWc8s/hswv7g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-T_vt5o5ePO-ta4UJ3LtT1A-1; Fri,
 10 Apr 2026 03:39:56 -0400
X-MC-Unique: T_vt5o5ePO-ta4UJ3LtT1A-1
X-Mimecast-MFC-AGG-ID: T_vt5o5ePO-ta4UJ3LtT1A_1775806795
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98D081800371;
	Fri, 10 Apr 2026 07:39:54 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 494501800B7F;
	Fri, 10 Apr 2026 07:39:51 +0000 (UTC)
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
Subject: [PATCH V3 6/8] nvme-core: align fabrics_q teardown with admin_q in nvme_free_ctrl
Date: Fri, 10 Apr 2026 09:39:22 +0200
Message-ID: <20260410073924.61078-7-mlombard@redhat.com>
In-Reply-To: <20260410073924.61078-1-mlombard@redhat.com>
References: <20260410073924.61078-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _A9gFUZ53-1QjAhcwCIi8KscmyPxYi_9W7H9el9y0ks_1775806795
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_004001_150861_6A4EE549 
X-CRM114-Status: GOOD (  10.96  )
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

Currently, the final reference for the fabrics admin queue (fabrics_q)
is dropped inside nvme_remove_admin_tag_set(). However, the primary
admin queue (admin_q) defers dropping its final reference until
nvme_free_ctrl().

Move the blk_put_queue() call for fabrics_q from nvme_remove_admin_tag_set()
to nvme_free_ctrl(). This aligns the lifecycle management of both admin
queues, ensuring they are freed symmetrically when the controller is finally
torn down.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f801d5475cd6..f3aa7b29d2a2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4927,10 +4927,8 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
 	 */
 	nvme_stop_keep_alive(ctrl);
 	blk_mq_destroy_queue(ctrl->admin_q);
-	if (ctrl->ops->flags & NVME_F_FABRICS) {
+	if (ctrl->ops->flags & NVME_F_FABRICS)
 		blk_mq_destroy_queue(ctrl->fabrics_q);
-		blk_put_queue(ctrl->fabrics_q);
-	}
 	blk_mq_free_tag_set(ctrl->admin_tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_admin_tag_set);
@@ -5072,6 +5070,8 @@ static void nvme_free_ctrl(struct device *dev)
 
 	if (ctrl->admin_q)
 		blk_put_queue(ctrl->admin_q);
+	if (ctrl->fabrics_q)
+		blk_put_queue(ctrl->fabrics_q);
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
 	nvme_free_cels(ctrl);
-- 
2.53.0


