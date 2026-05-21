Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B28CD5BAC
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uVSGDcrd+RZKYsDy6dy9on3hl6/sKG1/sonNb8PAeZA=; b=zj83ornHbLk8lWl+tcVOyGRppx
	gifiYfXcjJow8RneLS4uVpQ6FYjM/LufeW6YzfBYDglZyHWuYvyCorVSKFEuxvAKUlpFnoB1HjOwm
	e3ZRSljmEdebBFmww5OVAtKWjWLfMnhUr12dpIzwdlwLFKYnXldZs5OFxmx2Otadcx6SNqo/RTgRp
	+UpAqpkyPkkcc7ZPH1pdTw2G/hOdTeusfOfmYms9mJy4d+4Bo+QpyXqSGnzQI4KdsyrQbRsmMq/MT
	j1JJlz4NU6hJkSlLt10qxG6kMgUGO9vaZ1Xq+7dH0vVh+VPNFnYH7atFRmrRNXCscQzT94vGPz5A4
	3MT67PZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4gO-0000000886m-0gxu;
	Thu, 21 May 2026 14:47:32 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4gI-0000000882J-3u68
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 14:47:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A371C40BD8;
	Thu, 21 May 2026 14:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC4E1F00A3D;
	Thu, 21 May 2026 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374846;
	bh=uVSGDcrd+RZKYsDy6dy9on3hl6/sKG1/sonNb8PAeZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RcMKnSPgaXvu63qWmJG4t8ceJHJevYFzamIj2cfsU3fLneOyQEEr+dazIfDlYoJ2j
	 vEaRbQHBabZ3TNzcur02jbOfcDfaO0xVBMaAOjP14p9x3nfjU+Nf3OGRFCSkK2KOe4
	 2hr8SQI34kEhJ1+yd9lROoLbRGlwI1pGB3JdRWWoct+uQhRU43+FKoXcft0NHoKD09
	 CzJAM6x7bV0lPkdB2u/fgMCpUh7r8vKKKH6VVY0DEuL4LWeUNY8iZrVprWhn/w5KIg
	 yM/flFY7hmWB/kqeRjdr655eDbTMCeR29RFeF3kzDEolFFFI1TZovQy8fp/HSLW7Vc
	 JEI9zvg0QAe+A==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 21 May 2026 10:47:11 -0400
Subject: [PATCH net v2 5/7] net/handshake: hand off the pinned file
 reference to accept_doit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-handshake-file-pin-v2-5-b9dadc472840@oracle.com>
References: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
In-Reply-To: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5839;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=4vJcYpRm4pzIypGaSrrwN9WGqNWs9qFVMUQiiC/BW34=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDxr3eYwF3rWH6PLyr2mfQXgH/NI2DKyLD0MxM
 32cMg/H8jeJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCag8a9wAKCRAzarMzb2Z/
 l7COEACu5xH7M89Bg6hMkLjozTuIuEbU0BBgi2/l6dNT7k2MM6cokZj6qv60f/16eHoe4G6uP7U
 eNq+kdnsT81lNdHs9nrndawxjxYxIWmiWGF3FR9l7QUKOvldTvMysTJOSBKUQ8lxpNEhwwJJLE+
 AQ0knbrrW/gw4/O4NeJmYF+4hxPQJVCdFIyyRlByTIi+EEoU84Tn2oWfldPDStv2WPMP4chjuI0
 70CQQ3bRRzAfgegSuocwWjIgRHNIX+ZG9naKkneX6DNitmLO3FU9X2y+meDPivsT9M/tYdzwyea
 fq5YcvLrEG37Op7qmsZqHPG/tQIj6sw1cb8d2YmoUOfREE/MwzgqeyzNBcry7JrCtC1QuWenlgg
 aoCqUrmheWDzFyjmTX69lXwpvpi/tnK3HHiYcNUeDYyGX/G6x4EDwK/VUDRCmpdeRW7eGta3PrJ
 u2o2Suwt8zLShXK1ynuobRKHsN8949U6tStbR70ZAufKXRtid8WgeWrCdtU0zuSZ1NT6RFc217k
 OXEE5wEZU3IK+JgILshCHsbJ0PuK5pOjAn0dkHWQ+bXDQ1uInl1597guZj29UEQ1Mg3wpIHaGC9
 vnojl3SfWPl1zHfY7bKUZCSP8RNH1j+IHJ5ykXRUeCl49zCVY5vke49mk4G1dU8icUvSloD42OE
 14b0Zi3wTo01ZYQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_074727_995379_447C4A38 
X-CRM114-Status: GOOD (  20.23  )
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

handshake_req_next() removes the request from the per-net
pending list and drops hn_lock before handshake_nl_accept_doit()
reads req->hr_sk->sk_socket and dereferences sock->file (once in
FD_PREPARE() and again in get_file()).  In that window a
consumer running tls_handshake_cancel() followed by sockfd_put()
(svc_sock_free) or __fput_sync() (xs_reset_transport) releases
sock->file.  sock_release() then runs sock_orphan(), zeroing
sk_socket, and frees the struct socket.  The accept-side code
either reads NULL through sk_socket or chases freed memory.

The submit-side sock_hold() does not prevent this.  sk_refcnt
protects struct sock, but struct socket and sock->file are
independently refcounted via the file descriptor the consumer
owns.  Pinning sk leaves sock and sock->file unprotected.

Retarget the accept-side dereferences at req->hr_file, which was
pinned at submit time, instead of req->hr_sk->sk_socket->file.
Pinning on its own is not sufficient: a consumer that cancels
between handshake_req_next() returning and accept_doit reaching
FD_PREPARE() takes the !remove_pending() branch in
handshake_req_cancel() and drops hr_file before the accept side
takes its own reference.  Hand off an additional file reference
inside handshake_req_next(), under hn_lock, so the accept side
operates on a reference that no concurrent handshake_req_cancel()
can revoke.  FD_PREPARE() consumes that handed-off reference,
either by transferring it to the new fd in fd_publish() or by
dropping it in the cleanup destructor on error; the explicit
get_file() that previously balanced FD_PREPARE() is therefore
redundant and goes away.

Update handshake_req_cancel_test2 and _test3 to simulate the
FD_PREPARE() consumption with an fput() so the kunit file-count
assertions stay balanced.

Reported-by: Chris Mason <clm@meta.com>
Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 net/handshake/handshake-test.c |  8 ++++++++
 net/handshake/netlink.c        |  7 ++-----
 net/handshake/request.c        | 18 ++++++++++++++++++
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index df3948e807a0..9cc7a95f4120 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -375,6 +375,10 @@ static void handshake_req_cancel_test2(struct kunit *test)
 	/* Pretend to accept this request */
 	next = handshake_req_next(hn, HANDSHAKE_HANDLER_CLASS_TLSHD);
 	KUNIT_ASSERT_PTR_EQ(test, req, next);
+	/* Simulate FD_PREPARE() consuming the file reference handed
+	 * off by handshake_req_next(); see handshake_nl_accept_doit().
+	 */
+	fput(filp);
 
 	/* Act */
 	result = handshake_req_cancel(sock->sk);
@@ -417,6 +421,10 @@ static void handshake_req_cancel_test3(struct kunit *test)
 	/* Pretend to accept this request */
 	next = handshake_req_next(hn, HANDSHAKE_HANDLER_CLASS_TLSHD);
 	KUNIT_ASSERT_PTR_EQ(test, req, next);
+	/* Simulate FD_PREPARE() consuming the file reference handed
+	 * off by handshake_req_next(); see handshake_nl_accept_doit().
+	 */
+	fput(filp);
 
 	/* Pretend to complete this request */
 	handshake_complete(next, -ETIMEDOUT, NULL);
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index f395bfc7ff8c..a11041e745da 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -92,7 +92,6 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 	struct net *net = sock_net(skb->sk);
 	struct handshake_net *hn = handshake_pernet(net);
 	struct handshake_req *req = NULL;
-	struct socket *sock;
 	int class, err;
 
 	err = -EOPNOTSUPP;
@@ -107,15 +106,13 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 	err = -EAGAIN;
 	req = handshake_req_next(hn, class);
 	if (req) {
-		sock = req->hr_sk->sk_socket;
-
-		FD_PREPARE(fdf, O_CLOEXEC, sock->file);
+		FD_PREPARE(fdf, O_CLOEXEC, req->hr_file);
 		if (fdf.err) {
+			fput(req->hr_file); /* drop ref from handshake_req_next() */
 			err = fdf.err;
 			goto out_complete;
 		}
 
-		get_file(sock->file); /* FD_PREPARE() consumes a reference. */
 		err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
 		if (err)
 			goto out_complete; /* Automatic cleanup handles fput */
diff --git a/net/handshake/request.c b/net/handshake/request.c
index b076ae539422..d24b55af1a0a 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -179,6 +179,17 @@ static bool remove_pending(struct handshake_net *hn, struct handshake_req *req)
 	return ret;
 }
 
+/**
+ * handshake_req_next - Return the next queued handshake request
+ * @hn: per-net handshake state
+ * @class: handler class to match
+ *
+ * On a non-NULL return, the caller owns an extra reference
+ * on @req->hr_file.  FD_PREPARE() consumes it on success; on
+ * the FD_PREPARE() failure path the caller must fput() it.
+ *
+ * Return: pointer to a removed handshake_req, or NULL.
+ */
 struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 {
 	struct handshake_req *req, *pos;
@@ -189,6 +200,13 @@ struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 		if (pos->hr_proto->hp_handler_class != class)
 			continue;
 		__remove_pending_locked(hn, pos);
+		/* Hand off a file reference to the accept side under
+		 * hn_lock.  A concurrent handshake_req_cancel() can drop
+		 * hr_file before accept reaches FD_PREPARE(); this extra
+		 * reference keeps the file alive until FD_PREPARE() takes
+		 * ownership.
+		 */
+		get_file(pos->hr_file);
 		req = pos;
 		break;
 	}

-- 
2.54.0


