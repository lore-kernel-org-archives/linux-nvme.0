Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04630C282C2
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 15:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5Od+B2pfXQ72Za3W42/ficdFY+IP7zAgMGPOlwvZIqo=; b=zlgsN3kLXRy9c554cfKNw+wFSb
	tMeWyoIhk7aAOOftvnm6SSmMHdhdnmlK0RsMhuNMfYQxgZPlHLLItGchxtNqjut6zdWSKomEuaako
	0mXDugE8udxvHOrbo62xoksMviO2IYK6gahtDhNC5X6rVFwaUqsJ1BrV+BTiDA4KksHrm3HDYmdxG
	TKAmsBEieY9ra8jmQzrwD/Z8hgNG0FUNnShcuNDvXZY0hJynKr4EYw1BXCWMhDUilLIU0cM3ARcPv
	MRqBC6YehgTIFU9AmFMZGUi6cbxjzgRM9OyWbzcyOA5s2JLXnIe3qY4zOJUgmDq/cp7ZgExYzNv3+
	bEkseALQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJEt-00000004FOm-1XNW;
	Wed, 26 Feb 2025 15:22:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnHgF-00000003xPI-2027
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 13:42:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740577348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Od+B2pfXQ72Za3W42/ficdFY+IP7zAgMGPOlwvZIqo=;
	b=gbTTsY5eg8lCISE9lYysQWLKWcYVWCIShHYC0SN18am0x4Y1XEJQEexrYugrNBjT3Bm4QP
	Hrtu0xK6h0/wvZvf4HstfnRU9jJu4a2ZUci1GgZcXk51eFDfMQ56e0b1znpihRnkwlPcDt
	bDgLlzNEri9XigF8kzLla2joJAUfILU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-C1dfEIX0PrSNGI-zJLJhtg-1; Wed,
 26 Feb 2025 08:42:24 -0500
X-MC-Unique: C1dfEIX0PrSNGI-zJLJhtg-1
X-Mimecast-MFC-AGG-ID: C1dfEIX0PrSNGI-zJLJhtg_1740577343
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF1C619039C5;
	Wed, 26 Feb 2025 13:42:22 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.45.224.117])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13BC419560AB;
	Wed, 26 Feb 2025 13:42:19 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	hare@kernel.org,
	mlombard@bsdbackstore.eu
Subject: [PATCH] nvme-tcp: fix potential memory corruption in nvme_tcp_recv_pdu()
Date: Wed, 26 Feb 2025 14:42:18 +0100
Message-ID: <20250226134218.800559-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h4s4zt5PWV6bijFWGYp0S8mqYC1MGlGna14HMzJaxCY_1740577343
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_054231_585001_8CBFFCA8 
X-CRM114-Status: GOOD (  14.51  )
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

nvme_tcp_recv_pdu() doesn't check the validity of the header length.
When header digests are enabled, a target might send a packet with an
invalid header length (e.g. 255), causing nvme_tcp_verify_hdgst()
to access memory outside the allocated area and cause memory corruptions
by overwriting it with the calculated digest.

Fix this by rejecting packets with an unexpected header length.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/tcp.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8a9131c95a3d..ade7f1af33d8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -217,6 +217,19 @@ static inline int nvme_tcp_queue_id(struct nvme_tcp_queue *queue)
 	return queue - queue->ctrl->queues;
 }
 
+static inline bool nvme_tcp_recv_pdu_supported(enum nvme_tcp_pdu_type type)
+{
+	switch (type) {
+	case nvme_tcp_c2h_term:
+	case nvme_tcp_c2h_data:
+	case nvme_tcp_r2t:
+	case nvme_tcp_rsp:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * Check if the queue is TLS encrypted
  */
@@ -818,6 +831,16 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		return 0;
 
 	hdr = queue->pdu;
+	if (unlikely(hdr->hlen != sizeof(struct nvme_tcp_rsp_pdu))) {
+		if (!nvme_tcp_recv_pdu_supported(hdr->type))
+			goto unsupported_pdu;
+
+		dev_err(queue->ctrl->ctrl.device,
+			"pdu type %d has unexpected header length (%d)\n",
+			hdr->type, hdr->hlen);
+		return -EPROTO;
+	}
+
 	if (unlikely(hdr->type == nvme_tcp_c2h_term)) {
 		/*
 		 * C2HTermReq never includes Header or Data digests.
@@ -850,10 +873,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_tcp_init_recv_ctx(queue);
 		return nvme_tcp_handle_r2t(queue, (void *)queue->pdu);
 	default:
-		dev_err(queue->ctrl->ctrl.device,
-			"unsupported pdu type (%d)\n", hdr->type);
-		return -EINVAL;
+		goto unsupported_pdu;
 	}
+
+unsupported_pdu:
+	dev_err(queue->ctrl->ctrl.device,
+		"unsupported pdu type (%d)\n", hdr->type);
+	return -EINVAL;
 }
 
 static inline void nvme_tcp_end_request(struct request *rq, u16 status)
-- 
2.43.5


