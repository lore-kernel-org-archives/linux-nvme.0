Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E4FD116F1
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 01:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=czIyAwG2XcUYBMND32our9jihcE3M72DjVQfcH7wVb4=; b=1+m+5El0EEpm81AggC3By7DWTM
	Ta9qU5GuuVH19pBxH9ah36U/HVjOw5J7zEHft7ScWRrJGtdkCrADwJlFzl+vHXmEkUamuJURnHsAA
	lJzRyS0cn8J5ovk2cl5PHozgh2zyUKCbFEIxEkxykraT0gRaQ6o0WwQR8ijk/zsijb7BnaY8SR3/f
	OjPydenryJYYa+BVFCEqR6Dh0qNp3t3ANc347svl5QW2lMH+Vrqn1K37+qKJ+Vp06dTbyu9CVKaPq
	3VrsAwNuIZPTmy/R8V7sc4UuNXxugeTLxhTnZ+BtvnRL+28eUdHf99vYf5Ux8YYeuybH/aDVJAnoy
	OrBxqIVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQFIV-00000004gHP-487X;
	Tue, 02 Dec 2025 01:35:19 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQFIU-00000004gGM-0ahD
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 01:35:19 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-297e239baecso41895285ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 17:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764639317; x=1765244117; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czIyAwG2XcUYBMND32our9jihcE3M72DjVQfcH7wVb4=;
        b=k8yIts7auRQqXrOGKMprkqU1h2XO9xZB1Cja0VHHY0YT4ohA0TWqXHvpR67QD2nMv1
         VUNC0Lj/rrT67kZkW7dGHS4HUm7jbDBRl/jXC4+6yrQf3S6JXhauym3mCnyDKZlkGdUv
         9cI1YmosmBdBh8pag+8pnhOizLSsKOg2W5gJeitJcLfTRmyT55jwdjz10F71Db5XxlEr
         Mgy3PqBMEtke+leomyBWvbdPqikV0mDNm/xq+gLnL3LPIifgqw7OMDPK4bocOZvNIyPR
         2thUjIXrnutFtK7iCP/TZ9rl4fl7TG2mxq9CQHGf3EXRWeUEbRh0LZR1QdJTPSU1olvY
         Vc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764639317; x=1765244117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=czIyAwG2XcUYBMND32our9jihcE3M72DjVQfcH7wVb4=;
        b=MSg9MkK/r9xz+s83TqHUm7IGAIryPifVpsWYIeBGPviKxQp56cetg34mpXn9FRl9rl
         nHCfhOUk4vtUHAgjr3z8kRGf8sSs+RMc9HqZBDkuXGdRDZ9jta/PHJG16ihMETKKJo59
         BxPJ3iUic6KevvSpaRxDcw3I2xvH75gWlKSGYHBNef/Z+T7HbzfCmGk7lvC5PI0XP7qW
         FvW5oy8Eh2Sz0ciwVvaosV3gvtB8iaZ3w892aTAgvu2R3bU2Iit06Cbdpn88R4JiqUal
         8yCT/aIcBoF3OYvg9Ii71ySSi39p1xvLjbJ4Uk5HovVsYR2scgb9Ssbyfo/vGz0jY2Pj
         AmBA==
X-Forwarded-Encrypted: i=1; AJvYcCVbrLkoC8TxZcAdT9nRQoXnlz2Gmcb55v2LyOluk0YhmPe01BMoRUMPoikDnMDS/9zk5d+j6AjdycWz@lists.infradead.org
X-Gm-Message-State: AOJu0Yxb6GEHEYfiMFWKVS/yY0w9FHd9CARBAozO1MDBf8rNAbUFDjBr
	cETAMYwgtO4o4MpCriwWesf7DBg0vtwg91AmC/R2Wvl/xcpatITbG3bI
X-Gm-Gg: ASbGncv5yW0h/HBLkeQFIT5oOqHOdSPaSabSKBdktyvM4O+9+GbxFnchdH9SQNXc46C
	L1cwOVr7DfJfhkz/cWEr1lj1eJrtFtjz5O+qXg/5U593cI6NvkzDR0R/IYVGRE4aG2yswYrptDR
	sGnmTzP4NmMe4EkniT8I5r+vv9M9N/ymmo8gYiDztx1Ymhp9gJUzf6W95ZDU/98P5Hd/4QvVrZX
	7/t3tqM1FEq0l2TLXOVIHXqR7SuRXPFOf1yFAgZ9d/r3e8zoG0NBVihOSoATZHGLz98NI3Vm8ea
	wcXZMEOfQ5weCx1utnu1EeZJNyK02pYtiuL6PRzDJLvld+wMBKVwevUs/2YqomhJ3tLLT81TqSU
	cmrrj98T9FF9Jv+48zg+Moj6bj4zYeYBmsDiFK0ml/oGnKufjsHMOMrrcZChzkjM3c0UUW+Uc0q
	bk9CRgvsCs8IwnuqTPtrjDAlbW1oxFrBPRnEd7p5HTvhChhbY48O7qUygKw8dYRjygOcvtMxPHe
	80lzRn6hORUOFCpDKw=
X-Google-Smtp-Source: AGHT+IEg+/N743oXcIq0ciRB44SxAmj3ck5rf7L8gATspDeLcAoYxScp44MI8ISyD4Zq0PaY2ptvmA==
X-Received: by 2002:a17:903:1b03:b0:295:5da6:5ff7 with SMTP id d9443c01a7336-29d5a5379f5mr8003195ad.15.1764639317177;
        Mon, 01 Dec 2025 17:35:17 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb54563sm132378575ad.89.2025.12.01.17.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 17:35:16 -0800 (PST)
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
Subject: [PATCH v6 2/5] net/handshake: Define handshake_req_keyupdate
Date: Tue,  2 Dec 2025 11:34:26 +1000
Message-ID: <20251202013429.1199659-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251202013429.1199659-1-alistair.francis@wdc.com>
References: <20251202013429.1199659-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_173518_187121_B016F478 
X-CRM114-Status: GOOD (  18.17  )
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
---
v6:
 - New patch

 net/handshake/handshake.h |  2 +
 net/handshake/request.c   | 95 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

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
index 274d2c89b6b2..916caab88fe0 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -196,6 +196,101 @@ struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
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
+	ret = -EBUSY;
+
+	req_lookup = handshake_req_hash_lookup(sock->sk);
+	if (!req_lookup)
+		goto out_unlock;
+
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
2.51.1


