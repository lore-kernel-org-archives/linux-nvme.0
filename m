Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02324C761A6
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bwtZAIqMizlxRHNHYlOozFR+iuDe8mlNfS85V5xMYoE=; b=w6r9DFbROOzM7dk4oYLltAohDh
	cAaH0OBify7qbY5QYhnTeSjYLmh7GQ0AJkeia1dNumNoWF1pm2nm9qn7apRxIe/N3mYAfthZ/tbx1
	QEztPlvX4FFrNd9PfCrGr3nHwaEccXLBJFMBTOT1iBm+7kLf99PdQ032/5Z1r9Gk1T+rDUPUkDheM
	1P8P0HNH2fArmm0vNUkikHWn+yUjqjogOIXFB8PzWFy5CQbxUBVgu0IuPg/obXjSPBpjpyQsyzr3W
	sdikLognu5fSKnJkPqBN1gP72pc/2UULud5LvsJ/KPMSZ+mIKiAEP6f2tp4nIx0qMGE16aUcV8hST
	4kBLo2/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLV-000UyJ-38;
	Wed, 29 Mar 2023 14:00:13 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLH-000Ul5-26
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 14:00:02 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id D72A71FDF9;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680098389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bwtZAIqMizlxRHNHYlOozFR+iuDe8mlNfS85V5xMYoE=;
	b=psmP7owC2L9KbyZhdyCjbAkgUQrh0MM3xx/AZCy8lP1j38ekYtEHgOoqVQX57QAN23J4vi
	e4YnaRvSxEQBYg1NB6Y3W0VRytexyNgDVlL+akHfx0vWl6g5oULx6gWkhYjpmiopCH2TYW
	Q9Wjnq7Wc98RlqdNTHk/yDmKBvcSFmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680098389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bwtZAIqMizlxRHNHYlOozFR+iuDe8mlNfS85V5xMYoE=;
	b=or5tdVFXMNw5FRVb1XSVX+Cuqvcq2L9+r4DKZJKyYRugl27jKOz6MYk6S/wFNzc8euskJl
	PDn4PifeTOnhLYDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id C5FE42C17E;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id C3BAD51BF388; Wed, 29 Mar 2023 15:59:49 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/18] nvme-tcp: control message handling for recvmsg()
Date: Wed, 29 Mar 2023 15:59:31 +0200
Message-Id: <20230329135938.46905-12-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329135938.46905-1-hare@suse.de>
References: <20230329135938.46905-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_065959_902092_A23E9E97 
X-CRM114-Status: GOOD (  13.26  )
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
---
 drivers/nvme/host/tcp.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 54d27873227a..2e15fa83b725 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1377,6 +1377,11 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_icreq_pdu *icreq;
 	struct nvme_tcp_icresp_pdu *icresp;
+#ifdef CONFIG_NVME_TLS
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	struct cmsghdr *cmsg;
+	unsigned char ctype;
+#endif
 	struct msghdr msg = {};
 	struct kvec iov;
 	bool ctrl_hdgst, ctrl_ddgst;
@@ -1414,11 +1419,27 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	memset(&msg, 0, sizeof(msg));
 	iov.iov_base = icresp;
 	iov.iov_len = sizeof(*icresp);
+#ifdef CONFIG_NVME_TLS
+	msg.msg_control = cbuf;
+	msg.msg_controllen = sizeof(cbuf);
+#endif
 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
 	if (ret < 0)
 		goto free_icresp;
-
+#ifdef CONFIG_NVME_TLS
+	cmsg = (struct cmsghdr *)cbuf;
+	if (CMSG_OK(&msg, cmsg) &&
+	    cmsg->cmsg_level == SOL_TLS &&
+	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
+		ctype = *((unsigned char *)CMSG_DATA(cmsg));
+		if (ctype != TLS_RECORD_TYPE_DATA) {
+			pr_err("queue %d: unhandled TLS record %d\n",
+			       nvme_tcp_queue_id(queue), ctype);
+			return -ENOTCONN;
+		}
+	}
+#endif
 	ret = -EINVAL;
 	if (icresp->hdr.type != nvme_tcp_icresp) {
 		pr_err("queue %d: bad type returned %d\n",
-- 
2.35.3


