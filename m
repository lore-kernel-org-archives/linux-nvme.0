Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5502606A329
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=acpJyMfX;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIjF8Jqu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=N+NkVP4Bqe11Md8HQfIrYCtHEgpGbIAgjQAWinaA3P8=; b=acpJyMfX9zDB7v
	0ZiXRZUDglLet+PsMv0HxdaIlY2UWgKUn9uqI311RQCtdhXyDKejgn1yQAmUewEw0pf2bx91M7haB
	8TwlXltQwAS6npEVx8tbT+2z11DGvcxlpgmPowpBcGliYzabP0VAxIcVnpNde4fVThHwziHBL3pra
	hsFtQhMuDo70xYPZNn9H7Ls4J2g6WGPPgQmtUCKvXeyVmnAbSwYo9sRCuVWtHzevBTXGQqJwd7Hfi
	srj8Rfv/k2OJ/a+GVONZ0yxa46jvXgnMCLaI7FYneMhuFxMmJxPf7pKvkVEanERV6KXF5HbSDpaYp
	dWD+pLzBnAOs3zEnGgJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM45N-000000077eY-1qY5;
	Wed, 28 Oct 2026 13:53:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM45K-000000077ax-2T5U
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 13:52:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7221A600C8;
	Wed, 28 Oct 2026 13:52:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793195577;
	b=oLYG+Z08H3ZtX5qa9Wjg3ztCNZVL8Sq2NA1lH3lgV9q/U1L39LqB5gPAX4FCwVUHHodW
	 v8IinjoO4NqfVu2iSPdxi0be2lTtJkk5vvo/GTo0Ejh8d2SOv3LDMN+l2H08n8i+RTIRJ
	 38PLN9d1+tUfYdCaNeMGNmCNcdoLIQv97IqWLIUf956BBnj7NCNxKsN1FXjY6bohvZEOF
	 RhqHVNlAsQYaOvv4b230VKXkGCmX0rQat9sDRwfZWEB9IZfVWzG8LsRVqJOOfBGIfVMbn
	 acAJGlHlUkxE1V37KOTEAXRfuJHl1fqdXxKbWZqFh9xLGSnpcWBTytJbLPC+wkfwHRw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793195577;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=N+NkVP4Bqe11Md8HQfIrYCtHEgpGbIAgjQAWinaA3P8=;
	b=dZjJIKcZSZgM+PvIu8e6Rv1kniQu18Yh+WuDIX67miB7Ncu3UlEninhV2W2YDpAOAbZN
	 Yo2AO36n/gV25wCYu7TQR4LxeoxIw9F0tv6psi8Ap54Mylu6F38GbTR1tIVuv32wmCthE
	 r4+RGq2xIrXi1CkD1P/tWeY5V0gLeuVBIIWWPtjh9k0GiyOa6A0F/RM4/1Z68+Co4Xgxl
	 on3gt99L8Ki3Bbl2BgtJi4upDTt06v0exkXz9Wc4uXwQh67vY5uf57Hf+MbIgtxA76Wpu
	 2cjvZQS5P9AkAD2Z7+M1xCbuz80QO4oLzou9uakPC5k3+Cq2tXzi5n0auc8AEm9VysQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C78D01F031E3;
	Wed, 28 Oct 2026 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793195577;
	bh=N+NkVP4Bqe11Md8HQfIrYCtHEgpGbIAgjQAWinaA3P8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hIjF8JquirvH//JsaWTocmX5Nm5Je+QQ8l7g1vWBXCaU0j0pMswZRbRIRekzYm2aV
	 5PrEC5yvtBx6jlzYmxEsHKfbQV7hza6SVEgUvkDaTYm0Y3Nfu/Wy2qupw2sGfbSwwZ
	 aZDaHI3T++Ljq54P9HbfLttxEzRBMNjpIDqarWDUEb0NKsZpQraxkxpkUyp4/q1i7/
	 qFVvoxky2zNxRG5hPYaCZsaxNbLm8hHQlPK4NcRxZfd1KO1Pbc8JGawS54usjDeeAw
	 yxMNEWqGaZsbKRnVCmR1iHw5AM4xi0m5RUBm5tHl3E32jd2sbFfxg1PuOpI4KMwtz2
	 /pjwa8btpJOUg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E1E0845498;
	Wed, 28 Oct 2026 13:52:53 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Wed, 28 Oct 2026 09:52:55 -0400
Subject: [PATCH RFC net-next v2 5/5] selftests/tls: add KeyUpdate tests
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-keyupdate-rfc-v2-5-eb5143b4c487@gmail.com>
References: <20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com>
In-Reply-To: <20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>, Chuck Lever <cel@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Martin Belanger <martin.belanger@dell.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793195573; l=14717;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=euGu27Fn9pivPB5DT8Yvti9FtNh59GoiCM6RB2LjB+o=;
 b=8NLtORR6yzxk5BHswtQ2F8cMVO3jXuT1aR+jk+ahE1eJ9VmnMBP+iQsMGeyBYtGheyWYwJPGi
 1HyUuynQJDyDQsBlaZh+RTIJvVOZ4Uz2c4y3MFXpYZSF2nEJy+bhSCL
X-Developer-Key: i=martin.nvme.dev@gmail.com; a=ed25519;
 pk=4K+XXetGK35w2LzRRddd/bbHawZU222BN+YZRuSpN+k=
X-Endpoint-Received: by B4 Relay for martin.nvme.dev@gmail.com/20261014
 with auth_id=1176
X-Original-From: Martin Belanger <martin.nvme.dev@gmail.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: martin.nvme.dev@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Martin Belanger <martin.belanger@dell.com>

Test the in-kernel KeyUpdate on a bidirectional connection with both
traffic secrets registered on each socket:

- registration errors: wrong length, missing key, TLS 1.2, SM4, the
  RX secret before the TX secret, and a secret that does not give the
  installed key;
- KeyUpdates in both directions with data around them;
- a data record, a KeyUpdate and another data record queued before
  the first read;
- update_requested: the peer answers before its next data, and a
  second request waits for the answer;
- splice() across a KeyUpdate;
- a key installed with TLS_TX removes the registered secrets;
- after a key installed with TLS_RX, a new update_requested is
  accepted;
- TLS_TX_KEY_UPDATE on a shut down socket does not raise SIGPIPE;
- more than 8 KeyUpdates in one second, and an invalid
  request_update value, end the connection.

The keys are derived from the secrets with HKDF-Expand-Label, with the
HMAC of the kernel through AF_ALG.

Assisted-by: LLM
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 tools/testing/selftests/net/config |   4 +
 tools/testing/selftests/net/tls.c  | 412 +++++++++++++++++++++++++++++++++++++
 2 files changed, 416 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index cb8cb4696df7..0de4011cfabd 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -10,8 +10,12 @@ CONFIG_CAN_VXCAN=m
 CONFIG_CGROUPS=y
 CONFIG_CRYPTO_ARIA=y
 CONFIG_CRYPTO_CHACHA20POLY1305=m
+CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_SM4_GENERIC=y
+CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_BTF_MODULES=n
 CONFIG_DUMMY=y
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 9d3cd4fff062..775d347d54ea 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -11,6 +11,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 
+#include <linux/if_alg.h>
 #include <linux/tls.h>
 #include <linux/tcp.h>
 #include <linux/socket.h>
@@ -2390,6 +2391,417 @@ TEST_F(tls, rekey_poll_delay)
 	}
 }
 
+#ifndef SOL_ALG
+#define SOL_ALG 279
+#endif
+
+/* RFC 9846 section 7.1, HKDF-Expand-Label with an empty context, for an
+ * output no longer than the hash. The HMAC comes from the kernel.
+ */
+static bool hkdf_expand_label(const unsigned char *secret, int secret_len,
+			      const char *label, unsigned char *out,
+			      int out_len)
+{
+	struct sockaddr_alg sa = {
+		.salg_family = AF_ALG,
+		.salg_type = "hash",
+	};
+	unsigned char info[2 + 1 + 255 + 1 + 1], md[48];
+	int tfm, op, n = 0, label_len = 6 + strlen(label);
+	bool ok = false;
+
+	strcpy((char *)sa.salg_name,
+	       secret_len == 48 ? "hmac(sha384)" : "hmac(sha256)");
+
+	info[n++] = out_len >> 8;
+	info[n++] = out_len;
+	info[n++] = label_len;
+	memcpy(info + n, "tls13 ", 6);
+	memcpy(info + n + 6, label, label_len - 6);
+	n += label_len;
+	info[n++] = 0;	/* context */
+	info[n++] = 1;	/* HKDF-Expand counter */
+
+	tfm = socket(AF_ALG, SOCK_SEQPACKET, 0);
+	if (tfm < 0)
+		return false;
+	if (bind(tfm, (struct sockaddr *)&sa, sizeof(sa)) ||
+	    setsockopt(tfm, SOL_ALG, ALG_SET_KEY, secret, secret_len))
+		goto out;
+
+	op = accept(tfm, NULL, 0);
+	if (op < 0)
+		goto out;
+	ok = write(op, info, n) == n && read(op, md, secret_len) == secret_len;
+	close(op);
+	if (ok)
+		memcpy(out, md, out_len);
+out:
+	close(tfm);
+	return ok;
+}
+
+/* Fill @keys with the key and IV that @secret gives, record number 0 */
+static bool keyupdate_keys(uint16_t cipher_type, const unsigned char *secret,
+			   int secret_len, struct tls_crypto_info_keys *keys)
+{
+	unsigned char *key, *salt, *iv;
+	int key_len, salt_len, iv_len;
+	unsigned char nonce[12];
+
+	tls_crypto_info_init(TLS_1_3_VERSION, cipher_type, keys, 0);
+
+	switch (cipher_type) {
+	case TLS_CIPHER_AES_GCM_128:
+		key = keys->aes128.key;
+		salt = keys->aes128.salt;
+		iv = keys->aes128.iv;
+		key_len = sizeof(keys->aes128.key);
+		salt_len = sizeof(keys->aes128.salt);
+		iv_len = sizeof(keys->aes128.iv);
+		break;
+	case TLS_CIPHER_AES_GCM_256:
+		key = keys->aesgcm256.key;
+		salt = keys->aesgcm256.salt;
+		iv = keys->aesgcm256.iv;
+		key_len = sizeof(keys->aesgcm256.key);
+		salt_len = sizeof(keys->aesgcm256.salt);
+		iv_len = sizeof(keys->aesgcm256.iv);
+		break;
+	case TLS_CIPHER_AES_CCM_128:
+		key = keys->aesccm128.key;
+		salt = keys->aesccm128.salt;
+		iv = keys->aesccm128.iv;
+		key_len = sizeof(keys->aesccm128.key);
+		salt_len = sizeof(keys->aesccm128.salt);
+		iv_len = sizeof(keys->aesccm128.iv);
+		break;
+	case TLS_CIPHER_CHACHA20_POLY1305:
+		key = keys->chacha20.key;
+		salt = keys->chacha20.salt;
+		iv = keys->chacha20.iv;
+		key_len = sizeof(keys->chacha20.key);
+		salt_len = 0;
+		iv_len = sizeof(keys->chacha20.iv);
+		break;
+	default:
+		return false;
+	}
+
+	if (!hkdf_expand_label(secret, secret_len, "key", key, key_len) ||
+	    !hkdf_expand_label(secret, secret_len, "iv", nonce,
+			       salt_len + iv_len))
+		return false;
+
+	memcpy(salt, nonce, salt_len);
+	memcpy(iv, nonce + salt_len, iv_len);
+	return true;
+}
+
+/* In-kernel KeyUpdate: fd and cfd both register the TX and RX traffic
+ * secrets of a bidirectional connection. Returns false if the variant
+ * does not support it.
+ */
+static bool keyupdate_setup(struct __test_metadata *_metadata,
+			    FIXTURE_DATA(tls) *self,
+			    const FIXTURE_VARIANT(tls) *variant)
+{
+	struct tls_crypto_info_keys keys_a, keys_b;
+	unsigned char secret_a[48], secret_b[48];
+	int len;
+
+	if (self->notls || variant->tls_version != TLS_1_3_VERSION)
+		return false;
+
+	switch (variant->cipher_type) {
+	case TLS_CIPHER_AES_GCM_128:
+	case TLS_CIPHER_AES_CCM_128:
+	case TLS_CIPHER_CHACHA20_POLY1305:
+		len = 32;
+		break;
+	case TLS_CIPHER_AES_GCM_256:
+		len = 48;
+		break;
+	default:
+		return false;
+	}
+
+	memset(secret_a, 0xa5, sizeof(secret_a));
+	memset(secret_b, 0x5a, sizeof(secret_b));
+
+	/* the keys must be the ones that the secrets give */
+	ASSERT_TRUE(keyupdate_keys(variant->cipher_type, secret_a, len,
+				   &keys_a));
+	ASSERT_TRUE(keyupdate_keys(variant->cipher_type, secret_b, len,
+				   &keys_b));
+
+	/* fd -> cfd: replace the keys of the fixture */
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &keys_a,
+			     keys_a.len), 0);
+	EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &keys_a,
+			     keys_a.len), 0);
+	/* cfd -> fd */
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_RX, &keys_b,
+			     keys_b.len), 0);
+	EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_TX, &keys_b,
+			     keys_b.len), 0);
+
+	/* the RX secret needs the TX secret first */
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_RX_TRAFFIC_SECRET,
+			     secret_b, len), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX_TRAFFIC_SECRET,
+			     secret_a, len), 0);
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_RX_TRAFFIC_SECRET,
+			     secret_b, len), 0);
+	EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_TX_TRAFFIC_SECRET,
+			     secret_b, len), 0);
+	EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX_TRAFFIC_SECRET,
+			     secret_a, len), 0);
+
+	return true;
+}
+
+static void keyupdate_send(struct __test_metadata *_metadata, int fd,
+			   int request)
+{
+	EXPECT_EQ(setsockopt(fd, SOL_TLS, TLS_TX_KEY_UPDATE,
+			     &request, sizeof(request)), 0);
+}
+
+static void send_recv_str(struct __test_metadata *_metadata, int from, int to,
+			  const char *str)
+{
+	int len = strlen(str) + 1;
+	char buf[64];
+
+	EXPECT_EQ(send(from, str, len, 0), len);
+	EXPECT_EQ(recv(to, buf, sizeof(buf), 0), len);
+	EXPECT_EQ(memcmp(buf, str, len), 0);
+}
+
+TEST_F(tls, keyupdate_secret_errors)
+{
+	unsigned char secret[48] = {};
+	int one = 1;
+
+	if (self->notls)
+		SKIP(return, "no TLS support");
+
+	/* no secret registered */
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX_KEY_UPDATE,
+			     &one, sizeof(one)), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	if (variant->tls_version != TLS_1_3_VERSION) {
+		EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX_TRAFFIC_SECRET,
+				     secret, 32), -1);
+		EXPECT_EQ(errno, EINVAL);
+		return;
+	}
+
+	if (variant->cipher_type == TLS_CIPHER_SM4_GCM ||
+	    variant->cipher_type == TLS_CIPHER_SM4_CCM) {
+		EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX_TRAFFIC_SECRET,
+				     secret, 32), -1);
+		EXPECT_EQ(errno, EOPNOTSUPP);
+		return;
+	}
+
+	/* the RX key is not installed on fd */
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_RX_TRAFFIC_SECRET,
+			     secret, 32), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* wrong length */
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX_TRAFFIC_SECRET,
+			     secret, 16), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* the installed key does not come from this secret */
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX_TRAFFIC_SECRET, secret,
+			     variant->cipher_type == TLS_CIPHER_AES_GCM_256 ?
+			     48 : 32), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(tls, keyupdate)
+{
+	int i;
+
+	if (!keyupdate_setup(_metadata, self, variant))
+		SKIP(return, "no in-kernel KeyUpdate for this variant");
+
+	send_recv_str(_metadata, self->fd, self->cfd, "before");
+
+	/* stay below the limit of 8 received KeyUpdates per second */
+	for (i = 0; i < 4; i++) {
+		keyupdate_send(_metadata, self->fd, 0);
+		send_recv_str(_metadata, self->fd, self->cfd, "after");
+		keyupdate_send(_metadata, self->cfd, 0);
+		send_recv_str(_metadata, self->cfd, self->fd, "reverse");
+	}
+}
+
+TEST_F(tls, keyupdate_queued)
+{
+	const char *str = "queued behind a KeyUpdate";
+	int len = strlen(str) + 1;
+	char buf[64];
+
+	if (!keyupdate_setup(_metadata, self, variant))
+		SKIP(return, "no in-kernel KeyUpdate for this variant");
+
+	/* the record before the KeyUpdate, the KeyUpdate and the record
+	 * after it are all queued before the first read
+	 */
+	EXPECT_EQ(send(self->fd, str, len, MSG_MORE), len);
+	keyupdate_send(_metadata, self->fd, 0);
+	EXPECT_EQ(send(self->fd, str, len, 0), len);
+
+	EXPECT_EQ(recv(self->cfd, buf, len, MSG_WAITALL), len);
+	EXPECT_EQ(memcmp(buf, str, len), 0);
+	EXPECT_EQ(recv(self->cfd, buf, len, MSG_WAITALL), len);
+	EXPECT_EQ(memcmp(buf, str, len), 0);
+}
+
+TEST_F(tls, keyupdate_request)
+{
+	int one = 1;
+
+	if (!keyupdate_setup(_metadata, self, variant))
+		SKIP(return, "no in-kernel KeyUpdate for this variant");
+
+	keyupdate_send(_metadata, self->fd, 1);
+
+	/* no answer yet */
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX_KEY_UPDATE,
+			     &one, sizeof(one)), -1);
+	EXPECT_EQ(errno, EBUSY);
+
+	/* cfd processes the request, then answers ahead of its data */
+	send_recv_str(_metadata, self->fd, self->cfd, "request");
+	send_recv_str(_metadata, self->cfd, self->fd, "answer");
+
+	/* answered */
+	keyupdate_send(_metadata, self->fd, 1);
+	send_recv_str(_metadata, self->fd, self->cfd, "request");
+	send_recv_str(_metadata, self->cfd, self->fd, "answer");
+}
+
+TEST_F(tls, keyupdate_splice)
+{
+	const char *str = "spliced after a KeyUpdate";
+	int len = strlen(str) + 1;
+	char buf[64];
+	int p[2];
+
+	if (!keyupdate_setup(_metadata, self, variant))
+		SKIP(return, "no in-kernel KeyUpdate for this variant");
+
+	ASSERT_GE(pipe(p), 0);
+
+	keyupdate_send(_metadata, self->fd, 0);
+	EXPECT_EQ(send(self->fd, str, len, 0), len);
+
+	EXPECT_EQ(splice(self->cfd, NULL, p[1], NULL, len, 0), len);
+	EXPECT_EQ(read(p[0], buf, len), len);
+	EXPECT_EQ(memcmp(buf, str, len), 0);
+
+	close(p[0]);
+	close(p[1]);
+}
+
+TEST_F(tls, keyupdate_manual_rekey)
+{
+	struct tls_crypto_info_keys tls12;
+	int zero = 0;
+
+	if (!keyupdate_setup(_metadata, self, variant))
+		SKIP(return, "no in-kernel KeyUpdate for this variant");
+
+	/* a key installed by the user removes the registered secrets */
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type,
+			     &tls12, 2);
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX_KEY_UPDATE,
+			     &zero, sizeof(zero)), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(tls, keyupdate_manual_rekey_request)
+{
+	struct tls_crypto_info_keys keys;
+	unsigned char secret[48];
+	int len;
+
+	if (!keyupdate_setup(_metadata, self, variant))
+		SKIP(return, "no in-kernel KeyUpdate for this variant");
+
+	keyupdate_send(_metadata, self->fd, 1);
+
+	/* the answer to the request now goes to user space */
+	len = variant->cipher_type == TLS_CIPHER_AES_GCM_256 ? 48 : 32;
+	memset(secret, 0x3c, sizeof(secret));
+	ASSERT_TRUE(keyupdate_keys(variant->cipher_type, secret, len, &keys));
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_RX, &keys, keys.len), 0);
+
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_RX_TRAFFIC_SECRET,
+			     secret, len), 0);
+
+	keyupdate_send(_metadata, self->fd, 1);
+}
+
+TEST_F(tls, keyupdate_nosignal)
+{
+	int zero = 0;
+
+	if (!keyupdate_setup(_metadata, self, variant))
+		SKIP(return, "no in-kernel KeyUpdate for this variant");
+
+	/* The default action of SIGPIPE ends the test. The result is not
+	 * checked: as for sendmsg(), the error can show up only on the
+	 * next call.
+	 */
+	EXPECT_EQ(shutdown(self->fd, SHUT_WR), 0);
+	setsockopt(self->fd, SOL_TLS, TLS_TX_KEY_UPDATE, &zero, sizeof(zero));
+}
+
+TEST_F(tls, keyupdate_rate_limit)
+{
+	char buf[64];
+	int i;
+
+	if (!keyupdate_setup(_metadata, self, variant))
+		SKIP(return, "no in-kernel KeyUpdate for this variant");
+
+	/* the ninth KeyUpdate in one second ends the connection */
+	for (i = 0; i < 9; i++)
+		keyupdate_send(_metadata, self->fd, 0);
+	EXPECT_EQ(send(self->fd, "x", 1, 0), 1);
+
+	EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), 0), -1);
+	EXPECT_EQ(errno, EBADMSG);
+}
+
+TEST_F(tls, keyupdate_invalid)
+{
+	/* key_update, length 1, request_update 2 */
+	static const char bad[] = "\x18\x00\x00\x01\x02";
+	char buf[64];
+
+	if (!keyupdate_setup(_metadata, self, variant))
+		SKIP(return, "no in-kernel KeyUpdate for this variant");
+
+	EXPECT_EQ(tls_send_cmsg(self->fd, TLS_RECORD_TYPE_HANDSHAKE,
+				(char *)bad, 5, 0), 5);
+
+	EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), 0), -1);
+	EXPECT_EQ(errno, EBADMSG);
+}
+
 struct raw_rec {
 	unsigned int plain_len;
 	unsigned char plain_data[100];

-- 
2.53.0



