Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C24CD5BD5
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T5lTmWuuWaMPiOjTHMCXGVFaJdiWeerfyg6lzH6gsP4=; b=SxN1Kk1feMUDFhCFuRcwB2u5m9
	LvM4307jKs5WSMwrmQZHyb0UqqNTpvf6kztr7EFGtaHdaeYDraLJ2C7/LmYtR1oNh+J3+pI7uEyYl
	bQp8HgdIPxXBL5CTbn1kiy4UeAifH77DQleRis94A2Eekhk8JJ4YZEF5ouF7elH679+qOO8X5SAx1
	4ZqM1rod2QOzcigErQobdeEsiRI6+jWKXJlzCQBsYuRPKvKORa1XfkDt8dlWxlGzt3b9CN4L8MugU
	pu8bpqSGohRFnkDk0sRMUVUOK02Oj07SgeB0tNQGsxgDOcEuhvfwUmkt1iW0ckzllMCWQwHSl0Amy
	z0chWUqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYWl-000000004Gu-1IGb;
	Mon, 25 May 2026 16:51:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYWi-000000004Ck-2EJ3
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 16:51:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 41E6240BD2;
	Mon, 25 May 2026 16:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437D91F00A3E;
	Mon, 25 May 2026 16:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727900;
	bh=T5lTmWuuWaMPiOjTHMCXGVFaJdiWeerfyg6lzH6gsP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QggBvHIaRoKo1wymS4OJr18A2jiubdvZg1DPmgLT31hCAa4LCABnnD9G2QUIfERjv
	 kNOjsdhHjKpHXrhloBejUh4AB47B0vtSPnx20sqWfPnzkoB64/oNSKlcz+HxHRM5KR
	 wojjGXJq7h/xGvLfS/3y+c4lafrpSrnptWlT8NNrjz/LYV58CEw21sm+pKArvmFhE+
	 iXDjaqP3tc4D7Km8MflxUkY6sFwzmN4MLmSLsadQCv8OQM+UJjud/0nHTVFZVBVQgi
	 dAT6psDcD5eUrmN7lLdLELIdEkewtS5zdLyZMabFDEDiClTl3IKBugrLgVpZYcKe4k
	 26/b3oEZg0Lcg==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 25 May 2026 12:51:22 -0400
Subject: [PATCH net v3 8/8] net/handshake: Drain pending requests at net
 namespace exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-handshake-file-pin-v3-8-66c616906ead@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4231;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Z3FNtFN+AsR1CzlrdFXZjc/eykqu5b0u0GKUw75gq6k=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFH4S3jAuaw2WLUG21fibHEltq6Hlp6vrIUqsS
 75whnEpAOqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahR+EgAKCRAzarMzb2Z/
 l8ocEACY9buDtmzu4r2zV+YM5nwGIgw1W073jhnqcbhNN9aZVn+MJ8q+rnsEf1bd5e/1PNsd5Yq
 QEG8o7efxnzRPGbxzccXNsw3GI9G+qNzFyRS6r+6iT6A2m4TH9kbYE6tXk6hql73P68m+bK8SlW
 zCNYt00H/pm4lhAfw4EhUf8D2FHgtNjtUhJHpy/5zku+n5E4pN3B9nMit1wlQi4fHJu5Dn8fSPT
 GrABns7n4yaH3GQsLWiLMmR+IPoh/qjX4tTEdQXfTiUoKQzuQLXktOcTPS6QfErHUxxESm9KbwE
 lTdGlnt2lfRNcGulIUnuqnfiWoSXEMeOznXgS9/6UfUpogQF5f13kUC+q3YhgK9raWDM39o7Kq8
 BXTIntkahJe/NW8O7CExHRs8gYTiajHMV1aJszUposW9bdIOo4fh1YxpeyHsk9sS+Wi7R5ttca4
 Fv0QvEbqKJw40e6c6IpDLCQDQcTEJAvu2cQA294xi3tJeA20O+rQVFLxvxpG/SQLm9+m0TR3U+w
 5SE48quDp91yYat+LIhCz3CbewT1qhKwPwo4FKyLwqN2he8tHJXq9nFBuLDXxFhL4i3Bv3/z/9c
 g8Mm74dskNAx7uKuQxzAXCIKBf+wd6NVSOq6BBPh6HayjyGKIBRjGQgPfhU9PxTkktQhe5q3xjx
 TobcID3QYJC2MYw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_095140_622085_3E462E24 
X-CRM114-Status: GOOD (  19.73  )
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
drain has already taken ownership; handshake_complete()'s existing
test_and_set on HANDSHAKE_F_REQ_COMPLETED still arbitrates
between drain and cancel for who calls the consumer's hp_done. Use
list_del_init() rather than list_del() in the drain so req->hr_list
does not carry LIST_POISON after drain releases the entry.

The DRAINING guard in remove_pending() makes cancel return false,
but cancel still falls through to test_and_set_bit on
HANDSHAKE_F_REQ_COMPLETED and drops the request's hr_file reference.
Without another pin, if that is the last reference, sk_destruct frees
the request while it is still linked on the drain loop's local list.
Pin each request's hr_file under hn_lock before releasing the list,
and drop that drain pin after the loop finishes with the request.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 net/handshake/netlink.c | 10 ++++++++--
 net/handshake/request.c |  5 ++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 21d6cbd52fcd..3fd4fef9bab1 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -201,13 +201,19 @@ static void __net_exit handshake_net_exit(struct net *net)
 	 */
 	spin_lock_bh(&hn->hn_lock);
 	set_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags);
-	list_splice_init(&requests, &hn->hn_requests);
+	list_splice_init(&hn->hn_requests, &requests);
+	list_for_each_entry(req, &requests, hr_list)
+		get_file(req->hr_file);
 	spin_unlock_bh(&hn->hn_lock);
 
 	while (!list_empty(&requests)) {
+		struct file *file;
+
 		req = list_first_entry(&requests, struct handshake_req, hr_list);
-		list_del(&req->hr_list);
+		file = req->hr_file;
+		list_del_init(&req->hr_list);
 		handshake_complete(req, -ETIMEDOUT, NULL);
+		fput(file);
 	}
 }
 
diff --git a/net/handshake/request.c b/net/handshake/request.c
index bd3d9467ab91..cd30d54d0501 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -163,13 +163,16 @@ static void __remove_pending_locked(struct handshake_net *hn,
  * otherwise %false.
  *
  * If @req was on a pending list, it has not yet been accepted.
+ * Returns %false when the net namespace is draining; the drain
+ * loop has taken ownership of the pending list.
  */
 static bool remove_pending(struct handshake_net *hn, struct handshake_req *req)
 {
 	bool ret = false;
 
 	spin_lock_bh(&hn->hn_lock);
-	if (!list_empty(&req->hr_list)) {
+	if (!test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags) &&
+	    !list_empty(&req->hr_list)) {
 		__remove_pending_locked(hn, req);
 		ret = true;
 	}

-- 
2.54.0


