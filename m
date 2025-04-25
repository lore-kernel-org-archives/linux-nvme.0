Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5243C369D5
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YlcnA4h8MuczpUWyKZWIZNOmMUKvQv4GzmN3dlWS3k8=; b=ZTb0468J1ywJW8buN4xvjRhFwQ
	O9fB6TmSxY+Rrrz3kgRRm1/HovHL4tb1ShS6YJHzISsVkTP1MZ01Aze+fm1M5RKaLfbzVmeSvGXzM
	miHh/hal5udPGD6Y20K7XFP4grGLwqRXyRl+dqrh8Cj47XcvcO84gDNcJgs0pYh7xJ904B6MxMDCU
	k+rZi84rGIBxHqHAK+SsJk9cSt32b+LWMnXsLmd13fIYcJpeGJaGwyVddgrtueFQdM+mlNV8kKf56
	P3r/NYBRvVbTQOKaUtXayvfSPemr1qX/Giw32aqMRzzvGjCCu8bkJFofvK1nFQsp4ZG6Wx0nLRp95
	Y0S9PMhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8H0T-0000000GtUq-21IE;
	Fri, 25 Apr 2025 11:14:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Fgq-0000000Gbrw-1ZIM
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 09:49:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 317A04A870;
	Fri, 25 Apr 2025 09:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BD1C4CEEA;
	Fri, 25 Apr 2025 09:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745574587;
	bh=4L6xcVj9VCjwKCMPEFEfNatRh++ToqhZuCFlLi/xhpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=htx3/pwWZgSwGGzwV9FTGOJLcD/zqAMaAelLBL4jin1mOacht7B3pSsvShLFgJAAc
	 dYMgrRr/CnstR+0TDC08QaXHXku2Ns7t4mWdKv2t4hQayVDQazHABwFZNusiDHPSTW
	 q98sPDIrXVDIbCL+gdN+MzoSRy04b2f0uaFCEi7bvBOLIFUxLe72XRfV9M0VqonLsg
	 nkB6HI9HO6QVUuL4I+TDAEqdcY4s83rMd+Phg+4Nd9NZ13Pi7eewH9dz+fPf35Ccgi
	 m1FSi6tcCY47Hb77umqJR9HTVKYHFOlrS0g3CdMGfERvBq+vIMLmyWXgUK0UumdQKs
	 kaMCPtIMxtHhA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 03/12] nvmet-auth: use SHASH_DESC_ON_STACK
Date: Fri, 25 Apr 2025 11:49:18 +0200
Message-Id: <20250425094927.102656-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250425094927.102656-1-hare@kernel.org>
References: <20250425094927.102656-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_024948_428391_C675AF4B 
X-CRM114-Status: GOOD (  10.66  )
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

Use SHASH_DESC_ON_STACK to avoid explicit allocation.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/auth.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 46a25b76544d..bb2b7bda308b 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -290,7 +290,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int shash_len)
 {
 	struct crypto_shash *shash_tfm;
-	struct shash_desc *shash;
+	SHASH_DESC_ON_STACK(shash, shash_tfm);
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	const char *hash_name;
 	u8 *challenge = req->sq->dhchap_c1;
@@ -342,19 +342,13 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 						    req->sq->dhchap_c1,
 						    challenge, shash_len);
 		if (ret)
-			goto out_free_challenge;
+			goto out;
 	}
 
 	pr_debug("ctrl %d qid %d host response seq %u transaction %d\n",
 		 ctrl->cntlid, req->sq->qid, req->sq->dhchap_s1,
 		 req->sq->dhchap_tid);
 
-	shash = kzalloc(sizeof(*shash) + crypto_shash_descsize(shash_tfm),
-			GFP_KERNEL);
-	if (!shash) {
-		ret = -ENOMEM;
-		goto out_free_challenge;
-	}
 	shash->tfm = shash_tfm;
 	ret = crypto_shash_init(shash);
 	if (ret)
@@ -389,8 +383,6 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 		goto out;
 	ret = crypto_shash_final(shash, response);
 out:
-	kfree(shash);
-out_free_challenge:
 	if (challenge != req->sq->dhchap_c1)
 		kfree(challenge);
 out_free_response:
-- 
2.35.3


