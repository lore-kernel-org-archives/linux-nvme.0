Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C292C77B78
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 06:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sgcbHjUM943PrxMYrNm3+n6vXvKWv1aWg1e0dDLWooY=; b=cnVaqRj2/pQ/j1Jyxzkn/arugU
	FDUcSzLI80u8GH3b1V4LvDepFgvnsM9hkylgNKaOOqlQvI9MVb+hhY+YU9LDCK4lQd2HJJBey+69r
	1Zvit5CJ4Hl6Y1dgtELBfzGQeT/VrQo/cREc8DtqQenWPqxGKdCf3yR0HMWUYSfs01eDHGUEjPJkG
	iUz13zmKBg5a9e8A9w9DU1bnddnHrUX45GO9pZGu7SrfpS+2ymlEgLNsNyjAt1IJgYCftLwASdgiv
	OLZ4zyoPCEJbeyjQmu52UiH4RhTjqvWFa9Ol/hRoxUtRbS/wK950zszEVHGkzZRGoTbrN3z8kIV2o
	o8ia4C1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp1l8-004IkS-17;
	Wed, 19 Apr 2023 06:57:42 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp1ks-004IY4-2r
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 06:57:29 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 4B29E219B3;
	Wed, 19 Apr 2023 06:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681887438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgcbHjUM943PrxMYrNm3+n6vXvKWv1aWg1e0dDLWooY=;
	b=OUIWane5/rjcL5Q8d9p4q/TcfPv6dixHVH/rUomfbpg+1IAO6JlP7b6Yqm7nm/RrrJ+0QS
	4OAErls1Mql9D6qtDkvQIyXPIFUBxPujZkqXetUuwtlKIkkRwHyMu2mWCJsyb6Hkg0+X/G
	veZvddGpttD/Fclqr2P0U0PY/tloOuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681887438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgcbHjUM943PrxMYrNm3+n6vXvKWv1aWg1e0dDLWooY=;
	b=2lr1nYOqcGjYEjsNbOEcAYniDNlnleIKCeuzfGfQvuy+YqEPn4D8mHPMoTQuqu+6uR5MZp
	0FFxrmqTbNMxnQAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 3237B2C15A;
	Wed, 19 Apr 2023 06:57:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 154E851C26D9; Wed, 19 Apr 2023 08:57:18 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 09/17] security/keys: export key_lookup()
Date: Wed, 19 Apr 2023 08:57:06 +0200
Message-Id: <20230419065714.52076-10-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230419065714.52076-1-hare@suse.de>
References: <20230419065714.52076-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_235727_376237_08971DAE 
X-CRM114-Status: GOOD (  11.92  )
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


