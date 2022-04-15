Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6ADC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 10:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=A90Q+YMzjvMm9/J0jnNJFJBklk/e7sSOjiIos3qoYjs=; b=JWhWF7gX+DSX18d43kbcTZEsZ7
	SPpzolUmA8N20oqPcKNKQV2FBiCVamxs0zHpqhwSOkM5SrAAoFeQ1O4BTX9kedqlpUGsPNaUSpHMX
	y3L56CXTxL9WMYKvvUPK4jRkwoh86vD/U81CCd2kqB8BiRj+5AcNKeps9asXYh35u3LPq0Co/iaEx
	LoeIoS64KMogqWueN92lQs7i55XhWgMkFh7ztEExQJDTDTMtqp8bM0XQnnrSdO2ut2pxIboe/t4TM
	LlZJNjS96BVgDY1VqP93ZPn151yTOD+PmRoNhOtUHwWOiKsdIVLRnddRcJeCmOiAEfFIEWvj3DPqo
	H1EBWGBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfJ0F-009aYJ-2H; Fri, 15 Apr 2022 10:16:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfJ0D-009aXb-00
 for linux-nvme@lists.infradead.org; Fri, 15 Apr 2022 10:16:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650017790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A90Q+YMzjvMm9/J0jnNJFJBklk/e7sSOjiIos3qoYjs=;
 b=H+ZBVWJszaGfRzUqPCripMNujexleSk4Ko76KjfHnLhIEb4iNiQFLIJvKATnh8+8z1ziD9
 XA1i6sD0BbaX9T/g3OJ96i9iZyYiwEMxoGj2UAR9SJq3AZo2gEwyS2Bds2xi8XFU79oWzb
 xGxVgcMKOoLrEGkpSEOFYMC+l78WHS0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-JIFyrypHN1-n9W_gizBRxQ-1; Fri, 15 Apr 2022 06:14:39 -0400
X-MC-Unique: JIFyrypHN1-n9W_gizBRxQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 716CA3C14CC9;
 Fri, 15 Apr 2022 10:14:39 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.193.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63E37111F3B6;
 Fri, 15 Apr 2022 10:14:38 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me,
	kbusch@kernel.org,
	cleech@redhat.com
Subject: [PATCH] nvme-host: tcp: do not read from the socket if we are
 performing a reset
Date: Fri, 15 Apr 2022 12:14:37 +0200
Message-Id: <20220415101437.292254-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220415_031633_138910_47771721 
X-CRM114-Status: GOOD (  14.28  )
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

nvme_tcp_io_work() may be scheduled while the controller is resetting,
triggering kernel crashes because of invalid memory accesses.

general protection fault, probably for non-canonical
address 0x82f4228d6e5c6

 [exception RIP: _copy_to_iter+1344]
 [ffffa8a9e5c07c90] __skb_datagram_iter at ffffffffb0c339d8
 [ffffa8a9e5c07cf8] skb_copy_datagram_iter at ffffffffb0c33c83
 [ffffa8a9e5c07d28] nvme_tcp_recv_data at ffffffffc04dbff7 [nvme_tcp]
 [ffffa8a9e5c07d78] nvme_tcp_recv_skb at ffffffffc04dc90e [nvme_tcp]
 [ffffa8a9e5c07dc0] tcp_read_sock at ffffffffb0cfedbe
 [ffffa8a9e5c07e10] nvme_tcp_try_recv at ffffffffc04da518 [nvme_tcp]
 [ffffa8a9e5c07e58] nvme_tcp_io_work at ffffffffc04dbc54 [nvme_tcp]
 [ffffa8a9e5c07e88] process_one_work at ffffffffb0505408
 [ffffa8a9e5c07ed0] worker_thread at ffffffffb05059a0

Fix this bug by preventing nvme_tcp_io_work() from running if the queue
is not flagged as "LIVE" and is not in the process of
connecting to the target.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ad3a2bf2f1e9..e3ef014bbc0b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -103,6 +103,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_CONNECTING	= 3,
 };
 
 enum nvme_tcp_recv_state {
@@ -1213,6 +1214,10 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		bool pending = false;
 		int result;
 
+		if (unlikely(!test_bit(NVME_TCP_Q_LIVE, &queue->flags) &&
+				!test_bit(NVME_TCP_Q_CONNECTING, &queue->flags)))
+			return;
+
 		if (mutex_trylock(&queue->send_mutex)) {
 			result = nvme_tcp_try_send(queue);
 			mutex_unlock(&queue->send_mutex);
@@ -1670,6 +1675,8 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	int ret;
 
+	set_bit(NVME_TCP_Q_CONNECTING, &ctrl->queues[idx].flags);
+
 	if (idx)
 		ret = nvmf_connect_io_queue(nctrl, idx);
 	else
@@ -1683,6 +1690,7 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 		dev_err(nctrl->device,
 			"failed to connect queue: %d ret=%d\n", idx, ret);
 	}
+	clear_bit(NVME_TCP_Q_CONNECTING, &ctrl->queues[idx].flags);
 	return ret;
 }
 
-- 
2.27.0


