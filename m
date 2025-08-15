Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B5ECA0ED1
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Aug 2025 05:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4bYaR0txeJQ15MO4CAHzNGe+lgnMf7tAMLNjm+q8B+g=; b=y9qVKoZi8tHcS/LOS49N6YkJff
	e340Jx6rHQms+eO4oSB6Hz2V3KvBOHZ7dJ5mWcy9q7fcVLUVVSFZBz4Acn52TzDEiBLE/RC48s1YS
	jRuonHJFXuLP2mKL2L4eF0nWePXaGFyQQC5wUpQ5VsB/oPOwjOtzem8PFhorSUNyHPJxwPBjqHXGa
	xwkgu6684RSCEwCRq7qK1BhOaPUVdoJdWh0+L4DRZIcxGz7h20o1sMvozZtKHsRMR0UsB8PKL2cqw
	8mTtRKi0bR71JJAw2DqQOP6N2fw6p3rCUCqVVhjykyoRMCCL4urPDmevpaYPipKcGZyHR+yPNWSmR
	PIeRqOSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummaI-00000001Se9-0td9;
	Fri, 15 Aug 2025 05:02:34 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummaG-00000001SdO-1cyB
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 05:02:33 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-b4717553041so1304478a12.3
        for <linux-nvme@lists.infradead.org>; Thu, 14 Aug 2025 22:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234151; x=1755838951; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bYaR0txeJQ15MO4CAHzNGe+lgnMf7tAMLNjm+q8B+g=;
        b=CxPZBAQe8js/0JTqauUlwtY3Kbp2H/YRZJc0P+vS5wfJSuOCENDvakCHRLS+rtaCW+
         McKXgs3Q3OPiQX6J2oinctqYmjS/P6nRjeyE5lsUbcSj6aNWkX5XwCjw5w3Vak65L+cx
         r1knR/816I1OCzmziTOUE67/izec4EIbA5zTg11b+FfZh3IMxTpQkLAYt8BoOq8WETzN
         I3N3XmyB+tzXVb+oIXS7MaFFda+gtD/8emt0cbWvjQiKUiX7hMrLNABvvw4UiHy3BQlY
         P0SMvO1mOK3oya6FMWInaMasSqCFpJLh4p0QggiEPMqAIRLwk8vCy8GWW+2MfK7vjXXp
         uHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234151; x=1755838951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bYaR0txeJQ15MO4CAHzNGe+lgnMf7tAMLNjm+q8B+g=;
        b=OVW5O5Q5Fx6vr647zGaDMbKKQ6Fe7B7a2fnNvQfn4ku3O/UO2BsayKCx3kO3Yu9nVt
         GFczuv3O9pvcvKyGOJfVQRA+noGuj/XhaZjofTIS1ig2aNtw8aXECCMFAcgpLKity8JC
         BQRmBXA/EnsCZG+h4sLIqgmFgm0dBHtCGGNw4aZHI2+MhoL/Nd+qSaXLD7uwaovZMPRV
         3+U2d3edNfyCB5cSQAzeuq6GqiiCAdQijdhHAJDvPLMQeVUCfNE64duqg51IqfQgRKH9
         H1inoXq2UeJHsW+I8OQQrvhb3drEZpbCQog51PUiA0lg4zYaJezGca7Qm5hIRr3yd97j
         eLUA==
X-Forwarded-Encrypted: i=1; AJvYcCWKUvzVI7VRvZfxrdbl+tWboLA1faC60ZdTUsQDVZzbcnkLeZuP6gBWgYqom0Zz72ZEQgSjoP4NK64l@lists.infradead.org
X-Gm-Message-State: AOJu0YzSI8vaBvmZX1qGkjrxRmeuJBOEj8D+fiRDVppjUrSzWBLeq3aV
	gk7w+a6apxAMA5zolEdNVz4opjJKOIFojlDNiizRCooGY7ROaMc1UlxE
X-Gm-Gg: ASbGncvwPdd1n34Va/2fOdnnHFuwSd9r7fzhBkNbyR6Z8AJcdWTdqELE8cCKRSvbSAP
	re2cvAoKWQdKXxw7tl6nQrfJrOfPMeAdUoGhFPLaVY8gspyke2g6Nq+2YF8wKuNH/j3CRNRq5LF
	iVv9SB+rH/IY3RH6H/NHqad8hdzgObckB4IklylA3czhVLCRpYUrCKLn4sIbaPni4EEc8IjSHbP
	kjKNujFCR220DT1msbtnX52beXWjY65A0LOMR4qDg0ExpN/jjCYEE/BxiSm8LMZ9liakWi22+2i
	+E4o7Y4xDIuYW7N66TIQk69IivLA5EETs+aMRNTpSXRkM5J3KvfxFMxpU/WwrELqVV/4lhcCPQR
	/xRbwpHRTzoOWtvdtVW+q5F84XzY3iiT0qGeP2yGuQ4yx/mF5U2SObGEmtryKdLsNWzVAOGHmwU
	qaBGd1SCv4OeKXJaGmQWExdbdhcptD9J9BuHVbvQ==
X-Google-Smtp-Source: AGHT+IHbFa9wi3nz5/xQeXOUNqL7qBn+//4+UspNBNAPh8R+al2x4L9A89Rhs1lRGLSwUr5VjjqL+A==
X-Received: by 2002:a17:902:f647:b0:240:a504:cb84 with SMTP id d9443c01a7336-2446d865e0dmr13064545ad.30.1755234151526;
        Thu, 14 Aug 2025 22:02:31 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:02:31 -0700 (PDT)
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
Subject: [PATCH 2/8] net/handshake: Make handshake_req_cancel public
Date: Fri, 15 Aug 2025 15:02:04 +1000
Message-ID: <20250815050210.1518439-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815050210.1518439-1-alistair.francis@wdc.com>
References: <20250815050210.1518439-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_220232_438542_547E43A5 
X-CRM114-Status: GOOD (  12.61  )
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
 include/net/handshake.h        | 2 ++
 net/handshake/handshake-test.c | 1 +
 net/handshake/handshake.h      | 1 -
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/handshake.h b/include/net/handshake.h
index 449bed8c2557..8a64729614e1 100644
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
diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 55442b2f518a..c338b9977a71 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -13,6 +13,7 @@
 #include <net/sock.h>
 #include <net/genetlink.h>
 #include <net/netns/generic.h>
+#include <net/handshake.h>
 
 #include <uapi/linux/handshake.h>
 #include "handshake.h"
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
-- 
2.50.1


