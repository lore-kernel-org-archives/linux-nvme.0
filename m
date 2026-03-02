Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21C7D58E73
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 08:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jeTWbzy29dJx0b4GO1wdb7g+6wjnmPByLQv6b5yRFdA=; b=iWid4r4el23fNw6Ftlgi+SxQo1
	dx7H1uJ/ErT57vKG8JK5QUmNlRbhA1JrTLzrEsR4SOp31PHD4VO5SIIPJnB/xx3E3M9lG7SCnSNoX
	jOr0ll0rF8vNpqg4qUS+n6bBQz+Q1TaS62LB8VDhyRakyHY6HVgxS+U1G4N5tpnTJe/VjLJkBY/Qy
	Ot2rnyaV7HxifPn18x5g868tV0YpELZTSCzfZSqHx38y5yKM+hIwKP7X38IXqTTmpmQuiI5+xICI4
	7EWxOrUmf97fDkv4IrhboxTwETy6wgTRKgob7SH7CqYS5y/nLqnF6Uvjo26G7fLC82hzZp1eYfa07
	by2VdvkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDc-0000000CSmi-1dtk;
	Mon, 02 Mar 2026 08:01:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDX-0000000CSdU-0o7v
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 08:01:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9EF7E600B0;
	Mon,  2 Mar 2026 08:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B08C2BCAF;
	Mon,  2 Mar 2026 08:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438486;
	bh=o0SzMwmhs68jxLgExtyOWQABbfkTZFlkpk/nVETOC1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJs4g56JqYSP4oPFx4omBiRs5/Ajd5OQCvW8QBQNR+1AwfsZCTNdUuWlZCqYM/UaK
	 qGZbE76KFXo3uojwPmPIUFFAuEDN5RRpbcYCB4mxDxWXVnZKstCImKAeNHt13CLzQC
	 5ik5y2OyyQ1+4hhF7FfSdwoq3Ubfw7B1mZZGyqA/9B4Q4Sk7pQitfndYlXWMeTB4fD
	 PgYb+yrGXmlXA/arKUAkh4PdQIPNQ7oFXHrTsxk/uhG8If0MjlQ2zHuaBzL6TxTKOD
	 nQsn/jJHUCywq6T8P9Wzvqbb/d375S+5OBBBvNwkFtoqrPBZEWP3wKgkiF7BQJaWBH
	 dk7BCMWV4niGQ==
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
Subject: [PATCH 15/21] nvme-auth: host: remove allocation of crypto_shash
Date: Sun,  1 Mar 2026 23:59:53 -0800
Message-ID: <20260302075959.338638-16-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302075959.338638-1-ebiggers@kernel.org>
References: <20260302075959.338638-1-ebiggers@kernel.org>
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

Now that the crypto_shash that is being allocated in
nvme_auth_process_dhchap_challenge() and stored in the
struct nvme_dhchap_queue_context is no longer used, remove it.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/host/auth.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 2f27f550a7442..c8cd633cb0eae 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -5,11 +5,10 @@
 
 #include <linux/crc32.h>
 #include <linux/base64.h>
 #include <linux/prandom.h>
 #include <linux/unaligned.h>
-#include <crypto/hash.h>
 #include <crypto/dh.h>
 #include "nvme.h"
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
 #include <linux/nvme-keyring.h>
@@ -20,11 +19,10 @@ static mempool_t *nvme_chap_buf_pool;
 
 struct nvme_dhchap_queue_context {
 	struct list_head entry;
 	struct work_struct auth_work;
 	struct nvme_ctrl *ctrl;
-	struct crypto_shash *shash_tfm;
 	struct crypto_kpp *dh_tfm;
 	struct nvme_dhchap_key *transformed_key;
 	void *buf;
 	int qid;
 	int error;
@@ -181,42 +179,21 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 			 chap->qid, data->hashid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
 		return -EPROTO;
 	}
 
-	if (chap->hash_id == data->hashid && chap->shash_tfm &&
-	    !strcmp(crypto_shash_alg_name(chap->shash_tfm), hmac_name) &&
-	    crypto_shash_digestsize(chap->shash_tfm) == data->hl) {
+	if (chap->hash_id == data->hashid && chap->hash_len == data->hl) {
 		dev_dbg(ctrl->device,
 			"qid %d: reuse existing hash %s\n",
 			chap->qid, hmac_name);
 		goto select_kpp;
 	}
 
-	/* Reset if hash cannot be reused */
-	if (chap->shash_tfm) {
-		crypto_free_shash(chap->shash_tfm);
-		chap->hash_id = 0;
-		chap->hash_len = 0;
-	}
-	chap->shash_tfm = crypto_alloc_shash(hmac_name, 0,
-					     CRYPTO_ALG_ALLOCATES_MEMORY);
-	if (IS_ERR(chap->shash_tfm)) {
-		dev_warn(ctrl->device,
-			 "qid %d: failed to allocate hash %s, error %ld\n",
-			 chap->qid, hmac_name, PTR_ERR(chap->shash_tfm));
-		chap->shash_tfm = NULL;
-		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
-		return -ENOMEM;
-	}
-
-	if (crypto_shash_digestsize(chap->shash_tfm) != data->hl) {
+	if (nvme_auth_hmac_hash_len(data->hashid) != data->hl) {
 		dev_warn(ctrl->device,
 			 "qid %d: invalid hash length %d\n",
 			 chap->qid, data->hl);
-		crypto_free_shash(chap->shash_tfm);
-		chap->shash_tfm = NULL;
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
 		return -EPROTO;
 	}
 
 	chap->hash_id = data->hashid;
@@ -656,12 +633,10 @@ static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 
 static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
 {
 	nvme_auth_reset_dhchap(chap);
 	chap->authenticated = false;
-	if (chap->shash_tfm)
-		crypto_free_shash(chap->shash_tfm);
 	if (chap->dh_tfm)
 		crypto_free_kpp(chap->dh_tfm);
 }
 
 void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl)
-- 
2.53.0


