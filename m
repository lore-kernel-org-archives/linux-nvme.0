Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB41AC77B77
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fbkzGP66w2eIP0ijsrJNPutbfmYDdmvVd4+ex576gDA=; b=siaIrKY5ivnOcWHgSKNkK+QY2w
	+dyDr9iCK6dtrSLJAUJRrEmEEd6oKJjBJBzHByEWDY7aK1FiD1hgDcyiKvwj1PP/wzdc7r7kXmMz9
	yAl0mKOBDREXQrOKfBILmNyqtoi9iJVckqbsi2gwebs+uAh/G2ca5Z0VVk4PwZFqBakCZL4fi1aUJ
	5HN9ykzpwbqgeBhi6++zRRYuWplYzi4prGr5ksvyzQKEOSjWsK9/MnJz1A+ltex+n8eQguE/I8ry6
	QYJO1IdHqWy4sZO671+7/pbrgbyYp438Yx7JtB9ZnwzmAMDeOkTPgclbK1ORTt/+LVbk4j+hRRkBL
	Qg24QKTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poOVl-00GHtl-0I;
	Mon, 17 Apr 2023 13:03:13 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poOVd-00GHmR-1l
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 13:03:10 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 3A2DB21A46;
	Mon, 17 Apr 2023 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681736584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbkzGP66w2eIP0ijsrJNPutbfmYDdmvVd4+ex576gDA=;
	b=GYAYoAI1qaVrRByB1PdflvjYA8doBOMMPa74gzZ6cTz8Fe2LWToLpG+j5GU4Y8+8HiSmj4
	viq+dFFlxqAtEo5kgnxb11yevtTXPWg0wwR89Q2lttBpvcNtoBS0ouvm4wqmPTH4PZaVa/
	Kcq+2cBku+r5DJmnLJAETUjwvw4UYEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681736584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbkzGP66w2eIP0ijsrJNPutbfmYDdmvVd4+ex576gDA=;
	b=YMA8fi60OVIcJbKShpL/EvypZFUEFSkrURqLQEDHAuYcjaAAguMrsj8HgGt9DoFUd2pJ0V
	Z7noGuBeHXfyLcAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 295652C152;
	Mon, 17 Apr 2023 13:03:04 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 2224051C25AA; Mon, 17 Apr 2023 15:03:04 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/18] nvme-tcp: do not set MSG_SENDPAGE_NOTLAST
Date: Mon, 17 Apr 2023 15:02:52 +0200
Message-Id: <20230417130302.86274-9-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230417130302.86274-1-hare@suse.de>
References: <20230417130302.86274-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_060305_765420_C22AE1AA 
X-CRM114-Status: GOOD (  13.13  )
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

MSG_SENDPAGE_NOTLAST was introduced with commit 35f9c09fe9c7
("tcp: tcp_sendpages() should call tcp_push() once") to fix issues
with the ->sendfile() call, and the implication seems to be that
the flag should be strictly internal to sendfile.
Hence we shouldn't be setting it on nvme-tcp, and anyway doing
so will cause TLS sending invalid data.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 273c1f2760a4..732aa2296560 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -995,7 +995,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		if (last && !queue->data_digest && !nvme_tcp_queue_more(queue))
 			flags |= MSG_EOR;
 		else
-			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+			flags |= MSG_MORE;
 
 		if (sendpage_ok(page)) {
 			ret = kernel_sendpage(queue->sock, page, offset, len,
@@ -1049,7 +1049,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	int ret;
 
 	if (inline_data || nvme_tcp_queue_more(queue))
-		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+		flags |= MSG_MORE;
 	else
 		flags |= MSG_EOR;
 
@@ -1091,7 +1091,7 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 	if (!req->h2cdata_left)
 		ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
 				offset_in_page(pdu) + req->offset, len,
-				MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
+				MSG_DONTWAIT | MSG_MORE);
 	else
 		ret = sock_no_sendpage(queue->sock, virt_to_page(pdu),
 				offset_in_page(pdu) + req->offset, len,
-- 
2.35.3


