Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE59CA1012
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 02:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8tr7ELGOkxuEFTNKTRlSXZHzuS005z5Na+L9CuZ7aiI=; b=f/cI1B+N1lTqpYC2SQTG/SrDum
	mlVF2siDmmUZtZN3qjxgveXG7Bf1dskqmmIvuZ3H352j+i1i+N5n6YBiONujtFxP6VDneNmd8TNWI
	HbTcxM/6PQ3Z4Vkw2NOaKMaAiIN4bcBrNPL0gDAJx0MM9Tn+/lpGyGOeZMgUfvGasDZBe8mRQ6c3f
	GV3lvtBJ1WbwFoqAX2erw5nlZpQB9R+OfVK4QC+PuCTEIH4m2wWu6vd613T4Pk2akFX4MWT0sU2Vw
	o/RxuE9WGclYNXlkIyOZ2zwFStHOE+SFf6GJfdV3//YVh9PlsegYtJADsFoSLMPf0p//EdA8Va5C7
	HBay5JLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuMUW-0000000GEsW-0dmc;
	Fri, 05 Sep 2025 02:47:56 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuMU9-0000000GEhA-0XFf
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 02:47:34 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7724cacc32bso1375958b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 04 Sep 2025 19:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757040452; x=1757645252; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tr7ELGOkxuEFTNKTRlSXZHzuS005z5Na+L9CuZ7aiI=;
        b=H5o74hYxD0VqcvlHFY0Ih7v+thyhIfyw+Zj2L3KZGtUPIxhKsehYdDY6oeNd2bO9IC
         O76TZiBoW/xitU45uXNYsrC2bSP9mh7MizFgjkzgrChe+r1atrKBpWlFFnJ/QEvLkiqv
         dcLDx0c9w+YgXJAeMI8TFVH87AAPTk4auVzfTOvEuiiDgR93+ylsMN0447d17djubDGI
         v2kpl/dFFAtdlnm7npMAFgji8R55EcxRyBAbDBlKncz9EAH6KboLvReh4SCcwaOjXMQt
         VY1k40Tv3cw5Ima7o5O82XZRvqvHCx9eBN92KoLAArWfRy+lfL2AdnpF7Nx5GyTJSHa2
         JUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040452; x=1757645252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tr7ELGOkxuEFTNKTRlSXZHzuS005z5Na+L9CuZ7aiI=;
        b=MvApUItHO4UtW5+5RvBW4snPPaMJMNql9gcmoUWBP9MHwE1/5qNgwja4O7YD0imG/C
         hgKXGYmGahOEWACwDYydomBBB75dyBagOeZEFoDTDQuzXQtrodpw7NC2rcyKUQfrI6PG
         ucrF5e3TjI1QrUqkgzJi6yQPYpjXJ7mRDTM+o+czSN52dNjw9pCsw5HN55ctGoeNIt2N
         kymgWucR+WXXo3nayXz4Gm6rqF2ff7Puwc5T19LywAO+ofld+PrqwkBlB+1vnt6BKjQT
         bV8zuvNF7DxrPOnncPBH8RO73lffs1HWO98v9A1J+6tX1tb05DQZCcf9t7iG1P1CN/SK
         mHpw==
X-Forwarded-Encrypted: i=1; AJvYcCXK5UTSw/f0Uxni8t598uJVSN6X3eGA83O8KtL5VK8UgArct8OjJBIxvupXHaHZu/AT4y1CQYFTtnpv@lists.infradead.org
X-Gm-Message-State: AOJu0YxdYdwevgZtiWw2LyuyvTO6g3AmFlPFer4S31I9jyEHluMW5mVf
	PKiQ6cgbZvzNr5q0MXoDsdC8nge9ApnZwS47RAuJDTn1Q47AUXMMocu2SC85iA==
X-Gm-Gg: ASbGncurOdbD/YiKHijRmtG7k7ykZR9YsBHRgDY/dzvg9mSHFlUgT5C4bbK0NWCQbub
	9sN7P0ReMP1rgGgqd+YYeQeq6kM0v3cNv4YGFLF5cT8c+rdb/g9iOgICN2YMSOcQph7rBll4p/T
	pvOJirPb+Xx9f3awh3cTl+dxZcvnLTaskXRmw5U/7qCaSvSK3B07jRBvzZ6CpkWYI9iePbWiHAk
	rKT9bY3ZG0IY72C72JBZUXt4ZRVHpK1KHyMg0MNvL1lumqqs86DIS0FPPApPyKloZ+PN1iVvsBh
	1D63idMR8YWhWN+lrkyjW+7t26n6q44mjG2OJU3zxbqfuXLHGSU47P0r8yUlGeYCfU7BQiweKdt
	709pKIgVT4rpVAWHcJ4p65fBp8cCxpE5tFwKOs7VObBb1iE6c5j27nOiP1pldHeFsiX4cmwAwco
	2JvfIM7nfqCn7fu3EEex5Y4lg9o2Q=
X-Google-Smtp-Source: AGHT+IEpxJLcudozMK0RlH08J4zC+7BkrtPegzKfFrmhuSA37TLE3wdFwvGA3QhoSWRGB7n6xUFADg==
X-Received: by 2002:a05:6a20:3c8e:b0:243:b656:dcc9 with SMTP id adf61e73a8af0-243d6f8ddcemr29359920637.55.1757040452539;
        Thu, 04 Sep 2025 19:47:32 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm12991858b3a.84.2025.09.04.19.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:47:32 -0700 (PDT)
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
Subject: [PATCH v2 2/7] net/handshake: Make handshake_req_cancel public
Date: Fri,  5 Sep 2025 12:46:54 +1000
Message-ID: <20250905024659.811386-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905024659.811386-1-alistair.francis@wdc.com>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_194733_167511_D1002700 
X-CRM114-Status: GOOD (  12.69  )
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

As part of supporting KeyUpdate we are going to want to call
handshake_req_cancel() to cancel an existing handshake in order to
instead start a KeyUpdate request.

This is required to avoid hash conflicts when handshake_req_hash_add()
is called as part of submitting the KeyUpdate request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Fix build failures

 include/net/handshake.h   | 2 ++
 net/handshake/handshake.h | 1 -
 net/handshake/request.c   | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/handshake.h b/include/net/handshake.h
index a07fecea87eb..10f301f3c660 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -43,6 +43,8 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
 bool tls_handshake_cancel(struct sock *sk);
 void tls_handshake_close(struct socket *sock);
 
+bool handshake_req_cancel(struct sock *sk);
+
 u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *msg);
 void tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
 		    u8 *level, u8 *description);
diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index a48163765a7a..55c25eaba0f4 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -88,6 +88,5 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags);
 void handshake_complete(struct handshake_req *req, unsigned int status,
 			struct genl_info *info);
-bool handshake_req_cancel(struct sock *sk);
 
 #endif /* _INTERNAL_HANDSHAKE_H */
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 274d2c89b6b2..02269f212c70 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -17,6 +17,7 @@
 
 #include <net/sock.h>
 #include <net/genetlink.h>
+#include <net/handshake.h>
 #include <net/netns/generic.h>
 
 #include <kunit/visibility.h>
-- 
2.50.1


