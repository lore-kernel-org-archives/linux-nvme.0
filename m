Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D0BD58E7C
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 08:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YbvRYinR34ex5OYjbUDv2W22IlP6ZzZEmSGjwbDXJcY=; b=MgnGEjM5NuVNP7UpYKA7w3NOBf
	KXw84578i1DfboVZ6tA7t57+rgPGFKEkuGpTcHwQjnRSL0DYNHRTBScqComT4J4ESGBzBAGQJoRS2
	oKDSE3T3p3gzngQLhTQ83xXfFrxs1eAgbkKQmwz4XjqEVPRqghF7EyRb665cgMxGJUiUKHp3bnXt4
	huipr3sqVhgN8oVkJl3mURwRKRRWjPTnGpMMZaL0h80ARwSvbddik9TpPglFndGTbed/YyxMYiJ6d
	v2X1fvx42D3OO8Kvfr6di+4TGWXYC8P5ltmLkYLN9eKabtmMvY0/UNVyI87tFKOqjjQLkX/DJkXl1
	9nhw6SUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDb-0000000CSln-3RYS;
	Mon, 02 Mar 2026 08:01:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDV-0000000CSbQ-3hhQ
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 08:01:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A74044598;
	Mon,  2 Mar 2026 08:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EED1C2BCB5;
	Mon,  2 Mar 2026 08:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438485;
	bh=SKD+JW332kXRCdhQRnaHNck9bMn8pphwU1y/tRmQvvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qeYgIhw/ycYFwMWG4AGBmYaJ9qMaF2z9C7jKG+r90n2L0+dUBMXOhDY6+6j9WPfLs
	 QERgP5PaOfDn6I63xsRlyqotuna/zWZo7rX2j57y2BRzxBGelSED4JJog+rSbI0qnF
	 ASuXzXD8Km05qMAcp26wLe7/xfxQ+oeJYZLxNCL//6hI/7AbIXFj98odWIdbtelNEo
	 xBrC7VfPoanB0MxLES33kir5ED7baUe3zo6eoThi1LhIr8b3YIgGmq+VlKvbrkZwJJ
	 oB9MyBDaQ2gXaFi1W5DWdDZPKt5fwH6edx9JZOwsjZTPkpuYvM5yl1i3ljEC/aeVbz
	 GM1YXbYin9QaQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 13/21] nvme-auth: host: use crypto library in nvme_auth_dhchap_setup_host_response()
Date: Sun,  1 Mar 2026 23:59:51 -0800
Message-ID: <20260302075959.338638-14-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302075959.338638-1-ebiggers@kernel.org>
References: <20260302075959.338638-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_000125_982232_AC88C6B8 
X-CRM114-Status: GOOD (  11.86  )
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

For the HMAC computation in nvme_auth_dhchap_setup_host_response(), use
the crypto library instead of crypto_shash.  This is simpler, faster,
and more reliable.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/host/auth.c | 59 ++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 47a1525e876e0..f22f17ad7e2f4 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -432,11 +432,11 @@ static int nvme_auth_set_dhchap_failure2_data(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 		struct nvme_dhchap_queue_context *chap)
 {
-	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
+	struct nvme_auth_hmac_ctx hmac;
 	u8 buf[4], *challenge = chap->c1;
 	int ret;
 
 	dev_dbg(ctrl->device, "%s: qid %d host response seq %u transaction %d\n",
 		__func__, chap->qid, chap->s1, chap->transaction);
@@ -452,17 +452,15 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 	} else {
 		dev_dbg(ctrl->device, "%s: qid %d re-using host response\n",
 			__func__, chap->qid);
 	}
 
-	ret = crypto_shash_setkey(chap->shash_tfm,
-			chap->transformed_key->key, chap->transformed_key->len);
-	if (ret) {
-		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
-			 chap->qid, ret);
+	ret = nvme_auth_hmac_init(&hmac, chap->hash_id,
+				  chap->transformed_key->key,
+				  chap->transformed_key->len);
+	if (ret)
 		goto out;
-	}
 
 	if (chap->dh_tfm) {
 		challenge = kmalloc(chap->hash_len, GFP_KERNEL);
 		if (!challenge) {
 			ret = -ENOMEM;
@@ -475,48 +473,33 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 						    chap->hash_len);
 		if (ret)
 			goto out;
 	}
 
-	shash->tfm = chap->shash_tfm;
-	ret = crypto_shash_init(shash);
-	if (ret)
-		goto out;
-	ret = crypto_shash_update(shash, challenge, chap->hash_len);
-	if (ret)
-		goto out;
+	nvme_auth_hmac_update(&hmac, challenge, chap->hash_len);
+
 	put_unaligned_le32(chap->s1, buf);
-	ret = crypto_shash_update(shash, buf, 4);
-	if (ret)
-		goto out;
+	nvme_auth_hmac_update(&hmac, buf, 4);
+
 	put_unaligned_le16(chap->transaction, buf);
-	ret = crypto_shash_update(shash, buf, 2);
-	if (ret)
-		goto out;
+	nvme_auth_hmac_update(&hmac, buf, 2);
+
 	*buf = chap->sc_c;
-	ret = crypto_shash_update(shash, buf, 1);
-	if (ret)
-		goto out;
-	ret = crypto_shash_update(shash, "HostHost", 8);
-	if (ret)
-		goto out;
-	ret = crypto_shash_update(shash, ctrl->opts->host->nqn,
-				  strlen(ctrl->opts->host->nqn));
-	if (ret)
-		goto out;
+	nvme_auth_hmac_update(&hmac, buf, 1);
+	nvme_auth_hmac_update(&hmac, "HostHost", 8);
+	nvme_auth_hmac_update(&hmac, ctrl->opts->host->nqn,
+			      strlen(ctrl->opts->host->nqn));
 	memset(buf, 0, sizeof(buf));
-	ret = crypto_shash_update(shash, buf, 1);
-	if (ret)
-		goto out;
-	ret = crypto_shash_update(shash, ctrl->opts->subsysnqn,
-			    strlen(ctrl->opts->subsysnqn));
-	if (ret)
-		goto out;
-	ret = crypto_shash_final(shash, chap->response);
+	nvme_auth_hmac_update(&hmac, buf, 1);
+	nvme_auth_hmac_update(&hmac, ctrl->opts->subsysnqn,
+			      strlen(ctrl->opts->subsysnqn));
+	nvme_auth_hmac_final(&hmac, chap->response);
+	ret = 0;
 out:
 	if (challenge != chap->c1)
 		kfree(challenge);
+	memzero_explicit(&hmac, sizeof(hmac));
 	return ret;
 }
 
 static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 		struct nvme_dhchap_queue_context *chap)
-- 
2.53.0


