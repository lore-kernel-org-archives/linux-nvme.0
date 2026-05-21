Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2D7CD5BAF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=88ToqLzOsLRgPD+7KytIGI/hBC10CZr8uP3juS6Bygg=; b=yHxKbO0X6JarDwDf8z242SlWbC
	C0fVPNwknIUgzS4QUrNhBMjmYI0h194cj49tZGETeFZbio6brXwrC3Ty6E2mGJ9DBprsjSZxnRFN1
	k3nXgO/7RLFNQK86buPbUCCyHGmKKVVotMAhHqdAmmwFHGQe1x9HkRWvC5yjHEtMzvcTlDSXzotN7
	JEakuQEkYzvRFs/AhhKN1KI3FeCLe19aKXLTWmH1g/5O5XOemiB/s3QxXHE1TLJxgBZ3+FclLzCub
	vf7SaOGvqBG1htuNQJCMlx7yrVtDiqURLBEfBbhAw/952ngheY+i0F0n79fWozyzHxFx4/zjMm3BI
	8Pp6dbvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4gH-0000000881w-1UyF;
	Thu, 21 May 2026 14:47:25 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4gG-00000008811-0gkb
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 14:47:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7550B601F3;
	Thu, 21 May 2026 14:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0FC1F00A3B;
	Thu, 21 May 2026 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374842;
	bh=88ToqLzOsLRgPD+7KytIGI/hBC10CZr8uP3juS6Bygg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jj4BNh0AL06WtaHwm2ADa9PrpZrPZqm7bCXg53TvtX1vS7B7Fn+s1GFYjP4lMwhxs
	 x0SrGwmw4majV1ZNTSvgSyQXDhmI19eEeMXU1Mt8YJaem72h56vbCHjJDPmfQaaj/y
	 iX/paOwiljZTebpUDpEUolgB+FtiOIhvSS3d7RDDS/vB5lHTwlarh9JgjsDKDElQ97
	 1qL9u0RVnsxeuGztKNfv4xCLzplKGC/aIQsgfAyzZdeqztSiKCNvrNRKX7MfxSPko+
	 Xzv7+CbvFlBHdHkF9rzR6oih0BLFpT81o4wmX8c0w1ojieVK50uexGXZGLZRSouKQT
	 s0pV1YoEjx0HQ==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 21 May 2026 10:47:07 -0400
Subject: [PATCH net v2 1/7] net/handshake: Drain pending requests at net
 namespace exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-handshake-file-pin-v2-1-b9dadc472840@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3309;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=04KxU8BkirXW/POxVEKdC3sZ1vgwrSdYMhG+EtdWBHc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDxr32pW2kt6Upg1oWjwfpGLaSnWNlCAnGGwer
 QavL+dDI+WJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCag8a9wAKCRAzarMzb2Z/
 l2/UD/9pdiwh9wCfLZ8WoZQzibT3XZMF4BuHTOmH++OEqJaywFI1lSVGJoERuNxsQ7ee7Hk1pMi
 XqUsPYhhokBAayDRI8E3eb27fPrWdOzceGNuuWeV1PlK7BRcKqyRNkS7nN9MU9qcDtzzOL5fWIU
 0vcOTNDw1IMAoUITBj63ZSqtfEAWj1FNN+RD4ujiFFZG4D8hvMKfL4G0h7asnBxr6iN/AfUjkZC
 d0A9dTqLlQKMaY6SCtKl6+a3zwgwr2AXs8MX+ZzMd8JhNBLtTQUTi5JmG7jGsN/jPl4pHcbYG9k
 KmONC2ofYTCP8Y4Gpm3kHHTr3mM/SiKXLpzLU9YheMznkBI+E7kRqfsw30o4MdmUfHMGzzhQ02h
 tiGGrtO5RWz/nttxJ5of0yhldrXbGz8LzP3nszJ+Gyx2r4O12hnonzHYdZ2UqtW0w2vT8ZQ4hh9
 r5H7dpV7j1S9FroM2227Pmk+0cmQ0eVPJfHcLTQ6t6WPjujAUh8cJA6bA7L87zlUGJJ5oDOSxP7
 qWiGrXz70MRo6jVCnNIpm505/gs9Gi/hOZ/Ur0FNGZNGW2LnYPED+S8+glugJPAUFqbj1T3G4ig
 3HUaWl0X7I6hp8/8IswAeU1ZCIKsh0tX4r6KRt1rGMVbPVHYIBtgyCCz4bMsGXpxYEOV06yNerH
 PwQO+MxKy8+tVaw==
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

The arguments to list_splice_init() in handshake_net_exit() are
reversed. The call moves the local empty "requests" list onto
hn->hn_requests, leaving the local list empty, so the subsequent
drain loop runs zero iterations. Pending handshake requests that
had not yet been accepted are not torn down when the net namespace
is destroyed; each one keeps a reference on a socket file and on
the handshake_req allocation.

Pass the source and destination in the documented order
(list_splice_init(list, head) moves list onto head) so the pending
list is transferred to the local scratch list and drained through
handshake_complete().

Fixing the splice direction exposes a list-corruption race. After
the splice each req->hr_list still has non-empty link pointers,
threading the stack-local scratch list rather than hn_requests.
A concurrent handshake_req_cancel() -- for example, from sunrpc's
TLS timeout on a kernel socket whose netns reference was not
taken -- finds the request through the rhashtable, calls
remove_pending(), and sees !list_empty(&req->hr_list).
__remove_pending_locked() then list_del_init()s an entry off the
scratch list while the drain iterates, corrupting it. The same
call arriving after the drain loop has run list_del() on an
entry hits LIST_POISON instead.

Have remove_pending() check HANDSHAKE_F_NET_DRAINING under
hn_lock and report not-found when drain is in progress. The
drain has already taken ownership; handshake_complete()'s
existing test_and_set on HANDSHAKE_F_REQ_COMPLETED still
arbitrates between drain and cancel for who calls the consumer's
hp_done. Use list_del_init() rather than list_del() in the drain
so req->hr_list does not carry LIST_POISON after drain releases
the entry.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 net/handshake/netlink.c | 4 ++--
 net/handshake/request.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index b989456fc4c5..a8dd848371ff 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -204,12 +204,12 @@ static void __net_exit handshake_net_exit(struct net *net)
 	 */
 	spin_lock(&hn->hn_lock);
 	set_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags);
-	list_splice_init(&requests, &hn->hn_requests);
+	list_splice_init(&hn->hn_requests, &requests);
 	spin_unlock(&hn->hn_lock);
 
 	while (!list_empty(&requests)) {
 		req = list_first_entry(&requests, struct handshake_req, hr_list);
-		list_del(&req->hr_list);
+		list_del_init(&req->hr_list);
 
 		/*
 		 * Requests on this list have not yet been
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 2829adbeb149..cebafcc341d2 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -168,7 +168,8 @@ static bool remove_pending(struct handshake_net *hn, struct handshake_req *req)
 	bool ret = false;
 
 	spin_lock(&hn->hn_lock);
-	if (!list_empty(&req->hr_list)) {
+	if (!test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags) &&
+	    !list_empty(&req->hr_list)) {
 		__remove_pending_locked(hn, req);
 		ret = true;
 	}

-- 
2.54.0


