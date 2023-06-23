Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0BEEB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jun 2023 11:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W+/sbivnn4SSL91vpgGdKmYtGhKmLadJeuepui2ZFTU=; b=Y1Uhq/zMpMfgvPy3IUYk0vYb7t
	t2dlYJUKif9I5XclUNC3V6gpTZ4xYYBf88wnvSSFC/YqAXBcAOS/7FleH5B2L6rYFlfHBOc7hYBxB
	x6KS7K3zVbS/0dDfn5Ot5cZrHljbNzNdfh7yfcJAI7D09UDpuk90XsOHjNFAD18aIP7NlD/rN6wOx
	Rw1OiqdAeLIBmTPN1GOJ/y4Wvp3gpr210bzZdEQ8suT6GQ0esZ0pI+Lm5tUIiXftfh6HT6xkUJKTh
	++5Yk6stk4VQtwtbUhKFAlmVjv9TwxF6lc9Qm9kDnoLWYNubsl8vBm93uWexPHqnlJdyQS8B2i908
	YZl8J2UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCfDm-003SGo-0e;
	Fri, 23 Jun 2023 11:44:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCfDi-003SEY-1u
	for linux-nvme@lists.infradead.org;
	Fri, 23 Jun 2023 11:44:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687520693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+/sbivnn4SSL91vpgGdKmYtGhKmLadJeuepui2ZFTU=;
	b=VS3h1R3e3nfY3skVzQRRaBkoY6QvVTXHyOqxwVw1vwGtWq6+ZPr7yUCxJuVdsDAFj06PYf
	XuRxrJQqfzhgNCI+9A8+ctgv/sKd6+lo1GpHkcotVgZkMe6iq1JVFXEQH+tn+yj0o0YjoF
	/zK7Ck4CiirLJN6PXXA7fIphPNU8k0Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-oy5Qkzx6N9eqWFkhdXf48g-1; Fri, 23 Jun 2023 07:44:48 -0400
X-MC-Unique: oy5Qkzx6N9eqWFkhdXf48g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CCDC3C0F696;
	Fri, 23 Jun 2023 11:44:47 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 52893C1ED97;
	Fri, 23 Jun 2023 11:44:45 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Willem de Bruijn <willemb@google.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH net-next v4 07/15] nvme-tcp: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Date: Fri, 23 Jun 2023 12:44:17 +0100
Message-ID: <20230623114425.2150536-8-dhowells@redhat.com>
In-Reply-To: <20230623114425.2150536-1-dhowells@redhat.com>
References: <20230623114425.2150536-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230623_044454_702532_96949E8C 
X-CRM114-Status: GOOD (  18.17  )
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

When transmitting data, call down into TCP using a sendmsg with
MSG_SPLICE_PAGES instead of sendpage.

Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Sagi Grimberg <sagi@grimberg.me>
Acked-by: Willem de Bruijn <willemb@google.com>
cc: Keith Busch <kbusch@kernel.org>
cc: Jens Axboe <axboe@fb.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Chaitanya Kulkarni <kch@nvidia.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-nvme@lists.infradead.org
cc: netdev@vger.kernel.org
---

Notes:
    ver #4)
     - Cancel MSG_SPLICE_PAGES if the page being sent fails sendpage_ok().
    
    ver #3)
     - Split nvme/host from nvme/target changes.
    
    ver #2)
     - Wrap lines at 80.

 drivers/nvme/host/tcp.c | 49 +++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bf0230442d57..47ae17f16c05 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -997,25 +997,28 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 	u32 h2cdata_left = req->h2cdata_left;
 
 	while (true) {
+		struct bio_vec bvec;
+		struct msghdr msg = {
+			.msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES,
+		};
 		struct page *page = nvme_tcp_req_cur_page(req);
 		size_t offset = nvme_tcp_req_cur_offset(req);
 		size_t len = nvme_tcp_req_cur_length(req);
 		bool last = nvme_tcp_pdu_last_send(req, len);
 		int req_data_sent = req->data_sent;
-		int ret, flags = MSG_DONTWAIT;
+		int ret;
 
 		if (last && !queue->data_digest && !nvme_tcp_queue_more(queue))
-			flags |= MSG_EOR;
+			msg.msg_flags |= MSG_EOR;
 		else
-			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+			msg.msg_flags |= MSG_MORE;
 
-		if (sendpage_ok(page)) {
-			ret = kernel_sendpage(queue->sock, page, offset, len,
-					flags);
-		} else {
-			ret = sock_no_sendpage(queue->sock, page, offset, len,
-					flags);
-		}
+		if (!sendpage_ok(page))
+			msg.msg_flags &= ~MSG_SPLICE_PAGES,
+
+		bvec_set_page(&bvec, page, len, offset);
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
+		ret = sock_sendmsg(queue->sock, &msg);
 		if (ret <= 0)
 			return ret;
 
@@ -1054,22 +1057,24 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
 	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
+	struct bio_vec bvec;
+	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES, };
 	bool inline_data = nvme_tcp_has_inline_data(req);
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) + hdgst - req->offset;
-	int flags = MSG_DONTWAIT;
 	int ret;
 
 	if (inline_data || nvme_tcp_queue_more(queue))
-		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+		msg.msg_flags |= MSG_MORE;
 	else
-		flags |= MSG_EOR;
+		msg.msg_flags |= MSG_EOR;
 
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
-	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-			offset_in_page(pdu) + req->offset, len,  flags);
+	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
+	ret = sock_sendmsg(queue->sock, &msg);
 	if (unlikely(ret <= 0))
 		return ret;
 
@@ -1093,6 +1098,8 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
 	struct nvme_tcp_data_pdu *pdu = nvme_tcp_req_data_pdu(req);
+	struct bio_vec bvec;
+	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_MORE, };
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) - req->offset + hdgst;
 	int ret;
@@ -1101,13 +1108,11 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
 	if (!req->h2cdata_left)
-		ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-				offset_in_page(pdu) + req->offset, len,
-				MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
-	else
-		ret = sock_no_sendpage(queue->sock, virt_to_page(pdu),
-				offset_in_page(pdu) + req->offset, len,
-				MSG_DONTWAIT | MSG_MORE);
+		msg.msg_flags |= MSG_SPLICE_PAGES;
+
+	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
+	ret = sock_sendmsg(queue->sock, &msg);
 	if (unlikely(ret <= 0))
 		return ret;
 


