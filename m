Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F824C04FE2
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V3l9Ci+ybfsMTFs7lxLQ1BI6O14QQjb6jHsPow6xE2M=; b=zS+CEFDIDp7pDhOc+RvUXZQxDr
	aNygcuv2iri9nyp95C3W34qMdcT3Zolpq0I9w1xzXzT9kJ1rGfQPGbdkieG0bwUIxqVTEEVdMC2HI
	29IencU+XH31jDHKoP6D5zPHzLIOQ0JqMtQ2fYo8TkEFM0npNnvKSFvUHY6vV7tEt4HjY8B5kL63w
	fu9ee9RjpiJW936n8DV4pSZa0Z0K90Ct2LNsasHOQLjtCBEufMCb9kXRDybERIuL0U8jZUFpxelEs
	iQ8FT+Kn+fKdXgeSPpgIKDKUk5NdHiZQsuY6hNrL9qb+Gze4YLzsyYWoIXreLOICLMNSsM2EhxdBX
	En8pmVAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTPyN-00321X-0y;
	Tue, 08 Aug 2023 16:54:19 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTPyG-0031wd-0d
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 16:54:16 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 469442030C;
	Tue,  8 Aug 2023 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691513648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3l9Ci+ybfsMTFs7lxLQ1BI6O14QQjb6jHsPow6xE2M=;
	b=2aL91aj5L88yfFZ6NOCOSF9dmXbdfxuI+6GPR2sbcPXDHLMOWJB9VLLeN7vyfGlQPwQR7G
	0kCJSVDz7REYP+brd8r1cxPEhqPX6yudTavXawUiWuNTi7JDsophi66Q3NZOODlYP4Bjru
	eEKXKXV6rGIWBJyIhV6hWF64DPtx+QQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691513648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3l9Ci+ybfsMTFs7lxLQ1BI6O14QQjb6jHsPow6xE2M=;
	b=w085YZEiztNhee2PVunJ3+W6wbWoUXaK5+1dLpwMj7bg19g81a5NPjYQR+MB5db4iOhfYI
	iq/KpTzqTGttbaDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 39AF02C153;
	Tue,  8 Aug 2023 16:54:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 362BF51CACF7; Tue,  8 Aug 2023 18:54:08 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/16] nvme-tcp: control message handling for recvmsg()
Date: Tue,  8 Aug 2023 18:53:47 +0200
Message-Id: <20230808165354.123499-10-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230808165354.123499-1-hare@suse.de>
References: <20230808165354.123499-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_095414_928770_2AF4EA8E 
X-CRM114-Status: GOOD (  13.34  )
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

kTLS is sending TLS ALERT messages as control messages for recvmsg().
As we can't do anything sensible with it just abort the connection
and let the userspace agent to a re-negotiation.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d444119c408b..3382e85b7759 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -14,6 +14,7 @@
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/tls.h>
+#include <net/tls_prot.h>
 #include <net/handshake.h>
 #include <linux/blk-mq.h>
 #include <crypto/hash.h>
@@ -1369,6 +1370,8 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_icreq_pdu *icreq;
 	struct nvme_tcp_icresp_pdu *icresp;
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	u8 ctype;
 	struct msghdr msg = {};
 	struct kvec iov;
 	bool ctrl_hdgst, ctrl_ddgst;
@@ -1406,11 +1409,23 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	memset(&msg, 0, sizeof(msg));
 	iov.iov_base = icresp;
 	iov.iov_len = sizeof(*icresp);
+	if (queue->ctrl->ctrl.opts->tls) {
+		msg.msg_control = cbuf;
+		msg.msg_controllen = sizeof(cbuf);
+	}
 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
 	if (ret < 0)
 		goto free_icresp;
-
+	if (queue->ctrl->ctrl.opts->tls) {
+		ctype = tls_get_record_type(queue->sock->sk,
+					    (struct cmsghdr *)cbuf);
+		if (ctype != TLS_RECORD_TYPE_DATA) {
+			pr_err("queue %d: unhandled TLS record %d\n",
+			       nvme_tcp_queue_id(queue), ctype);
+			return -ENOTCONN;
+		}
+	}
 	ret = -EINVAL;
 	if (icresp->hdr.type != nvme_tcp_icresp) {
 		pr_err("queue %d: bad type returned %d\n",
-- 
2.35.3


