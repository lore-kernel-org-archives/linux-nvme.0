Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C59CD4F3D
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iH+hAZTnQuBHXQ7FDXtE64N21hMMt1xCdEy5ijN2/Sk=; b=J9LUw00lSCkTR74AmP1H1VgAdm
	t1Zp6t8B5PUI/8aEwQz358pn8vjVwB2u6VL7MaURd0+OJN0IoOJJuSWP9gzUZ7Cq/bZqbWp4dFAkL
	2j4n/FXjs8gmG1HThNvr3+7tzli+qe8mOWXavkkzxONldZZYnf6lFgtF8FDF9arSz+I/srrr6RJBZ
	tjwhk8r2tkO0LifjSsrGTYykdrS/um6eZXxdYDK08ot/KwgPwvQ8aBBuNVA0KhRUobvIb3KkwvDhf
	CLGOcfhstQ0ytco1zV8e9oUYcf4DurqKKxhUsL1qwQ+yUD2wG+odsOhYptrqlGsLa4Ml+6ByzFylu
	2l8q9fPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4gN-00000008864-3kE8;
	Thu, 21 May 2026 14:47:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4gK-0000000883D-1tvQ
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 14:47:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E20ED60211;
	Thu, 21 May 2026 14:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC87A1F000E9;
	Thu, 21 May 2026 14:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374847;
	bh=iH+hAZTnQuBHXQ7FDXtE64N21hMMt1xCdEy5ijN2/Sk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N19ahjFazA6Ry3KBJewafWcWBptqfdPTeMH+BxHsZgulrupGhmLg1ttfjdriZIl9e
	 S4iVmFkbJAuOB715+wkWHhVMYWDFw704kANmgpPCZvk33MgX3HblU2ywmBiXJSDAlP
	 aH5IgjLp3gL4nnf1ZwYgNW+ithQT8zzYV1lPxyuAb6PBo6a2gFJ//CGvoKasUbzyDy
	 s7XO832T+x2k2kW7RiQaZqPH1bFRXKRRIzrhekhJdHjqDQYiweuVqkFjmHas1grh91
	 Mo4JixE7jH1sC8ABopwQt+ZHxGMUoLghjOtY0/2uXDlaqZeyifzgJAXq7Rt/sBKwVA
	 oZLd2PJKeA1dQ==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 21 May 2026 10:47:12 -0400
Subject: [PATCH net v2 6/7] net/handshake: Close the submit-side sock_hold
 race
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-handshake-file-pin-v2-6-b9dadc472840@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2471;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=9ZOikSUuV+RCaLR3zLmrqVgvTu9j9SMOgYayy3SXkDk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDxr3/7Df3KopM5XcQVKWKeXMWsKIiR1xiQo4f
 NR2jal/o4qJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCag8a9wAKCRAzarMzb2Z/
 l3j3D/9L64/Cn/NHxuVL3oBdcZuWoaJ7qF0AlhrMeqbAGVNoZqPsrRAOpg8cevLTCe9TH2xHdJQ
 rcKzQLbDhht1kW/aYZZ0/DmuZASflTWJoBsUZfGuCnMWpQAk8mv7aUz0BtrvP451ZSnOdD2PIFj
 ufdIMmWwaC7NJjFe+ADkxuL+cZISCe4WjrQ0cHFHwInAeFkffYqiJDg09q1K1ZwVsXw+OGDzHbd
 au+/7KsvviVGg2GUs2t1Kuf7rlAX1Kqbvgcg7f3915jrK0CK7U4sPbs1Ix+IOIoSN9OF4MHDjqS
 tk7OUkUG0mAdvs2+GSnOja89JO6uoirpV1ISCWSvp+N7sEKYP0R8ixAbzkxiv0MfNz298E95YF+
 ZZQM4fK8e+yVgQnvc1rj1XBgZk5X//DVFouzxZTpuJK+d3ZHYKCwES8ta8skO0TlSmJynxomhEF
 oaTLIOTZnn+PEmqWiN6hu8nGE7VVCVYy6s0BoT5++b3SfKA8/+R9FwB2AkLlzIDXW9yUJt1Rg86
 Q93NbI86VlQzskupDU4sk75+aXpu6sRjlGn7gPouY/3uOl4KelYw0uzFfA6bXreal/ZYg83vR5g
 aTUZ8ifgppLzMDcAdJB5K0CPLtUHpvbj1fnN+Ekjjtmqb90pofhKQ5mQ3aXLfiyVctOIvwhvFZ6
 VFhw2gruS4D4iCg==
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

Drop all three. Submit's pinning is strictly the file reference
acquired earlier in the function, and the lifetime story is
contained in a single get_file()/fput() pair.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 net/handshake/request.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index d24b55af1a0a..1c669c1602b5 100644
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
 
@@ -335,9 +328,6 @@ void handshake_complete(struct handshake_req *req, int status,
 		trace_handshake_complete(net, req, sk, status);
 		req->hr_proto->hp_done(req, status, info);
 
-		/* Handshake request is no longer pending */
-		sock_put(sk);
-
 		fput(file);
 	}
 }
@@ -385,8 +375,6 @@ bool handshake_req_cancel(struct sock *sk)
 out_true:
 	trace_handshake_cancel(net, req, sk);
 
-	/* Handshake request is no longer pending */
-	sock_put(sk);
 	fput(req->hr_file);
 	return true;
 }

-- 
2.54.0


