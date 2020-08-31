Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196D6C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 18:44:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3812071B
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 18:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B6CDGoAG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DROQwDMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3812071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Fkjnqt7EPhUJulfGinEPjk5ZWjmbkRVQrJbgR9srtpU=; b=B6CDGoAGwsm3Ogsn9pPWvNzzFJ
	eDkfUB39tpBX2FJppQIqBy1yrojm2y3Wu50bc0IYndaG1hB1HUKSot4WHnFgrRN26OoNAToteAZz8
	5W5C6dSF/G7TH9MGcMaHH6Bl30CWZsuxx935NLTCepmLIYYB3+mdEw7ptqVJt8utkmnrzxYaPxcdq
	zP2HaKsRy0wMQMU5h3P7DneRvsYQbBQlYdOK0fyyLcmp926ikXki4zs7JPgMryC2G/DOsyoH3vlK7
	x+iYG/Augk3vyPVmVfSMI2YjK4fw7YcPLXwD366WzUt2BDfkuXsJGGP+Knt+hX0XWD6QAgV5NLicg
	1qwcSumw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCon9-000422-4o; Mon, 31 Aug 2020 18:44:31 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCon5-00041a-K1
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 18:44:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598899465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type;
 bh=ytiFD1pS1HaoUD70jKQKEulrT9n23jAP18kGqv6QDtM=;
 b=DROQwDMJB7A5LgFYNT80q6LOHybZ5q9buPljYe1NEfTHj5gnf9U+/1gaNIZHRuuajZ9/yY
 naw9a/YdQiyEYvUMjawcCk+7agv1biqvrOaW/PX7uWxGmLUpD9sa9NgCL3yTM8amb73Pg6
 RKOQMj8RG3WZuSclNYNkksy+DWfTGt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-jC2bkvPTOxm4fVaqpg5ZkA-1; Mon, 31 Aug 2020 14:44:21 -0400
X-MC-Unique: jC2bkvPTOxm4fVaqpg5ZkA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 086F4640C1;
 Mon, 31 Aug 2020 18:44:20 +0000 (UTC)
Received: from hpz440.redhat.com (ovpn-113-65.rdu2.redhat.com [10.10.113.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FC125C1BB;
 Mon, 31 Aug 2020 18:44:19 +0000 (UTC)
From: David Milburn <dmilburn@redhat.com>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCH] nvme-rdma: flush async events before freeing qe
Date: Mon, 31 Aug 2020 13:44:18 -0500
Message-Id: <1598899458-15153-1-git-send-email-dmilburn@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dmilburn@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_144427_698161_DE4AF806 
X-CRM114-Status: GOOD (  11.36  )
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

Flush async event workqueue in case async event has been
queued up before freeing qe and setting ctrl->async_event_sqe.data
to NULL. Otherwise, we can get into a state were nvme_rdma_submit_
async_event() runs with sqe->data set to NULL leading to crash.

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8e5ffe2f117d..76f117462d5b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -835,6 +835,7 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
 	}
 	if (ctrl->async_event_sqe.data) {
+		flush_work(&ctrl->ctrl.async_event_work);
 		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
 				sizeof(struct nvme_command), DMA_TO_DEVICE);
 		ctrl->async_event_sqe.data = NULL;
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
