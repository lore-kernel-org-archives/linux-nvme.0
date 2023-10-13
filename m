Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271B8CDB484
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 20:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1GLFrwGH4uXeFR8RVOdSkxb/2TdBOc0jUn6jf8KiE5U=; b=dK2ETZYTYMtohAyXlt6/hLuS9H
	ceR2kF8PfZ5H2iVeJOHiYsSpN9sMv6GPEON0luwtUgDmf8p/Ng1R6zUzeqUeWkS227dlNmLWaM7cm
	x4m7XELMidWdrjra9CJ9qsC3Lw1RfgRq5yu6qYruzT0RCAZZVD83sRlVmdQZ3fWmAX41f8lc4ouTX
	MeXBhu/jCvvSFLZfvDbEZwb2vt1BPplakG/pO5ysgOeEo4lLa/u7cpYbo6Le47pCauTMXO7F/L0Ns
	z/n07djJdqChY+v05qo6J2htYDDXWgtdvjc67v2Y6N2esWcik2PXQJ9ikUaPbHM2iWNTYrsnKbs1w
	DgH2miug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrOmX-004Dzl-24;
	Fri, 13 Oct 2023 20:29:13 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrOmT-004Dxf-1c
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 20:29:12 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 21BBD240104
	for <linux-nvme@lists.infradead.org>; Fri, 13 Oct 2023 22:29:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697228948; bh=PZesDCIO0qB1QiAn0VpqqXvIqc6VhWTAaPu3kq45sGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=p21QMCQZptEMN8nCgKKrSJyOyuSRMzuXEZInHKUlwjZmVMFuJHrKcz8TcT8Q5ijVU
	 P43BfasODEUKbqFXO9F01rmPwq5DRdF+NXCZQsVnmK5/FSX3z+04vB1/hnyFk4k4Td
	 q8WLruBeboMc5YIg/sVAfI1aeZq1gZRoXo816fyEM1valib3PmSo+RRqJLq3Cdcgaf
	 GgEf4Q9OLc32FJE6fz6Lyes1HNk9LPRLIPAFmP5+049kCOcGSijQI7G6dFGi8RupOH
	 rYLndMQal2wARJf1uLBEiw2hsixheq5cgvSysDglPh+fDIKoeX3iWSy9JZHDGq8XRF
	 V0iUHB9Qub+5A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S6dQB5FQ1z9rxF;
	Fri, 13 Oct 2023 22:29:06 +0200 (CEST)
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
Subject: [PATCH 2/2] nvme-auth: allow mixing of secret and hash lengths
Date: Fri, 13 Oct 2023 20:28:27 +0000
Message-Id: <20231013202827.2262708-3-shiftee@posteo.net>
In-Reply-To: <20231013202827.2262708-1-shiftee@posteo.net>
References: <20231013202827.2262708-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_132909_689315_3DCBFB55 
X-CRM114-Status: GOOD (  10.05  )
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
---
 drivers/nvme/common/auth.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index d90e4f0c08b7..176855f86f0d 100644
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


