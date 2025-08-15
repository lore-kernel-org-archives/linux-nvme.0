Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C2ECA0ED1
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Aug 2025 05:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mi5PFbe1K4XbqRUhP6Ms3ZRXGTgHp0ZImPelGcEgGdY=; b=Gbr0SoxiXpmUO0KtBs7/22u2u5
	IogsLGpbssGzxqsDDXDo/hDMZnoDE8Ib9CCPp5uezJd+oTcnfm2eQbS21qXNpFsEETRJlQTDCYnw/
	N60K6JFqlqecK1lIHXu/kqnoQh1QHWKFFhQkTs/PmyMPYaliIq0ZqXdXlaRRsQuCQpOvo8V3dSQBZ
	38gmq7GkZgM1sbMRj/+39Y70Pus8/AOcZcsnWqshruxWCWXhcBdf0YFeJTe7lWCmWHC4jWwjDBe0l
	UoiWJTAA+POQTqfElpOJmtHtbupnpP6ndJ7JpBqb6waeh7XK+OuA1fdqnkU7ydFCQqnPCtkR0PN26
	dRnTOljA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummal-00000001SyF-3Upt;
	Fri, 15 Aug 2025 05:03:03 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummaj-00000001SwS-03fG
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 05:03:02 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-b47173a03ffso1009034a12.1
        for <linux-nvme@lists.infradead.org>; Thu, 14 Aug 2025 22:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234180; x=1755838980; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi5PFbe1K4XbqRUhP6Ms3ZRXGTgHp0ZImPelGcEgGdY=;
        b=nTWnlr+s7+dtt4Ihvh8tZw7AbkPTSUqP0EUTdsE6oxqiMPpTad30qoQEPgNbI01SuQ
         C07Lj3oQXL0Ni7qyqD/d2RAhnTpQx0Ry3/GGso5JSmV2xBu1ygOVyWokGsP2pdWu+FOZ
         riAbixijj+aaBLzn7ziUg3PhhuyCxB4IDOdoWBFxzYgGBZtaIjmxBWpBBMWOd6+C/WLp
         5O7MpAmsS8RBTc01l2bmN+Cdsfve/jXSIlxD/PWbygECFN/XzEcM0knYLXzQbL/+fxdh
         XrFtEf6+njaLxKfuUdhQF/C3Wws4WBp/JdFb64irv1rTGfjHrF78U7bPbe9Dte2KgRn7
         amSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234180; x=1755838980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi5PFbe1K4XbqRUhP6Ms3ZRXGTgHp0ZImPelGcEgGdY=;
        b=jr7arU5uWmGzKomLgdD0HUILvqGJ2sOErGRJ30tmUKgrl2e3NTWO4pLKAkxW8dUIvO
         EywQbQiD0MZhLHMAyw8iuWRCOR2rxSF4hOOSs7rD+hmqbVqGY8bJxpO3sJ5g4R0wAFqy
         8d+Q4OODVUhJRi4W5amXnx/i+dHagwvk34v5bmNYgdKNkHWnZxf4OpFyeqduNcylC302
         /5j83tyf+5wEBRbzOrvg49tGxTyM6worl+FXGJBHAZge1tVv9hqlTfW10cNocnhY+nPO
         kFHLVXn21W9nIUQmi9ZeA8ALFphXLNHwLCxRhmqaitZL+/Dqz1KytE974EI+W5FaEjya
         /FSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9/PGjqBrrOuoJKw8CbtwyOwWRNWHhqrqtu2MaV0hd7Sgl42nSK46iQvP5+jx6258R5JECkn7h2cb0@lists.infradead.org
X-Gm-Message-State: AOJu0YwhCKP1yoaJ5hCIqAi1EQKYZ7dq2+ZuTw6nuvY0G7Jk3TXbUMXD
	TNAz4qq/4h9/VGLzLv390cwHJW18uthTDZPtvgcpxtSCMmzLtrMq7Io2
X-Gm-Gg: ASbGncvhIJQwvke7L7JEmw0jBgzt4PXq//Vei8bQPiEY3n7NHLzdbHAZ5XFjbX7rVpv
	T2HM6jEh2UIs2Ci9I8m0nMf8y32zt6h9fv42gh8RVCgmhimoOgnN2ZUcC3d2PZV3hg7RvksZssu
	Q6Yn4/tzceEwvwaG1ikcsbrHqKqricnYe2jaFfedpVyHNFtYQzfrcT2sStUZp7jD1rMsJ3L/jPd
	gb92BigQ/J0vuKhpWyZpeiQY7X2w25L+Vc7uTtcQoE2FAqw0NWZCJAo0XCAgmy+IQ7ztrHH0Lhr
	ZdPkIiPrPUNe/6j8xISrwkeoCX4f2jtALASn+owMM94zdpEwh9SoGsSGxrTeAGUAlzhfti2bu7v
	L28tPGzUB062RDSlNLnUlT4TVnXlryFS62ZdeMMndnbBWxYmRzUPZyopzP1iSVIJqaCxgcjBqSg
	Xfvm5wRw91bpFKOnjklqeVAq7OkM4=
X-Google-Smtp-Source: AGHT+IHfW2tMpo7JSMRUfWuqJPTI95KykdEA+sXXbpzW28CCs6+DYKpACzkzoqJ7Hv9T5S6Ux64oUg==
X-Received: by 2002:a17:903:1ad0:b0:242:b315:ddaf with SMTP id d9443c01a7336-2446d6eeb19mr12372625ad.7.1755234180198;
        Thu, 14 Aug 2025 22:03:00 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:02:59 -0700 (PDT)
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
Subject: [PATCH 7/8] net/handshake: Support decoding the HandshakeType
Date: Fri, 15 Aug 2025 15:02:09 +1000
Message-ID: <20250815050210.1518439-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815050210.1518439-1-alistair.francis@wdc.com>
References: <20250815050210.1518439-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_220301_062604_1EC53ED6 
X-CRM114-Status: GOOD (  11.97  )
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

Support decoding the HandshakeType as part of the TLS handshake
protocol.

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/net/handshake.h |  1 +
 include/net/tls_prot.h  | 17 +++++++++++++++++
 net/handshake/alert.c   | 26 ++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/include/net/handshake.h b/include/net/handshake.h
index 8f791c55edc9..d13dc6299c37 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -54,6 +54,7 @@ void handshake_sk_destruct_req(struct sock *sk);
 bool handshake_req_cancel(struct sock *sk);
 
 u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *msg);
+u8 tls_get_handshake_type(const struct sock *sk, const struct cmsghdr *cmsg);
 void tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
 		    u8 *level, u8 *description);
 
diff --git a/include/net/tls_prot.h b/include/net/tls_prot.h
index 68a40756440b..5125e7c22cb3 100644
--- a/include/net/tls_prot.h
+++ b/include/net/tls_prot.h
@@ -23,6 +23,23 @@ enum {
 	TLS_RECORD_TYPE_ACK = 26,
 };
 
+/*
+ * TLS Record protocol: HandshakeType
+ */
+enum {
+	TLS_HANDSHAKE_TYPE_CLIENT_HELLO = 1,
+	TLS_HANDSHAKE_TYPE_SERVER_HELLO = 2,
+	TLS_HANDSHAKE_TYPE_NEW_SESSION_TICKET = 4,
+	TLS_HANDSHAKE_TYPE_END_OF_EARLY_DATA = 5,
+	TLS_HANDSHAKE_TYPE_ENCRYPTED_EXTENSIONS = 8,
+	TLS_HANDSHAKE_TYPE_CERTIFICATE = 11,
+	TLS_HANDSHAKE_TYPE_CERTIFICATE_REQUEST = 13,
+	TLS_HANDSHAKE_TYPE_CERTIFICATE_VERIFY = 15,
+	TLS_HANDSHAKE_TYPE_FINISHED = 20,
+	TLS_HANDSHAKE_TYPE_KEY_UPDATE = 24,
+	TLS_HANDSHAKE_TYPE_MESSAGE_HASH = 254,
+};
+
 /*
  * TLS Alert protocol: AlertLevel
  */
diff --git a/net/handshake/alert.c b/net/handshake/alert.c
index 329d91984683..7e16ef5ed913 100644
--- a/net/handshake/alert.c
+++ b/net/handshake/alert.c
@@ -86,6 +86,32 @@ u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *cmsg)
 }
 EXPORT_SYMBOL(tls_get_record_type);
 
+/**
+ * tls_get_handshake_type - Look for TLS HANDSHAKE_TYPE information
+ * @sk: socket (for IP address information)
+ * @cmsg: incoming message to be parsed
+ *
+ * Returns zero or a TLS_HANDSHAKE_TYPE value.
+ */
+u8 tls_get_handshake_type(const struct sock *sk, const struct cmsghdr *cmsg)
+{
+	u8 record_type, msg_type;
+
+	if (cmsg->cmsg_level != SOL_TLS)
+		return 0;
+	if (cmsg->cmsg_type != TLS_GET_RECORD_TYPE)
+		return 0;
+
+	record_type = *((u8 *)CMSG_DATA(cmsg));
+
+	if (record_type != TLS_RECORD_TYPE_HANDSHAKE)
+		return 0;
+
+	msg_type = *((u8 *)CMSG_DATA(cmsg) + 4);
+	return msg_type;
+}
+EXPORT_SYMBOL(tls_get_handshake_type);
+
 /**
  * tls_alert_recv - Parse TLS Alert messages
  * @sk: socket (for IP address information)
-- 
2.50.1


