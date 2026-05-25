Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0B1CD5BB1
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 16:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IxJaGtQoJkPVdTRrPxKYx3Y8U4vPqPnOum4dhkgUAHg=; b=KrRaOgHtFQO7ck/YMPt+RhCiKN
	6EdRXa4DDTm2LzrjUBTSDPhaV8YMtUt3Ulp4+i+/iz3c63ORHl3pnNn7xUWOY5xZNAkrLA7f69t/M
	BtLhs/TaK9ADEyUUmdJtRY0zPUYeTMaVCnVvw8B9dXv5MYyhVCAKO1DQAsPdZtKm+JDFuciFJI1yt
	23X8YzxSd6QMVZPV3SEaxm5okTtQi7GgF4wBAiF9oIL7Y7R1ZpBOwmKXDn81SuV2+G6fT4u7urEEa
	owA8HFXjaMsCrmi7U89lC4XqgAlC6wr+kLvFI1FRAT8EZCSQuxN+RW1CIONZTfM9Qq6Hb99Opnlu/
	CSRwJkrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYWe-0000000048H-3LLg;
	Mon, 25 May 2026 16:51:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYWb-0000000045y-20ZD
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 16:51:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B617F40D8D;
	Mon, 25 May 2026 16:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDEE1F00A3D;
	Mon, 25 May 2026 16:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727892;
	bh=IxJaGtQoJkPVdTRrPxKYx3Y8U4vPqPnOum4dhkgUAHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ofJP1NgED2ey6e2/TQOlgZckaV6Cnyu+o2VwBw1jI5+GFdXo0+YLVfJ3lhP4GfuCw
	 imI8w/rpE8Xaw/+URIpMmcVvRxFGfYKiNRmTZgvU0FAwXOlVQneH7ZeIT+OhsexeGZ
	 6BRbfgpDrJ1SwwhuuJpQRqmf0C/AOU8nVFw6B7WVQfJ0S5RDTjPR3rZVP3yvOQuckV
	 0Zngh0zLEApfqgsYS2ZkUX+9OGyV0qJLvBgT2Q5PYQBK7TcVYMRVUv67cPUVqqpt+1
	 Lt2X892G45KiZ3m+k7mhDQQA7kg4T65W2Ofuhdd5VCj1HB8XHsr6u7OHJdX9Uz/hZz
	 /8HEkxwu466aw==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 25 May 2026 12:51:15 -0400
Subject: [PATCH net v3 1/8] net/handshake: Use spin_lock_bh for hn_lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-handshake-file-pin-v3-1-66c616906ead@oracle.com>
References: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
In-Reply-To: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4764;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=6A+lqpdwbykiqZeeogOj+ebtUfZ/y8/UTW+7RqvHrqU=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFH4RPkLmCr9G4vXTlRtRPquQN4vNWc5Tl9gsM
 1G7xEriz26JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahR+EQAKCRAzarMzb2Z/
 lzIGD/442fxMYfTEY5rbtqA6gBoUsmqAW9Qi/SLIJxaoDMC8H/IzWwFXSivPlYPFtgcuRI7X+Sd
 x5uAKLZKsuqT+f4CW44JvFZw9Qtz3+ZA4yuZ3zq7TRtwHMe6rFkbxoZ6FYp8sS2fJj12qcuG0SN
 Vaksic4h65BS61mlwWKqp8+2qKd1TiMp+CNNfzZiaA3E0AVUpwIlvlxBdaZkU+lmLSofDYXjQPg
 EYZNlpcFsAlP8W9iPmxlgz17YEDHQ+WqeBZecio8fRuUeKYPhVwGAEgAOHIEsGVG6QbRyDiKdon
 +zf0glOSSAhHXbPUxZcOjXbrLvRw2bhLGq9JPQtSLtQcM6Rn2mlpInf3JAxCgGIFpSCwNiNYnmm
 G5pPCD55U9ITYmK9LnTlc93yAwjFkiQbgwq6d/J/cDN8xfj2aqeCJ1VFw+xwwTpvgQ+DrKSYlGu
 OHI4Qzd03wjtMpqJtX/4nuNKMuVCGDgtH3BSn8IkFrI4fV86oNx6bbkr6EPLrcrG/z812j6SqDK
 G4a0tCNnGLzwAr10z/Xza/vOQlBALfikkfeUEoouKNI+EeBM1dnrNLrewrUvgNSrv0lGcA1Ydo7
 ZuMotosy22ZXx2F+eMKcELSsqX/kLnjLVnFqfzoPpOufVFaCvg8O31QtXiCWqlL4zSA2B0gmUKg
 c7aDLMcjBUx5Cfg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_095133_574381_33113024 
X-CRM114-Status: GOOD (  15.43  )
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

nvmet_tcp_state_change(), a socket callback that runs in BH context,
can reach handshake_req_cancel() via nvmet_tcp_schedule_release_queue()
and tls_handshake_cancel().  handshake_req_cancel() acquires
hn->hn_lock with plain spin_lock().  If a process-context thread on
the same CPU holds hn->hn_lock when a softirq invokes the cancel path,
the lock attempt deadlocks.  This is the only caller that invokes
tls_handshake_cancel() from BH context; every other consumer calls it
from process context.

Deferring the cancel to process context in the NVMe target is not
straightforward: nvmet_tcp_schedule_release_queue() must call
tls_handshake_cancel() atomically with its state transition to
DISCONNECTING.  If the cancel were deferred, the handshake completion
callback could fire in the window before the cancel runs, observe the
unexpected state, and return without dropping its kref on the queue.
Reworking that interlock is considerably more invasive than hardening
the handshake lock.  Convert all hn->hn_lock acquisitions from
spin_lock/spin_unlock to spin_lock_bh/spin_unlock_bh so the lock is
never taken with softirqs enabled.

Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/handshake/netlink.c |  4 ++--
 net/handshake/request.c | 14 +++++++-------
 net/handshake/tlshd.c   |  2 ++
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index b989456fc4c5..97114ec8027a 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -202,10 +202,10 @@ static void __net_exit handshake_net_exit(struct net *net)
 	 * accepted and are in progress will be destroyed when
 	 * the socket is closed.
 	 */
-	spin_lock(&hn->hn_lock);
+	spin_lock_bh(&hn->hn_lock);
 	set_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags);
 	list_splice_init(&requests, &hn->hn_requests);
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 
 	while (!list_empty(&requests)) {
 		req = list_first_entry(&requests, struct handshake_req, hr_list);
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 2829adbeb149..5d4a17f902d2 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -167,12 +167,12 @@ static bool remove_pending(struct handshake_net *hn, struct handshake_req *req)
 {
 	bool ret = false;
 
-	spin_lock(&hn->hn_lock);
+	spin_lock_bh(&hn->hn_lock);
 	if (!list_empty(&req->hr_list)) {
 		__remove_pending_locked(hn, req);
 		ret = true;
 	}
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 
 	return ret;
 }
@@ -182,7 +182,7 @@ struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 	struct handshake_req *req, *pos;
 
 	req = NULL;
-	spin_lock(&hn->hn_lock);
+	spin_lock_bh(&hn->hn_lock);
 	list_for_each_entry(pos, &hn->hn_requests, hr_list) {
 		if (pos->hr_proto->hp_handler_class != class)
 			continue;
@@ -190,7 +190,7 @@ struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 		req = pos;
 		break;
 	}
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 
 	return req;
 }
@@ -249,7 +249,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 	if (READ_ONCE(hn->hn_pending) >= hn->hn_pending_max)
 		goto out_err;
 
-	spin_lock(&hn->hn_lock);
+	spin_lock_bh(&hn->hn_lock);
 	ret = -EOPNOTSUPP;
 	if (test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags))
 		goto out_unlock;
@@ -258,7 +258,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 		goto out_unlock;
 	if (!__add_pending_locked(hn, req))
 		goto out_unlock;
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 
 	ret = handshake_genl_notify(net, req->hr_proto, flags);
 	if (ret) {
@@ -274,7 +274,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 	return 0;
 
 out_unlock:
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 out_err:
 	/* Restore original destructor so socket teardown still runs on failure */
 	req->hr_sk->sk_destruct = req->hr_odestruct;
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 8f9532a15f43..af294c6cc717 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -425,6 +425,8 @@ EXPORT_SYMBOL(tls_server_hello_psk);
  * Request cancellation races with request completion. To determine
  * who won, callers examine the return value from this function.
  *
+ * Context: May be called from process or softirq context.
+ *
  * Return values:
  *   %true - Uncompleted handshake request was canceled
  *   %false - Handshake request already completed or not found

-- 
2.54.0


