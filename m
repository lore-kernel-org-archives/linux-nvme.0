Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57A3C6FA8F
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Aug 2023 14:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r44AGU89fbr2kIGCRc1HbALaa9GuRJqyF2xn832+/8s=; b=uls+dlxzQKGTeRGjqh5bYgs2r8
	I63h27YpWxXF7L0NTFIZp7UpVLlCeWmzTgakAtL25fB5EdTGC92uXSNUTzwDGsgq0daDJE93ul9iA
	i2KZVhDw0x70zKvYn+LojVAR420BRO0ufJ0AffIRSfVrcPrWbBmidtD1rqAdWMJPqsvG6ioZOghiG
	Q8jSpo6whokDHEVVcKWI0teIy6ZGIKCmQRlqRGZyg89eWbD101K4d1aFjSeDBw6tX4cVpLpcOAWOP
	u+F+ghsKND/8Wx4KTgWiMQjw/d07ceCbPZ3q26wh5Q2N6qG3Rq/tSAJDTyAHCbDl+vlfjkq8GDhsR
	LhBmjczQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBUu-003FP5-2c;
	Thu, 24 Aug 2023 14:39:44 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBUj-003FCs-0u
	for linux-nvme@lists.infradead.org;
	Thu, 24 Aug 2023 14:39:35 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id C16CA2081D;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692887966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r44AGU89fbr2kIGCRc1HbALaa9GuRJqyF2xn832+/8s=;
	b=OCRA0NzR+sy4NqMiPZpA4mWjI414BKP0hXHlZ9dJ8VllSpC84g9cXsuTlEff3mTzRwb1Zk
	0CKZGjOYlW9mJDri5TNEtxwF2LfnQSrHyKiHwMBcFbGQPZZ1TN//aEQPG8Wqm0GT2mt+dZ
	OqekzmowzPx8DPJofniVPA8QdNnNjZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692887966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r44AGU89fbr2kIGCRc1HbALaa9GuRJqyF2xn832+/8s=;
	b=H0MBguMsARLRtxtyccBEEFk5tL53jEC09d/viUlP2/VuK5g+UrYuXl8+I/RRNPtc0nS8jy
	7Q52XaYrAjRIbsDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B531F2C14F;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id B26DE51CB8C3; Thu, 24 Aug 2023 16:39:26 +0200 (CEST)
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
Date: Thu, 24 Aug 2023 16:39:13 +0200
Message-Id: <20230824143925.9098-7-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230824143925.9098-1-hare@suse.de>
References: <20230824143925.9098-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_073933_460921_E7BB733A 
X-CRM114-Status: GOOD (  12.23  )
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


