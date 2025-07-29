Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60EEC83F26
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 07:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CUc8kFhAV7hypvAgEkTcPRzYg5s34VrqAAtY84jsOyQ=; b=d/KvNQQSzy9SP+LjwdN6UAvoJn
	BLzm5Z+zLrIYCLTxEEudUdgWD1BjrmAm4FxUWOLBUxep1tS/J0vweYUWAuGyYvP+TSdOOQTbzXVXd
	b2zKPRitjsyYRUOYWBHnTPKx40a9B4m/RztSKxl7uAUMcej/dMYRkRKVKXZoPZ/JIihZJjoVnyl+B
	pPT2Qr1IUEFg+DB3k6aQllRnBaGy0DTutsQSA6RaihNF5Qz6Q41ToWA7wL8F2nJeQlkgnGm7CATCr
	1wFyY06l8Tf6I4tSjfQepZcYlmlXg4yeCAsOSurFrJhm32K25P4ip1J9dieUbLOnBseLwbOIAmPMh
	cpnkTCjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugezM-0000000G9SQ-31x7;
	Tue, 29 Jul 2025 07:43:08 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugaJT-0000000Fn1g-25rZ
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 02:43:36 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-b3226307787so4322497a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 28 Jul 2025 19:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753757015; x=1754361815; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUc8kFhAV7hypvAgEkTcPRzYg5s34VrqAAtY84jsOyQ=;
        b=RTzC09q2JOLGjYpJbV/g9PG2WRfwQxwmIc4y0hEeJ1XKFzfgzTQOwTHLlzHpUWEFgy
         0IjxxNYxJKnIQjbn0tdPHkK/FCo8VXKzG32/irOlGBimIpx31JL4BeWrRrzI3WKv1oE6
         lOXgQL129dnRTID7LG8e5p4hVkl05IbOjP2rqHF82rAh3FlEJC+o4RTNp7q2uF0evQ1j
         jwFa1fMQWCHH7CokeKY4I9gMUoUI4isMgH7jJi0fjyt6dxrqI4E67LE7IyKI31L9rmHK
         pMv0yxofYRywok5e6QsnEqTPUaF8R7AXBzNXv2m0bGDy0qLLwubh0G9oLP7xBnL3R3pU
         YY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753757015; x=1754361815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUc8kFhAV7hypvAgEkTcPRzYg5s34VrqAAtY84jsOyQ=;
        b=Hvrtkfg7OVgk/L8ns+CVppN5f5vq8JKKAG1IJ/c3FUTqUcaddVXbhQcPiOAnbVFVGj
         NNe2PyqVlJwGQ8i+IBfLDi4lW8f3WpSTLouck3rHZJZbze1o/24K+wGhtvJlITckhPsE
         nqw2Au6Gzr9+Q/Nqtyuhup5gCQTbfgb8j25tnRcZ/tuSPkkJFBx4l6OMaMdsdNU7A0sM
         yfAga64/1PLQPIPy+/zq1bGDt3vodWY8yFF/9HMW2FJi2iofiIEEn30O5t4F1qMluJ7N
         ym0sy3hP2+3zrtehb+7q2YjNfeVvj2TW0/VbwSZLXoXRcBnpOBkewIs2E1H2W2toOobX
         /KEw==
X-Forwarded-Encrypted: i=1; AJvYcCXjPRYrRGB+gj2ewoYOmGlFXrCEEtH385glxQc2kXOmqWU7j1RietYIk68tcTGkMeklygPP4YbsGPmz@lists.infradead.org
X-Gm-Message-State: AOJu0YxTcZRe9eq810cOyhhT+Up2rqfauAwXFGh2jOrkexnQnWmKZKds
	K3l7tp/s0XJYrobnz2GFgs/4dzI1sZ9uZEAV0LJgJCkESwRiJdeDILfp
X-Gm-Gg: ASbGncvSGcHnDEaY43HZO0LrpjxaQ+DHx+MdukSN2kY4hOiUQbiVWcgx7lbdDpbyQe/
	t8g3aZdUlASKvPMxwKNDGDTF81wjiOMs+6kZKMmAxCrxwIJw+y0u4UEZGk9bSdA8+2Ua4PWZxyq
	wiUhJdf2caukKz115+L0MakGyNeuYpbRzNABoeaAZHjVgTEGMWrynjUDNkiMNJHdcek/irhClrx
	pbJ3+9+j74eWVz4kOyIHA582Xs4VoFUFZSOxlyPztVhKG9OQq47bWaOtZ6duDKzU3XYhgOD5pQ6
	jqbaR5c8vt3uiUFFN8IOUnn4qMgqWnssDfqoTxzFvSxVJqf+mCvB5hUBScnjcbWsevjlRN6/gT4
	kRnhMGxxxNoPujWo9QsQRZD+gjQ==
X-Google-Smtp-Source: AGHT+IGvnSnLVLEqZTFD+PzBwy1Cdk7P5Du3q9Qu7UOjqUQgKKgrycbGzQke7Edy0NFQh/gyLC2l1w==
X-Received: by 2002:a17:903:3b8b:b0:234:ba37:879e with SMTP id d9443c01a7336-23fb3178fdamr231355165ad.38.1753757014631;
        Mon, 28 Jul 2025 19:43:34 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fecd9ed12sm51327855ad.8.2025.07.28.19.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 19:43:34 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: alistair.francis@wdc.com,
	dlemoal@kernel.org,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC 2/4] net/tls/tls_sw: use the record size limit specified
Date: Tue, 29 Jul 2025 12:41:50 +1000
Message-ID: <20250729024150.222513-5-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729024150.222513-2-wilfred.opensource@gmail.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250728_194335_538075_0B5307D4 
X-CRM114-Status: GOOD (  17.94  )
X-Mailman-Approved-At: Tue, 29 Jul 2025 00:43:06 -0700
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Currently, for tls_sw, the kernel uses the default 16K
TLS_MAX_PAYLOAD_SIZE for records. However, if an endpoint has specified
a record size much lower than that, it is currently not respected.

This patch adds support to using the record size limit specified by an
endpoint if it has been set.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 include/net/tls.h |  1 +
 net/tls/tls_sw.c  | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..6248beb4a6c1 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -241,6 +241,7 @@ struct tls_context {
 
 	struct scatterlist *partially_sent_record;
 	u16 partially_sent_offset;
+	u32 tls_record_size_limit;
 
 	bool splicing_pages;
 	bool pending_open_record_frags;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index fc88e34b7f33..4c64f1436832 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1024,6 +1024,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	ssize_t copied = 0;
 	struct sk_msg *msg_pl, *msg_en;
 	struct tls_rec *rec;
+	u32 tls_record_size_limit;
 	int required_size;
 	int num_async = 0;
 	bool full_record;
@@ -1045,6 +1046,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		}
 	}
 
+	if (tls_ctx->tls_record_size_limit > 0) {
+		tls_record_size_limit = min(tls_ctx->tls_record_size_limit,
+					    TLS_MAX_PAYLOAD_SIZE);
+	} else {
+		tls_record_size_limit = TLS_MAX_PAYLOAD_SIZE;
+	}
+
 	while (msg_data_left(msg)) {
 		if (sk->sk_err) {
 			ret = -sk->sk_err;
@@ -1066,7 +1074,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		orig_size = msg_pl->sg.size;
 		full_record = false;
 		try_to_copy = msg_data_left(msg);
-		record_room = TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;
+		record_room = tls_record_size_limit - msg_pl->sg.size;
 		if (try_to_copy >= record_room) {
 			try_to_copy = record_room;
 			full_record = true;
-- 
2.50.1


