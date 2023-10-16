Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0445C41513
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 23:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CMSvdMv5ORPzvcdgmy/csbGYAGQ7uVpCgqzYGAKIR+k=; b=H42tfrUceqUZrMcDsRWa/Ar3Qf
	pe+FO2prcR947yAk3JLTwdSWzDHh88fgBwXyjxfGwwiIqj6bqAgOoRT2Zwurx8RAT2dTMOmYn5BRH
	2DWpDs1lAEaawX8K0APMH3A/55Qk7fqztnVKZ6ghwoEBzbn5JNdON53eykFIRcUIRO+vHON7KscOR
	eCsuoCcvSpmtyEbhjQNuWLvzvrJehHhFbJl0iaxasHF6gbgf0TtxXOM96JSsXaP0a0VsAwUcpgIaB
	P8L4WqiP03h31c6Hr21ikUh2lfQzzUgExeJPpuVEwtLJQaU4Tl189qaL4+wyPKoFFA0U7F1gbQS+h
	HpNuja5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsWZ9-00AmSM-1W;
	Mon, 16 Oct 2023 23:00:03 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsWZ5-00AmQO-35
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 23:00:01 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 863AB24002A
	for <linux-nvme@lists.infradead.org>; Tue, 17 Oct 2023 00:59:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697497198; bh=e/5Tq8mpMYFzV9iwEEcLoCLz0k+o4VrsmcZ/cYdtLww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=mFwnzH/dCSbg254F+1fJ/qnNuV9LnSM9dAXfq4u+EzeUtGgSte60xd6Pp0ArZ9Fk+
	 kc+DoD7qHcW6vQXObYxgEIJIKcBhkw+F74AJ10Ubrcr3I5T6ZJv7+EGS2sESsBd4q0
	 vPESqkUkInNmBOuFUamKVnp4iAfVdgt8tGdRuxHuzHiomI9LJqbW7QcqqIwG6VjErw
	 JXj3OPW0VIttmEusrAnzxLYKuPeC30Bqe1segyOb/xp41bTQBigoEV9avfPm2c3m9z
	 xJsc+fz7R4NFN4H0Ml/t/NiDkZtU8LOd07RneZ5eNR3yNgRKSIzhq+41C8iGZW1+7T
	 07Ydq+M9ydyJw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S8Xcs0mk7z9rxR;
	Tue, 17 Oct 2023 00:59:57 +0200 (CEST)
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
Subject: [PATCH v3 3/3] nvme-auth: allow mixing of secret and hash lengths
Date: Mon, 16 Oct 2023 22:58:57 +0000
Message-Id: <20231016225857.3085234-4-shiftee@posteo.net>
In-Reply-To: <20231016225857.3085234-1-shiftee@posteo.net>
References: <20231016225857.3085234-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_160000_545947_3E231C0D 
X-CRM114-Status: GOOD (  10.30  )
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
index 647931acc1ba..c2273bc0fa56 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -182,14 +182,6 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
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


