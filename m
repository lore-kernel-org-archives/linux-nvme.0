Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974C5C04E69
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Aug 2023 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r44AGU89fbr2kIGCRc1HbALaa9GuRJqyF2xn832+/8s=; b=2WA0CNliRDIIOErnbcp1e7WihG
	INWA65Xh7LmZ9O8aEpJRP+Q5vaZGwLwXuxUl2olX84RFIWGbCg8iXAt/Xdz6pmM5VK9RsSmv2araT
	ngaiL3w+sWJFPVJMr4emJZzI/li794iAjqs0vLDSJvsbe/U7tQEd+TPhtG4w1wNQzN+1zw/m8OA4b
	nRsrT6jaepj+wdynfmQLVQBSZhffKpfKFMmUBfaDcZwAKfLDRUZ16LJdcus6K+DAabT7y8gL7LrZ8
	xNv0QagOeFup2XxFnesZbfQ76LRN3FnKhnLpmFFUSf/dj+ozYWMLTr9rLPqAsZNjmM/oEtpRC0PVU
	i0QYXoBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWFIK-0043sl-2q;
	Wed, 16 Aug 2023 12:06:36 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWFI9-0043iI-3B
	for linux-nvme@lists.infradead.org;
	Wed, 16 Aug 2023 12:06:29 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id E4E781F85D;
	Wed, 16 Aug 2023 12:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692187583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r44AGU89fbr2kIGCRc1HbALaa9GuRJqyF2xn832+/8s=;
	b=pfwIWy6xKl5ejb5DsVAUn15cHxOdKB69KlQQCw5M+sio8JVAu54uyR6Ld9UOPiIf6Agq/V
	GEJxnozHHt1UURO190QIVtwtiz3Elke0BTTDQ57urvp9SIrhMlNs2hX0AZd65QDu5crjhM
	SMy4helWJ5xzWJl5ORofj/y4Jw9HCjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692187583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r44AGU89fbr2kIGCRc1HbALaa9GuRJqyF2xn832+/8s=;
	b=lKkzH4ejyfdPPf+CKr6pDXrRSn2Ser15umktIljh2X0bXDNb5/YRvfHKYQFpZhmMsHAW2I
	812qaHKIG0HdnLBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B7A582C15C;
	Wed, 16 Aug 2023 12:06:23 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id A474151CB228; Wed, 16 Aug 2023 14:06:23 +0200 (CEST)
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
Subject: [PATCH 06/18] security/keys: export key_lookup()
Date: Wed, 16 Aug 2023 14:05:56 +0200
Message-Id: <20230816120608.37135-7-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230816120608.37135-1-hare@suse.de>
References: <20230816120608.37135-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_050626_166456_90A3ACD7 
X-CRM114-Status: GOOD (  12.35  )
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
 include/linux/key.h | 1 +
 security/keys/key.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/key.h b/include/linux/key.h
index 938d7ecfb495..943a432da3ae 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -515,6 +515,7 @@ extern void key_init(void);
 #define key_init()			do { } while(0)
 #define key_free_user_ns(ns)		do { } while(0)
 #define key_remove_domain(d)		do { } while(0)
+#define key_lookup(k)			NULL
 
 #endif /* CONFIG_KEYS */
 #endif /* __KERNEL__ */
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


