Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19112CCD1A2
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 04:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZhR6OqlULE14euOr7SOeJPbIcbHzF9rdhJ80nFJJwb0=; b=sbzFk4Cdqh3bBOzWR/DRNatdNB
	Q9kSaS9Sex470ev2YlxVcUwVRzcr+Who9QVHMJdRkwkOzDU6cNUsLuBAS3BN2JJ/5bHXaJEW8ctuN
	P6pE1DD4LRcWYm3hDTRpZ3s3gCnzo4mZOoiv7QCfYOEr/LMEKjnMjJhjTfbtPmx6PKJb6DTABVBCS
	9XGmR26Cu05iSoojuQ4IqdSnPaN1I3Yvu9cckCmMxjKCeq52aC1J3eLUThSgXY5HtWLaPIUZfkgey
	9ixjLdgNgwc8BFH7ikFlt5rT9sROolr9/c4Nj4fV+aNJsTqrN7oFK8GFPfl3bc3Byga3lzd1PyivO
	9vkZkqVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c1o-00000006Wks-1o2i;
	Fri, 17 Oct 2025 04:25:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c1m-00000006Wjb-3pIw
	for linux-nvme@bombadil.infradead.org;
	Fri, 17 Oct 2025 04:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ZhR6OqlULE14euOr7SOeJPbIcbHzF9rdhJ80nFJJwb0=; b=KwMCewRBbaudhhnamoQu0XppIn
	qZ0BfnDnc4N1FZGnSwC7E4NH2sygC/vcwSuhCihBn6dzY6hKlUzrjl14Z4KWCLZnUXqpfD1/HZPE+
	CXoecYwxtdIOsXQhhSwo/5p5FKZXLaNwYtIwv5Hb1Ym1E+dBu7YvdLD7wUiSnwGHkOGj+Sj87gyuI
	JpQx7jsdH8SOVDXv/3iSaOZOCmqEmJuVVY3TgxRuGuEHxNhH1q/Iuh0USUQ+cJuasXxBB47uPGxFW
	REFnlBnEtxjHlmYhlpb3oq6naL6sv9LGDU5DYK+zmGBefPvBjm9C3IR/CvC5zaDrHpDZA0qGtE96s
	Dwbk1a7A==;
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c0S-00000007HbU-0xY9
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 04:24:50 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-290d14e5c9aso7113355ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 16 Oct 2025 21:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675024; x=1761279824; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhR6OqlULE14euOr7SOeJPbIcbHzF9rdhJ80nFJJwb0=;
        b=jN/6R7SQ90+XixEDljjpv+KT2fEkmxhvpxdsJgNpZoaJxuYlNBcd6bx+I1pqFEp4mz
         tm4QJTnTkWRGSH0AD0roMIALs/iz5u8CZtJs4I1ZBaKT+8pUhHUjaKfvGtMqaAlceUH3
         d2YeHQEC6bsprE2VU2fRvyF4S08AMiANwKg/89NmWnng7XOWMZUjzDbuJJNkZuhyogSC
         qTO5hd0Y6vSc3eLX1329Zngj8LTGd1Rv9a1vULiYAhOReestWgiTpvad7QsmveVp/JA2
         KuMVXEypV4kAqU/MMdzmUfZT/ADGf1Vf5GffthvFIMk3r5LkaKHAJP8bE0arHIZTeyYU
         3H8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675024; x=1761279824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhR6OqlULE14euOr7SOeJPbIcbHzF9rdhJ80nFJJwb0=;
        b=t/Zrwp8J86KSkdiVhWP3NRvFXMTlQjY9FPFKEYCxZk/XxIz4U6TIgKMWvSsoDA0nWi
         9u8pgLaXZz9ooS00lsN9X9Li9qKMylcVLSpB98737qni3JZMP4ukIWZkZCorVba3yde5
         +aRajTvqStGWuMYq69qpCBNHNd/IQ1JXlgPckLfg5b51u84etfayFKLvzzTE43lmgAln
         Fl0HXGl1U0OR+alsaW4NMMkM/U5jEh4eH13XGU8nJTIn0jEI2u/RSvHMYCpBlREiDa8o
         c0r7tZvOYzN+qejrKjwd7YKrDDCaGqmAZR45vYdNQoDDCerpb9f4OYjbBnHaxqtEXJGT
         Rc9w==
X-Forwarded-Encrypted: i=1; AJvYcCWzi3eWcqsyVoe3VuC5nKrqO0HFRnsy3WRuPpNZOyNQtMnamC3t8vfCOw1LcVxAEfKNokanv6m07COv@lists.infradead.org
X-Gm-Message-State: AOJu0YwY9TKjylec+N0xGQgAYtPqN6fCkz40WWZVHwp9LEgTuUQ4CaEj
	7lBsxTCYAEPBO7Z2yT3oVoXn4SZ8x4gfE7L0w3AjJV0+9Xibj/FOD03u
X-Gm-Gg: ASbGncupU6XfAbrGr4anRKh+mahtsh7imkJkL366/0Q8B/87srj7fWy8H7j0sLuY9XR
	Wk0T+vemf1XOCT4XFjdyX6XK0/PacaxCLPOpWOPbYscrD0X5dRAmQU5XBcTfsmoqHYvMgXpVH05
	Pmu/fUpYjaSYGkt/h+032NtBNLfxIQAbVdWyldVfr1KFfXjNTzYzAi3Z/PpYJBqvbkfaZnEzMK0
	1R++Pdd4ykKNlZNIFGjxHQovorjXj9l+EY2LeNkPQ0NrFAdsXyHaDqHO8AcNLH/nkQ205LN7RyA
	tOUcmZX/XuG2Ci3EEtG0nAAYiZ4L6QpWNLfJXv2Q11x+JMpKDkr1ClJ+YJ087Ftg1mxRj30H1dM
	0rthc4rAapvAGxvZGmKf2xynDe7g6tMbPEeVs7wgHs0KybqO65+mWqmciJSDLqmcn6mq2oo+jLX
	TE7sXbi2lXW1olPwpaeKjAScqclG5sV1b1WbrfZAlmwLL1gs/bkH+ps2Y4zlFZrqbKX6U0CtgFt
	nMTH905FdsVXpsD4mWX
X-Google-Smtp-Source: AGHT+IFs1j5KeQPUYHknhxmr73Cz8lIn7tiQ+fRQndA5W23hoDMgcJ9Yk8+rVDxwb74P5c6XfgnCZQ==
X-Received: by 2002:a17:903:b90:b0:269:9a7a:9a43 with SMTP id d9443c01a7336-290c9c89fdfmr20658745ad.10.1760675024212;
        Thu, 16 Oct 2025 21:23:44 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:23:43 -0700 (PDT)
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
Subject: [PATCH v4 2/7] net/handshake: Define handshake_sk_destruct_req
Date: Fri, 17 Oct 2025 14:23:07 +1000
Message-ID: <20251017042312.1271322-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017042312.1271322-1-alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251017_052448_539567_9F160969 
X-CRM114-Status: GOOD (  10.29  )
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

Define a `handshake_sk_destruct_req()` function to allow the destruction
of the handshake req.

This is required to avoid hash conflicts when handshake_req_hash_add()
is called as part of submitting the KeyUpdate request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v4:
 - No change
v3:
 - New patch

 net/handshake/request.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 274d2c89b6b2..0d1c91c80478 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
 		sk_destruct(sk);
 }
 
+/**
+ * handshake_sk_destruct_req - destroy an existing request
+ * @sk: socket on which there is an existing request
+ */
+static void handshake_sk_destruct_req(struct sock *sk)
+{
+	struct handshake_req *req;
+
+	req = handshake_req_hash_lookup(sk);
+	if (!req)
+		return;
+
+	trace_handshake_destruct(sock_net(sk), req, sk);
+	handshake_req_destroy(req);
+}
+
 /**
  * handshake_req_alloc - Allocate a handshake request
  * @proto: security protocol
-- 
2.51.0


