Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3A8CD5BC9
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 16:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3sV7CisUXRvu4xk7CJK2Om/kDdQX9rT8XPN6mILOPS0=; b=lg6/m9MetMRWUwR6INjB3bdsFp
	6ftTZDS7z44Jx9Hd6UptysW6PaNyK/Iuv4WmCnQk3qm1LZcRQnpWTIhYczIN+2+V0OkW/o7mkkPoS
	NQrzZMr8e4UMzHCMpcF93Jh6YETNzoaOMTdMgcHc0ExJcudPGCGUcN6D1iVxDg0l5oHB3YA5BnaIy
	xT/AiJCYKs+HXFMkRfrkNxnTq+du09Hqzm2dzEMap+/tRWmUjv1iYOTfmTQH3Knz3SHhQJaHjY5s3
	wKWqQhKEBLsFxVcFiDjycTdILiHyTdXBwf/wP+yOX9rjSa49Msa5f5POI0YnF7EE7/4huqBMdv9Oj
	tBApCi7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYWj-000000004Ei-4Byp;
	Mon, 25 May 2026 16:51:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYWg-0000000049q-1JMh
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 16:51:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0F154438EC;
	Mon, 25 May 2026 16:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1642F1F00A3C;
	Mon, 25 May 2026 16:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727897;
	bh=3sV7CisUXRvu4xk7CJK2Om/kDdQX9rT8XPN6mILOPS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S7Qv71hnVHQbo4h2JuSr2NsgpHWyvjwR5I8XQsbLkzSrdjkfOGknsvnh73RpvLbCo
	 Z6bpfzMzMZBc75b4qb1jfn0Fj0QI0f7cWoHLZtObnSguEMJ9ap2UcQO0i4DsVBxqRz
	 YLFOXpdyP86ycXV8Im37PZtGg8s1TGZ/P1L8reP2KoFmjHooUe1aVgHEe7RwZJxDTJ
	 5Yi4G6ByqETNWhboq9js+qYX43I/z9CfaAIngwHNKiUAsAySt7EY+NDpjc+o1y2nkC
	 b5wurClhj8Rsrnn4yzWO33FwJhciFlgTRb6Ffu/O1Nj2eY6aOLE8s7mjTDnKV0eqDY
	 n8/vl7MJBpEGw==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 25 May 2026 12:51:20 -0400
Subject: [PATCH net v3 6/8] net/handshake: Close the submit-side sock_hold
 race
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-handshake-file-pin-v3-6-66c616906ead@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2451;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=1phSO4uZAXeOihfNhVM6RpyPnzc+8HOYch8AcjQXdyg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFH4Skf2i6pZ8hDWIZ4UR0Qd7PfwL2fLAwummy
 p6tTW0zmaaJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahR+EgAKCRAzarMzb2Z/
 l4GpD/4zGxPw62b9x5jVTuAcyor25aG3900J7pbSntZ8T9WLGYTTw6Y6WVNxvxk2XOXhdGnV5Yt
 MnHQFq5A7ExIiitt9XE/jrUwxIPrMPF3STmgYy529pAhPn/FVcuHykAoCluR7EhFEOP3J8Id/sz
 upUbyQE9I+3YFGm9SfRwqUeef7JXQf9lj4XMA5LA8mtBbMgLTKCvWp+5NR6MwVJq5VfTOG4R02Q
 DvSo9WY06miTDkWgFNBsdQQLPR+EPMFRtINJXJWHPpnZrpLyMekYrHT87ALPwAXhcPn+IfJ4l8x
 B5RoFe2OmEkzgmcWstXS2/wIf279GP7D6GcOO6kynq1Ql5LQyCuxx/PpuswpwKR2sJSZSpIQ1fb
 CjySPUeKyF+ONNPTauAJbaQrg5wSbCdgPzTDJNrjGlK2zSqUcOd4lVsABNZBS8TRSMy+JTUnm8q
 /NEMQPATGWzug2XQx1wy4i3pgLV1f3W9qBiwEyvIQEh6B5mnM8DUy+miY85EjBc6Bn0njtBHRI9
 YIML+HRK9S6sRvNe3kMHDi+IuDZ8vqDKVhy/ztPzaRmbP8vse22sM0LZnNzOnotWK9+OkkB+hXj
 MtO2zYJiPZWPi7fuL/wIFn3XSAzVCiKaGb6b8vnGXWi7qc74+SaiCPZdC69wICDHanxCLa6QIzJ
 zCb1b5iZgvJBtYw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_095138_407871_8FFA3149 
X-CRM114-Status: UNSURE (   9.72  )
X-CRM114-Notice: Please train this message.
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

handshake_req_submit() publishes the request via
handshake_req_hash_add() and __add_pending_locked(), drops
hn_lock, and calls handshake_genl_notify() (which can sleep)
before taking sock_hold() on req->hr_sk. A fast tlshd ACCEPT
followed by DONE can drive handshake_complete()'s sock_put()
into the window between the spin_unlock and the late
sock_hold(); on a system where the consumer's fd held the
only sk reference, the late sock_hold() then operates on an
sk whose refcount has reached zero.

The preceding two patches install an explicit file reference
on struct handshake_req. That file pins sock->file, which
pins the embedded struct socket, which defers inet_release()'s
sock_put(). As long as hr_file is held, sk cannot reach refcount
zero from the consumer side, and the submit-side sock_hold()
with its matching sock_put() calls in handshake_complete() and
handshake_req_cancel() is now redundant.

Drop all three. The file reference already keeps each request's
socket alive, and the lifetime story is contained in a single
get_file()/fput() pair.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 net/handshake/request.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index e2d7ee7ce6e0..bd3d9467ab91 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -301,13 +301,6 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			goto out_err;
 	}
 
-	/*
-	 * Pin struct sock so sk_destruct does not run until the
-	 * handshake completion path releases it; struct socket is
-	 * held separately via hr_file above.
-	 */
-	sock_hold(req->hr_sk);
-
 	trace_handshake_submit(net, req, req->hr_sk);
 	return 0;
 
@@ -337,9 +330,6 @@ void handshake_complete(struct handshake_req *req, int status,
 		trace_handshake_complete(net, req, sk, status);
 		req->hr_proto->hp_done(req, status, info);
 
-		/* Handshake request is no longer pending */
-		sock_put(sk);
-
 		fput(file);
 	}
 }
@@ -387,8 +377,6 @@ bool handshake_req_cancel(struct sock *sk)
 out_true:
 	trace_handshake_cancel(net, req, sk);
 
-	/* Handshake request is no longer pending */
-	sock_put(sk);
 	fput(req->hr_file);
 	return true;
 }

-- 
2.54.0


