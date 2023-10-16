Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8438ECDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 08:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9g8elNNSZrtscpGJBTobmscrbBNZtu0NhCoovM6FFsY=; b=Uz4WJuKLJ1LyYt9BIBDnMQUua/
	9XN74EkQw6gkBm0g+KI7xgaLCnBN2JZcIp0/21vmHIPOCHDalaUtcoUql85AdLgIh8u5S4bUSsiG/
	pzicrmzdldnlK3gS8LgO6u2JIykYNcTltGVWW/U/V2iKJKYwBSd5YKvgpwC1SgLiqbUQ8TibXu/w2
	u2/nUWsAYjqcUummoPUNFySB6NZIwZZhcwfXF8iQD/uZ7PKWL3i87mRoGB5hn6xoCnSnBLTDJVQjF
	g87wm3ZfO7p1tOKBDtDP+YJ+LzV402rfB/NSvvOO9MwmOZy7x84tMVGWrX5G1gpy/NLao4OxsXwTA
	r2wIgXQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsJPn-008uR2-1Z;
	Mon, 16 Oct 2023 08:57:31 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsJPj-008uPJ-2i
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 08:57:30 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 7ADD524002E
	for <linux-nvme@lists.infradead.org>; Mon, 16 Oct 2023 10:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697446646; bh=brODLvvYvkikrtNYqrnX6Dobqx5VOdIf75/P3TBpnxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=rz2yLfYBh0V5kX5rXYaSPuirzbRNh3TlARKEGFpk83Z1fEDqOkk8uoQwvUZ2x2R2p
	 7qhvUaxbbH8yOVvpm/7NqoMuQNdbF7qlPkPPB5dJultfzwkHORlLOfC7uRcNmzcOPU
	 gH0JZykB4FMxUM9dLD1RhEW1ThK80mIHB/yNX15jfxTFFXyRoFeCP4v/YIEduB/y1b
	 CE4a5IYhGK8guUXD+Db0sLNpS//yv2MnCyZtNGmrrFr7jD2PoLfQBHJBDrSsHTsUXY
	 cbAIl/2u7voMpgBUyE2AMdH9wwbrLx4NEogU379p2bVQKrLLBamF3JbjrKpjG6D1Fd
	 iJhgi/ZQPfdDw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S89wh1bVBz9rxj;
	Mon, 16 Oct 2023 10:57:24 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>,
	Akash Appaiah <Akash.Appaiah@dell.com>
Subject: [PATCH v2 2/2] nvme-auth: allow mixing of secret and hash lengths
Date: Mon, 16 Oct 2023 08:57:15 +0000
Message-Id: <20231016085715.3068974-3-shiftee@posteo.net>
In-Reply-To: <20231016085715.3068974-1-shiftee@posteo.net>
References: <20231016085715.3068974-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_015728_019050_C100D360 
X-CRM114-Status: GOOD (  10.09  )
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

We can now use any of the secret transformation hashes with a
secret, regardless of the secret size.
e.g. a 32 byte key with the SHA-512(64 byte) hash.

The example secret from the spec should now be permitted with
any of the following:
DHHC-1:00:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
DHHC-1:01:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
DHHC-1:02:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
DHHC-1:03:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:

Note: Secrets are still restricted to 32,48 or 64 bits.

Co-developed-by: Akash Appaiah <Akash.Appaiah@dell.com>
Signed-off-by: Akash Appaiah <Akash.Appaiah@dell.com>
Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/common/auth.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 26a7fbdf4d55..712178e1fb02 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -187,14 +187,6 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 		goto out_free_secret;
 	}
 
-	if (key_hash > 0 &&
-	    (key_len - 4) != nvme_auth_hmac_hash_len(key_hash)) {
-		pr_err("Mismatched key len %d for %s\n", key_len,
-		       nvme_auth_hmac_name(key_hash));
-		ret = -EINVAL;
-		goto out_free_secret;
-	}
-
 	/* The last four bytes is the CRC in little-endian format */
 	key_len -= 4;
 	/*
-- 
2.39.2


