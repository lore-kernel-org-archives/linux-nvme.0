Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC4ECA5FBF
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IJFRpgGenZGFgmE716szjfJPy4R2IRxV7+FW89IFnek=; b=kT93daWbFUPTld2skdmocQ1259
	UVXNO61pnqhIm3on6vwh41cGkH9BVWehPnzPcAXaGiDzh1GvTDOvSlhAXXkQN6x4soaj6VBho6NqC
	UGmLL4zL6YdrOX+zHFvYSKo3gUDlPkpgaT1UJyPfbVVfd8ayOEolb6FuRh9Uvdg8LVmdWcUrElKL4
	6i/ur49MQbW08yV0p8nBV57FgbMIeYkr5rBx4hTQcP49UI5g0cPWO4V+bsAhTtz6op/YwKavnrgr7
	pw6uELyMYF46grodZn7DJVF6zpEk0YjY9furbi23rtcGiZObLMfWL0FHHCHOOoB0Ao3/Zxj2CaqkX
	ZWZVuH0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7f-00000002jSs-1ThS;
	Tue, 29 Sep 2026 08:23:35 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBS6L-00000002a3b-2p2v
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 07:18:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1B95860A5E;
	Tue, 29 Sep 2026 07:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656C11F00893;
	Tue, 29 Sep 2026 07:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790666288;
	bh=IJFRpgGenZGFgmE716szjfJPy4R2IRxV7+FW89IFnek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LHPMDU1stnoIOzkVui5b8vIjoubzbqbSkB4Jj1qRkY6vs6k1Y8cf0xmvP9HdU+YYk
	 swI3Mapse3ZMpePDOfv9JPB2K6iAg5gqIteBCHA4COYT3fRb609BKChwFGSCxSziUc
	 Biv+bVQseOx+MUK9r1S5tpgS7zGeRiWE0sh9iij7+BLslOUPKSFPtF8IiBWh+NDmiB
	 T6hCU9+gd6sD7bGJw4O+ZgDRrGfEzJAVQ21WozmNFHiLL1QcS91U27S7+RXqvICDh8
	 0EwVWsV8vAEy1EuFG+wTLl4Px1nPEY48mKz5HPwvfvg8LuX+TzyYQ+Z1TEW7ADYcVh
	 1Rae7OOHJcrOQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	edumazet@google.com,
	netdev@vger.kernel.org,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	gfs2@lists.linux.dev,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	mptcp@lists.linux.dev,
	Wen Gu <guwen@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Allison Henderson <achender@kernel.org>,
	rds-devel@oss.oracle.com,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH v3 net-next 3/9] sunrpc: use sk_set_nospace() and sk_clear_nospace()
Date: Tue, 29 Sep 2026 07:17:37 +0000
Message-ID: <20260929071743.23624-4-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260929071743.23624-1-edumazet@kernel.org>
References: <20260929071743.23624-1-edumazet@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 01:23:30 -0700
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

Use the new helpers instead of open coding the SOCK_NOSPACE
manipulation, so that TCP can later maintain a cheaper private
copy of this bit.

No functional change intended.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/sunrpc/svcsock.c  | 4 ++--
 net/sunrpc/xprtsock.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 50e5e7f5b762de28c34d0f58cb0c6feb1e3ce79f..2d8cdee0798d540ba8eae589deaac5bd3ff889fa 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -792,11 +792,11 @@ static int svc_udp_has_wspace(struct svc_xprt *xprt)
 	 * Set the SOCK_NOSPACE flag before checking the available
 	 * sock space.
 	 */
-	set_bit(SOCK_NOSPACE, &svsk->sk_sock->flags);
+	sk_set_nospace(svsk->sk_sk);
 	required = atomic_read(&svsk->sk_xprt.xpt_reserved) + serv->sv_max_mesg;
 	if (required*2 > sock_wspace(svsk->sk_sk))
 		return 0;
-	clear_bit(SOCK_NOSPACE, &svsk->sk_sock->flags);
+	sk_clear_nospace(svsk->sk_sk);
 	return 1;
 }
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 7f60723fa64d84887e260e5e130e44cdbec6f850..b97c70c12f627630509510facfd3c3cf96ab6cb6 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -858,7 +858,7 @@ static int xs_nospace(struct rpc_rqst *req, struct sock_xprt *transport)
 	if (xprt_connected(xprt)) {
 		/* wait for more buffer space */
 		set_bit(XPRT_SOCK_NOSPACE, &transport->sock_state);
-		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_set_nospace(sk);
 		sk->sk_write_pending++;
 		xprt_wait_for_buffer_space(xprt);
 	} else
@@ -1615,7 +1615,7 @@ static void xs_write_space(struct sock *sk)
 
 	if (!sk->sk_socket)
 		return;
-	clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+	sk_clear_nospace(sk);
 
 	if (unlikely(!(xprt = xprt_from_sock(sk))))
 		return;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


