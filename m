Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE40C04FE0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+dizRk+AKWPmujw+plYi8pUzy1hayXc2qUpknu/6dAE=; b=N0axF9vTdtJBdwcDzCognnTTup
	xoVRon1JIYylsv/qFB5EmGerhq9TZPrfUFe8qhO1e5zRaL5l9mG4EI+e1+8KKaygGzX33URwnbyIi
	2Oz4mqkUDXOVpR91J3mRnPJ6oAdD0X7BKgbt9waR5KmIV1315CNxIe125dVRb0w3fFWp432scd+RP
	FpZCIlJtEYo9G7lVQU50RyVyB2OMwqX+PLEYmYOiw5sAVGYlAZ9Nm8UrHzDnrq+EbHg25BX76jHva
	5kueBlxID21rOikF6HKwBJbBSaGettfEu90cElKJpJmNeDwaomn6RlMTe14ssg8spVO7PDy9WWKNK
	/SRUzUFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU7Fc-007yKR-19;
	Thu, 10 Aug 2023 15:07:00 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU7FL-007y4X-2E
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 15:06:47 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 0C33B1F86A;
	Thu, 10 Aug 2023 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691680001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+dizRk+AKWPmujw+plYi8pUzy1hayXc2qUpknu/6dAE=;
	b=bCswFyJcxq7kL8SqTG/iLtZfF6W6aZMDb5y8HYJG1kjKb4wfSgYPDHu++P+lcqVn/rIm/o
	nxgWsCV4ilXQ+Q7tMQg75UB0Cawcnpcvu99AMtGXPI7SzhOce3cw2YYiY90ZpzxWC8Qu10
	W/SdWllhq6AZ29YX5/eT+KVNYolXki4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691680001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+dizRk+AKWPmujw+plYi8pUzy1hayXc2qUpknu/6dAE=;
	b=ocjNRhRu6oReymssjOqKhADLR1RBMKoLABVZgBtmfs+uSuCUNOJsB3I3pfr2qZEoYv7bHa
	aDdPQj7VFGah5tCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id E989F2C143;
	Thu, 10 Aug 2023 15:06:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id F2AA051CAE48; Thu, 10 Aug 2023 17:06:39 +0200 (CEST)
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
Date: Thu, 10 Aug 2023 17:06:19 +0200
Message-Id: <20230810150630.134991-7-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810150630.134991-1-hare@suse.de>
References: <20230810150630.134991-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_080643_889538_8F2A5E0E 
X-CRM114-Status: GOOD (  10.60  )
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
index 5c0c7df833f8..bd1b7d45df90 100644
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


