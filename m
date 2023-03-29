Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E05C761A6
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 14:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pCtaP9beJ7whuRGtckdI0e9bOwhehZSrmwfkRW3uOc0=; b=QBMxNJ0O5DDwX4vXaQP4H1l1T8
	JMcQTxOHtFPd8AMHxWZFcD82jxI6uPjje1oeHSlGeS0up4BYFC37sAYE7S8geaKZRJGr1SmozvFp3
	SMjp3F7WTdggVoRPs7IcbmAtjBSPSnlOwoDtoVnIEDuUcJToKHeVGsW+GCY+CxoN8svqeuJCAuzVS
	CvtNTmfojl9Z/gVDQTbD4x/45xJ606wenwvqxzrpvNnxw6Xd5gZlFluw90YXFgEH00TsOoB3NuO/7
	ADRdO72mHsti3Jm44CzCfKfsqmYLczdmCfHyRqu8Ulv9XoU1ZmtUhO6T4g5bW9m9bFFNbmsjsl4/x
	tE4S0wwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLH-000Ull-2f;
	Wed, 29 Mar 2023 13:59:59 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLD-000Ugx-0l
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 13:59:56 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id C3E891FDEE;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680098389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCtaP9beJ7whuRGtckdI0e9bOwhehZSrmwfkRW3uOc0=;
	b=G/jRegTlQjVQm4o4eRV3Pqrw/1IuOH0dicK1FB9aNO5poZYeSajbdkX2f7nYtlICkPZt+H
	TPIwvSNn/jLpTqGvK2E0oJVt2ndQpoW4HoWT4RUGakfLfXGB/D9pDSZNwMGJ+fdM+DxqiH
	+uqMf7TW83sM/R8dKVqa+i4ntlPgVIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680098389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCtaP9beJ7whuRGtckdI0e9bOwhehZSrmwfkRW3uOc0=;
	b=3NMakry93izUO0j7ni8vl6+XtOZe9zoHfJf9RYSRsRGySyc3/DL9GhaGPv5pLoNiTSY3aV
	r1ACCjhnSmZ2//AA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B12C12C178;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id AB28751BF382; Wed, 29 Mar 2023 15:59:49 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/18] security/keys: export key_lookup()
Date: Wed, 29 Mar 2023 15:59:28 +0200
Message-Id: <20230329135938.46905-9-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329135938.46905-1-hare@suse.de>
References: <20230329135938.46905-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_065955_440824_61F9FE65 
X-CRM114-Status: UNSURE (   9.98  )
X-CRM114-Notice: Please train this message.
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


