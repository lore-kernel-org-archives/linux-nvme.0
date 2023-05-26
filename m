Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98997C7EE31
	for <linux-nvme@archiver.kernel.org>; Fri, 26 May 2023 14:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NMxERdXx7wwqcXUcsFITgZvHQBWYGRWSZzCfKLrybFM=; b=PKHAohbHEBw7r8SnOfcta7nsJl
	B2O3EKa3vPxRGXuFy4PzohayqKMAIYmudc6EaFiotjAuT9cCz9k9+0bsGCNRZruyTRS2pb/VYBfFU
	83mEfCl9DWzXuQX3VlE7Po88i7mYImQoZWgkzmHL19hd9tY974E1r4umSVx61ESK7bYeFRscfuYWK
	9NOjzqxoWIFv4OMFIEgH5gEvdymzBs9DRFhCqoGiO7ZAJxS0G4q7vWUjwtWECPVj0rY3mRFPlcKnl
	yE9T8gZWCsB2F+wQmBQxjXu7iszRi7tYgYsBOgyVvf+GeNCqy/VX59ePbt/+ICAw2tY2ullrGgI/6
	cfWVtUwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2YUF-002np1-0k;
	Fri, 26 May 2023 14:32:11 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2YU9-002nlf-0g
	for linux-nvme@lists.infradead.org;
	Fri, 26 May 2023 14:32:07 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id DAD0521B18;
	Fri, 26 May 2023 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1685111519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NMxERdXx7wwqcXUcsFITgZvHQBWYGRWSZzCfKLrybFM=;
	b=Nq2iIcrFitbylzUVB2kXFh/eNTAnNolgrPnAvbtykyeAvuP0/Gt2PoHYqJDpwV6GoV2uqJ
	cbr3saZvoYdvXbZFUUIK7Aj94NlaWB/5Iigthonx4BL1qY2OXbpu40WfySE0wNgGPxz+nm
	FpgIHVZNoBxbWLdZtZBuGABf0/LEQvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1685111519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NMxERdXx7wwqcXUcsFITgZvHQBWYGRWSZzCfKLrybFM=;
	b=o27bLuj+fU+1s0ceXb3c+/tNm5OWJW4HSP/9TCKMgHwFSPLC8QwgUaHWY9SxgbkuzEbVxe
	GpAD8gRLILBt/4Ag==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B988C2C141;
	Fri, 26 May 2023 14:31:59 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id ABCC851C3F40; Fri, 26 May 2023 16:31:58 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH 1/3] net/tls: handle MSG_EOR for tls_sw TX flow
Date: Fri, 26 May 2023 16:31:50 +0200
Message-Id: <20230526143152.53954-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230526143152.53954-1-hare@suse.de>
References: <20230526143152.53954-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230526_073205_394550_887046E2 
X-CRM114-Status: GOOD (  11.95  )
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

tls_sw_sendmsg() / tls_do_sw_sendpage() already handles
MSG_MORE / MSG_SENDPAGE_NOTLAST, but bails out on MSG_EOR.
But seeing that MSG_EOR is basically the opposite of
MSG_MORE / MSG_SENDPAGE_NOTLAST this patch adds handling
MSG_EOR by treating it as the negation of MSG_MORE.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 net/tls/tls_sw.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 635b8bf6b937..be8e0459d403 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -953,9 +953,12 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	int pending;
 
 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
-			       MSG_CMSG_COMPAT))
+			       MSG_EOR | MSG_CMSG_COMPAT))
 		return -EOPNOTSUPP;
 
+	if (msg->msg_flags & MSG_EOR)
+		eor = true;
+
 	ret = mutex_lock_interruptible(&tls_ctx->tx_lock);
 	if (ret)
 		return ret;
@@ -1173,6 +1176,8 @@ static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
 	bool eor;
 
 	eor = !(flags & MSG_SENDPAGE_NOTLAST);
+	if (flags & MSG_EOR)
+		eor = true;
 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
 	/* Call the sk_stream functions to manage the sndbuf mem. */
@@ -1274,7 +1279,7 @@ static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
 int tls_sw_sendpage_locked(struct sock *sk, struct page *page,
 			   int offset, size_t size, int flags)
 {
-	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
+	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR |
 		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY |
 		      MSG_NO_SHARED_FRAGS))
 		return -EOPNOTSUPP;
@@ -1288,7 +1293,7 @@ int tls_sw_sendpage(struct sock *sk, struct page *page,
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	int ret;
 
-	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
+	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR |
 		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY))
 		return -EOPNOTSUPP;
 
-- 
2.35.3


