Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB15C369D7
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lSrFeuwI+3l25sD3M3885NYuDR8f/fvFpQMnKnjOdNI=; b=xHo5SB5s7QVYa2q+hKoHtcZSbW
	fU5z5qy2m6Nh6d2FCXtig/MhlXtr+Aid0YDeRgQiQPttMC01z1I0VeLWwiVn8TGAkHbyHl4H4touA
	7FP/iuVamfjMflxv7imxaynJAVgneCilr6FgjwMJQQ23roYZcqbmqcZ/C6QNF6RXtt0FlDH8/wUHp
	+1AcQe79oGMNuceZhRS21d+8Wbo6opEymprgnU2ORNXK4eERURj0otnBfPJnhEW6sy0vPMcyCfrUa
	bfpCXersFjCvu4PAYn/ip59nQJE2A3Wpqdq5Nd0UCXtNiNeo68L4GTlvz7eVvFiooPWgcgt6keYVd
	3n2Dtm7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8H0U-0000000GtVM-0kni;
	Fri, 25 Apr 2025 11:14:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Fgs-0000000Gbse-123B
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 09:49:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A27FC5C5D07;
	Fri, 25 Apr 2025 09:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A0FC4CEEA;
	Fri, 25 Apr 2025 09:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745574589;
	bh=bQE7zhjLbf87DUX3ex69GDrTzmXutCS+KT1hnC2r3gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IWfv9QuM5WjVbOka/LpByGJxh4g3P7Uh8SLpZorZu1h2ReFSdNQN4SHyx44psuJay
	 vc3NEc39M+2lyLTUqlFjzDh+fEA8/fH09+Dq70h++DbjhfMxq56ug4CCzgN0/SgsRP
	 S6aWiJayI1jsfXcB9ua0v54Vzst+gBtKyKjKe9gJJIvrAs9wOWC2CutmkelHHdf0J5
	 brGGUoewombLF4a8R01o7qoxT0reryjCEj02efYNY60JNG/36Z9GsuEwNDylsgmK3O
	 Lv9q3tB6ZunzaJHHnNUp71W4yR5p383KkqvbNPqV8aU08KwCi7rj4BveIYylhnxroX
	 OVwUGP0V5JxSA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 04/12] nvme-auth: do not cache the transformed secret
Date: Fri, 25 Apr 2025 11:49:19 +0200
Message-Id: <20250425094927.102656-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250425094927.102656-1-hare@kernel.org>
References: <20250425094927.102656-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_024950_325625_3E89898C 
X-CRM114-Status: GOOD (  12.90  )
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

Only saving so much, and doesn't bring much benefit.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/auth.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 4b6dc1dd5f66..4e30a491e677 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -24,8 +24,6 @@ struct nvme_dhchap_queue_context {
 	struct nvme_ctrl *ctrl;
 	struct crypto_shash *shash_tfm;
 	struct crypto_kpp *dh_tfm;
-	u8 *transformed_secret;
-	size_t transformed_len;
 	void *buf;
 	int qid;
 	int error;
@@ -431,28 +429,25 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 		struct nvme_dhchap_queue_context *chap)
 {
 	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
+	u8 *transformed_secret;
+	size_t transformed_len;
 	u8 buf[4], *challenge = chap->c1;
 	int ret;
 
 	dev_dbg(ctrl->device, "%s: qid %d host response seq %u transaction %d\n",
 		__func__, chap->qid, chap->s1, chap->transaction);
 
-	if (!chap->transformed_secret) {
-		ret = nvme_auth_transform_key(ctrl->host_key,
-					      ctrl->opts->host->nqn,
-					      &chap->transformed_secret);
-		if (ret < 0)
-			return ret;
-		chap->transformed_len = ret;
-	} else {
-		dev_dbg(ctrl->device, "%s: qid %d re-using host response\n",
-			__func__, chap->qid);
-	}
+	ret = nvme_auth_transform_key(ctrl->host_key,
+				      ctrl->opts->host->nqn,
+				      &transformed_secret);
+	if (ret < 0)
+		return ret;
+	transformed_len = ret;
 
 	ret = crypto_shash_setkey(chap->shash_tfm,
-			chap->transformed_secret, chap->transformed_len);
+			transformed_secret, transformed_len);
 	if (ret) {
-		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
+		dev_warn(ctrl->device, "qid %d: failed to set host key, error %d\n",
 			 chap->qid, ret);
 		goto out;
 	}
@@ -509,6 +504,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 out:
 	if (challenge != chap->c1)
 		kfree(challenge);
+	kfree(transformed_secret);
 	return ret;
 }
 
@@ -657,9 +653,6 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 
 static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 {
-	kfree(chap->transformed_secret);
-	chap->transformed_secret = NULL;
-	chap->transformed_len = 0;
 	kfree_sensitive(chap->host_key);
 	chap->host_key = NULL;
 	chap->host_key_len = 0;
-- 
2.35.3


