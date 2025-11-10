Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B641CCF9E3
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Nov 2025 21:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CqbdrlaMc3Jk8JpenOWMbSfatSrNtvvxxieQXTOmSxo=; b=WH4FOVOehjLXonZ0y9he/Uljgu
	dZn3MwttvkyrkStoijJSA8FllCbZ6b2zPPVXJQBNX4bofTlijvw9f5k4FYAbuMbboTKAIDhzMumjd
	UfgtRUaxR/7+BjDxKjOHk8BoxBfD8n/z3+vsKfW/AjpJPsFnrmjPeX7s/9q0bGtIlx7xk3xZO8KQI
	ebDHEdGIKJrXbp/1WAvF7hr9lUkBX+JLjHA2BPGLMkCC+alKPmsxK3PSxRQYF1VB1hCB3J4deSTRr
	c+9krliaB/f5nh2PACG/jQZ+mV71UkojutOpnxtANgp6rXS9MIY9Jctk3VksMEcu1CsCe9ocQK4wp
	1IEXsc/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIZJN-000000069aj-2ZrK;
	Mon, 10 Nov 2025 21:20:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIZJL-000000069aC-2Wk2
	for linux-nvme@lists.infradead.org;
	Mon, 10 Nov 2025 21:20:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762809626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqbdrlaMc3Jk8JpenOWMbSfatSrNtvvxxieQXTOmSxo=;
	b=SBtFK4y5d9TdxFFuamr6mI1dPs3y1a+hGQLJA0GYNJPTZeDMfA/18nSVDEuXR+pIJOt3jb
	F+i+samMxZRxGoySv/8sqdKWKS0Y5SyRWWxUxdnAz2Z2ImBgu8t8//CV1LS2reW6aXcFBb
	NDwY5ciyaEoqpCiIu/CJtpXwD60KJIc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-OW3wz_ZXNEe33dtCVjHiHQ-1; Mon,
 10 Nov 2025 16:20:16 -0500
X-MC-Unique: OW3wz_ZXNEe33dtCVjHiHQ-1
X-Mimecast-MFC-AGG-ID: OW3wz_ZXNEe33dtCVjHiHQ_1762809614
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C992F195609D;
	Mon, 10 Nov 2025 21:20:13 +0000 (UTC)
Received: from emilne-na.westford.csb (unknown [10.45.224.56])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE81E19560B7;
	Mon, 10 Nov 2025 21:20:08 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: mpatalan@redhat.com,
	james.smart@broadcom.com,
	paul.ely@broadcom.com,
	justin.tee@broadcom.com,
	sagi@grimberg.me,
	njavali@marvell.com,
	ming.lei@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] nvme: nvme-fc: move tagset removal to nvme_fc_delete_ctrl()
Date: Mon, 10 Nov 2025 16:20:00 -0500
Message-ID: <20251110212001.6318-2-emilne@redhat.com>
In-Reply-To: <20251110212001.6318-1-emilne@redhat.com>
References: <20251110212001.6318-1-emilne@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251110_132027_712268_0F17758B 
X-CRM114-Status: GOOD (  14.20  )
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

Now target is removed from nvme_fc_ctrl_free() which is the ctrl->ref
release handler. And even admin queue is unquiesced there, this way
is definitely wrong because the ctr->ref is grabbed when submitting
command.

And Marco observed that nvme_fc_ctrl_free() can be called from request
completion code path, and trigger kernel warning since request completes
from softirq context.

Fix the issue by moveing target removal into nvme_fc_delete_ctrl(),
which is also aligned with nvme-tcp and nvme-rdma.

Patch originally proposed by Ming Lei, then modified to move the tagset
removal down to after nvme_fc_delete_association() after further testing.

Cc: Marco Patalano <mpatalan@redhat.com>
Cc: Ewan Milne <emilne@redhat.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Cc: stable@vger.kernel.org
Tested-by: Marco Patalano <mpatalan@redhat.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/nvme/host/fc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b613fc5966a7..9e1841223e8a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2359,17 +2359,11 @@ nvme_fc_ctrl_free(struct kref *ref)
 		container_of(ref, struct nvme_fc_ctrl, ref);
 	unsigned long flags;
 
-	if (ctrl->ctrl.tagset)
-		nvme_remove_io_tag_set(&ctrl->ctrl);
-
 	/* remove from rport list */
 	spin_lock_irqsave(&ctrl->rport->lock, flags);
 	list_del(&ctrl->ctrl_list);
 	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
-	nvme_remove_admin_tag_set(&ctrl->ctrl);
-
 	kfree(ctrl->queues);
 
 	put_device(ctrl->dev);
@@ -3265,11 +3259,18 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 
 	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
+
 	/*
 	 * kill the association on the link side.  this will block
 	 * waiting for io to terminate
 	 */
 	nvme_fc_delete_association(ctrl);
+
+	if (ctrl->ctrl.tagset)
+		nvme_remove_io_tag_set(&ctrl->ctrl);
+
+	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+	nvme_remove_admin_tag_set(&ctrl->ctrl);
 }
 
 static void
-- 
2.43.0


