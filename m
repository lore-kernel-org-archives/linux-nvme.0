Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717F1CD4F4A
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 18:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7BKpq32hzuh0neO9rBhaIgtgo43mrOs/1dtotDjy4bk=; b=T/8HJa+x6ubeXVB2bdkUFpBwix
	QMnsCxOEZEB+7xMjlmPlHKHOv0Tl9bmGbPxOABO2zuj7dce8MK4GX6ThWavHsUZPSBUH6v2pY09XM
	e+6BFGyIvyUZpwGSuAz8kNYaHLFOujWhn/aXBiEHbr8A6wBKtjZge6SzylARjdvnBPbAOsEWeP4Ki
	ZRyKgzZyc6nc6lqNp5h7XIFvGRPUbI+2WgHEGeExLYFGozY3wjp//+BW2E9ncNm2YnRdPSF45i+nZ
	Ey3kKy7/Kv1NdY7fmGEYaU8Z1Kam01kmys47L01QYdos6Xsb6q4iYGmeeI6IfGHa9zMGgLIzQ83rG
	AMnuoS3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP2eD-0000000GYYF-2yGE;
	Mon, 18 May 2026 18:25:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP2eB-0000000GYVR-21EB
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 18:24:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AD264601E7;
	Mon, 18 May 2026 18:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CBAC2BCC9;
	Mon, 18 May 2026 18:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128698;
	bh=njF2+kXcv5Mo7EDAtzz6Kd6Q+qwQOtL8nHJSxw2olYI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DTnp9BXoxCwOfuZdgcJ/FKfi5swezphwUa1yRhNZC9mg5TC50Q/GNsSaegLE2afPa
	 PZYumreWNWx/7uxu6+3eipXsuZEd4GwrzS7btPhIuPfZLFUkE21LNvwtVaBIJbu5Lx
	 xah+OVcvZbpPXxsjBeEt7h2Sf4LfyNHWdP3DKNO8xNxotoNeXZLWgmibgpQNd9nAwk
	 5gjbcboma47FUEkPS+jvjeC61w1FpKKm67UiAL4ckpzVfqP+wdDwYNNsj0v3hGX/Ux
	 lvk7X5dRb7sRC1hD3cr2KShfg1MbHlSSqEpYDUDYMrXYI/zoIdki1LHIjQcgiloabx
	 +38soMOIXTfQQ==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 18 May 2026 14:24:31 -0400
Subject: [PATCH net 4/7] net/handshake: Take a long-lived file reference at
 submit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-handshake-file-pin-v1-4-4bbcb7e62fda@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
In-Reply-To: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5232;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=uYhO2UHYUMvDGd847dN9rjt4J8bHQE4/y1lWKDwprHA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqC1l1+jjUqcVWi3AEj1oRwdwZRVsYbRw2ZaQeO
 7TJk/EXx52JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagtZdQAKCRAzarMzb2Z/
 l+wkEACcj0pnITEReg6grmpQaOJ3Y8bdPpAZhBbElpQJJTTDltsaARsU2A5sAUqeWQXLZDEW7hu
 XF7d/N3/O6ct8z/TZ2DR8ZjrR5ftZG1dggcN35XAur+kXtiBWwDkBN7iek02XpTNEE943+/YsHE
 O6KgXZr2XFIwYjhzXCV00beFWSjpn1/GomhdJnvcaPQVSQ8D0t/1bekN+qlrYssDcdvyL2uoycD
 Jd9PqNM/HqSmm4/oc/FphEzZ9UfOd//pmRYlZqBaNOgsYrG6SVTf1YsHj3XjntM1ZT+YDbsu8GU
 FymiifAy1+R3jmTYjdTxjU9RvxRsinPaFi0A0OBb3IFDK/Lz8w6gZVgj30nBNSO1MOtfEdbB6QM
 1DGFwPPjN7tH5UKgEA1fAgEtZoZDEPxExHMGqF+/c3DJLh5r22hyaCR35MIp+nzsEsAJgL8PuX3
 6b4/r8eSt/uOp6NfAZfAgEv1x5y3YL2c+2JuXwHAHG45ezJqqwnJ+LhDJ6C0xL9kDk1Vlz4LbjS
 bdfpDZcvHy0zgtP19PSZ4GmM1cmu8iZL/kdFBCU0xdCOJtyJ57lC+d19W4KOWpNOasCrx/TKLcq
 mXdpWuMYzDkBAgnf1lSsmOpSkMCzI8SPzM5BFRljYpEuWjfNX9fD4zbU7tx7egcuDPDBmS2r91o
 bOfhtBp63WwGvNQ==
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
index 08e5a5867a90..0d5871f4bd67 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -215,12 +215,6 @@ static void __net_exit handshake_net_exit(struct net *net)
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


