Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23212CDB482
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 08:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IMQR5cNvM+ZVjAji+5R7a1XSgCNs6VwXtgxU/bgB4Eo=; b=tQNmbpXAZCQvb2mHpUzmIScwl1
	XJych3MANNsT7P1BSZl9w5Fz+rfryX/eOzGTuz9hjZHq/WpU1gYOCu50UeMJyVzHwRVFR7IwG7ID1
	B6ccd30BbJeqDgbN/F4QOa+ggXC4n8b5r0YMsoev3CuFvdGK4w6j0+3D53u5AdehhdMoysl9Gl1ni
	dGzxr5w+UphLEWSGG3zVTQf4Hkgc+v0pi62CJ7uMxEFbZ1KdtIPUjLXgprEbXRGuy1JS8BPIxiLuV
	J4SbeGIKFaEcDQkDn9WBw1IuSrFIX2g/0xVJZjwAJ8lUZZsEh9vyWhbhj7JO/F4WDCxiwbqwWBDha
	XSkcEGcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsJPl-008uQP-2U;
	Mon, 16 Oct 2023 08:57:29 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsJPh-008uOq-24
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 08:57:28 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 44E97240108
	for <linux-nvme@lists.infradead.org>; Mon, 16 Oct 2023 10:57:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697446644; bh=kv0HETudyLnK7zerm9neLvpDVJtlAcnFf3yrw1VeEJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=fl7cKXtKqgMoo+wm4CW5MibIn+9AP5TAEM+bUCfIFsikcsqq0zlIpFLLEMwrkkGU7
	 MqvGf107aMkBI3j4y7GOthQmbkYuntjHWmaHHZJnMezHHR5Da7ZJIQvlufzzJZJNn0
	 4irEZBPwawFDf29amh26/1rekW71at6oFz9wkszJtGJZHkxAqOnaHkNKOlT2POSLpC
	 nm3B99HsSTmzoubvKH2l+bTAbi1RoelQDSHIhAU1x7xsUza2EU2mM5wFQlVSK0+E7n
	 4CB6Vasig2VvGnYIodopcXpxCUqh9fvYiwczGez/vgPV7pWhd9lGkb+XU+All+BhzM
	 YDy61XdIgSfzg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S89wf3nYFz9rxd;
	Mon, 16 Oct 2023 10:57:22 +0200 (CEST)
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
Subject: [PATCH v2 1/2] nvme-auth: use transformed key size to create resp
Date: Mon, 16 Oct 2023 08:57:14 +0000
Message-Id: <20231016085715.3068974-2-shiftee@posteo.net>
In-Reply-To: <20231016085715.3068974-1-shiftee@posteo.net>
References: <20231016085715.3068974-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_015725_965933_53CFBCA4 
X-CRM114-Status: GOOD (  13.05  )
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

This does not change current behaviour as the driver currently
verifies that the secret size is the same size as the length of
the transformation hash.

Co-developed-by: Akash Appaiah <Akash.Appaiah@dell.com>
Signed-off-by: Akash Appaiah <Akash.Appaiah@dell.com>
Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
V1 -> V2: support target implementation and controller secrets also

 drivers/nvme/common/auth.c | 6 +++++-
 drivers/nvme/host/auth.c   | 4 ++--
 drivers/nvme/target/auth.c | 4 ++--
 include/linux/nvme-auth.h  | 3 ++-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index d90e4f0c08b7..26a7fbdf4d55 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -243,6 +243,8 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
 	}
 	if (key->hash == 0) {
 		transformed_key = kmemdup(key->key, key->len, GFP_KERNEL);
+		if (transformed_key)
+			key->transformed_len = key->len;
 		return transformed_key ? transformed_key : ERR_PTR(-ENOMEM);
 	}
 	hmac_name = nvme_auth_hmac_name(key->hash);
@@ -263,7 +265,8 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
 		goto out_free_key;
 	}
 
-	transformed_key = kzalloc(crypto_shash_digestsize(key_tfm), GFP_KERNEL);
+	key->transformed_len = crypto_shash_digestsize(key_tfm);
+	transformed_key = kzalloc(key->transformed_len, GFP_KERNEL);
 	if (!transformed_key) {
 		ret = -ENOMEM;
 		goto out_free_shash;
@@ -297,6 +300,7 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
 	kfree(shash);
 out_free_key:
 	crypto_free_shash(key_tfm);
+	key->transformed_len = 0;
 
 	return ERR_PTR(ret);
 }
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index daf5d144a8ea..89293da3210e 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -442,7 +442,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 	}
 
 	ret = crypto_shash_setkey(chap->shash_tfm,
-			chap->host_response, ctrl->host_key->len);
+			chap->host_response, ctrl->host_key->transformed_len);
 	if (ret) {
 		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
 			 chap->qid, ret);
@@ -520,7 +520,7 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 	}
 
 	ret = crypto_shash_setkey(chap->shash_tfm,
-			ctrl_response, ctrl->ctrl_key->len);
+			ctrl_response, ctrl->ctrl_key->transformed_len);
 	if (ret) {
 		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
 			 chap->qid, ret);
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 4dcddcf95279..c46473b383b1 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -298,7 +298,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	}
 
 	ret = crypto_shash_setkey(shash_tfm, host_response,
-				  ctrl->host_key->len);
+				  ctrl->host_key->transformed_len);
 	if (ret)
 		goto out_free_response;
 
@@ -410,7 +410,7 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	}
 
 	ret = crypto_shash_setkey(shash_tfm, ctrl_response,
-				  ctrl->ctrl_key->len);
+				  ctrl->ctrl_key->transformed_len);
 	if (ret)
 		goto out_free_response;
 
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index dcb8030062dd..cf24d885dfd9 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -10,8 +10,9 @@
 
 struct nvme_dhchap_key {
 	u8 *key;
-	size_t len;
 	u8 hash;
+	size_t len;
+	size_t transformed_len;
 };
 
 u32 nvme_auth_get_seqnum(void);
-- 
2.39.2


