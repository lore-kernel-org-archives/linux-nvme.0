Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C387C77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 06:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D2jMKOmNF2qw/bBBdcdrFg+yGA0M8qQfBwrpoxTsBm4=; b=U3kjrPiZPl+P6kSLZpOWlTJvPL
	YcOaJCDrrKTpsyCt/Nm3vVzGYoFm8v7Zi3KmGQfR7w5T/Q856/xVgvI71nhdTyMOFjWCmFpCYI4ll
	VTgG2JefToobiYyhIbVydDDwN/z9kyS5Jul9mCqTS1nCwNQNjlqlLWeyf/cG1aXbTMq9UgolpDrFW
	JuBSY8IaEPFa5CZW225413yX5EDw+KA3IqM+N2RY/N0U/lB9AS98Vx5OQvqsyoRiPSpbzJ8EFr2bb
	eKq77/zBbMHj26uLhF1Q3gZeVAagquc5qLuW2TKZGWo6fMBk/YZ6lkC3G4TRShmrSYOeRYi/+Pg1o
	SJ9bYhQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp1kt-004IWo-1p;
	Wed, 19 Apr 2023 06:57:27 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp1ko-004ITq-0t
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 06:57:23 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 445821FD84;
	Wed, 19 Apr 2023 06:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681887438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2jMKOmNF2qw/bBBdcdrFg+yGA0M8qQfBwrpoxTsBm4=;
	b=OKeFqdSvAsKIfs+eM8gq1o648XHDFZyy72ZiFMUic/cyyjLAltlJjIK2ZOLOTTKgi49gLn
	X13BDNb7r41FCzcxco69SoEtQuFx1+GyM6II5zoEhN64ucRTUggfAT+2+it4cnSR1P7T+Y
	ez5f4u94L3G1wkkWB45SqdU0JfIkfc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681887438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2jMKOmNF2qw/bBBdcdrFg+yGA0M8qQfBwrpoxTsBm4=;
	b=0GA+aPRixgPNnc7QE1WQGa3YAltTVa5GZj9Ye/loAdZO5mPNys5RBZyAQ4GAkLONb9iDr+
	A5uhAY0k3IEIGwBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 2DC9F2C14E;
	Wed, 19 Apr 2023 06:57:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 0D4D851C26D7; Wed, 19 Apr 2023 08:57:18 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/17] nvme-tcp: fixup MSG_SENDPAGE_NOTLAST
Date: Wed, 19 Apr 2023 08:57:05 +0200
Message-Id: <20230419065714.52076-9-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230419065714.52076-1-hare@suse.de>
References: <20230419065714.52076-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_235722_567147_A96A4B16 
X-CRM114-Status: GOOD (  15.08  )
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

We can only set MSG_SENDPAGE_NOTLAST when sending the command PDU if the
actual data is transferred via sendpage(), too.
If we use sendmsg() to transfer the data we end up with a TX stall on TLS
as it implements different code paths for sendmsg() and sendpage().
So check in nvme_tcp_try_send_pdu() if inline data is present and revert
to sendmsg if the inline data cannot be sent via sendpage().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 273c1f2760a4..9ecd7db2cd98 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -995,9 +995,11 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		if (last && !queue->data_digest && !nvme_tcp_queue_more(queue))
 			flags |= MSG_EOR;
 		else
-			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+			flags |= MSG_MORE;
 
 		if (sendpage_ok(page)) {
+			if (flags & MSG_MORE)
+				flags |= MSG_SENDPAGE_NOTLAST;
 			ret = kernel_sendpage(queue->sock, page, offset, len,
 					flags);
 		} else {
@@ -1049,15 +1051,23 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	int ret;
 
 	if (inline_data || nvme_tcp_queue_more(queue))
-		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+		flags |= MSG_MORE;
 	else
 		flags |= MSG_EOR;
 
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
-	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-			offset_in_page(pdu) + req->offset, len,  flags);
+	if (!inline_data || sendpage_ok(nvme_tcp_req_cur_page(req))) {
+		if (flags & MSG_MORE)
+			flags |= MSG_SENDPAGE_NOTLAST;
+		ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
+				offset_in_page(pdu) + req->offset, len,  flags);
+	} else {
+		ret = sock_no_sendpage(queue->sock, virt_to_page(pdu),
+				offset_in_page(pdu) + req->offset,
+				len, flags);
+	}
 	if (unlikely(ret <= 0))
 		return ret;
 
-- 
2.35.3


