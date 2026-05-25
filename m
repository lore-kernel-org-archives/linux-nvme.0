Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5364CD5BB1
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 16:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d43OvyTEb6bAL6zj8ItVc6Tz/MdWEJDtxx2XnzF1c2Y=; b=GjPUd88/t6I/ZbMuchpJ2RrlH7
	QVy8MfTWn2k1zdPCX/vbjwX9OKXzoZ5PgMosPXdl8ohumFltsDefUYbn6YkCQ8R6EKqQO37IVJJMk
	rbLqVykgNB4GrYYTm8LCj6Vx0rQEV4qKO+IaB77AU9nIGCqWel34I+2UMKGrdHwLXVC8oigS7t0jV
	y6Nod3/05CXak436R8EABnZeMMJPZanJu5GreBHSL/9dxmsY4PDr67jphnKdLnjIYfXu66cKeza6A
	hGKdqj2sA01Cclebm42Dkl1mjJq+cNq22LYwoSI2GYflAdtDX8s7e3UJaq9NZk4nZCgi+tTvw/g2v
	SX3BCVqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYWh-000000004Bl-3QA9;
	Mon, 25 May 2026 16:51:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYWf-00000000494-0zKK
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 16:51:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EFC9040D8D;
	Mon, 25 May 2026 16:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051361F000E9;
	Mon, 25 May 2026 16:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727896;
	bh=d43OvyTEb6bAL6zj8ItVc6Tz/MdWEJDtxx2XnzF1c2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=J34q84V7dsXoeOVI6nEY3G2GfiHqj4bI+1/SsK4BdfFlyIpVdjY5awVoe7+8BDNJP
	 UTD6P9E9H/+MZFJuZmtT90NEd2q5m71HCNCLs3/UEtlhTO3qR5yfp6pYYRbzNbtZ7w
	 cWis2rmfs5oN4OPobXXeYvoEBFvaXBbG7FUJSLHsguGzpZdwckduxvHkfvwWkDiZtn
	 vEWKuF6Sc6SFCa3LF7YhRH/aGhdYaC0b87Y2sn2vklUoH1THEsQoSrPqPfJ8hcGXls
	 PI5XhoA8uFu2rlLfkBCDtBjj3BiIL7HOF5zzseGUWYNHGZ4OWXnRVj3KA6u5qIECHj
	 1vo9ByoAJMCpQ==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 25 May 2026 12:51:19 -0400
Subject: [PATCH net v3 5/8] net/handshake: hand off the pinned file
 reference to accept_doit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-handshake-file-pin-v3-5-66c616906ead@oracle.com>
References: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
In-Reply-To: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
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
 bh=PQa8JmI2XxvEt+qEwXdYH3srIUEbOTHyXSbAkTgS458=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFH4SHHWUymmHmHh5bguz5l1c+NEXN6b6uWQO0
 YYUlppdyr2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahR+EgAKCRAzarMzb2Z/
 lzBpEACQmDjjcw3kCeQL12k4nftxTMWfBo+LhFnH89HlHrnvUdbVrxvuY06cO8S0QmWH0RVkWYc
 oHQaYy7x7CmvIkvBpZLDYnQ7Jn7BzlfKkhpTl7HjiMiIAT9mYyFMLfWUucn+evhlxz6ysP5ZzPc
 b5z+0eXyIpwGzzIt6jxRIEGgaHKjhpBo2gwOnI7KbS3QEnGiYMLDWIqlWE8r/V2Uj6qH0rN234g
 gO9a9ArVtlErIJ7HMyHdoeyxQoo2vsnygZ28X4kGshyTBp8OyH+NKHICAwFCWsoqRwNr+KeKv2f
 1oRSu4QCDLD+RmlM7Icd8u1UjI+iW9v0It47IQaDHqdqiaDJ2mhk/E8+UgokV/jTzM2v59cnjOy
 +8F//TnNJYwYmVMRU+tNqEIz/yI1t6JG4cKQCudfxJ8RZtEHKFmGhpt3CEWHaq9wHq0QPlwpKcv
 hNVQtFphQp9f0ehsoZhlo1s85sXWOThW65q5PJaa3XSxxunW7xMGD72l68yMaM1rbeAiQOYIHAr
 GC4X7vZWfJqzUoXStGw4GJBVAzkqjlZCga6Hp3PiEFpbVdLy4oDGpyRjo0BPKM2Z8OqeFWyevS5
 r6UOLx+CORW2Qh6ESdPnAqJT+PmdSuAd5W1wt8UcFm7XDrlI7jd/s3ILL+bZpiIJ/riOCx2akal
 4DvrURBoPywnXHw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_095137_339216_CDCD7EE9 
X-CRM114-Status: GOOD (  20.29  )
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
index 1a5821eb7184..21d6cbd52fcd 100644
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
index da064511ab86..e2d7ee7ce6e0 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -178,6 +178,17 @@ static bool remove_pending(struct handshake_net *hn, struct handshake_req *req)
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
@@ -188,6 +199,13 @@ struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
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


