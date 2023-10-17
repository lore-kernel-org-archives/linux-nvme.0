Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6613CDB474
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 10:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MgYSQUsaCKTBOjvnSrqGBHDLXVdDU+83yjZTXDijhpU=; b=R9ztmVFouL0iybJPBQ3jAlQNLo
	tWvAuAfzsvE3RoEOEoT7ORshR583Efa8zr9fh17f09VNzxyEwS1EGlxHFLGPp07RiPNwjTabAoisr
	98uikqFF/PT81sbJPaSkFAjDpy7AnHwEs9EjYVywj9iOMJvsa9o5mbImmb8yzpQo4bES0Ys3k9I0+
	2lRsHoh118Yu+Xk/y49cuS0X5mIhCuVzC+ceibAdhbI2YkycLWj9y4ryZoeebBWhvN5CgeFABOnmU
	2qFJbwgDdFd18jy85iub0W1LnlmlWkDI7X+6TV8ITKUQlzbmHb6bidZ42ij7MM2SXMpOnyu4IGieG
	E/gFJFtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qshhP-00C8Af-0v;
	Tue, 17 Oct 2023 10:53:19 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qshhL-00C87z-0h
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 10:53:17 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id A56D6240101
	for <linux-nvme@lists.infradead.org>; Tue, 17 Oct 2023 12:53:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697539990; bh=QzwVfBdifB51edMzB/+yD4kt6tOaLkGIgcIPJIModxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=pEcE4rLHEDQ1ldQlDn9UAH6zsBnG37g3Ze2AQBI6PpnTYdFEeardtvkqkUL9v3pJi
	 cM80Zgch2X8y0Hd/PB/p7+JBH82s+UAXfLJeH1SWXt8JlprhonIoz+Osjy5IuDE37k
	 3mIz2sIZJgXuHDJ5ajybp0zgEjznvQqt+jiufTsH/kLdP7N1dmNhQMEKwN05h9p2+9
	 Z1TybwjxgdK+RS8R3tepSpjvcE/seF9JMvYg0Wp7faQxgWAqLOqGmv0eegutk6lwH/
	 C2oFqxK6ZD94lpdwOdvbPq/O4xNgfo4hpgPkIUJj0S+17WKP04HeSuE9GDqR2QfhxY
	 vS78FKCqaVBdA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S8rRn34mlz6tvp;
	Tue, 17 Oct 2023 12:53:09 +0200 (CEST)
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
Subject: [PATCH v4 3/3] nvme-auth: allow mixing of secret and hash lengths
Date: Tue, 17 Oct 2023 10:52:51 +0000
Message-Id: <20231017105251.3274652-4-shiftee@posteo.net>
In-Reply-To: <20231017105251.3274652-1-shiftee@posteo.net>
References: <20231017105251.3274652-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_035315_405030_3064F0A8 
X-CRM114-Status: GOOD (  10.33  )
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
index f9e7ed8e729d..ddfcc3889fec 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -190,14 +190,6 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
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


