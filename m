Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF658EB64DB
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SOw9ClnSc9r47uoXD4terkn/PQVkRnQZDq9J97sUBoI=; b=3eqVpGz9v3smQpAO/B3DvPmoJW
	FbEcbzT7OIZ0LJUlBRPdJgaKrEpyVDbgqdxLwfYxVsmMAq4zzmHG9SozETyN1vuv4jyvmu4bm7IWy
	sRdHT1Ljokl0f6YtO+0n85AqMCin6BIYscIKQNo56GTr8IcnIr5DsZ61MWP1oFCHfv/kzilBxRvl7
	H0gY2ixTza0mQ6f2QFkitP8uOBZUJax6fMulSmhtR2mpCpxPFR6AiKn9i113J721az88o9lPx4H1+
	/QuS+XqSS211ToCSaddb3hnorVGnp2x+ci2k7lHsLFQVceXfilqepDcEXMZJf9E1ZNYNJuDUn2QJ2
	eH1MoOBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBcmn-00BbCJ-32;
	Tue, 20 Jun 2023 14:56:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBcmk-00BbAn-20
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 14:56:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687273005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOw9ClnSc9r47uoXD4terkn/PQVkRnQZDq9J97sUBoI=;
	b=h4MYebas13ZT0AZfxEGG+bOhYyl7qLyITWTtXhvjfo7p3RXbDDCf/qIlSYenphGk7nc+cG
	SWRuvlSAzGb1Upw4BoUFaPS3k111BM0Ysoq6VZ7phjvPsZUIxEUeHbKBRBXstuAmylcQLK
	0DcOEi02vGc7kvpv7sFblHNyXyB/DAA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-8YJyb2soPem25NlFFJ-W_g-1; Tue, 20 Jun 2023 10:56:40 -0400
X-MC-Unique: 8YJyb2soPem25NlFFJ-W_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27CFB8925DC;
	Tue, 20 Jun 2023 14:54:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 19014112132C;
	Tue, 20 Jun 2023 14:54:26 +0000 (UTC)
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
Subject: [PATCH net-next v3 11/18] nvme/target: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Date: Tue, 20 Jun 2023 15:53:30 +0100
Message-ID: <20230620145338.1300897-12-dhowells@redhat.com>
In-Reply-To: <20230620145338.1300897-1-dhowells@redhat.com>
References: <20230620145338.1300897-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_075646_734281_7617E008 
X-CRM114-Status: GOOD (  16.63  )
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


