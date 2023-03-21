Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4998C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=01FvCzc8K/qwSryjaw/aU5BwAq7VP6XXNesI6YImU0k=; b=xPrThRn9QZegRHjdqn7RlZryRM
	pP6XNQkTkbx+Qq0sM75hEIey0y5ef3u610fhBSpOuSJVsR0m25kspu9ap1s1lSnofNYZjaKscciQg
	Ei0oRHMSco8RWYQomsYe1iD3Wh+t5LEcWzfFBmmoqNYnR/BpCmM36mNrSgacACuS/rCDJDfWdMLpV
	OrwaNpArfK+mnAoMiav7UGBcJgfKiyH4pTP9Tnb/jVcjV18Nn9iRJFyprhC0axhZSeN7bR1UVsiG/
	Q0JVAVP1DMVz63j+qjJ4DbMTUk9+EvkQ21GWDPQTuy+DNtjJMIVmS7t90WEwpwJcYYj3fDXXhGC/Y
	u85Me6Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pebLj-00CNeK-01;
	Tue, 21 Mar 2023 12:44:23 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pebLS-00CNS8-0b
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 12:44:08 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 03F5520003;
	Tue, 21 Mar 2023 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679402638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01FvCzc8K/qwSryjaw/aU5BwAq7VP6XXNesI6YImU0k=;
	b=gLADUOIP8v5JQtPNVqc3sBvgyogbV35P7JHNjNgqHmS7qZktJkxn5xNv70pvrDw9XiryiR
	c2e4KWfTjI0cXvoDfCdKGCmkkWZPBXqrWAFA1u2wK9qAL42iHgL8Q7jskyTRSqykJUOx64
	1dgMARUlhTOfB+8Q4jLL2gVu8jn9y/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679402638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01FvCzc8K/qwSryjaw/aU5BwAq7VP6XXNesI6YImU0k=;
	b=HQ2DgoLaS3YTxdZQT2lmIamJ9szoOAvGFLRwTYlXrHQ8HWoYOoiN9pWm/ZUfgIg9fx3LQ+
	+xvjaK5OX1UtXbDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id E350C2C15A;
	Tue, 21 Mar 2023 12:43:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id DFE0751BEEA8; Tue, 21 Mar 2023 13:43:57 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <cel@kernel.org>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/18] nvme-tcp: fixup send workflow for kTLS
Date: Tue, 21 Mar 2023 13:43:17 +0100
Message-Id: <20230321124325.77385-11-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230321124325.77385-1-hare@suse.de>
References: <20230321124325.77385-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_054406_380163_93B66B8C 
X-CRM114-Status: GOOD (  14.47  )
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

kTLS does not support MSG_EOR flag for sendmsg(), and the ->sendpage()
call really doesn't bring any benefit as data has to be copied
anyway.
So use sock_no_sendpage() or sendmsg() instead, and ensure that the
MSG_EOR flag is blanked out for kTLS.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bbff1f52a167..007d457cacf9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1034,13 +1034,19 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		bool last = nvme_tcp_pdu_last_send(req, len);
 		int req_data_sent = req->data_sent;
 		int ret, flags = MSG_DONTWAIT;
+		bool do_sendpage = sendpage_ok(page);
 
-		if (last && !queue->data_digest && !nvme_tcp_queue_more(queue))
+		if (!last || queue->data_digest || nvme_tcp_queue_more(queue))
+			flags |= MSG_MORE;
+		else if (!test_bit(NVME_TCP_Q_TLS, &queue->flags))
 			flags |= MSG_EOR;
-		else
-			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
 
-		if (sendpage_ok(page)) {
+		if (test_bit(NVME_TCP_Q_TLS, &queue->flags))
+			do_sendpage = false;
+
+		if (do_sendpage) {
+			if (flags & MSG_MORE)
+				flags |= MSG_SENDPAGE_NOTLAST;
 			ret = kernel_sendpage(queue->sock, page, offset, len,
 					flags);
 		} else {
@@ -1088,19 +1094,22 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	bool inline_data = nvme_tcp_has_inline_data(req);
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) + hdgst - req->offset;
-	int flags = MSG_DONTWAIT;
+	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
+	struct kvec iov = {
+		.iov_base = (u8 *)req->pdu + req->offset,
+		.iov_len = len,
+	};
 	int ret;
 
 	if (inline_data || nvme_tcp_queue_more(queue))
-		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
-	else
-		flags |= MSG_EOR;
+		msg.msg_flags |= MSG_MORE;
+	else if (!test_bit(NVME_TCP_Q_TLS, &queue->flags))
+		msg.msg_flags |= MSG_EOR;
 
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
-	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-			offset_in_page(pdu) + req->offset, len,  flags);
+	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
 	if (unlikely(ret <= 0))
 		return ret;
 
@@ -1131,7 +1140,7 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
-	if (!req->h2cdata_left)
+	if (!test_bit(NVME_TCP_Q_TLS, &queue->flags) && !req->h2cdata_left)
 		ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
 				offset_in_page(pdu) + req->offset, len,
 				MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
@@ -1168,7 +1177,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 
 	if (nvme_tcp_queue_more(queue))
 		msg.msg_flags |= MSG_MORE;
-	else
+	else if (!test_bit(NVME_TCP_Q_TLS, &queue->flags))
 		msg.msg_flags |= MSG_EOR;
 
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
-- 
2.35.3


