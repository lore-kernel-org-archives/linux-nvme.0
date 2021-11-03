Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3427DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 08:19:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3EC6113B
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 08:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC3EC6113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JZtCwcUJrAi7/VWXFyEdpb/WYXB6YikAvmQRZbTtUgM=; b=1TvhZfnpIqL8yqjJB5u2c1Du7K
	gXmnaNnQxPFFBNX2fGkupSuNjoc9icGTY1V5+s/SMaSi8VhlEKi021LwfV52ISyiUqg6N1aBZZJjB
	U9weSmXBiLzAhgMoJ04XVi+CrT/ihOG62Yo9noTuLvuSoiZwMEpbERA39O+NxNoy7icI7uST6BstB
	U5RN+EwEXYN0lmGsBfh/jGp4iK+Wn67S8tpATWIWYVg3I37lMCqnAQMgk1CFS4EyVs0+6GVN9p9/f
	mK9WaI+xaJiqcy1+OGlqaTozxGKKjjXUN7lfqFJGim1BQKuX67GEIwRFuud7C76ocXGN4bDUDA46u
	qJbH/7Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1miBUm-004VR5-1Q; Wed, 03 Nov 2021 08:19:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miBTW-004UdX-Ub
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 08:18:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635927504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JZtCwcUJrAi7/VWXFyEdpb/WYXB6YikAvmQRZbTtUgM=;
 b=cgIbOuCa5xdk7LgKglba1Cc1mqFUhJOuc5vd5+BsJGkP3RG7zmxJBrf4V/Cn01LLYEgr6X
 9yEBTJuiD3rZqlAbNOrwSIcGeP9pT3WzC+E+Xdj9h8a/0zTD+Dncbp3jy3NehMyBhUh/NI
 Al3exebxSQgoKIahx2DKcxOWbV0FQJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-szDt8C7EO-yZ6plLXVc6pw-1; Wed, 03 Nov 2021 04:18:21 -0400
X-MC-Unique: szDt8C7EO-yZ6plLXVc6pw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C54A10A8E00;
 Wed,  3 Nov 2021 08:18:20 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.193.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C174760C05;
 Wed,  3 Nov 2021 08:18:18 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH] nvme-tcp: fix memory leak when freeing a queue
Date: Wed,  3 Nov 2021 09:18:17 +0100
Message-Id: <20211103081817.94820-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211103_011827_107099_E81FFA06 
X-CRM114-Status: GOOD (  11.75  )
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

Release the page frag cache when tearing down the io queues

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/tcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 07156ea9d1a8..999417626b15 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1229,6 +1229,7 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 
 static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 {
+	struct page *page;
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 
@@ -1238,6 +1239,11 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	if (queue->hdr_digest || queue->data_digest)
 		nvme_tcp_free_crypto(queue);
 
+	if (queue->pf_cache.va) {
+		page = virt_to_head_page(queue->pf_cache.va);
+		__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
+		queue->pf_cache.va = NULL;
+	}
 	sock_release(queue->sock);
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
-- 
2.27.0


