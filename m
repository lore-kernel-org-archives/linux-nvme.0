Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134F3C0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jun 2023 11:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wPelxPY/D2Xo1HQrs/bARLsTqDBy+xx6UHdo64Xl3wM=; b=1+54crGO/wy6PU2ZdkHjRDxKDC
	sHubITD/954EToCi9mVSn1nfJreTmsY3r+PLrv4Q+NDQT/atyxR8YVUhKAHRnTnmrBLHbRuQ9Xj0d
	i/gGom5Fe1434G1rAe+zj1DBzoIEPy/phf2797wcAxbqbc8GBNVuE2v/4fh4AXeWgZlidn4/DdFuD
	6tDg6NsH7pMlgrTpIS5g2MqZ35PeqhHd6wUzpsgSzOl3NYKrDdOCgo/oxSnS7T7XvPnNc8FHJPphN
	jyFGT+UqzUsTIKtP9lctObdSohSL4RFbdfQPqW0OTgtg7H71hiUtOD3BQ3e+bpah4SrPsjsOQQsBB
	b1b0gBcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCfDo-003SHy-0G;
	Fri, 23 Jun 2023 11:45:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCfDk-003SFS-1W
	for linux-nvme@lists.infradead.org;
	Fri, 23 Jun 2023 11:44:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687520695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPelxPY/D2Xo1HQrs/bARLsTqDBy+xx6UHdo64Xl3wM=;
	b=IgiH2cjnOtr08NT6UpmD2kD3sYb6armXrQrs1BvCAbG05oSeEA2FLaSxbByoB91HMZmhED
	E7zeL0wjh9YsdRmT9FuXf7h4lyWt4YTFLurtYOWfpMGJ+e2gRPMHl9AQGmr3enwce/s2ku
	nXIBvGuQIUo8VxLZbbGFuUODa2q0+Vk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-yfqi9PmCPaK-TAUzgrk0lA-1; Fri, 23 Jun 2023 07:44:51 -0400
X-MC-Unique: yfqi9PmCPaK-TAUzgrk0lA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38DD590ED25;
	Fri, 23 Jun 2023 11:44:50 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 229D6200B402;
	Fri, 23 Jun 2023 11:44:48 +0000 (UTC)
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
Subject: [PATCH net-next v4 08/15] nvmet-tcp: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Date: Fri, 23 Jun 2023 12:44:18 +0100
Message-ID: <20230623114425.2150536-9-dhowells@redhat.com>
In-Reply-To: <20230623114425.2150536-1-dhowells@redhat.com>
References: <20230623114425.2150536-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230623_044456_579980_06D33892 
X-CRM114-Status: GOOD (  16.66  )
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
copied instead of calling sendpage.

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
    ver #3)
     - Split nvme/host from nvme/target changes.
    
    ver #2)
     - Wrap lines at 80.

 drivers/nvme/target/tcp.c | 46 ++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index ed98df72c76b..868aa4de2e4c 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -576,13 +576,17 @@ static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd)
 
 static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
 {
+	struct msghdr msg = {
+		.msg_flags = MSG_DONTWAIT | MSG_MORE | MSG_SPLICE_PAGES,
+	};
+	struct bio_vec bvec;
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
 
@@ -603,17 +607,21 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 	int ret;
 
 	while (cmd->cur_sg) {
+		struct msghdr msg = {
+			.msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES,
+		};
 		struct page *page = sg_page(cmd->cur_sg);
+		struct bio_vec bvec;
 		u32 left = cmd->cur_sg->length - cmd->offset;
-		int flags = MSG_DONTWAIT;
 
 		if ((!last_in_batch && cmd->queue->send_list_len) ||
 		    cmd->wbytes_done + left < cmd->req.transfer_len ||
 		    queue->data_digest || !queue->nvme_sq.sqhd_disabled)
-			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+			msg.msg_flags |= MSG_MORE;
 
-		ret = kernel_sendpage(cmd->queue->sock, page, cmd->offset,
-					left, flags);
+		bvec_set_page(&bvec, page, left, cmd->offset);
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, left);
+		ret = sock_sendmsg(cmd->queue->sock, &msg);
 		if (ret <= 0)
 			return ret;
 
@@ -649,18 +657,20 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
 		bool last_in_batch)
 {
+	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES, };
+	struct bio_vec bvec;
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
 	int left = sizeof(*cmd->rsp_pdu) - cmd->offset + hdgst;
-	int flags = MSG_DONTWAIT;
 	int ret;
 
 	if (!last_in_batch && cmd->queue->send_list_len)
-		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+		msg.msg_flags |= MSG_MORE;
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
@@ -677,18 +687,20 @@ static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
 
 static int nvmet_try_send_r2t(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 {
+	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES, };
+	struct bio_vec bvec;
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
 	int left = sizeof(*cmd->r2t_pdu) - cmd->offset + hdgst;
-	int flags = MSG_DONTWAIT;
 	int ret;
 
 	if (!last_in_batch && cmd->queue->send_list_len)
-		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+		msg.msg_flags |= MSG_MORE;
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


