Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AA2C761A6
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Mar 2023 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XvqldHWl7xh/L1V+KGWEm9YizW/K8SDxYbPNnLnjdW8=; b=WEuvwre3h1VhKDa0sx91r7YC+9
	jJ24nR2SWQoDiIuBiSLPz8FbTj6FpjFiqfMn2Mr7+rgAJPUsfFI2fLfGTMsQy76VKAKg78RInhrDl
	pgEMzBqiSwWaqiN5MI7Yy2PEMlkaaLXscGj3XJDHoA6bh/OGzNV1H6Y6H5ugtYnR4LVb11e4j5kNt
	an+EsWiwGnRQ7A0kJHNXZpBr8IsVbe8vCiNhD2buX7WUqhP8VBHyJ2zmR6Gqu+GuOe8iT5hHi/ceM
	TZOhQlq5NdWnCdxzr37g/H7+sHikmQNWIM/WJAkGgiulkVDFKyBx0XVK4YsFVzCYRZAIn2JQnb13D
	aPz4RM8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1piHLy-0082CV-1x;
	Fri, 31 Mar 2023 16:11:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1piHLr-00827u-2Y
	for linux-nvme@lists.infradead.org;
	Fri, 31 Mar 2023 16:11:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680279102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XvqldHWl7xh/L1V+KGWEm9YizW/K8SDxYbPNnLnjdW8=;
	b=ZqH/AhZwiiy4uZE0SSWt2PN9CsyGw6XKk0tLyNP5MH/hCe7JFZdXoZovHAKlyETsGUQfW9
	YqRuxLMhY5qs8HcT8Nv3jKMNhr3ZII+fDVnGJvrBqlmujBgnlKY5UqvbDfwyGXFq77hfs9
	zLgszCmBayPe2lereCsKkIquLfO/ILE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-1ZXUWRtzOLGY7fvr_wG5SQ-1; Fri, 31 Mar 2023 12:11:39 -0400
X-MC-Unique: 1ZXUWRtzOLGY7fvr_wG5SQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FC60889047;
	Fri, 31 Mar 2023 16:11:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DD7E5202701E;
	Fri, 31 Mar 2023 16:11:34 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH v3 49/55] nvme: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Date: Fri, 31 Mar 2023 17:09:08 +0100
Message-Id: <20230331160914.1608208-50-dhowells@redhat.com>
In-Reply-To: <20230331160914.1608208-1-dhowells@redhat.com>
References: <20230331160914.1608208-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230331_091143_910195_BA9BCFA4 
X-CRM114-Status: GOOD (  19.41  )
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

When transmitting data, call down into TCP using a single sendmsg with
MSG_SPLICE_PAGES to indicate that content should be spliced rather than
performing several sendmsg and sendpage calls to transmit header, data
pages and trailer.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Keith Busch <kbusch@kernel.org>
cc: Jens Axboe <axboe@fb.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Sagi Grimberg <sagi@grimberg.me>
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
 drivers/nvme/host/tcp.c   | 44 ++++++++++++++++++------------------
 drivers/nvme/target/tcp.c | 47 +++++++++++++++++++++++++--------------
 2 files changed, 52 insertions(+), 39 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fa32969b532f..cc617692702d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -979,25 +979,23 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 	u32 h2cdata_left = req->h2cdata_left;
 
 	while (true) {
+		struct bio_vec bvec;
+		struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES, };
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
+			msg.msg_flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
 
-		if (sendpage_ok(page)) {
-			ret = kernel_sendpage(queue->sock, page, offset, len,
-					flags);
-		} else {
-			ret = sock_no_sendpage(queue->sock, page, offset, len,
-					flags);
-		}
+		bvec_set_page(&bvec, page, len, offset);
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
+		ret = sock_sendmsg(queue->sock, &msg);
 		if (ret <= 0)
 			return ret;
 
@@ -1036,22 +1034,24 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
 	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
+	struct bio_vec bvec;
+	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES, };
 	bool inline_data = nvme_tcp_has_inline_data(req);
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) + hdgst - req->offset;
-	int flags = MSG_DONTWAIT;
 	int ret;
 
 	if (inline_data || nvme_tcp_queue_more(queue))
-		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+		msg.msg_flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
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
 
@@ -1075,6 +1075,8 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
 	struct nvme_tcp_data_pdu *pdu = req->pdu;
+	struct bio_vec bvec;
+	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_MORE, };
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) - req->offset + hdgst;
 	int ret;
@@ -1083,13 +1085,11 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
 	if (!req->h2cdata_left)
-		ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-				offset_in_page(pdu) + req->offset, len,
-				MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
-	else
-		ret = sock_no_sendpage(queue->sock, virt_to_page(pdu),
-				offset_in_page(pdu) + req->offset, len,
-				MSG_DONTWAIT | MSG_MORE);
+		msg.msg_flags |= MSG_SPLICE_PAGES | MSG_SENDPAGE_NOTLAST;
+
+	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
+	ret = sock_sendmsg(queue->sock, &msg);
 	if (unlikely(ret <= 0))
 		return ret;
 
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d6cc557cc539..00b491abf50f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -548,13 +548,18 @@ static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd)
 
 static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
 {
+	struct bio_vec bvec;
+	struct msghdr msg = {
+		.msg_flags = (MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST |
+			      MSG_SPLICE_PAGES),
+	};
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
 	int left = sizeof(*cmd->data_pdu) - cmd->offset + hdgst;
 	int ret;
 
-	ret = kernel_sendpage(cmd->queue->sock, virt_to_page(cmd->data_pdu),
-			offset_in_page(cmd->data_pdu) + cmd->offset,
-			left, MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
+	bvec_set_virt(&bvec, (void *)cmd->data_pdu + cmd->offset, left);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, left);
+	ret = sock_sendmsg(cmd->queue->sock, &msg);
 	if (ret <= 0)
 		return ret;
 
@@ -575,17 +580,21 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 	int ret;
 
 	while (cmd->cur_sg) {
+		struct bio_vec bvec;
+		struct msghdr msg = {
+			.msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES,
+		};
 		struct page *page = sg_page(cmd->cur_sg);
 		u32 left = cmd->cur_sg->length - cmd->offset;
-		int flags = MSG_DONTWAIT;
 
 		if ((!last_in_batch && cmd->queue->send_list_len) ||
 		    cmd->wbytes_done + left < cmd->req.transfer_len ||
 		    queue->data_digest || !queue->nvme_sq.sqhd_disabled)
-			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+			msg.msg_flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
 
-		ret = kernel_sendpage(cmd->queue->sock, page, cmd->offset,
-					left, flags);
+		bvec_set_page(&bvec, page, left, cmd->offset);
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, left);
+		ret = sock_sendmsg(cmd->queue->sock, &msg);
 		if (ret <= 0)
 			return ret;
 
@@ -621,18 +630,20 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
 		bool last_in_batch)
 {
+	struct bio_vec bvec;
+	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES, };
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
 	int left = sizeof(*cmd->rsp_pdu) - cmd->offset + hdgst;
-	int flags = MSG_DONTWAIT;
 	int ret;
 
 	if (!last_in_batch && cmd->queue->send_list_len)
-		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+		msg.msg_flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
 	else
-		flags |= MSG_EOR;
+		msg.msg_flags |= MSG_EOR;
 
-	ret = kernel_sendpage(cmd->queue->sock, virt_to_page(cmd->rsp_pdu),
-		offset_in_page(cmd->rsp_pdu) + cmd->offset, left, flags);
+	bvec_set_virt(&bvec, (void *)cmd->rsp_pdu + cmd->offset, left);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, left);
+	ret = sock_sendmsg(cmd->queue->sock, &msg);
 	if (ret <= 0)
 		return ret;
 	cmd->offset += ret;
@@ -649,18 +660,20 @@ static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
 
 static int nvmet_try_send_r2t(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 {
+	struct bio_vec bvec;
+	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES, };
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
 	int left = sizeof(*cmd->r2t_pdu) - cmd->offset + hdgst;
-	int flags = MSG_DONTWAIT;
 	int ret;
 
 	if (!last_in_batch && cmd->queue->send_list_len)
-		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+		msg.msg_flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
 	else
-		flags |= MSG_EOR;
+		msg.msg_flags |= MSG_EOR;
 
-	ret = kernel_sendpage(cmd->queue->sock, virt_to_page(cmd->r2t_pdu),
-		offset_in_page(cmd->r2t_pdu) + cmd->offset, left, flags);
+	bvec_set_virt(&bvec, (void *)cmd->r2t_pdu + cmd->offset, left);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, left);
+	ret = sock_sendmsg(cmd->queue->sock, &msg);
 	if (ret <= 0)
 		return ret;
 	cmd->offset += ret;


