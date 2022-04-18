Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77660C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cNjoxCSCnIcfYlvKMTrG5SG5OzWg/wu9POVKzaWKdRQ=; b=xcF7V53IRSy5iCgGgDsC/CYk9C
	2ejzR4TXydiNXsyuQnzi0kHcngV1SPg8ujPUFciEQ7v05Fx0tSc/lu9hSxMpa49XcOYk1G7CuZAct
	uw7MVNOynwCK4ydvDvwoKKPxWUnVwiiJ/z253WW3MEjjDgk/XoV6my7oQgEP0sNCG+6+pXKWk9IVx
	2QGuERDFhZmvQS+FWblgTzheOANoawTbqmu6e4Z4EueY8oGX41BSvLjazOnQ7RCz5Imf3nn6TZ7j+
	gSGcHQGYRca7+hDQXbDcCbqMG8PRyLXPZiQsBt0LDdqCgsXMtBFSp/Mu4Ad00wP58U/ECM0UEysBw
	RD1lMObQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngUZG-0007Fx-46; Mon, 18 Apr 2022 16:49:38 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngUZC-0007Dq-9F
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 16:49:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9438BB80EC4;
 Mon, 18 Apr 2022 16:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5625C385A7;
 Mon, 18 Apr 2022 16:49:30 +0000 (UTC)
Subject: [PATCH RFC 1/5] net: Add distinct sk_psock field
From: Chuck Lever <chuck.lever@oracle.com>
To: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
Date: Mon, 18 Apr 2022 12:49:29 -0400
Message-ID: <165030056960.5073.6664402939918720250.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_094934_690308_ECFE4333 
X-CRM114-Status: GOOD (  17.22  )
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

The sk_psock facility populates the sk_user_data field with the
address of an extra bit of metadata. User space sockets never
populate the sk_user_data field, so this has worked out fine.

However, kernel consumers such as the RPC client and server do
populate the sk_user_data field. The sk_psock() function cannot tell
that the content of sk_user_data does not point to psock metadata,
so it will happily return a pointer to something else, cast to a
struct sk_psock.

Thus kernel consumers and psock currently cannot co-exist.

We could educate sk_psock() to return NULL if sk_user_data does
not point to a struct sk_psock. However, a more general solution
that enables full co-existence psock and other uses of sk_user_data
might be more interesting.

Move the struct sk_psock address to its own pointer field so that
the contents of the sk_user_data field is preserved.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/skmsg.h |    2 +-
 include/net/sock.h    |    4 +++-
 net/core/skmsg.c      |    6 +++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index c5a2d6f50f25..5ef3a07c5b6c 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -277,7 +277,7 @@ static inline void sk_msg_sg_copy_clear(struct sk_msg *msg, u32 start)
 
 static inline struct sk_psock *sk_psock(const struct sock *sk)
 {
-	return rcu_dereference_sk_user_data(sk);
+	return rcu_dereference(sk->sk_psock);
 }
 
 static inline void sk_psock_set_state(struct sk_psock *psock,
diff --git a/include/net/sock.h b/include/net/sock.h
index c4b91fc19b9c..d2a513169527 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -327,7 +327,8 @@ struct sk_filter;
   *	@sk_tskey: counter to disambiguate concurrent tstamp requests
   *	@sk_zckey: counter to order MSG_ZEROCOPY notifications
   *	@sk_socket: Identd and reporting IO signals
-  *	@sk_user_data: RPC layer private data
+  *	@sk_user_data: Upper layer private data
+  *	@sk_psock: socket policy data (bpf)
   *	@sk_frag: cached page frag
   *	@sk_peek_off: current peek_offset value
   *	@sk_send_head: front of stuff to transmit
@@ -519,6 +520,7 @@ struct sock {
 
 	struct socket		*sk_socket;
 	void			*sk_user_data;
+	struct sk_psock	__rcu	*sk_psock;
 #ifdef CONFIG_SECURITY
 	void			*sk_security;
 #endif
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index cc381165ea08..2b3d01d92790 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -695,7 +695,7 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 
 	write_lock_bh(&sk->sk_callback_lock);
 
-	if (sk->sk_user_data) {
+	if (sk->sk_psock) {
 		psock = ERR_PTR(-EBUSY);
 		goto out;
 	}
@@ -726,7 +726,7 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 	sk_psock_set_state(psock, SK_PSOCK_TX_ENABLED);
 	refcount_set(&psock->refcnt, 1);
 
-	rcu_assign_sk_user_data_nocopy(sk, psock);
+	rcu_assign_pointer(sk->sk_psock, psock);
 	sock_hold(sk);
 
 out:
@@ -825,7 +825,7 @@ void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
 {
 	write_lock_bh(&sk->sk_callback_lock);
 	sk_psock_restore_proto(sk, psock);
-	rcu_assign_sk_user_data(sk, NULL);
+	rcu_assign_pointer(sk->sk_psock, NULL);
 	if (psock->progs.stream_parser)
 		sk_psock_stop_strp(sk, psock);
 	else if (psock->progs.stream_verdict || psock->progs.skb_verdict)



