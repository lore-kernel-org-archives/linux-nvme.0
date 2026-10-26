Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C382606A32F
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JyrsanbA;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWfTqytS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=m+EbTsNk0LWkXXCWtw52FAj4Hw4PwsHMPWs5J2sqEps=; b=JyrsanbAQPrL6N
	L5QOIj+Ssm6AW+P1IRi1t6X/FKpVh8wmAo6XRvIl882pR8BFYxt9iNhWolYhWyB8p9Dm0JJ+JZqdY
	KPBoL7lD+BaHRVgzmh97MzwOxHHrYpWWnT2S2OobpzvjJFINpkHgdh3FPiMaU7sa1Iwz9ijChVQLL
	o3fHL0wQQ+AtXX8CuNOrEVfca9KmCB4u+UFxoFiffhgZBWCPMHCJ0kMvTSBcugzORYZ/A2iJdWFXC
	0zivJR07jB0btvqm4tyM06AKgxbXXKXo7tL62f6r89dfyCIk5seP/8bZICz6tKGDUzGREbCmN5tcT
	YidJavNNHDjj2T64hz+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL8ht-00000001X5B-0RIy;
	Mon, 26 Oct 2026 00:36:57 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL8hq-00000001X3k-24w1
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 00:36:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2FC53440BA;
	Mon, 26 Oct 2026 00:36:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792975014;
	b=gkggy9ZZOMlr2O+TburTPUZzUJQz69bbba/jlzfYptTV0tO5c/klgJHwpusGozlfWaPj
	 OcxYOQgwBRAPOALPgHK4JQPQHV3jXO/lkn5F7iObjCsPHNATnEIOtyMTQFR0cCHdEEjEb
	 EpzJIjMKciZTIuXbXb8Oq0aL1b4Wn7ifjBsNrMjo+horJo2QJOE9ii7sOd1YivbOqLVJ+
	 oVBFEEqnXTOFuhQhPG44eVHRE4K6JFTm2HeeNfMognj2JFZyJfJvKWglYk+0lkXRg2Sqf
	 OSmcQgyKWo65ZRMFZ3DFgiN+K8zC7rbTzVUxFFZ6fv74W6t0WxC4wTV/rFfVJHUNbjg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792975014;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=m+EbTsNk0LWkXXCWtw52FAj4Hw4PwsHMPWs5J2sqEps=;
	b=rgwwO/1Bm5Gf9sLz+K6Ml6sX8/a0PU6gjlerMVpYNcLZuGTW+qSIVDyhcZg5SZCdnWCa
	 VQF9k3qygat2/zNUw6gWhbyyUF2d1AWZvgqZleQksplz30xVNGvcs+9tSos//CDX3AU8p
	 2EzGc7uU9+C/kjIx1ZO1IELMVuPKMrCyJT8L4nxWhe7ZJsJATjxrb3uqa8066OMUFYCvR
	 yHPWfl3lIFfS/lRz8WphUWAouTTw7Xky5xwv6v27Y70c1QlKL+ioz9C9F0tTdiUsvec9j
	 14wm5vksP4rn7+B3CslRuxnbAKJZUy5Hn6Fz+KjZG32d8vZoYcNhe/LtKUsAWt0hP8w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2A1D61F031E3;
	Mon, 26 Oct 2026 00:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792975014;
	bh=m+EbTsNk0LWkXXCWtw52FAj4Hw4PwsHMPWs5J2sqEps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hWfTqytS4xvugKU3N9ivql9sPUNq+J/YhMEgtBo8XX7IznV1sYRyYcMhfRhGEmb1V
	 MRu4c0PzDVv47Qeh+IyUEZjBhre9j1P464AQ3tNevyE2sHcnCxwCLn0gJbB7xxBhnL
	 U+cWS3EGzctMTf6oaNACN3tDgenEjR5QZ+7fAo0glpoltGDTprDSPrQFVAg+sO8PTp
	 UMRSk3KvNTiZCbTsHZj/b/1SiVZK0ZMttpPojGgdBOcuKmalubg0850trJhNSsUg8k
	 3VV5W44owxCwaIyxQGQ2vtOwEDWfZRpkpAWlSigxwtzP6BpA8dDIjtDo/YdSM3bVOq
	 F60SagEesqJNQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5A9F944B6E;
	Mon, 26 Oct 2026 00:36:51 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Sun, 25 Oct 2026 20:36:52 -0400
Subject: [PATCH RFC net-next 5/5] selftests/tls: add KeyUpdate tests
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-keyupdate-rfc-v1-5-60b7756eccbd@gmail.com>
References: <20261025-keyupdate-rfc-v1-0-60b7756eccbd@gmail.com>
In-Reply-To: <20261025-keyupdate-rfc-v1-0-60b7756eccbd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792975010; l=8642;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=yVTcJm4gumldwJJYUwOUFkQ01b/PvpDG48+U91afbhM=;
 b=OWGWACKk60Jdz51NxNg5fFf6lIwPI7RqwuiJYwckoH/iN1vocuNyVsCmOWt7Te23mgmX4FsWt
 wdcZylFlv4ZCOH7qmYwuwU5EFsMPsBiLKbc8ang8/0/rHyxFbXwcSgN
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Martin Belanger <martin.belanger@dell.com>

Test the in-kernel KeyUpdate on a bidirectional connection with both
traffic secrets registered on each socket:

- registration errors: wrong length, missing key, TLS 1.2, SM4, and
  the RX secret before the TX secret;
- KeyUpdates in both directions with data around them;
- a data record, a KeyUpdate and another data record queued before
  the first read;
- update_requested: the peer answers before its next data, and a
  second request waits for the answer;
- splice() across a KeyUpdate;
- a key installed with TLS_TX removes the registered secrets;
- more than 8 KeyUpdates in one second, and an invalid
  request_update value, end the connection.

Assisted-by: LLM
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 tools/testing/selftests/net/tls.c | 249 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 249 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 9d3cd4fff062..838030d09cd3 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -2390,6 +2390,255 @@ TEST_F(tls, rekey_poll_delay)
 	}
 }
 
+/* In-kernel KeyUpdate: fd and cfd both register the TX and RX traffic
+ * secrets of a bidirectional connection. Returns false if the variant
+ * does not support it.
+ */
+static bool keyupdate_setup(struct __test_metadata *_metadata,
+			    FIXTURE_DATA(tls) *self,
+			    const FIXTURE_VARIANT(tls) *variant)
+{
+	struct tls_crypto_info_keys tls12;
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
+	/* cfd -> fd */
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type,
+			     &tls12, 1);
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_RX, &tls12, tls12.len), 0);
+	EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+	memset(secret_a, 0xa5, sizeof(secret_a));
+	memset(secret_b, 0x5a, sizeof(secret_b));
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



