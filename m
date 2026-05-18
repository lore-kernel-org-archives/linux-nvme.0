Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D239DCD4F58
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 18:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UfjQh5mK+P/X5TWOeNGFsiXmUnE9OOdzEiBUkYtr/mU=; b=V9IJvrrwchDxNFKv3J0P36WfnP
	o1GtSUuyFyRCtSrHBW04p7cDSm0xUXBVPmDVKQhslCabvx22tOje8eq8Lch1nR+Ly18jlAQ/CEC+o
	sMFxV/JBkJfCvJGHuUmMr1SjlzAaF67Wz5tiVzCI4SuZRK3PzrQY1HTFsQLGDr2hJprPm23V1Iryb
	+csk+oEsEwGj2DXR1s2Z25mW/zFc9RQG31S1k8UK2JZo6VDvMtGTsbYe/Wk7l4M97xzawObgq1yRr
	jzVE6rZ627sgarlaHtNKze3vfJk5zzwcRVAL+oDZZ2ZcCmO6ACO9gwuz4T3vkcUw7lvLcmfkSSJJ6
	20yzAFEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP2eD-0000000GYYd-3kCW;
	Mon, 18 May 2026 18:25:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP2eC-0000000GYWt-11BS
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 18:25:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AF9EA600CB;
	Mon, 18 May 2026 18:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98510C2BCC6;
	Mon, 18 May 2026 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128699;
	bh=hgylRra5SSNtfmzy04GJNbjsLYncRF3SakSvhGTvpuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aUtEEY+kmISJQY20w36zrf1KkRyJt+KP12sVbg5eNwap2HYhpEx4ugWu40klk3YU/
	 dSZtfIf+zSbGl53JgE6BVJxC1fArcefPflhTgZiOgtdWal4b50WO4VLGs+xw3bFFww
	 JDvyWVVCZYgnrOsv1HBPQllTEa2Zuhk/TALPpLYG+4iEuEvuY6ip8HwFNILXSsyYnU
	 9ESZNvaPAey1uWANdJ2S2DqKsKOJfLJtBxQ4dGh1eNFdxYlvJVIznn55Lghp19D/hp
	 KWCejzWtSJWJMeMP+zrqGLXOoRImw2DOziNKIICI7L76E9zeRWcIYinHxSXgLGphlY
	 gBFro23LGF75A==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 18 May 2026 14:24:32 -0400
Subject: [PATCH net 5/7] net/handshake: hand off the pinned file reference
 to accept_doit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-handshake-file-pin-v1-5-4bbcb7e62fda@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
In-Reply-To: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5791;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=w1dTXaM4JxhmgKUJhboSvvCMGmysOGdKEWX7jO4D4+Y=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqC1l1ZdxiRBhfJsdPC0vPM5Ru3R5j+bz/kgGSL
 qLFHuLri1+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagtZdQAKCRAzarMzb2Z/
 l0mZD/9/eU/NS/i+EkkR7oOEpqvuVUSgnAwEWlCEQpnjdO+nDo17si0U766Ond8mJnDT8ICuzBI
 3+wR3K80QyYS2/W/NGPrQxOBpo8KkH06HlYpg118wtBVHwPvzHHaQ6agQ/ZbB5S8nu6FnzdzCwm
 JG/buhSHi1Q+okPU/seR8a04ae2SyygT0ZOSfySZ8Wrfi1gm8EFCxeVHcyQD1utFE5IFdtlR5gQ
 ogFGfGTW7EtvuHOQKNfUi8CINx7yJLDOoS4jsjOOnt1ke/4ey+PxKvuNvLJvJmISI3YV0MEfLZ/
 H7saeC++Hjr+ZMuCJaySmDR4h20+D76XP2PZJwevsHnGkCVmG/FULHsEM/fdLxHX83BeC8ef+Df
 Q3DEATNSS8CwtiBAv5zwE5rN2u5+iQTm7ZjKfjzxGg4U7nusuJYb/PZreFzzTLdThCUkXvobUHI
 +nEhVfD6hlBAbUyBgzrbAQLoNeAUws7pWRknesS9Ys2henwlaKWPKVsujvDAWrgnraj+N0C+dvi
 V46Dp/VA2Aix4tHz9PwnGkluzgdjzsXkXdRN87/cgteXhpwbFkkxbONi8XXugSIBoXLgJMJ9UFm
 p11+mVACC9edYNMc6Pi+Dx02kSnOX/aMElqsGKjdwD11weSH62iCo+UxJE5wgo30T30YhM3s3Xd
 nzz7pEB/f2lrxog==
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
index 0d5871f4bd67..086d5439c155 100644
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


