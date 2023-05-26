Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7543EC7EE2E
	for <linux-nvme@archiver.kernel.org>; Fri, 26 May 2023 14:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i/MJTUeDZzlx42IR4b00ab5UFRMqUbHmDFYZj2cxqws=; b=IO7dE/BZcqj7OcOcybTApx9zQi
	d5E9uGmgzsBxVNIsakE2SnvI2BngBnUZB4XfoCCvdny/yJJL9FGG8lkDN1vXYVVbgslBs2eeUHovd
	F9o///JEWuaOGYbjS7nGCEgRMCZjt7i5niK/yDYiDsMvyi+Kwg9uH5ahY7cYsSePr40RR7ujx0YFy
	dkDA3yjz93kxtVuCk3c4eNibPRE7GqTmDTUNfDPW0GmbCkoimPCi2KcEZbwSMEvKtqWABSWfDuCue
	CmY8DwSdXtXPhvQmwfM453NRzffw4BRivBRlLfOA1KzGiu66j+XhF78wI8GWl8GmM2W/J0lzDnRdE
	CYRQNe0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2YUE-002noN-1U;
	Fri, 26 May 2023 14:32:10 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2YU9-002nlg-0X
	for linux-nvme@lists.infradead.org;
	Fri, 26 May 2023 14:32:07 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id E0BE21F86C;
	Fri, 26 May 2023 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1685111519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/MJTUeDZzlx42IR4b00ab5UFRMqUbHmDFYZj2cxqws=;
	b=rF+oM9uLvegbK0EkU26cwdUfsKGPut0IrffY574Elbjjjik9xDXg/XvI5wYGjRNgdIMc11
	+BPdSA90fKsNPNP4XQyuPC0FEj0SsJGp6QOLrUU4i0udHla5YrEilNGXtXTr4XDtwdTPni
	lTokl8tx0Eg400ZUp/I/0OBmzhG7GQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1685111519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/MJTUeDZzlx42IR4b00ab5UFRMqUbHmDFYZj2cxqws=;
	b=aj3nIkf4Zm15Cl/dpHb4fV6ZDEfetCNQtjwS+TgY4yYNYitKcUhPt6NpMD67Yvxpfmr2qB
	SyUrd3ZhLXp7AGDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id BEAF42C143;
	Fri, 26 May 2023 14:31:59 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id B4A3D51C3F42; Fri, 26 May 2023 16:31:58 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH 2/3] net/tls: handle MSG_EOR for tls_device TX flow
Date: Fri, 26 May 2023 16:31:51 +0200
Message-Id: <20230526143152.53954-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230526143152.53954-1-hare@suse.de>
References: <20230526143152.53954-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230526_073205_369970_0E899B63 
X-CRM114-Status: GOOD (  12.01  )
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

tls_push_data() MSG_MORE / MSG_SENDPAGE_NOTLAST, but bails
out on MSG_EOR.
But seeing that MSG_EOR is basically the opposite of
MSG_MORE / MSG_SENDPAGE_NOTLAST this patch adds handling
MSG_EOR by treating it as the negation of MSG_MORE.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 net/tls/tls_device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index a7cc4f9faac2..9603a3c9ec24 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -449,7 +449,7 @@ static int tls_push_data(struct sock *sk,
 	long timeo;
 
 	if (flags &
-	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST))
+	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST | MSG_EOR))
 		return -EOPNOTSUPP;
 
 	if (unlikely(sk->sk_err))
@@ -529,6 +529,10 @@ static int tls_push_data(struct sock *sk,
 				more = true;
 				break;
 			}
+			if (flags & MSG_EOR) {
+				more = false;
+				break;
+			}
 
 			done = true;
 		}
@@ -603,6 +607,8 @@ int tls_device_sendpage(struct sock *sk, struct page *page,
 
 	if (flags & MSG_SENDPAGE_NOTLAST)
 		flags |= MSG_MORE;
+	if (flags & MSG_EOR)
+		flags &= ~(MSG_MORE | MSG_SENDPAGE_NOTLAST);
 
 	mutex_lock(&tls_ctx->tx_lock);
 	lock_sock(sk);
-- 
2.35.3


