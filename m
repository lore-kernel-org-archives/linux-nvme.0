Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBAECD4F57
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 18:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/U2giAC5aTYil7sHJ6ymgAq4kTHgQI0/D/TBLPfhUQ8=; b=G1iFNAGxkXh3bJbUIdpaW1Q3K8
	uXFatsLXsdz9F5OlORtiyJaHYzJ96JAtmG+J3+CuBrwzTO76kC535HCNGYEL1vdfJAw2ikObOzaZ+
	EdAecyT4DSYWXgY+pXhEygl2kJnDo2g197rHWxXTaIVhTIcB165MEXCcHT1x42eiwlHR42XB6QPQp
	2Gg065Hr7y5o6NKxtxwQMn6LMooItG84nWmq4App+/rhzJYSfCAZGUFrhucxZjGMxiUIQWtEI1N7Q
	WyPo7bH9R1eV4xWTS3u5w5XH418pCLRjJPvRiEktHq+iU0X70Y6BCkx8U/B2JCigGyON93htv2rt/
	0WUrTJFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP2eB-0000000GYWK-2MfI;
	Mon, 18 May 2026 18:24:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP2eA-0000000GYV8-0v5V
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 18:24:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A8B2C6001A;
	Mon, 18 May 2026 18:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92875C2BCB7;
	Mon, 18 May 2026 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128697;
	bh=twmvduN3uG2Ks2PKCFKufQWyWW4vLlqZBb/LR7VSIkU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C0+56ms2B8K/8yn+lc9TpPbcK05dLzJqEhCvrTCEJ+nkNoyXpD/JUEHv+yneMzuYq
	 KX1Dg9030ODSmvTKMVA5rydVpEEkoaz179mPsTXIgNu1Bn1jgwKCFc5A+No42M6M7P
	 LpzqyjfHy1+f0xCid3/92aNIxdAuU2BS5QZDf2XgUsy5rs1T9kXAVcYpxPIcjXmbY+
	 QU+1lNXSpM0/2EGjXMI6UUzR2kBkXYMRjj7cElhdLfcVjbb91btStp9+wXktLC6K1m
	 2i2OG1sJu2szczB+unGl30iKNVPjUedLlMBm4Kzi5J3+3FP3lFcOc7EwJU4vs+x0D4
	 znWRWGZs5FetQ==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 18 May 2026 14:24:30 -0400
Subject: [PATCH net 3/7] net/handshake: Pass negative errno through
 handshake_complete()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-handshake-file-pin-v1-3-4bbcb7e62fda@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
In-Reply-To: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5586;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=MHXWC28Fyxqey74iGEY64a+YvPzzIuUnNgMDY9DlYhM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqC1l1WSb9KThtHrmcyoEAfX3B9OSzNZdPyhIGI
 Oo63XI63geJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagtZdQAKCRAzarMzb2Z/
 l0aGEACrD9oJ5QPy4Vi/m2SfpaN/CcKBtjEiMIOfsTgPLzxACFDEP9zybvTuBRfIpNdKSeBUEGh
 N4Ul4RqpThkbYREwfzFEbVUQZPETtfBa0RbAil4i2QVD6b3uNOyiwz24oxOS4+yS3ndiceRVv3P
 8xpPqkn/mJFM+0HxNSR6V4ATsdtNPBAkLZyVccxLx0+s+cbyw9g+YgMS+w6MoqErX0p1PeVR8An
 FATQQ+tvHQXSvVjbkia+QNikRzxTlsNfucq8ZBvh0WqIBGb2pALfior+YhyiVbqkJhP88eou5ml
 yRBVL8mFk+CMQsuhabHzKgkrZ71xeTN7MizJU64GT0A5v7jv5hZ9sejc8HxVWDiXJorWDM9KP9f
 SyeAch+vtzZoCXQ0O30l9QBDv5K/ZS6cuS5GBwpnydjBHXtmoEiMSwC/Ti9+sOnDlSBMx/FRK6l
 4byi/M2o+4QZWehU+mh8zR4nRX7gBkujkS1c7joB8FEZv41qr/vczhaRneUj3MP6BEgzZM1B0Mh
 aPb5wiVOrzsm3DFmaPYOh4xjUhdbzd/huxXeDRkBuppMpXx1fdvdOPhCXjWXxTj97C3t8QVpU/i
 GBCpoZj3Gkgz/zi+xkaX7V4wPlf514fnJyexKW/iOyBjS/J0XNkxjGtrETFyBYnStbYxIUFmNWb
 AiteTo8IdJ1MNFQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
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

From: Chuck Lever <chuck.lever@oracle.com>

handshake_complete() declares status as unsigned int and
tls_handshake_done() negates that value (-status) before handing
it to the TLS consumer. Consumers match on negative errno
constants -- xs_tls_handshake_done() has

	switch (status) {
	case 0:
	case -EACCES:
	case -ETIMEDOUT:
		lower_transport->xprt_err = status;
		break;
	default:
		lower_transport->xprt_err = -EACCES;
	}

so the API as designed expects callers to pass positive errno
values that the tlshd shim then negates.

Three internal callers in handshake_nl_accept_doit(), the
net-exit drain, and a kunit test follow kernel convention and
pass negative errnos -- -EIO, -ETIMEDOUT, -ETIMEDOUT. The
implicit conversion to unsigned int turns -ETIMEDOUT into
0xFFFFFF92; the subsequent -status in tls_handshake_done()
wraps back to 110, the consumer's switch falls through, and
the xprt reports -EACCES on what should be -ETIMEDOUT or -EIO.

Fix the API rather than the call sites. The natural kernel
convention is negative errno in, negative errno out. Change
handshake_complete() and hp_done to take int status, drop the
negation in tls_handshake_done(), and negate once in
handshake_nl_done_doit() where status arrives from the wire
as an unsigned netlink attribute. The three internal callers
were already correct under that convention and need no change.

At the same wire boundary, clamp values above MAX_ERRNO to the
default -EIO. A well-behaved tlshd never sends such a value,
but negating an unconstrained u32 invokes signed-integer
overflow when the high bit is set, which UBSAN would report.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/handshake/handshake-test.c | 2 +-
 net/handshake/handshake.h      | 4 ++--
 net/handshake/netlink.c        | 9 +++++++--
 net/handshake/request.c        | 2 +-
 net/handshake/tlshd.c          | 4 ++--
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 55442b2f518a..df3948e807a0 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -25,7 +25,7 @@ static int test_accept_func(struct handshake_req *req, struct genl_info *info,
 	return 0;
 }
 
-static void test_done_func(struct handshake_req *req, unsigned int status,
+static void test_done_func(struct handshake_req *req, int status,
 			   struct genl_info *info)
 {
 }
diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index a48163765a7a..2289b0e274f4 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -57,7 +57,7 @@ struct handshake_proto {
 	int			(*hp_accept)(struct handshake_req *req,
 					     struct genl_info *info, int fd);
 	void			(*hp_done)(struct handshake_req *req,
-					   unsigned int status,
+					   int status,
 					   struct genl_info *info);
 	void			(*hp_destroy)(struct handshake_req *req);
 };
@@ -86,7 +86,7 @@ struct handshake_req *handshake_req_hash_lookup(struct sock *sk);
 struct handshake_req *handshake_req_next(struct handshake_net *hn, int class);
 int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags);
-void handshake_complete(struct handshake_req *req, unsigned int status,
+void handshake_complete(struct handshake_req *req, int status,
 			struct genl_info *info);
 bool handshake_req_cancel(struct sock *sk);
 
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index a8dd848371ff..08e5a5867a90 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -159,8 +159,13 @@ int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
 	trace_handshake_cmd_done(net, req, sock->sk, fd);
 
 	status = -EIO;
-	if (info->attrs[HANDSHAKE_A_DONE_STATUS])
-		status = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
+	if (info->attrs[HANDSHAKE_A_DONE_STATUS]) {
+		u32 val = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
+
+		/* Values above MAX_ERRNO would overflow on negation. */
+		if (val <= MAX_ERRNO)
+			status = -(int)val;
+	}
 
 	handshake_complete(req, status, info);
 	sockfd_put(sock);
diff --git a/net/handshake/request.c b/net/handshake/request.c
index cebafcc341d2..93cec5f0e16e 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -285,7 +285,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 }
 EXPORT_SYMBOL(handshake_req_submit);
 
-void handshake_complete(struct handshake_req *req, unsigned int status,
+void handshake_complete(struct handshake_req *req, int status,
 			struct genl_info *info)
 {
 	struct sock *sk = req->hr_sk;
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 8f9532a15f43..3dd99982150f 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -93,7 +93,7 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
  *
  */
 static void tls_handshake_done(struct handshake_req *req,
-			       unsigned int status, struct genl_info *info)
+			       int status, struct genl_info *info)
 {
 	struct tls_handshake_req *treq = handshake_req_private(req);
 
@@ -104,7 +104,7 @@ static void tls_handshake_done(struct handshake_req *req,
 	if (!status)
 		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
 
-	treq->th_consumer_done(treq->th_consumer_data, -status,
+	treq->th_consumer_done(treq->th_consumer_data, status,
 			       treq->th_peerid[0]);
 }
 

-- 
2.54.0


