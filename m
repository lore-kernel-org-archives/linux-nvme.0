Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C5FEDEC11
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 05:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zXXONp/ELYPAk8Ra1lPAUCJk3t+/mDBCyOGivtl5sfY=; b=cR5kLvBGeUrmTH6KsZ5sm3Po3i
	BVr5kpkwdrsSydB/kgHFLgbk24KW1lR/xqM3uX+5uk/i8AxI42s9I97+UwKVsDeqm3ilqXndlDD04
	1sh7+PgOomZm3Xs/ov9dKG5MwpKO6ViHIGygFviN8QFWY8lTckdSoucZAi4sRghPOcLjPP14AMBoZ
	YaBnRDYHJFBf0/UtlTP+NWz0DTT6OjYt+c3xPR1MdNlYO+agiBBwciWL/kS72g3zSMT5aTixynh+b
	fYyxI5LL2bow1wmEnrofu6bxo3L4QYtM2xFZEtoYL/Ix71Kx8pxYHqlHhyUW/UQ+XT4h/71mMeU4S
	t0FNmgYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxeuY-0000000GTgI-1XVZ;
	Wed, 04 Mar 2026 05:36:42 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxeuV-0000000GTfZ-46Wn
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 05:36:41 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-35984cd0335so1421505a91.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Mar 2026 21:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772602599; x=1773207399; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXXONp/ELYPAk8Ra1lPAUCJk3t+/mDBCyOGivtl5sfY=;
        b=Hukt7S1R0CPVqZpH7rDClxPvqIEVboMKkT7+neuB25KAFzK/6FIv+yGhS+I11Fhw25
         99GgTRyLtJ293mn5hm4KqiaRbAIPvSadZxLWCAOdPIYTQj4ihL8BQO2lljyz4+F0HjHM
         kHwtNRuj+neC9qzzLVC1peRJE1NbWNEgUvWaORETZ0k7OPKXl4owL6SauhKU67u6LcZ2
         EwPHcpTp2z92+MhoZP83Rxq4tsrv3IXWFw/7tQTbuaQnGQsqXPpTEvUmJW4dizKuMwgl
         eU2KJ9DQbVetUq9G4IzsJhNX7hxS0fnZQXe28kvpjbYxJ7ctRs0jaYw7M9sOMOMe27g+
         cG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772602599; x=1773207399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXXONp/ELYPAk8Ra1lPAUCJk3t+/mDBCyOGivtl5sfY=;
        b=fISgJ+uZotZigKiKrrEcHajlQ2jYV4wZxbeBF/2NnZrgKdn6h9fBLmDSa3LZg0jIH3
         KlsS6I+f3HaHJmT55szgyetmuhqpBVnn4md4KLU9atON2cJ6opA4eiPaeA77tpUg/v83
         VQayd/FLdHfZFhCMJtBPk2aIu6aqjSjX+emEdax823MshjR0Z4hU0zzpI3XhOsE+3Lex
         DDHUES+4pqKSIvfwfTfg81b6RdBaSnhcf6tKqm7UBgFRO0sxdLuHnfVdWPCCCDjCo4F1
         1KqhryixA+ho7maNu4pUXLGF8bK6xq0YD17uhzxnf5xDFh7vJlBLpHPNd71Q4159K8dR
         wmLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZloEY7DI0vK5WMXapsHtAS829FJV/5JoFx+o/2lOxQfXYSNjwa1pnv7noYIx2nKjql3R9OGWvDjp0@lists.infradead.org
X-Gm-Message-State: AOJu0YyJ3CfztrM2m/WAqa/2N3Zb1TyU1XjzsvJNG397UwiEwUfM04ob
	PJLQV8UaAOltMH0GM5u8+irRzsaZMQkXDPPgYUuzOC8OfBEWhzwE7tN3PItDew==
X-Gm-Gg: ATEYQzyqAJ4cJJBvee3+6F3tqM9hztCtX+oxEVcpVISE5d56TZ5Ag/sOTbPfGasZ4nt
	e6JsMJwzg1GajyCPwEgHlbMvN3aKL6Lr1KXFSJtabPtM3aclBF6P/OqceyC+Asuq0Mi4iksroQm
	fP0pWNUNduvyZUFJiL9qsarBOluWynUEL6s5vYuB5sMF+t4KW4/sr6+PBcVHW97I1nJiUrKmYl4
	iUEb3dqvnDIltxM5I52UHYjnkg0LfDOUNRYSFUzWi88NlxmfLrUv79ts56jeY+5wNeXSJ2gVUYn
	UJbBvWGPH9st+JjpaT296HPT0vI+txiNZ80pHqV0T+UkjgbaJ6eTYUApSDMTGJAdidpwZ2gO3q0
	T1BHzXWs12JFHePtpTZdYtxGK0YY5IlJ+Ac+Be/WpmE8rutgA1iKLdsjta71go29PuG2CAUAqcK
	0Upc5NFXKVTJP7a+kKH/YNQlIjEorMKbCvF3Y6BfTBUg==
X-Received: by 2002:a17:90a:ec87:b0:359:8a78:5696 with SMTP id 98e67ed59e1d1-359a6ce6a46mr960709a91.1.1772602599018;
        Tue, 03 Mar 2026 21:36:39 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c090bfdsm4020057a91.8.2026.03.03.21.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:36:38 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v7 2/5] net/handshake: Define handshake_req_keyupdate
Date: Wed,  4 Mar 2026 15:34:57 +1000
Message-ID: <20260304053500.590630-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304053500.590630-1-alistair.francis@wdc.com>
References: <20260304053500.590630-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_213640_027736_3E98E285 
X-CRM114-Status: GOOD (  18.48  )
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

From: Alistair Francis <alistair.francis@wdc.com>

Add a new handshake_req_keyupdate() function which is similar to the
existing handshake_req_submit().

The new handshake_req_keyupdate() does not add the request to the hash
table (unlike handshake_req_submit()) but instead uses the existing
request from the initial handshake.

During the initial handshake handshake_req_submit() will add the request
to the hash table. The request will not be removed from the hash table
unless the socket is closed (reference count hits zero).

After the initial handshake handshake_req_keyupdate() can be used to re-use
the existing request in the hash table to trigger a KeyUpdate with
userspace.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v7:
 - No change
v6:
 - New patch

 net/handshake/handshake.h |  2 +
 net/handshake/request.c   | 97 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index a48163765a7a..04feacd1e21d 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -84,6 +84,8 @@ void handshake_req_hash_destroy(void);
 void *handshake_req_private(struct handshake_req *req);
 struct handshake_req *handshake_req_hash_lookup(struct sock *sk);
 struct handshake_req *handshake_req_next(struct handshake_net *hn, int class);
+int handshake_req_keyupdate(struct socket *sock, struct handshake_req *req,
+			 gfp_t flags);
 int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags);
 void handshake_complete(struct handshake_req *req, unsigned int status,
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 2829adbeb149..5653c8f69dce 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -196,6 +196,103 @@ struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_req_next);
 
+/**
+ * handshake_req_keyupdate - Submit a KeyUpdate request
+ * @sock: open socket on which to perform the handshake
+ * @req: handshake arguments, this must already be allocated and exist
+ * in the hash table, which happens as part of handshake_req_submit()
+ * @flags: memory allocation flags
+ *
+ * Return values:
+ *   %0: Request queued
+ *   %-EINVAL: Invalid argument
+ *   %-EBUSY: A handshake is already under way for this socket
+ *   %-ESRCH: No handshake agent is available
+ *   %-EFAULT: An initial handshake hasn't happened yet
+ *   %-EAGAIN: Too many pending handshake requests
+ *   %-ENOMEM: Failed to allocate memory
+ *   %-EMSGSIZE: Failed to construct notification message
+ *   %-EOPNOTSUPP: Handshake module not initialized
+ *
+ * A zero return value from handshake_req_submit() means that
+ * exactly one subsequent completion callback is guaranteed.
+ *
+ * A negative return value from handshake_req_submit() means that
+ * no completion callback will be done and that @req has been
+ * destroyed.
+ */
+int handshake_req_keyupdate(struct socket *sock, struct handshake_req *req,
+			    gfp_t flags)
+{
+	struct handshake_net *hn;
+	struct net *net;
+	struct handshake_req *req_lookup;
+	int ret;
+
+	if (!sock || !req || !sock->file) {
+		kfree(req);
+		return -EINVAL;
+	}
+
+	req->hr_sk = sock->sk;
+	if (!req->hr_sk) {
+		kfree(req);
+		return -EINVAL;
+	}
+	req->hr_odestruct = req->hr_sk->sk_destruct;
+	req->hr_sk->sk_destruct = handshake_sk_destruct;
+
+	ret = -EOPNOTSUPP;
+	net = sock_net(req->hr_sk);
+	hn = handshake_pernet(net);
+	if (!hn)
+		goto out_err;
+
+	ret = -EAGAIN;
+	if (READ_ONCE(hn->hn_pending) >= hn->hn_pending_max)
+		goto out_err;
+
+	spin_lock(&hn->hn_lock);
+	ret = -EOPNOTSUPP;
+	if (test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags))
+		goto out_unlock;
+
+	ret = -EFAULT;
+	req_lookup = handshake_req_hash_lookup(sock->sk);
+	if (!req_lookup)
+		goto out_unlock;
+
+	ret = -EBUSY;
+	if (req_lookup != req)
+		goto out_unlock;
+	if (!__add_pending_locked(hn, req))
+		goto out_unlock;
+	spin_unlock(&hn->hn_lock);
+
+	test_and_clear_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags);
+
+	ret = handshake_genl_notify(net, req->hr_proto, flags);
+	if (ret) {
+		trace_handshake_notify_err(net, req, req->hr_sk, ret);
+		if (remove_pending(hn, req))
+			goto out_err;
+	}
+
+	/* Prevent socket release while a handshake request is pending */
+	sock_hold(req->hr_sk);
+
+	trace_handshake_submit(net, req, req->hr_sk);
+	return 0;
+
+out_unlock:
+	spin_unlock(&hn->hn_lock);
+out_err:
+	trace_handshake_submit_err(net, req, req->hr_sk, ret);
+	handshake_req_destroy(req);
+	return ret;
+}
+EXPORT_SYMBOL(handshake_req_keyupdate);
+
 /**
  * handshake_req_submit - Submit a handshake request
  * @sock: open socket on which to perform the handshake
-- 
2.53.0


