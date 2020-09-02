Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981F1C433E2
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 19:46:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6614420758
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 19:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XowVw6Ho";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZ0yAZ+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6614420758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AGdBG2u45GfUwMRXePkksw+g+Vc8eLKXiHy5T1kez9I=; b=XowVw6Hoq/to6xHWAeT83jlq8I
	MNBoexAmrdsktuElqXOrvExSU8fjBxI3axSpEaL9TYBw5tU7oIsvCgXkWOupEydF/HYvfiXTsGNRE
	xF1H6syaaajmW709zrh4H3NrcNt7bAdLk+UFZuN5Xuw/eXKybJSvivYUZY2PqSw6i0hSueIzjaQoH
	0rdi3/xe2P/54X4hqoaZnrQbsnVjazgah+1t7DMRXuXa3OiNchCPfEarG0GFLArqD9c42MCDISFEB
	p8XcftQnS2O9/jLh1/9OQN+xnlNoMtHFg/75hgiPjo7DdWO7cG/DBckJB3IbhSK+X5UUnspmOpOG2
	UatFHYNA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDYiM-0003JY-QE; Wed, 02 Sep 2020 19:46:38 +0000
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDYiK-0003J0-Kn
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 19:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599075995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type;
 bh=4O8ev40dFyNC7HUF05HFMoAB9+QQ2N/03PjUTMuS64E=;
 b=bZ0yAZ+OIAC375Q8VNQHmf3hQH5HRcOi4Xa6dtF2ycPMAq6LaxBP0V/7S6YJo+0lYNuO1Z
 zmkrIBRr+biB3uHf1mugS10SthE66cbMmJZQSk67yX2AsWiGOebXNO/RdNkSl5PyzpxF+Z
 E3s0yk6fhEoaR5SGU0Wsx8snZm/qS8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-46JR99uaM9aMQkTjRCLAOw-1; Wed, 02 Sep 2020 15:46:28 -0400
X-MC-Unique: 46JR99uaM9aMQkTjRCLAOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 828A8E75D;
 Wed,  2 Sep 2020 19:46:27 +0000 (UTC)
Received: from hpz440.redhat.com (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4E787EEB6;
 Wed,  2 Sep 2020 19:46:26 +0000 (UTC)
From: David Milburn <dmilburn@redhat.com>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 james.smart@broadcom.com
Subject: [PATCH v2] nvme: cancel async events before freeing event struct
Date: Wed,  2 Sep 2020 14:46:25 -0500
Message-Id: <1599075985-70180-1-git-send-email-dmilburn@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dmilburn@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_154636_709615_81B54CC4 
X-CRM114-Status: GOOD (  12.05  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cancel async event work in case async event has been queued
up, and transport trys to submit event after it has been freed.

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/nvme/host/fc.c   | 1 +
 drivers/nvme/host/rdma.c | 1 +
 drivers/nvme/host/tcp.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a7f474ddfff7..e8ef42b9d50c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2160,6 +2160,7 @@ nvme_fc_term_aen_ops(struct nvme_fc_ctrl *ctrl)
 	struct nvme_fc_fcp_op *aen_op;
 	int i;
 
+	cancel_work_sync(&ctrl->ctrl.async_event_work);
 	aen_op = ctrl->aen_ops;
 	for (i = 0; i < NVME_NR_AEN_COMMANDS; i++, aen_op++) {
 		__nvme_fc_exit_request(ctrl, aen_op);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8e5ffe2f117d..9e378d0a0c01 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -835,6 +835,7 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
 	}
 	if (ctrl->async_event_sqe.data) {
+		cancel_work_sync(&ctrl->ctrl.async_event_work);
 		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
 				sizeof(struct nvme_command), DMA_TO_DEVICE);
 		ctrl->async_event_sqe.data = NULL;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 16851ae3bddf..8f4f29f18b8c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1596,6 +1596,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 static void nvme_tcp_free_admin_queue(struct nvme_ctrl *ctrl)
 {
 	if (to_tcp_ctrl(ctrl)->async_req.pdu) {
+		cancel_work_sync(&ctrl->async_event_work);
 		nvme_tcp_free_async_req(to_tcp_ctrl(ctrl));
 		to_tcp_ctrl(ctrl)->async_req.pdu = NULL;
 	}
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
