Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E30CD4F52
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 18:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TaVrKM0W/iXAiq2i91kPvjKNy4TIyYJomcDBuXBfGdM=; b=4vibkIWPHflTuruU170CP8xa5P
	kf3NsxXT6vvTcRzlZGGvhWcot1pXuM7zMOA/JqlWJcFdUyjmHGv3b8HWmbHjgNVli1ShdNaq1hGir
	3nxjgHUQdEyi5i67nt8VppR30ctJUXgiGyudZZ2mEgiX9mL9wVh5eVDdfIVpYhlLfv/aeA8uI3TgJ
	vWKA9XoFE5SiCEEyss36qyC87b+y2LCc9FZZbCE7pm3ox443+BByYIRB+/AWN2GrjIkIMpziVCDxh
	/fkFYLMRr/PLB8NTxXY+vT2z4RhRQW7at9yv+46lSlQ1yWeSFBs5IJUB1bTvswEBXkS4TMPZRuKXl
	nGIk5EMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP2eB-0000000GYW2-1sjl;
	Mon, 18 May 2026 18:24:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP2e8-0000000GYU4-1d6E
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 18:24:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7DBC3444E8;
	Mon, 18 May 2026 18:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93329C2BCC9;
	Mon, 18 May 2026 18:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128695;
	bh=0YOQDMaHT00FKrFsX3Z/0Ptk2GGsNAdEsx0Aednt3vU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=irqI/Qztz8OAr2RKRGxuoauBWFUNOZmyNRY9ISirfqlh6+9JkN+/5hl36antDW7z1
	 O2EMizJc3vfwAig7jMfGGnfeyVZltxtd2pXeYoHZph3Hfi7/lvKIpU07M2fEh4y0zB
	 9EOo1pf7P7YzHatGLw60xu2ZSgwJM41IPreD2lI9vNqllXVY9JYtBIiYk54lFruIix
	 bwhvMLQ3WTMVy3fkHy+BmJe6DJKYwYjgutR62up8WYhtMmQ2IGeoHHhm8zetrY00Wh
	 IcHlneIYhHkoikzK6FrRzg1B8y5D/urvTggDhJ31KYKNVOEz0L13z/seEmVYsSwGGV
	 +D6Lst6OORp6A==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 18 May 2026 14:24:28 -0400
Subject: [PATCH net 1/7] net/handshake: Drain pending requests at net
 namespace exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-handshake-file-pin-v1-1-4bbcb7e62fda@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
In-Reply-To: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3261;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=2OOqFmnaiOfw920Y/fXorACxTz+mTKmYAHcv24KvEz8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqC1l037A5xZFYEOIS4Xr2DLGvlKw+3mxHKJS4O
 QgftrnkcjOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagtZdAAKCRAzarMzb2Z/
 lz3rEAC38pQdHEPcs2An+Dv1D2iD2znOAUn74Xwu13/2fvl2dv+klzQDkfFGUtrunNSFipzV5Ux
 GzK6ecKZM640frfVkH6iseOhsweUi4NId6fsMZ0PojZEMxuRy6DnTBbzL2AH65kWr39LtxsnZI4
 azewUAU9IwKNEzNGdnZ7v+pjI2nIsFN2agmsm0LRHS7H4f6G/8c8bv45HVEzHmVYUI1C9X0gZ8Z
 O0LHUAr6DGVj3C3oD0ceRLse02oEqi7ssN+jdeR+k9BaAXX8AUXdKFtIjBUAsKT/JQoAFeyJ3uL
 zNOo1p97TExnqzw+noNM/h2XAGrSd6ekkyDTzZG2zlFDe64HjPRM8FheAe6Ma8qAwPxMexNMjWn
 JJe/eYOs9J/H+Wt/CDWZR1qoQDfD1ZQzOc2cU9DeLl7Ojeg1Slg6/1oA+nCtLZD7M2vxb7J2TWH
 7Ui74JFamUvJkUJVb14Wgoa+kNF5/14c2/Y78vHURLYloqbdavuNLrVKcLvNwgurwCyYmQgivyQ
 MGxHrOy3SmBodZs/fLm1eqZAY+daMAuPjEdK+sQkZusFLW9Bco7H1uhgaZ22Kqva6alBEKCQXe4
 uyPY+0ZD6NJ4wyrhWM0zVhmOURw8IR6jNSChSoeLJpyx+vTesmd3C3DAThugtb1i2Gmcb75str3
 1WTX5cR0jxZA3Zw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_112456_479554_4A458009 
X-CRM114-Status: GOOD (  17.66  )
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


