Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E584EC43461
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 22:43:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50A120758
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 22:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vIU442xW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEa2Eg29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50A120758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bst6bNQ9EZnV2VUUsuluCV/3wakz6YX7r/QE8clXXyY=; b=vIU442xW3YKGC13x/6lq1ZISVn
	Lb9D2lUA+8EvgWAHa+cNLYHLXfaculTBRr3WH++Pps9rRo/NHRIBPfCAgRY8vavFFlKt19HW5QICu
	VmbJjH+qwARZylQidekHJzLSk+jZ/P/KUaizkbFdN4k9TZ9QjtlPmodgVp2qioFlWoeaO9kJkfq5A
	wFVrBBZnF9TT/uXI+68DOEzF366epPL9ajglhCS/kTJaHHef+xzHPrkyL8GNRIpsDOA/npJ0AAtWX
	qw6Af2yYQ2hyBLtGgHG0E1qh5J6ohqSJTa8SYEHl7qJumZacW1xBMbChuZ4IqFSjup6bJAwZDDHIi
	gnO6z0Mw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDbT9-0006li-Ur; Wed, 02 Sep 2020 22:43:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDbT4-0006jJ-72
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 22:43:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=bFLdiWC2nX7vVaaxuyTLcv5u5yht2AKIrSDcJ8V2GtA=;
 b=fEa2Eg29XoT2rJ6g5SyKrkKUg9Vso7TFdyUYTdE5NXUz+SnMegS+DFk4Nug291VLEBb/4j
 WqKzVo/N579iGSTid/0oGsVTYZ9GiktbBTbRuJGsPenVAee5lVHpxoQEbhfD7wWrdRVoN4
 CJ97jyiiz4bzxCj9psV0yG47Lrl5I8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-TkqTBKJZOoW0-ASHZswUbQ-1; Wed, 02 Sep 2020 18:42:57 -0400
X-MC-Unique: TkqTBKJZOoW0-ASHZswUbQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97D2A1DE00;
 Wed,  2 Sep 2020 22:42:56 +0000 (UTC)
Received: from hpz440.redhat.com (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1872360C0F;
 Wed,  2 Sep 2020 22:42:56 +0000 (UTC)
From: David Milburn <dmilburn@redhat.com>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 james.smart@broadcom.com
Subject: [PATCH v3 1/3] nvme-rdma: cancel async events before freeing event
 struct
Date: Wed,  2 Sep 2020 17:42:52 -0500
Message-Id: <1599086574-85969-2-git-send-email-dmilburn@redhat.com>
In-Reply-To: <1599086574-85969-1-git-send-email-dmilburn@redhat.com>
References: <1599086574-85969-1-git-send-email-dmilburn@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dmilburn@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_184302_294962_5CD7C5A7 
X-CRM114-Status: GOOD (  13.04  )
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
up, and nvme_rdma_submit_async_event() runs after event has
been freed.

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
