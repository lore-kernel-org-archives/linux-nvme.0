Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B133FC3601E
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 08:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V3NaaBPbnlL9Ry8zQgQPdksx2lWWriFPXY1wF8vf+8w=; b=0dI596ajE873L5vEgMZ2ULpNMg
	2qf7gi99HQZvPc/8Hs7DU8qyNXUCpvchBX3RQcONA72tSo6BrnLaOGxF6bzCVTwmElE2hdj5KkZy0
	SZC5cKYxA3EBCjgohH+A28ZyIhnxV4awGamVvgGCzqXIHOtKBIzMykGpxVZRAPmfTOl1caqtIkffn
	HFIrzi0wepYUgbzlrXpJbSt+ZNieplKcxxaKz1mSY+2x/sryxeofNQsaQSaqPzvyK87+gppVz1yRP
	+0jJgA/ADjxU+wCc2qKJgurpCNJLhz9naU8u3BfJsV6QltM0tjX/uBO4Mel5KxhaNbRwCTt2lWDct
	WNAOEyxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cPW-0000000B8bC-0fRR;
	Fri, 04 Apr 2025 08:28:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cPT-0000000B8Zg-3QDZ
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 08:28:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743755299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3NaaBPbnlL9Ry8zQgQPdksx2lWWriFPXY1wF8vf+8w=;
	b=ay8A80eo/oVl+y4LRfHVylRe3dBjNhjQilZWb7stRqiikGUr0yeKwhBDQshvXBlWfrJka2
	jD79ECW75yj/yL/OpH/iZj7r3PkBvO+mHnshui/UXKYT7AAFQhGZQgBgKQSeGU1uz253Az
	DhPAVZyCpe08qSibRkaTfYuEhkqnsLA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-wP8xe5MJMoOnY_R9snKmzg-1; Fri,
 04 Apr 2025 04:28:17 -0400
X-MC-Unique: wP8xe5MJMoOnY_R9snKmzg-1
X-Mimecast-MFC-AGG-ID: wP8xe5MJMoOnY_R9snKmzg_1743755296
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 025101954B3E;
	Fri,  4 Apr 2025 08:28:16 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC60E1955BF7;
	Fri,  4 Apr 2025 08:28:12 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	mlombard@bsdbackstore.eu,
	zhang.guanghui@cestc.cn,
	loberman@redhat.com
Subject: [PATCH V4 2/2] nvme-tcp: do not complete the request if send operation fails
Date: Fri,  4 Apr 2025 10:28:01 +0200
Message-ID: <20250404082801.1614252-3-mlombard@redhat.com>
In-Reply-To: <20250404082801.1614252-1-mlombard@redhat.com>
References: <20250404082801.1614252-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e1wNFznYh6-TB7DaiX39fTCMa4y8Fn5dlGUPbENCxgc_1743755296
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_012819_925063_E5B7D599 
X-CRM114-Status: GOOD (  11.69  )
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

In some cases, the send operation may fail even though
the command is successfully received by the target.
The target then sends a command completion capsule back to the host,
leading to double completion and a kernel panic.

To prevent this, do not fail the request; instead, let the
error recovery mechanism clean everything up.

Tested-by: Zhang Guanghui <zhang.guanghui@cestc.cn>
Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/tcp.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f1e2b0417b39..726f24a352fe 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1101,19 +1101,6 @@ static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
 	queue->request = NULL;
 }
 
-static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
-{
-	if (nvme_tcp_async_req(req)) {
-		union nvme_result res = {};
-
-		nvme_complete_async_event(&req->queue->ctrl->ctrl,
-				cpu_to_le16(NVME_SC_HOST_PATH_ERROR), &res);
-	} else {
-		nvme_tcp_end_request(blk_mq_rq_from_pdu(req),
-				NVME_SC_HOST_PATH_ERROR);
-	}
-}
-
 static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
@@ -1327,7 +1314,6 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	} else if (ret < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to send request %d\n", ret);
-		nvme_tcp_fail_request(queue->request);
 		nvme_tcp_done_send_req(queue);
 		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
 	}
-- 
2.43.5


