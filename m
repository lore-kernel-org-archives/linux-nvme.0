Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941D4C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 09:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Cfgbj1kemCqgf7gxNBgNUuoOAfNfU7sJcZxHxpQYpyI=; b=rBnVvjv6Vn7+VLmLhr6OEG8lbd
	5xatv/U0MA/tGRy5+QbQU97/FPADpe5ZW4KkKH0L70dAwUJ6IIqE1cudi8/s7aClGRO+7HTlqiXw9
	wCiiv+SjCcPbOs+kCl9a9Fqc4svSEXsKt+I2fmbq9p7PtKJlntl14Qt+sYX0bsClYmVRhKgVA9kNr
	iPywR18SVMYRl/zGKV8VpVTXnfKMFKx+p44ZFUeEmLGygMq/wX9zzvzBAUOYfN/CBipFswZlRK91F
	BZXHFvSV2igDTI2ZTx5xo3trjyQg4RKMQLKB6BuRA8HzlF37Li+/ZFJbvRPuVDk91ajSMaRBQHEWw
	SLz18n4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCbY6-0000000F2YZ-0VLs;
	Wed, 07 May 2025 09:58:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCbGs-0000000Ezqt-0HLK
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 09:40:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 79857629D5;
	Wed,  7 May 2025 09:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B8CC4CEF0;
	Wed,  7 May 2025 09:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746610857;
	bh=DflWMP1YuzuQ5vH06lh0le/JMRdskS8d8TMO2J6HC2w=;
	h=From:To:Cc:Subject:Date:From;
	b=nO0G0+p1yzuIVfKNUQeJFrPfTHo4qyQd0iVxKNi8CO+gEAQwDYpg9XCJBxKWdsPhW
	 sQxjCWuRqrX74RcH9zNCSS1F1m7mKoeoapjlM6t0qgYMp2lzCHw5Asb4G6XDSCNINO
	 TvUezUYwKjoy6Q5a/1GQv7zy/KtMJ3X9xQEiYaSrEEe2SAxnAU2M3wEn3pVUtCetIH
	 VmOBAkqqwHBDpO7wkPaccCi1hTwoVqJF3JO8X5dsAzpNnf8WTR2V4/HNN2yaD7fyZy
	 WjRsKGnB38w1JtF3sty1bKJ6rI61gwIO+U1Ef2lWnQs69He/xzBfj7Hw6W1r33VLGY
	 m5w2w9ZVGWFBw==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nvme@lists.infradead.org,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] net/handshake: Add new parameter 'HANDSHAKE_A_ACCEPT_KEYRING'
Date: Wed,  7 May 2025 11:40:49 +0200
Message-Id: <20250507094049.26181-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Hannes Reinecke <hare@kernel.org>

Add a new netlink parameter 'HANDSHAKE_A_ACCEPT_KEYRING' to provide
the serial number of the keyring to use.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 include/uapi/linux/handshake.h | 1 +
 net/handshake/tlshd.c          | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index 3d7ea58778c9..662e7de46c54 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -45,6 +45,7 @@ enum {
 	HANDSHAKE_A_ACCEPT_PEER_IDENTITY,
 	HANDSHAKE_A_ACCEPT_CERTIFICATE,
 	HANDSHAKE_A_ACCEPT_PEERNAME,
+	HANDSHAKE_A_ACCEPT_KEYRING,
 
 	__HANDSHAKE_A_ACCEPT_MAX,
 	HANDSHAKE_A_ACCEPT_MAX = (__HANDSHAKE_A_ACCEPT_MAX - 1)
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index d6f52839827e..081093dfd553 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -230,6 +230,12 @@ static int tls_handshake_accept(struct handshake_req *req,
 		if (ret < 0)
 			goto out_cancel;
 	}
+	if (treq->th_keyring) {
+		ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEYRING,
+				  treq->th_keyring);
+		if (ret < 0)
+			goto out_cancel;
+	}
 
 	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_AUTH_MODE,
 			  treq->th_auth_mode);
-- 
2.35.3


