Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B69C04FE1
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=syCOzHYGMstv0ON3xH8NMsvosggH9HqCSSSsNSck9TI=; b=DZ7Df0YwPnKjo/yfFw8RfImA/v
	AngtmUbPTMhp0wDbHCeTrcqF8uj6bo+AoxIiUqVIFoO2JojTWCcA2Xf3RQYC500KZMtZH+9rJacga
	DQtssbGctPcN2gfujwdRkw8cOqc6plaNcnwvb+85QEx9aCMpylUH/2wqPRvMzGWcZLeGfpYckER9b
	nITGni0cHyZOZ+zfQNxu4tIuxhvX9sfWLZ+QeauWQaJ6Ev0K4om3BpM+Faic04v1CfaARleT0n1eL
	CBtQIBC6eRWTiSRYYfX2/8xwzsh9HE6xNKA3uX3AoCU4NnevtTWBraf4h+h1Zlk7QP86fyAMcc6LK
	X5D9cq8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTPyO-00322n-26;
	Tue, 08 Aug 2023 16:54:20 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTPyG-0031wj-0d
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 16:54:17 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 38BF52243E;
	Tue,  8 Aug 2023 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691513648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syCOzHYGMstv0ON3xH8NMsvosggH9HqCSSSsNSck9TI=;
	b=ZOqzEvODjxE10g2deRIa/UA+xadk+P3hTvZFRarZlU8RXaWc8GEwTKJu2kBEh02SQ1T/YK
	qVw1HltQ9fzPxh56sJTBgwO1V4Dl70vyjLXhK9TsXchhkKFi+u9EQ+j+6BiV/ORN7Tpupi
	Hex26f848sGoEI8KUZStpX1H0ZeESA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691513648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syCOzHYGMstv0ON3xH8NMsvosggH9HqCSSSsNSck9TI=;
	b=yhQTLqKobMOeX+ZgGNZmUmMci3AZEszcAMIItEwTRdNMTRHhm6GKEnPVXCa9xB/ycDipCx
	wXnkLdRo8uIl3LAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 279F92C14E;
	Tue,  8 Aug 2023 16:54:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 2007751CACF1; Tue,  8 Aug 2023 18:54:08 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 06/16] security/keys: export key_lookup()
Date: Tue,  8 Aug 2023 18:53:44 +0200
Message-Id: <20230808165354.123499-7-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230808165354.123499-1-hare@suse.de>
References: <20230808165354.123499-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_095414_957212_45B1ECD6 
X-CRM114-Status: GOOD (  10.68  )
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

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 security/keys/key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/key.c b/security/keys/key.c
index 5c0c7df833f8..bd1b7d45df90 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -693,6 +693,7 @@ struct key *key_lookup(key_serial_t id)
 	spin_unlock(&key_serial_lock);
 	return key;
 }
+EXPORT_SYMBOL_GPL(key_lookup);
 
 /*
  * Find and lock the specified key type against removal.
-- 
2.35.3


