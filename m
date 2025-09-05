Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75342CA1013
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 02:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G1EWHajpMqKqyxA8GWEtrMVXQwoVeft66qRlv9TDlNE=; b=nkfa6O/L3Fp6blpgplVRL3UPz0
	ccfBHyhj8bAzxjFrvkJn+Hs3jSN0MUNwLDBVR0swhOc9xSl453HrVqTtkWSSKyz4Z0x+WDZr+DTjF
	76L/s3jPvgPxve3PpACtRaK0gg2uoobMRqG6TxmeTnmBPtVbvcOsgEd6h+Aq3/IKmCj6A6j1930Cz
	LTyi0VSDgtFu4b2MfFDoEgcuGuSiAFYrPqTHj+W2rKKNk/enNjP7cbQxhMYOYrMtxosx6ZU1tukLe
	mmjnsjo3m+cLNKebecEMR6YfZbp4Y7d8XhzDU0wnk1S0u8s2GbuI+869BvJz47gdjfaNqTRkR86DY
	nEN3759A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuMUW-0000000GEtg-3kuP;
	Fri, 05 Sep 2025 02:47:56 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuMUE-0000000GElA-40W1
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 02:47:40 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-772843b6057so1419916b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 04 Sep 2025 19:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757040458; x=1757645258; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1EWHajpMqKqyxA8GWEtrMVXQwoVeft66qRlv9TDlNE=;
        b=a5xai87W+/C3q/H13K2wDCHNT0QVsJure+DemhokrPnxbXRXR9doLWFD/Oc/GlZzvB
         Y8NHxuBsGdIFxqKzjxNjNc1cL26RffXTyPmYu2t7J4bCn4jAERb4v3ChaIyomfzEIV0K
         VQmQvgouuH5TSZ4tY3Jve72I68GnXoyFj33tY8TskYNVhc3qW7nmjgf+IL6Q68wm/9UQ
         0DOFocuTqCgPiZ61GvfSBYCo3ph1AqqOd+vqB9V4UMyJ6dwz/Z2IFZqt94NlmvxawyA1
         ZyENXxcoLlCKWJuK6ySNsYEn4vc8EpsXJIyUI2vKJWl0gyekO7HSxdt0NpZiGPTfy2iJ
         eJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040458; x=1757645258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1EWHajpMqKqyxA8GWEtrMVXQwoVeft66qRlv9TDlNE=;
        b=J8YoSUlxVLuPcnFM21b2KA6pMn04jw6T/lXkBgAA1W5qi642itNj3lLizmuGXh9nKG
         jaIyiDflzzax/12h0q1dLL2ZS2qrEa9ueGxQQEoAbrT4XbOeQU1a2D5f7yQ+c9zZ0c3/
         ZhXb4mZ5liKDAKp2exJHO5EaTR21YUt39lYA20QI+AmqHZWRJjbddu/omAckpPT3I4/7
         URupaPnFiegY+SuDKdU8TvdQuvbdeXpy8ZcfOR57pofpmqLgRmtI6NDyI6Wa+VwuTjLs
         /nk8eGRz3lST79k8JUwjDawj29HEGwB5sNizh2ruvovqO553m6bquv9scM8G/oWzqxsR
         fFew==
X-Forwarded-Encrypted: i=1; AJvYcCXunoxAQQAxeObeoManV4sFk9uIaZ6adQVKcySKqRMF+rhreMloYg0qvQPuzdqd3J0/MkEjAtrNeHgB@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+B8cF/HvyFWqFR6yNkC+H15Iqo1NpA+gp1PyTwFDxu/3tPDNb
	6s1k3iMT+/PvMUpjS5avHaKwQZTK/MD92DUBTOdHM8YO3KTWoHOU5xWJ
X-Gm-Gg: ASbGnct4xnRfxbVtE8K7jfSySsPUdxbqGnSXZxHbysQHDk44IH2JkIJY4pyW8thaObn
	IqouupRDZ8cqxfx2d8N2fLcjDfJqQ+TWspL7Gl+fIiq3sKv6e7r3fqc99XMnqBKt8/gyQDBEuDx
	kphb49A8V7ODJIqRrX/YBLzjlqL/pwezuz3SN6wFquLTZSTr5ydBlEEksDA7pipw53SJGJJK5+G
	AW8z26Tu1RxOdfF3h3tsf1iTJYkOYE/iIrbLaGid0/73zj8ppMrHnxxvEA66IxoKzrhrFItaL6j
	1QYygqLlTBcRO77EBZkMcTVMUtzKC7x/tqEVTZe31ePchuoMvmNqePVN5ZjIisxQCV+dtm2p/hb
	az5oEXsFa+5mIEx6S0HN3XqHyN8Q5BG6psJnw8ycrwdK0EDuB9LUbknLPbJmxG6df633QNnj/tA
	QPPDTRj0aTCaVryvkUNgXwjihFLZk=
X-Google-Smtp-Source: AGHT+IEX64nfMru9GugujC6DsIEIeho+MjIw85M5xAJP6i7Xx1NoXALA29BzByuoUSArpy/50s7n8w==
X-Received: by 2002:a05:6a00:1a94:b0:772:4fc6:84b3 with SMTP id d2e1a72fcca58-7724fc689a8mr23059661b3a.31.1757040458343;
        Thu, 04 Sep 2025 19:47:38 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm12991858b3a.84.2025.09.04.19.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:47:37 -0700 (PDT)
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
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 3/7] net/handshake: Expose handshake_sk_destruct_req publically
Date: Fri,  5 Sep 2025 12:46:55 +1000
Message-ID: <20250905024659.811386-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905024659.811386-1-alistair.francis@wdc.com>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_194738_994471_2948056C 
X-CRM114-Status: GOOD (  11.22  )
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

Define a `handshake_sk_destruct_req()` function and expose it publically
so that other subsystems can destruct the handshake req.

This will be used as part of the KeyUpdate to ensure any existing
requests anre cancelled and destructed if required.

This is required to avoid hash conflicts when handshake_req_hash_add()
is called as part of submitting the KeyUpdate request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Fix build failures

 include/net/handshake.h |  1 +
 net/handshake/request.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/net/handshake.h b/include/net/handshake.h
index 10f301f3c660..89dc169eae89 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -44,6 +44,7 @@ bool tls_handshake_cancel(struct sock *sk);
 void tls_handshake_close(struct socket *sock);
 
 bool handshake_req_cancel(struct sock *sk);
+void handshake_sk_destruct_req(struct sock *sk);
 
 u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *msg);
 void tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 02269f212c70..bb61c9a1a03d 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -342,3 +342,20 @@ bool handshake_req_cancel(struct sock *sk)
 	return true;
 }
 EXPORT_SYMBOL(handshake_req_cancel);
+
+/**
+ * handshake_sk_destruct_req - destroy an existing request
+ * @sk: socket on which there is an existing request
+ */
+void handshake_sk_destruct_req(struct sock *sk)
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
+EXPORT_SYMBOL(handshake_sk_destruct_req);
-- 
2.50.1


