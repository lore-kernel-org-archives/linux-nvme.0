Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF56C3ABC6
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 09:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lsXAE/37qAQ2veLfwLwdnHJFTg1bGwrE2gWCRdhRNQE=; b=Ez8OiJ+Z++MX5rLk8uCOzS9z4H
	vMQ3ANwtoUZMObl0cLb3WYJdZRjioYH+Rf5UIcMfHTgd4CduBL1EeKdYmPCJH94NnMwZmGNgyNdTP
	qZzVgqIIm8m97L5tp8yVXe8NYDLiFzC6dE9luEcBTOeOk5UJCVsOztQtTrcINQz4LE7teuz2mk9Mp
	Zy7+OFUsV1iwDQGgx4S83XKyXsbRVjIaBYy/ehC2ga/w/GeHF9y3lJsFVpFV1cscxX9xghozUkI7D
	c4/eXdqcN7A+DsN7ghK2HNrYZJHXTB2OVHKCDdPokP3eDZzSmD30/YLLUjoltE2CidgIBOJkoCE/Y
	L9Qi8jUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaxR-0000000EvHw-3GRq;
	Wed, 07 May 2025 09:20:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCa9B-0000000EjzY-0wo1
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 08:28:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 53691629E9;
	Wed,  7 May 2025 08:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B747BC4CEEB;
	Wed,  7 May 2025 08:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746606536;
	bh=v36C+tv2FudCMMhP7top3B3YzvHFkE3MN/XnZJ56pbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K87xbVW3+dmTESQNyTtS+1eQMN4DeHXX4WBDV6jvB1hZ1tC9rfy4rfjz5c26DU+uu
	 rmFar1tH7Wwh7KfWrHQvx3lkNzEatO5F25q+H2TXIG87Ewvaj7bHCr9faWfgXc3YBZ
	 0KpjDC0h0KsS2JZ0BDC+ORke7vDap6Jmim0q6s1H4Ovy/a0LaLDe4FfPyxWT7Jji0Q
	 UeK1aBUwS26uB4OBvGPMK1Y+RPOMoXNfPL+lUWYxZPlP38oQwD9GmAHCBeygoZjIjU
	 VQuNCdakMzyFNCeV729MEcpfNY71tU0IocJrfT58bOnSgXOyEh5GQAkBzzf4++yNuq
	 XOeBI/stUrV5g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/2] nvmet-auth: use SHASH_DESC_ON_STACK
Date: Wed,  7 May 2025 10:28:18 +0200
Message-Id: <20250507082818.46157-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250507082818.46157-1-hare@kernel.org>
References: <20250507082818.46157-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index cef8d77f477b..5dc9f3097c4c 100644
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


