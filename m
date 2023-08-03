Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DD7C001DF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Aug 2023 10:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sgcbHjUM943PrxMYrNm3+n6vXvKWv1aWg1e0dDLWooY=; b=hEkcMIc3EFnns19HLdEYL0sdpX
	KAziLg/8fOloks/3owvDuFng0vrdtUwrrvoLTsd3OxZrZZiNchOnRDd9tt+znU19cPiW3to7g6cpb
	vHTmZZ8F1Nr5huJ1r6hPjanoo+A5CFT1rN+q5hAoBqv8RNLp0avg3aRjKIVdvkGML6VNkqyrphBQ3
	HeFVQ4nYL86WMh1MT2TF4qqm9Bfg2IpE2MiBOmyQVG21yRJKP7Wo05gWWZFIO1gBn0i5IvzR16V4s
	d7iqb2nxysWv5tVzlSYjr3pKL+AnLv4h4JE6wgMc5lOPDRVHmG+UBWhSbgqXx0VMZVBd0nZXTJKrp
	gKQgLbcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVxj-007XcS-2W;
	Thu, 03 Aug 2023 10:53:47 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVxG-007XDY-2y
	for linux-nvme@lists.infradead.org;
	Thu, 03 Aug 2023 10:53:22 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 651232199F;
	Thu,  3 Aug 2023 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691059989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgcbHjUM943PrxMYrNm3+n6vXvKWv1aWg1e0dDLWooY=;
	b=faaV5hAbElwgoa4evY66TTT6bWVXUVIhrbqQ0EbKBDGaD5/M43c0HyfO5W6a2mRKsYyEws
	vAiPYXThrp1bQDXpEUw34BicTCyOpVJr+3cGYI2GS25EXr5W/Wsd4MUk5ym8Xc82Bn3IdB
	d3W5Bcsz5Mo/JDQzjY8zlS2xcBoL22Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691059989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgcbHjUM943PrxMYrNm3+n6vXvKWv1aWg1e0dDLWooY=;
	b=7BQlEaJOtLwj09QtTF+BI8eZL1hAE0RnXgc6pjslbWsYhjgoYsO1PKfrpib8J0966STDTu
	PKRCTYdCs2937+Bg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 54F652C14E;
	Thu,  3 Aug 2023 10:53:09 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 4DAAE51CA7CB; Thu,  3 Aug 2023 12:53:09 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 06/14] security/keys: export key_lookup()
Date: Thu,  3 Aug 2023 12:50:54 +0200
Message-Id: <20230803105102.30949-7-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230803105102.30949-1-hare@suse.de>
References: <20230803105102.30949-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_035319_131258_523CD676 
X-CRM114-Status: GOOD (  11.02  )
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


