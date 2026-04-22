Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F68BFA1FE7
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 19:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WrJ1fF90FZLG9ya38hr9n+8x6xZoakkZ8wfk0YYKt8k=; b=uMY4UVpkfRvzOJ/mnu9VmcBj1G
	uGVuYESobtQfvNF1rvdazjA5SjaCW8fPbrZiRT7IViDJI2QyM92czu7Yt9RSTLsNvAlQBXRJKISJD
	y4+44KsO69e1/4aq0Rb7LPZfja+KTbup7zNSucbFwyVllgOK1E93DM5sP8pUMkpZ2wgpOLEd7Wttj
	qs90igLTCZqZdvw9vVbd1q8/pY823QIWf5Z3C/OftPT4gCeXo9ESj3NjgSoXaxyPSfr+v94NTq7pe
	nHkN+6dgH2PqB6Qov3xYx2+DUrXvh8HVUK2ZNo0UoEp06buTo2OTK/oqyzzGIT1RaN61NeNeuYvKR
	6YzsrR/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFcv3-0000000AfX0-3dOK;
	Wed, 22 Apr 2026 19:07:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFcv0-0000000AfWQ-2KnE
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 19:07:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776884843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WrJ1fF90FZLG9ya38hr9n+8x6xZoakkZ8wfk0YYKt8k=;
	b=FNUiahEuR54PtqKfHlWxXMvOCLo8L+qrAdOOb8tSMHHTnQ29F8ME9Fd9+avOrBgUuzrLR8
	dilAukQCT+bOml2GV9Z+zzuh66sVENcMsYnWmpMXQz5M3XRW0ca1dRWsR+j8wqK5xxKrjo
	VBbdW+zCbNtmFdIKmlC2mvirAWfz7tE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-n_iTRVgdOXShu67Rlv-7nQ-1; Wed,
 22 Apr 2026 15:07:18 -0400
X-MC-Unique: n_iTRVgdOXShu67Rlv-7nQ-1
X-Mimecast-MFC-AGG-ID: n_iTRVgdOXShu67Rlv-7nQ_1776884835
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77EFA18003F6;
	Wed, 22 Apr 2026 19:07:14 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (unknown [10.2.17.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7187330001A1;
	Wed, 22 Apr 2026 19:07:11 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 REPOST] nvme-auth: Hash DH shared secret to create session key
Date: Wed, 22 Apr 2026 12:06:36 -0700
Message-ID: <20260422190636.2651992-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ATDIB1-a_Kr3HYZIRmZngtjva3TnBX32VIuTeCzayYo_1776884835
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_120726_670643_E53A57D9 
X-CRM114-Status: GOOD (  22.98  )
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

The NVMe Base Specification 8.3.5.5.9 states that the session key Ks
shall be computed from the ephemeral DH key by applying the hash
function selected by the HashID parameter.

The current implementation stores the raw DH shared secret as the
session key without hashing it. This causes redundant hash operations:

1. Augmented challenge computation (section 8.3.5.5.4) requires
   Ca = HMAC(H(g^xy mod p), C). The code compensates by hashing the
   unhashed session key in nvme_auth_augmented_challenge() to produce
   the correct result.

2. PSK generation (section 8.3.5.5.9) requires PSK = HMAC(Ks, C1 || C2)
   where Ks should already be H(g^xy mod p). As the DH shared secret
   is always larger than the HMAC block size, HMAC internally hashes
   it before use, accidentally producing the correct result.

When using secure channel concatenation with bidirectional
authentication, this results in hashing the DH value three times: twice
for augmented challenge calculations and once during PSK generation.

Fix this by:
- Modifying nvme_auth_gen_shared_secret() to hash the DH shared secret
  once after computation: Ks = H(g^xy mod p)
- Removing the hash operation from nvme_auth_augmented_challenge()
  as the session key is now already hashed
- Updating session key buffer size from DH key size to hash output size
- Adding specification references in comments

This avoid storing the raw DH shared secret and reduces the number of
hash operations from three to one when using secure channel
concatenation.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Chris Leech <cleech@redhat.com>
---
v2 repost: just collecting reviewed tags and starting a new thread
v2: 
- Renamed nvme_auth_gen_session_key() arguments from ctrl_key to
  public_key, as it is the peers public DH key and this code is also
  used on the target/controller side when the peer is the host.
- Changed argument validation from erroring on sess_key_len < hash_len
  to sess_key_len != hash_len to be more precise in calling requirements

created on the nvme-7.1 branch
this depends on Eric Biggers "nvme-auth use crypto library" patches 
from <20260302075959.338638-1-ebiggers@kernel.org>

 drivers/nvme/common/auth.c | 94 ++++++++++++++++++++++++++++++--------
 drivers/nvme/host/auth.c   | 13 +++---
 drivers/nvme/target/auth.c | 15 +++---
 include/linux/nvme-auth.h  |  6 +--
 4 files changed, 92 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 2d325fb930836..77f1d22512f8f 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -351,18 +351,29 @@ struct nvme_dhchap_key *nvme_auth_transform_key(
 }
 EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
 
+/**
+ * nvme_auth_augmented_challenge() - Compute the augmented DH-HMAC-CHAP challenge
+ * @hmac_id: Hash algorithm identifier
+ * @skey: Session key
+ * @skey_len: Length of @skey
+ * @challenge: Challenge value
+ * @aug: Output buffer for the augmented challenge
+ * @hlen: Hash output length (length of @challenge and @aug)
+ *
+ * NVMe base specification 8.3.5.5.4: The augmented challenge is computed
+ * applying the HMAC function using the hash function H() selected by the
+ * HashID parameter ... with the hash of the ephemeral DH key ... as HMAC key
+ * to the challenge C (i.e., Ca = HMAC(H(g^xy mod p), C)).
+ *
+ * As the session key skey is already H(g^xy mod p) per section 8.3.5.5.9, use
+ * it directly as the HMAC key without additional hashing.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
 int nvme_auth_augmented_challenge(u8 hmac_id, const u8 *skey, size_t skey_len,
 				  const u8 *challenge, u8 *aug, size_t hlen)
 {
-	u8 hashed_key[NVME_AUTH_MAX_DIGEST_SIZE];
-	int ret;
-
-	ret = nvme_auth_hash(hmac_id, skey, skey_len, hashed_key);
-	if (ret)
-		return ret;
-	ret = nvme_auth_hmac(hmac_id, hashed_key, hlen, challenge, hlen, aug);
-	memzero_explicit(hashed_key, sizeof(hashed_key));
-	return ret;
+	return nvme_auth_hmac(hmac_id, skey, skey_len, challenge, hlen, aug);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_augmented_challenge);
 
@@ -403,33 +414,76 @@ int nvme_auth_gen_pubkey(struct crypto_kpp *dh_tfm,
 }
 EXPORT_SYMBOL_GPL(nvme_auth_gen_pubkey);
 
-int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
-		const u8 *ctrl_key, size_t ctrl_key_len,
-		u8 *sess_key, size_t sess_key_len)
+/**
+ * nvme_auth_gen_session_key() - Generate an ephemeral session key
+ * @dh_tfm: Diffie-Hellman transform with local private key already set
+ * @public_key: Peer's public key
+ * @public_key_len: Length of @public_key
+ * @sess_key: Output buffer for the session key
+ * @sess_key_len: Size of @sess_key buffer
+ * @hash_id: Hash algorithm identifier
+ *
+ * NVMe base specification 8.3.5.5.9: The session key Ks shall be computed from
+ * the ephemeral DH key (i.e., g^xy mod p) ... by applying the hash function
+ * H() selected by the HashID parameter ... (i.e., Ks = H(g^xy mod p)).
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int nvme_auth_gen_session_key(struct crypto_kpp *dh_tfm,
+		const u8 *public_key, size_t public_key_len,
+		u8 *sess_key, size_t sess_key_len, u8 hash_id)
 {
 	struct kpp_request *req;
 	struct crypto_wait wait;
 	struct scatterlist src, dst;
+	u8 *dh_secret;
+	size_t dh_secret_len, hash_len;
 	int ret;
 
-	req = kpp_request_alloc(dh_tfm, GFP_KERNEL);
-	if (!req)
+	hash_len = nvme_auth_hmac_hash_len(hash_id);
+	if (!hash_len) {
+		pr_warn("%s: invalid hash algorithm %d\n", __func__, hash_id);
+		return -EINVAL;
+	}
+
+	if (sess_key_len != hash_len) {
+		pr_warn("%s: sess_key buffer missized (%zu != %zu)\n",
+			__func__, sess_key_len, hash_len);
+		return -EINVAL;
+	}
+
+	dh_secret_len = crypto_kpp_maxsize(dh_tfm);
+	dh_secret = kzalloc(dh_secret_len, GFP_KERNEL);
+	if (!dh_secret)
 		return -ENOMEM;
 
+	req = kpp_request_alloc(dh_tfm, GFP_KERNEL);
+	if (!req) {
+		ret = -ENOMEM;
+		goto out_free_secret;
+	}
+
 	crypto_init_wait(&wait);
-	sg_init_one(&src, ctrl_key, ctrl_key_len);
-	kpp_request_set_input(req, &src, ctrl_key_len);
-	sg_init_one(&dst, sess_key, sess_key_len);
-	kpp_request_set_output(req, &dst, sess_key_len);
+	sg_init_one(&src, public_key, public_key_len);
+	kpp_request_set_input(req, &src, public_key_len);
+	sg_init_one(&dst, dh_secret, dh_secret_len);
+	kpp_request_set_output(req, &dst, dh_secret_len);
 	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				 crypto_req_done, &wait);
 
 	ret = crypto_wait_req(crypto_kpp_compute_shared_secret(req), &wait);
-
 	kpp_request_free(req);
+
+	if (ret)
+		goto out_free_secret;
+
+	ret = nvme_auth_hash(hash_id, dh_secret, dh_secret_len, sess_key);
+
+out_free_secret:
+	kfree_sensitive(dh_secret);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(nvme_auth_gen_shared_secret);
+EXPORT_SYMBOL_GPL(nvme_auth_gen_session_key);
 
 int nvme_auth_parse_key(const char *secret, struct nvme_dhchap_key **ret_key)
 {
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 63f543e809985..16de4499a8e7d 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -588,7 +588,7 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 	}
 
 gen_sesskey:
-	chap->sess_key_len = chap->host_key_len;
+	chap->sess_key_len = chap->hash_len;
 	chap->sess_key = kmalloc(chap->sess_key_len, GFP_KERNEL);
 	if (!chap->sess_key) {
 		chap->sess_key_len = 0;
@@ -596,16 +596,17 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 		return -ENOMEM;
 	}
 
-	ret = nvme_auth_gen_shared_secret(chap->dh_tfm,
-					  chap->ctrl_key, chap->ctrl_key_len,
-					  chap->sess_key, chap->sess_key_len);
+	ret = nvme_auth_gen_session_key(chap->dh_tfm,
+					chap->ctrl_key, chap->ctrl_key_len,
+					chap->sess_key, chap->sess_key_len,
+					chap->hash_id);
 	if (ret) {
 		dev_dbg(ctrl->device,
-			"failed to generate shared secret, error %d\n", ret);
+			"failed to generate session key, error %d\n", ret);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return ret;
 	}
-	dev_dbg(ctrl->device, "shared secret %*ph\n",
+	dev_dbg(ctrl->device, "session key %*ph\n",
 		(int)chap->sess_key_len, chap->sess_key);
 	return 0;
 }
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index c35c427ca2ac1..9a2eccdc8b133 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -447,18 +447,19 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	int ret;
 
-	req->sq->dhchap_skey_len = ctrl->dh_keysize;
+	req->sq->dhchap_skey_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
 	req->sq->dhchap_skey = kzalloc(req->sq->dhchap_skey_len, GFP_KERNEL);
 	if (!req->sq->dhchap_skey)
 		return -ENOMEM;
-	ret = nvme_auth_gen_shared_secret(ctrl->dh_tfm,
-					  pkey, pkey_size,
-					  req->sq->dhchap_skey,
-					  req->sq->dhchap_skey_len);
+	ret = nvme_auth_gen_session_key(ctrl->dh_tfm,
+					pkey, pkey_size,
+					req->sq->dhchap_skey,
+					req->sq->dhchap_skey_len,
+					ctrl->shash_id);
 	if (ret)
-		pr_debug("failed to compute shared secret, err %d\n", ret);
+		pr_debug("failed to compute session key, err %d\n", ret);
 	else
-		pr_debug("%s: shared secret %*ph\n", __func__,
+		pr_debug("%s: session key %*ph\n", __func__,
 			 (int)req->sq->dhchap_skey_len,
 			 req->sq->dhchap_skey);
 
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index 184a1f9510fad..89902ae8b9298 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -49,9 +49,9 @@ int nvme_auth_augmented_challenge(u8 hmac_id, const u8 *skey, size_t skey_len,
 int nvme_auth_gen_privkey(struct crypto_kpp *dh_tfm, u8 dh_gid);
 int nvme_auth_gen_pubkey(struct crypto_kpp *dh_tfm,
 			 u8 *host_key, size_t host_key_len);
-int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
-				const u8 *ctrl_key, size_t ctrl_key_len,
-				u8 *sess_key, size_t sess_key_len);
+int nvme_auth_gen_session_key(struct crypto_kpp *dh_tfm,
+			      const u8 *public_key, size_t public_key_len,
+			      u8 *sess_key, size_t sess_key_len, u8 hash_id);
 int nvme_auth_generate_psk(u8 hmac_id, const u8 *skey, size_t skey_len,
 			   const u8 *c1, const u8 *c2, size_t hash_len,
 			   u8 **ret_psk, size_t *ret_len);
-- 
2.53.0


