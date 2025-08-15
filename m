Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2356ACA0ED1
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Aug 2025 05:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+KvInbCUt8tTGLRjQNfEmbBCvEDs8pNQ8LImh9T5E8A=; b=p2bjqYp9MOKFbd3nkMGdeBY7ey
	Vqn8RKSjd/3g9hJoUwkUfoXvw+D8M/KSbnDNhY/CGtPT1EavdHYv0Jcw4PkOwMWo9krOBQGoDwPJ2
	MM1hBhObCARJi101L8l/4RrJpSKmTiTsYlRQQIPC3/QhECZZPxX3CVAhYGcxOrSyO6oXGoCvDeo3R
	xJyT4GRDBv4hr2nhSBZJCL3bktOSjnPWlvPbX0jiQfAHa7/p+FMKMMDh4/PC370khOOaBOuNSFucr
	8F7RtKxFBPP0m1W/j5hE2Khu67nig2Wkl85gssx7Vy24Q1yojsWrf/S8954F19m7JaEBi29bliKc3
	AIZELezg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummaO-00000001Shv-22n8;
	Fri, 15 Aug 2025 05:02:40 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummaM-00000001Sg8-0c0F
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 05:02:39 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-76e2e5c0d4fso1386677b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 14 Aug 2025 22:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234157; x=1755838957; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KvInbCUt8tTGLRjQNfEmbBCvEDs8pNQ8LImh9T5E8A=;
        b=Y3CFH2NSliF9ASoIKFk+NYpYKKMoIrRcQJXHydm5e3fveA5EMYTr5z91VE8u/N2PEn
         sizUO/1PurI01veGF/bnYelSheavlfs+ZaRSwsuvYhdyPyzGwG7uJ7DJuSAfv4hO0LGW
         HvWxp02hQrOsoDLK2n5XIEeoCIbGEmk4iEzq7dEWM3HF4f1bbtYnJ+X5I2wKgnDeR8jm
         Nq9X1dL3vfuqgX0sq8dI8D/wqEI7LUl/72QQYSIpYLxblQFpGUnmYdt1WrIiMULC+CC3
         VswG0qp7GoEZzdaCOCv8Oq6s31R819vXbs9YJaDhm/KFNMI8IDx7dN2MS5Pzlqg0KyW2
         HXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234157; x=1755838957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KvInbCUt8tTGLRjQNfEmbBCvEDs8pNQ8LImh9T5E8A=;
        b=tox9sGiytIiQpGl8+u8rQ0QazoS18hrNTQ66VLWeh2ryzJcuU7dYXKWbn1xfziRdwh
         PUfmDRYfyPgIqTc8TkdmlbsCTADjs+w49BVu2FkY2AZh0Nmn3k8912ioYLjx0/HRSQXr
         H0e/aFPu+a3aogos0ThPVgaE36SAu6kpvJ2Nl435DjuheFdSXTKBupa6frF2qIWqjhyI
         Zj20a1/SRSPkFsV7aEyBrZZF9qZqBVIjLThv2DUQHJziljTnhKcruGd2j6+jBlscV6Vj
         EmsynhTAkptjxngFASso5fqlitrG36UfyTAsdaBkgfmALLP6+hwH3DIVs/O7ta5g30xs
         w6HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDlA22P0339SZDy+YeG0NA4XmJkF0WmgOyAvi/xGHWoGTUE2ndkqLbBbvGRZGijukRPNQW0/wk1MZ5@lists.infradead.org
X-Gm-Message-State: AOJu0YzGIZ7QN7WXvcEOsxJmDR69fVhXTKpqzM9MNY19nEVADXMxoq4M
	cCBHTf8JBUtn/pVH0ZgWMNr4oxC4z3EA23dcVCgp5pBCiPwjqF0K/xQZ
X-Gm-Gg: ASbGncuXsAyCBoYrNTMhlm2zt7EWhQQkY/+BL1FQlCnNkFbxvvWUIs5ax9D+W3gZnoV
	F28AbI3QCnigkY0XTuo38gfRJwaWviQmxwyMr6gdZeFMkNXmp8C8x/J80zjOgkrzSJfNfKcZsqx
	bxDXE+9ckI2+L0JdQQdbTosbIZzkTglo++w8Wt7udflcgfTVgI7x7QKkm99v7iCdcMTW+9QD2Yh
	g4td3Cka39s9GjOUJ3yPprBIJqpCsMb6K5ov9tBVu/z432qi5y0QHy41MGj1xxIR+8RPM+GMUpO
	M1OwAnXoCqX3ND9UHalzgEVybCMnZemPyNu7jdSlu4+TzA8kWdz/UEN3oLXv71htyIDFarQL80d
	A9XXB04bG5wu9q0fRFCd0RrDaXg92B1G7m44f3ac9hGcQVBvlEU+By85QMlI1LUcAqStXKPyfwG
	ByD3dCbGpAFdQEzUwP7ETpGH90SmM=
X-Google-Smtp-Source: AGHT+IFH+OSkE7l+lj2EnSVnkTcqL9+YMNtK2tre9BkCjoc5zJE0Ky8LTNiG//ckenUsfyTJOUv3vA==
X-Received: by 2002:a17:903:2f10:b0:23f:f074:415e with SMTP id d9443c01a7336-2446d6f108fmr10850335ad.14.1755234157302;
        Thu, 14 Aug 2025 22:02:37 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:02:36 -0700 (PDT)
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
Subject: [PATCH 3/8] net/handshake: Expose handshake_sk_destruct_req publically
Date: Fri, 15 Aug 2025 15:02:05 +1000
Message-ID: <20250815050210.1518439-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815050210.1518439-1-alistair.francis@wdc.com>
References: <20250815050210.1518439-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_220238_185912_14054B5C 
X-CRM114-Status: GOOD (  10.96  )
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
 include/net/handshake.h |  1 +
 net/handshake/request.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/net/handshake.h b/include/net/handshake.h
index 8a64729614e1..fab4760049c6 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -43,6 +43,7 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
 bool tls_handshake_cancel(struct sock *sk);
 void tls_handshake_close(struct socket *sock);
 
+void handshake_sk_destruct_req(struct sock *sk);
 bool handshake_req_cancel(struct sock *sk);
 
 u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *msg);
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 274d2c89b6b2..bb727a9ad042 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -341,3 +341,20 @@ bool handshake_req_cancel(struct sock *sk)
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


