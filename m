Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C98CD5BAF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=21j6wtvcFA+GRGELWMitdJk5M39RTYQ9AsL6lrYPK6I=; b=r6x9WQHPmXS0/UKWyzVn01VGxh
	t8mZ8EJ8/7ypYlDblyAnoM1/f81qGtRqSDYAsyLoCcLyfjbNppvuOd0xi+C5ERKUpFooChHy4qvBw
	XqAzuWnEtg/K8yOs8548ZWRfzBBqWp3W/VKkyWWLLeycmLMKxTvCoCMQKpMfX9n16SHTdRdsLSeq4
	XctS8O3Dqb39n5AzH2WKKtg+OoAhUggeAw80kWLSfFeOGbtOGtgL6Axaf+0GLLLR++p6qaf/GI05j
	VOVshS2BjYumw5qa4Rv0WrVwViQ1CoLp2PRPzx4rjCVuZQg9EdSIsZQuIYGZ2JMiUAzbZj7Fr6lDt
	09pQNOQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4gO-0000000886Q-07Ww;
	Thu, 21 May 2026 14:47:32 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4gH-00000008824-3aDq
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 14:47:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9151D404AD;
	Thu, 21 May 2026 14:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992671F00A3C;
	Thu, 21 May 2026 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374845;
	bh=21j6wtvcFA+GRGELWMitdJk5M39RTYQ9AsL6lrYPK6I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lzpyOOffSM7S0Kw0Avs7NYxIZnzponQerJpqZkVGduShcrTInpGmeswrvHi1UHtz4
	 4+XBlAUA3/qmth5HkfWIR0MjixKtkKjVItmZ0uK9lcRHowXnuooO/M2yCrXs4bOUW8
	 hbL4jPmWx7HW4V5OFLpREYMivbB1FntdaYRh+7Vhh1zhzvrNpjfLd5nizfiy9rQDfT
	 CdCYQKDSoVGxF5SH9Ika9F5IQng0BnPlt15eC60TJGQd1jaQdevjVIAktrWx/qj802
	 BkMRycB369oyh4WDKfJhZkMFP/gEGvBU41UvD5yuh09ficQ4xYhs2t1+P+jgS/b6G0
	 55QT0ApyQrYlg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 21 May 2026 10:47:10 -0400
Subject: [PATCH net v2 4/7] net/handshake: Take a long-lived file reference
 at submit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-handshake-file-pin-v2-4-b9dadc472840@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5280;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=fOAILlkKSpljatm8qDuCiH6tgK9RZ5Eb5IrSzyam3sM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDxr39u3YY8FyWNtMyGSzpjpsS4/RmGatWc+tn
 Km2dNEqgT+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCag8a9wAKCRAzarMzb2Z/
 l+XCEACpxUeTQhYcISgeVJIaWxE/Ts4rlB71bknABwWtvmvObF1BCPP80u/91mbeREgTAeaiLx+
 4cBLucfDktQsnkcDZybHGPYSTcozRgVA35PA61bZJjJ6mb/RwGxtCbFyQ679z7I/3sGRVQO72Vq
 6nrG0xk/WFNAFTK/FIqfGgSfd2ZPqa7jmohu7h/d7cLaU77MERqr7hlXIx0WBmosuVf9gHEmYdC
 nIueAuycwnrQsIto6kwM7lSksjyKfB2yIEwVnjEMv11jZanyRUXW+553JCNFSgcQ7MvqDTivpWG
 adCGscHz+326D43R1AylQToavQivDhlkeowEXyGjEGbo+FS0D7dwHXQIY/62PrZmOnydruJHWeK
 thQK0XvdpsOIVMxgKip7KIsV5o2ImmklNJ/M911iRSNmp0HBKEG2AUFPQsZGKBh7PifLka8PxYo
 qogyyB+aJOvrlxLmZBi6vwUdjwBg+eqrzEUAXc/mkaf4/hMlGABEOm+8J7msKbnaRb0ZsJVMNFE
 ZIhWlH6s26hoD7BmC0abTsqZ5baynw3CcAibmrDEmGjfXOVe5vIUsofXfyS1Yq82frTrOpzHeDt
 1Qo9ZUzTKG7w/2Qg7lw0od/EI2+L/yxrP+V2D1QPu9O6LApPnjbgi182GqMHz7cCeFmVpu5yvIc
 3rJ6JO1/Wy2OC1Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_074727_972821_C4506F9B 
X-CRM114-Status: GOOD (  22.52  )
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

handshake_nl_accept_doit() needs the file pointer backing
req->hr_sk->sk_socket to survive the window between
handshake_req_next() and the subsequent FD_PREPARE() and get_file().
The submit-side sock_hold() does not provide that. sk_refcnt keeps
struct sock alive, but struct socket is owned by sock->file: when
the consumer fputs the last file reference, sock_release() tears
the socket down regardless of any sock_hold.

Prepare for a fix by adding an hr_file pointer to struct
handshake_req and acquiring an explicit reference on sock->file
during handshake_req_submit(). Release the reference on the
completion-bit-winning path of handshake_complete() and
handshake_req_cancel(), and on the submit error paths that destroy
the request before it has been published.

The accept-side dereferences are not yet retargeted; that change
comes in the next patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 net/handshake/handshake.h |  2 ++
 net/handshake/netlink.c   |  6 ------
 net/handshake/request.c   | 27 ++++++++++++++++++++++++++-
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index 2289b0e274f4..da61cadd1ad3 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -24,6 +24,7 @@ enum hn_flags_bits {
 	HANDSHAKE_F_NET_DRAINING,
 };
 
+struct file;
 struct handshake_proto;
 
 /* One handshake request */
@@ -32,6 +33,7 @@ struct handshake_req {
 	struct rhash_head		hr_rhash;
 	unsigned long			hr_flags;
 	const struct handshake_proto	*hr_proto;
+	struct file			*hr_file;
 	struct sock			*hr_sk;
 	void				(*hr_odestruct)(struct sock *sk);
 
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 18e1268efc7e..f395bfc7ff8c 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -210,12 +210,6 @@ static void __net_exit handshake_net_exit(struct net *net)
 	while (!list_empty(&requests)) {
 		req = list_first_entry(&requests, struct handshake_req, hr_list);
 		list_del_init(&req->hr_list);
-
-		/*
-		 * Requests on this list have not yet been
-		 * accepted, so they do not have an fd to put.
-		 */
-
 		handshake_complete(req, -ETIMEDOUT, NULL);
 	}
 }
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 93cec5f0e16e..b076ae539422 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/inet.h>
+#include <linux/file.h>
 #include <linux/rhashtable.h>
 
 #include <net/sock.h>
@@ -219,6 +220,12 @@ EXPORT_SYMBOL_IF_KUNIT(handshake_req_next);
  * A negative return value from handshake_req_submit() means that
  * no completion callback will be done and that @req has been
  * destroyed.
+ *
+ * The caller must hold a reference on @sock->file for the duration
+ * of this call. Once the request is published to the accept side, a
+ * concurrent completion or cancellation may release the request's pin on
+ * @sock->file; the caller's reference is what keeps @sock->sk valid until
+ * handshake_req_submit() returns.
  */
 int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags)
@@ -237,6 +244,14 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 		kfree(req);
 		return -EINVAL;
 	}
+
+	/*
+	 * Pin sock->file for the lifetime of the request so the
+	 * accept side does not race a consumer that releases the
+	 * socket while a handshake is pending.
+	 */
+	req->hr_file = get_file(sock->file);
+
 	req->hr_odestruct = req->hr_sk->sk_destruct;
 	req->hr_sk->sk_destruct = handshake_sk_destruct;
 
@@ -268,7 +283,11 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			goto out_err;
 	}
 
-	/* Prevent socket release while a handshake request is pending */
+	/*
+	 * Pin struct sock so sk_destruct does not run until the
+	 * handshake completion path releases it; struct socket is
+	 * held separately via hr_file above.
+	 */
 	sock_hold(req->hr_sk);
 
 	trace_handshake_submit(net, req, req->hr_sk);
@@ -280,6 +299,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 	/* Restore original destructor so socket teardown still runs on failure */
 	req->hr_sk->sk_destruct = req->hr_odestruct;
 	trace_handshake_submit_err(net, req, req->hr_sk, ret);
+	fput(req->hr_file);
 	handshake_req_destroy(req);
 	return ret;
 }
@@ -292,11 +312,15 @@ void handshake_complete(struct handshake_req *req, int status,
 	struct net *net = sock_net(sk);
 
 	if (!test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
+		struct file *file = req->hr_file;
+
 		trace_handshake_complete(net, req, sk, status);
 		req->hr_proto->hp_done(req, status, info);
 
 		/* Handshake request is no longer pending */
 		sock_put(sk);
+
+		fput(file);
 	}
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
@@ -345,6 +369,7 @@ bool handshake_req_cancel(struct sock *sk)
 
 	/* Handshake request is no longer pending */
 	sock_put(sk);
+	fput(req->hr_file);
 	return true;
 }
 EXPORT_SYMBOL(handshake_req_cancel);

-- 
2.54.0


