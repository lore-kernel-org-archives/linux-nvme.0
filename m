Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C71CCA472
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 14:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rCby7RSGgJOPOjFe4EbgrqVLYf9CZqlsG//4VZU1QJ4=; b=xVOivGFVHNctZwVdBAft6HHK5/
	S81LFpgwRA9G+HIjiqr4TDey/MkbLyeKe0JYA5RxOaQlO9ELH6u4aUauadTalC2OMtvd4WOjiQUbn
	vj8DYyoOrpyy82AHKtDPQ4zjyoPS0qZlrXLmnSbhK2iVlWGdlItQ2MjLcySEdxkApDBhEw3yV2UA9
	UZvkSjKQQaXS9T5d504RMHehRtYJ7jsydP6v6xlbcsVoCUD0SQ4EeyWV4ruohKR2+0U+H0oCxS+tg
	ljkpB40u0VagAaAzeaS5JgwAPd/QpCYmQmJ0GpJoBnCcG/9nsF0dyF2TuyUSUIOat4AwAe0MmeH4m
	PGzbmJqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3xij-00000008A47-1uQi;
	Wed, 01 Oct 2025 14:22:17 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3xih-00000008A2B-2Ck6
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 14:22:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B121540322;
	Wed,  1 Oct 2025 14:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B350C4CEF5;
	Wed,  1 Oct 2025 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759328534;
	bh=i9l/j6UudWk8LVHeOzd5dLEcSMgstXKbR/Ps7dQ21IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZZJxFSAeOrxbCcJ37DQSD+Vu2XSSpM5cFzql7wJuafgrxceKKsj6y3dCMrS6wBqv
	 61J4r+4unLRAGAxQTPtxAjxmNCfqurqfnsQPjMoP77QTesAW3+mRwXXk4LQ6VFz/GU
	 xSJKCtcimNqNaofqtiPfjHUqm7qmxO9EOvOgNqKcp/6Tb+b2dtOvERmmBMzBKH6W08
	 2a02uMF8B4gqCsnn0FEj+NOD4o/sxYKaPnp15OXUvJ3w15A02ei9sj9A7bel93kIc8
	 8Ch0tDUvzvYEIGFzNSD+dLgraCuxqmS46OW7VPYjTQnFgaNZ8DS3uyvzwdGlU8c8/D
	 W+ZErIXNe0sqw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/3] nvme-keyring: typo in nvme_dhchap_psk_lookup()
Date: Wed,  1 Oct 2025 16:21:59 +0200
Message-ID: <20251001142200.61696-3-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001142200.61696-1-hare@kernel.org>
References: <20251001142200.61696-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_072215_585497_D7F7F916 
X-CRM114-Status: GOOD (  11.30  )
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

Spurious semicolon in the function stub nvme_dhchap_psk_lookup().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509302259.Yku13u90-lkp@intel.com/
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 include/linux/nvme-keyring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index d8baa71f061d..6115bf5cf346 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -50,7 +50,7 @@ static inline struct key *nvme_dhchap_psk_refresh(struct key *keyring,
 	return ERR_PTR(-ENOTSUPP);
 }
 static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
-		const char *hostnqn, const char *subnqn, u8 hmac);
+		const char *hostnqn, const char *subnqn, u8 hmac)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
-- 
2.43.0


