Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9239C04A94
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 11:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gFv1GNXmaQGmSM+mG7gy4jwJID6bSTZqne91i6RpXC0=; b=0LeeNpzEw/6vpjvT1zNCEqsaEb
	f2Zo8igLYFSFXWXVLQYMgZsnk5oVMgAMpGuHB5vkxAOZ08JvWKHWzkiN3r2VP0FRH7t++mAr7jMuM
	mzm5zm4mq/0GZLqMeJCCGnduSkWj5frfEExELpumaCQI0pMMdnibxxmqfdTytMD5yBw8hPXeM6wsV
	AuDxtgJvtOGKIDd6fgagANtEcNZxwS8p0rr4lNo4At6m0E2E3dgroPGzqejJ4U0XEDr1fQSnCAxQl
	ynMFbnYdIko0tkQX1RQdGttfvgekCX4Teaap+TV7Pbj1DGSIjtYlXCOmmDUdYy66+WPHg8tlGpjGe
	Pg4AYmGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVVc8-00GunO-2D;
	Mon, 14 Aug 2023 11:20:00 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVVc2-00GuiL-2l
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 11:19:57 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 1A76721998;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692011992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFv1GNXmaQGmSM+mG7gy4jwJID6bSTZqne91i6RpXC0=;
	b=oZKWff0dsitH1nS8g7qGNsB9q0LKQBrzg8aPxU4rxYyvO/xLNf99lfM7WYoY9hx6QtIDfx
	2Xr2K3FIKl9Y+8fVp4vO5OYTMcTvgsfFW6AC/aFGdOEJvvUXJe9rb3HWtIAR1EQJOGemgU
	+wByAgS3UN98Ra1kdS5aiCVGgrkFB2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692011992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFv1GNXmaQGmSM+mG7gy4jwJID6bSTZqne91i6RpXC0=;
	b=Q3hfiOEaRC2b0xxdnSm+49b+VgqRssIrXAis5Yt3kqYfgGL+Fw8dAb9iqY5x0J4w3op+Y3
	3vKfFkF6aj+DFFCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 059882C153;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id F1F1551CB0CB; Mon, 14 Aug 2023 13:19:51 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 06/17] security/keys: export key_lookup()
Date: Mon, 14 Aug 2023 13:19:32 +0200
Message-Id: <20230814111943.68325-7-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230814111943.68325-1-hare@suse.de>
References: <20230814111943.68325-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_041955_112663_0416BBAD 
X-CRM114-Status: GOOD (  10.58  )
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

For in-kernel consumers one cannot readily assign a user (eg when
running from a workqueue), so the normal key search permissions
cannot be applied.
This patch exports the 'key_lookup()' function for a simple lookup
of keys without checking for permissions.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Acked-by: David Howells <dhowells@redhat.com>
---
 security/keys/key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/key.c b/security/keys/key.c
index 5c0c7df833f8..0260a1902922 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -693,6 +693,7 @@ struct key *key_lookup(key_serial_t id)
 	spin_unlock(&key_serial_lock);
 	return key;
 }
+EXPORT_SYMBOL(key_lookup);
 
 /*
  * Find and lock the specified key type against removal.
-- 
2.35.3


