Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9791CD4F50
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RQ8F4zAvyuKAZBkIw5NDVodPDujhO6Rgyaj5DqwRjbA=; b=kifDbRrZ8PusF1Xi284a4Ih6KV
	wfUUGANdRdZtQG8pcMfl7p/arCRQ/EUlUmcExjqiOx67lWvhJTepZf7VeDQDUHAvPQqlcksrTRShi
	r7THiw/iEv5YCb9bBjpNn/uZYz55PqbxN7iIV0PPGQ6k8Lizdn6eaZpinS/+WqzFld27cetG3PDI2
	3IDFOuy0OCWPkGfBQTl1/2Z+VK/4M+33hbL8GfzLGUlFTrXFJSGHQFnu8yuN+LXcivKpGcsjQPTrH
	EjARwOzNUr5iACJydSg8D+FUbdIPnP35kmy3JUmgg0Ta36yicP0AnJMNPgylrO/ULoX0GTgLbNR21
	X9YM6E6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP2eF-0000000GYaJ-0tbg;
	Mon, 18 May 2026 18:25:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP2eD-0000000GYXu-1V1t
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 18:25:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CDF0A601E9;
	Mon, 18 May 2026 18:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D619C2BCB7;
	Mon, 18 May 2026 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128700;
	bh=Y84GsqMZH3S9Oxo1jGVwdFL4nBULJFTA48F/5LHByu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZmKHzgnV1zOcnC1LeeQQsmc82fIpfB+dlWX1q+tKzRCGGl/FgWdKAKLvpzeeXPqB+
	 zZNWhcmwbNkKXy7cYjzlfn0Ui1CxqYWDGStt8WLHIvnBP8X8vnie9XEnNJsl6lnvg4
	 W9E5GVPebC2qsgtImPg7RljXLa9viU19GyXDVfDykYlaPVfDg3UbwAkCNgWtd7olz2
	 h8zu+beYSrSRZ3T53EU+T/XjuP03OSUvc6DBAtIhqPrJF9dZYEZsEo/JbyNd8S/p53
	 MhFwjCR+HFkl2jNyqon2knjfDUibAgCw3zn6kcog2o5a6izwji0eIZP9O/LuyJetD0
	 Pi3Z7Mf+pdR8Q==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 18 May 2026 14:24:33 -0400
Subject: [PATCH net 6/7] net/handshake: Close the submit-side sock_hold
 race
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-handshake-file-pin-v1-6-4bbcb7e62fda@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
In-Reply-To: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2423;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=k9ndcmxWIdqOht0wMxjUop1uvWrw2thqkYTfWFXfHD8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqC1l1+M7enEIBnttY1PlJLNawcg++wk+wRuFoF
 0cA3qnJLtiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagtZdQAKCRAzarMzb2Z/
 l0aQD/4gi6tMJ1pxUtCPSoc6XBXQBpPOkQYr/KSEwKtrm8IQKiVWzckUOjE0PJ2l2ZBme6ynWAg
 ZEWU09Cht4/aZIA/L49vInnAJf8+dSEV2SzpKi7jqtX9LVl0snDVebWKXAKC83WxbRgpdvxo4cS
 KROatjK6YOWci39JFnoblqw7xbGQy8eILUoEr9FEVJmixWshTY1Fn2DrtJG2Sw/Hp2ih9jtGHLd
 Sxvth1d6/7YU7EQBQzHEnxzTjoksa7hoblMdBJzbk9NC3ZnyrEvvhgqdGKq25nl6Kz0Hp6y/AWO
 xINs7dCqUiarf4wTdoFQZ1B6xdliPjD/5xt7zjSyJK3rwWJANLxvEzBDOz3dppCLFZZo29QVqaZ
 4iwi2sW3OCpOXCOvhUjdRZpoL8Iry16rZtMD5J0IWWwpA4Hxwomwj9+I74/DUGytBRCLALoZ/47
 egWKb/daoGP58Yo/IjMRZysdvwV9SltqpV0svYWEztM4JtWgL/8ZyQ1FmmrnZrA2ZwMw1Xw25vf
 M4m9ofXetYFCgTVyrtVOExG8ZSReBL3jyAfDgdgVHdUO2TUKztnIo1MwM5/jmm6a2oSYCIXXWXh
 zM6cuXemxNXLSEGEgyOSsS+uc0RcYAqGBQ0Mon1oR3k5AaUCMBe75COmT6r1cBDKvUho1FhpBbF
 fG1MRMvYryAsE5A==
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


