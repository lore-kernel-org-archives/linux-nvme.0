Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA46082BDA
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=J/6IqlOQ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehANWkTp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bI6peh6OxeP45Qk1ajgbOOQHDjkXSKZs/7Xqb7UH6NI=; b=J/6IqlOQtb9rX+
	cXnOaZwayaF9dZmWvB+tNVQVtAAlt0GPtBzqEbZnH92S9AVRqCvtvLikUnwEfTUoqjOl8u8ZmP6+O
	PU0PnkkgeUgeVoQA1q/uAjIDiBvtHRaK/zkcQ8yzrUbOQidleg2nkA0MsctJLuQu9VwoTY+z9Ccg1
	dEVYiqm+/kuDWC4OR2qvg+M8T0eZMH7xfs1DvXNBImIwprZh1URRPVx9RlVwUxx4wfHFfXnUcMU0i
	O2Qa/KXalvUNBpdp9xkcxplvWD840thzf8z6tphaBPavjqIx6bMdXvWnCFO0cjHPbQoZkyCd2pNd1
	bgkfA/7oYkli+bUGs/2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0MZ-00000009cBe-1AL8;
	Thu, 05 Nov 2026 16:30:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0MN-00000009c68-12sk
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 16:30:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 044B743E34;
	Thu,  5 Nov 2026 16:30:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793896242;
	b=PJl6g5FafZzRv/9Mvgm062HHuIpxgGFcYPciBzTLyMCpYzqC5yQk3aho0GCDr5y0U9dA
	 BCeP7JslW0ZA2evr9Hl8TZK+/tbdc7roEnoaTm1DHr5XF55knuVMxdLczW2jq0ldtX4Vo
	 lZvFT8Bkagsy3xRmhBmMohkNYG4WShWNNvHRZ7Ra8crfZOp48JcVH02GsedLXWTse6vPm
	 pe0rsBUgnr8fzWArqI+DiyFhERHVVQ89JR1ijmaVYeE0oE2JodYwa/Oi+aXZabGaQjZ2w
	 Hdt/BWscwNNvAvQHsEjom6kLsknB9zR9TgTyq6ExE13Y6VHEKjWQAAW5yE4Z0e08RtQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793896242;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=bI6peh6OxeP45Qk1ajgbOOQHDjkXSKZs/7Xqb7UH6NI=;
	b=2WjRcc+rufJwa0iLQdNN4O2kj+Q1lg/9PnaRjJLosr8o23tKdyIgdJx7BygUNlHaBG0W
	 Evt8DsD/wW3dHNvd3k1/Y7/WOlh1hws4djQXjPOo5ypKjg8odLAR8RKt8r2OdCYE+HLFJ
	 5OtucteTBiuwASROxzONxhwArhe4iOEVsYrOmJ0O2pCPTiPtPrN/1VDxNX9qOlqT8LG+I
	 rtuH5kiVrvlp3dHjmKxwu+5Aj2tHIfLJVs3LAvvLXbERkL87prHK7BAdytUsLfqyaDY59
	 AOZe5qL/fmOi4g0VoD1J+pxE3xuLyTiobaTNRnTMJmpeV19ucmoiXxFXsaankBW9cIw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2F81A1F00A17;
	Thu,  5 Nov 2026 16:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896242;
	bh=bI6peh6OxeP45Qk1ajgbOOQHDjkXSKZs/7Xqb7UH6NI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ehANWkTpMPOLswgz+mCRy1PdXR6pOWl1gz5bTroYOrMUijcNEy2xq6I40LaoR6pxJ
	 QOGqVsLkv20xBzNSSbhhuTwEVrFfHMofnQfdSzdW4WT8ssrE9hJLcaO7y7nWsvw8tT
	 hgx2cSXD/rkDfzDI3WJvNjW5uGjNrJ2da5qmz2UQc7BFIOumkGlUpGk3JEHnunzCuv
	 en4Zz0xfaWGT+t9/tC2Ey9fFIGtl2pi4fHpumVa8qprBJS4PrtDyT9MDlHUmFXwe1D
	 GaOsTCIBtrxFjky9m0RczB1EGA7y4/7FYG+fv3D3I1XRYmHHJMakC1T7lX3/nFdkgu
	 Vzekxzy7P7bRw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B5EF347334;
	Thu,  5 Nov 2026 16:30:39 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Thu, 05 Nov 2026 11:30:42 -0500
Subject: [PATCH net-next v6 6/6] selftests/tls: add KeyUpdate tests
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-keyupdate-rfc-v6-6-99b695f9eb4f@gmail.com>
References: <20261105-keyupdate-rfc-v6-0-99b695f9eb4f@gmail.com>
In-Reply-To: <20261105-keyupdate-rfc-v6-0-99b695f9eb4f@gmail.com>
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
 Martin Belanger <martin.nvme.dev@gmail.com>, 
 Martin Belanger <martin.belanger@dell.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793896238; l=18429;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=fsVkcnDOVWz720biQUKVqCt0eCQOn4XqFkNc66k1Tcw=;
 b=kOmXFCgexZF8wmkLyj5FHroiAsfdlZZkFrQoCkkcLqZqQB83GrMvuXUpCDV8OeCn/mN7qx7mw
 4VKEwuRoAoNDVYOq4vZrolpUS8UgUa8Jrb94IeJ1eMCeEAC7KDMXOMy
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
- update_requested: the peer answers before its next data, also
  after a send that failed with EAGAIN, and a second request waits
  for the answer;
- splice() across a KeyUpdate;
- one write that crosses the record limit gets a KeyUpdate in the
  middle;
- a key installed with TLS_TX removes the registered secrets;
- after a key installed with TLS_RX, a new update_requested is
  accepted;
- TLS_TX_KEY_UPDATE on a shut down socket does not raise SIGPIPE;
- more than 8 KeyUpdates in one second, and an invalid
  request_update value, end the connection.

The keys are derived from the secrets with HKDF-Expand-Label, with the
HMAC of the kernel through AF_ALG.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 tools/testing/selftests/net/config |   4 +
 tools/testing/selftests/net/tls.c  | 520 +++++++++++++++++++++++++++++++++++++
 2 files changed, 524 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 7a89e2618d4c..b75692f25765 100644
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
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_BTF_MODULES=n
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index c4203401c4bf..ed3b510a5ef6 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -11,6 +11,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 
+#include <linux/if_alg.h>
 #include <linux/tls.h>
 #include <linux/tcp.h>
 #include <linux/socket.h>
@@ -2421,6 +2422,525 @@ TEST_F(tls, rekey_poll_delay)
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
+ * secrets of a bidirectional connection. fd -> cfd starts at record
+ * number @seq. Returns false if the variant does not support it.
+ */
+static bool keyupdate_setup_seq(struct __test_metadata *_metadata,
+				FIXTURE_DATA(tls) *self,
+				const FIXTURE_VARIANT(tls) *variant,
+				uint64_t seq)
+{
+	struct tls_crypto_info_keys keys_a, keys_b;
+	unsigned char secret_a[48], secret_b[48];
+	unsigned char *rec_seq;
+	int len, i;
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
+	/* rec_seq is the last member of each crypto_info */
+	rec_seq = (unsigned char *)&keys_a + keys_a.len - 8;
+	for (i = 0; i < 8; i++)
+		rec_seq[i] = seq >> (56 - 8 * i);
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
+static bool keyupdate_setup(struct __test_metadata *_metadata,
+			    FIXTURE_DATA(tls) *self,
+			    const FIXTURE_VARIANT(tls) *variant)
+{
+	return keyupdate_setup_seq(_metadata, self, variant, 0);
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
+	 * checked: as for sendmsg(), a send error may not reach the caller.
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
+TEST_F(tls, keyupdate_record_limit)
+{
+	struct tls_crypto_info_keys get;
+	char sbuf[1024], rbuf[1024];
+	socklen_t optlen;
+	unsigned char *rec_seq;
+	__u16 limit = 128;
+	int i;
+
+	if (variant->cipher_type == TLS_CIPHER_CHACHA20_POLY1305)
+		SKIP(return, "no record limit for ChaCha20-Poly1305");
+	if (!keyupdate_setup_seq(_metadata, self, variant, (1 << 24) - 2))
+		SKIP(return, "no in-kernel KeyUpdate for this variant");
+
+	ASSERT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN,
+			     &limit, sizeof(limit)), 0);
+	for (i = 0; i < sizeof(sbuf); i++)
+		sbuf[i] = i;
+
+	/* one call writes 8 records or more, past the record limit */
+	EXPECT_EQ(send(self->fd, sbuf, sizeof(sbuf), 0), sizeof(sbuf));
+	EXPECT_EQ(recv(self->cfd, rbuf, sizeof(rbuf), MSG_WAITALL),
+		  sizeof(rbuf));
+	EXPECT_EQ(memcmp(sbuf, rbuf, sizeof(sbuf)), 0);
+
+	/* the KeyUpdate in the middle of the call restarted at 0 */
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type,
+			     &get, 0);
+	optlen = get.len;
+	ASSERT_EQ(getsockopt(self->fd, SOL_TLS, TLS_TX, &get, &optlen), 0);
+	rec_seq = (unsigned char *)&get + optlen - 8;
+	for (i = 0; i < 5; i++)
+		EXPECT_EQ(rec_seq[i], 0);
+}
+
+/* A send that fails with EAGAIN before it copies any data leaves an
+ * empty open record. The next send must still answer a KeyUpdate
+ * request before its data.
+ */
+TEST_F(tls, keyupdate_request_after_eagain)
+{
+	struct tls_crypto_info_keys get;
+	size_t sent = 0, rcvd = 0;
+	char buf[16384];
+	unsigned char *rec_seq;
+	socklen_t optlen;
+	int size = 4096;
+	ssize_t ret;
+	int i;
+
+	if (!keyupdate_setup(_metadata, self, variant))
+		SKIP(return, "no in-kernel KeyUpdate for this variant");
+
+	ASSERT_EQ(setsockopt(self->fd, SOL_SOCKET, SO_SNDBUF, &size,
+			     sizeof(size)), 0);
+	ASSERT_EQ(setsockopt(self->cfd, SOL_SOCKET, SO_RCVBUF, &size,
+			     sizeof(size)), 0);
+	memset(buf, 0x42, sizeof(buf));
+
+	/* fill the send buffer until a send copies nothing */
+	for (;;) {
+		ret = send(self->fd, buf, sizeof(buf), MSG_DONTWAIT);
+		if (ret < 0)
+			break;
+		sent += ret;
+	}
+	ASSERT_EQ(errno, EAGAIN);
+
+	/* fd reads the request; its answer is now due */
+	keyupdate_send(_metadata, self->cfd, 1);
+	EXPECT_EQ(recv(self->fd, buf, sizeof(buf), MSG_DONTWAIT), -1);
+	EXPECT_EQ(errno, EAGAIN);
+
+	while (rcvd < sent) {
+		ret = recv(self->cfd, buf, sizeof(buf), 0);
+		ASSERT_GT(ret, 0);
+		rcvd += ret;
+	}
+
+	/* the answer goes out before this data */
+	send_recv_str(_metadata, self->fd, self->cfd, "data");
+
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type,
+			     &get, 0);
+	optlen = get.len;
+	ASSERT_EQ(getsockopt(self->fd, SOL_TLS, TLS_TX, &get, &optlen), 0);
+	rec_seq = (unsigned char *)&get + optlen - 8;
+	for (i = 0; i < 7; i++)
+		EXPECT_EQ(rec_seq[i], 0);
+	EXPECT_EQ(rec_seq[7], 1);
+
+	/* cfd got the answer, so it can ask again */
+	keyupdate_send(_metadata, self->cfd, 1);
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



