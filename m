Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FADCCA470
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 04:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9morpPQKu8lXMrpuy/uDVQLBubkYtfu9D8D3JxjNjjM=; b=hg5nIXbAd8Q/EbuADdneU0vIcQ
	ziTDMBu5g/49rft3W1dRruadc09/VvIsE6bdb3vf55u/IQLTJ1LuNOQpaXHyfYj0+bUu/7r43+927
	Ux7AM7Wsxqjc79xT7Q0gqUcXzBnL1b8TTGeKjED6hVIz8xH/T4zZVxRPd3xLBcZUK9WHuoGLxv9bF
	EhJdLfbSFRoE0RhHBetmu7MTpN7mYxP+UmS9XBdzUaLMIpYEO5eXGyg23jclIiqbYI2EnktzbAexo
	2m/iMxSMZGoCeURozU7F1QqqZlP2fFWBQIx9mEOr29gwdd2os9sG8AnDX6/XDIZYGJqnt3I84uXiq
	AS0AHPyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4XSv-0000000Bdre-3LbH;
	Fri, 03 Oct 2025 04:32:21 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4XSs-0000000BdpD-3khu
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 04:32:19 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-33292adb180so1863770a91.3
        for <linux-nvme@lists.infradead.org>; Thu, 02 Oct 2025 21:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465938; x=1760070738; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9morpPQKu8lXMrpuy/uDVQLBubkYtfu9D8D3JxjNjjM=;
        b=eZ4g9oPQBVR105blGtxV+tE7dQ1r+y4JlKM50cspFyh899GH6FrtlldJH4WDlvuXUl
         DQ0dZiLtMOX5WxgVdP+GcWPnG8/IGwSRCUv0UV8Vqr2AgvMVEYl4zaHBGDQNc3MKA6Xi
         uZdLTLq560ro6VOgLvtpGO45lTRefZjgXzDpzFXwYsIZfql9UCnCVJi0Q1ENyQkIIYEJ
         vhP20hT65S2DXh/G6bJmS4vV+4rqU4d1p/vmIof2xC3y3wd9xMtyksCxyBUibhLJlDD0
         SFrHfxAD4fwo2NwShRSkuwhGEvegNQEnb/xIzx+H2yrDoBmnPLNetD+sgYrahFGOFFGe
         8tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465938; x=1760070738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9morpPQKu8lXMrpuy/uDVQLBubkYtfu9D8D3JxjNjjM=;
        b=BxtC7mxRFZ/QyEw9pu2DyeQQAoC6yWykJ3WVIul4S2cSGrPXvNxlLPo1DeEQVWUjb7
         sotJwqcLH4gblBabkk8vt+E0NwngXpxpD0bty/s5MgnXFum4SppPMpANosf1h4WJfaxQ
         qdFG//xwxIEcdD7hHYr2A40FIxfucX590LbtaqdV1M9arrJC9UprUIEb2V3BUVWOjqmr
         Wqs14t9qaXUjy4lZliy2T+b6qdubQOZvVXjC7V0hM99NVU97kmCHtlY9breU7AdxJg/4
         z5P5oBLwh0e5tAVIHeXy+Gcdec/6bcxFiBM5UZe2CPC/udH+p3yvSlVoTQjnfstiMZ/h
         zSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg0WvD2bgfUhBKleDbyufJjSakSbICgrP9ttGZncOZWfp+83LZXvRp+7PrVaJGnujg4qK64yMThvfJ@lists.infradead.org
X-Gm-Message-State: AOJu0Yyrj5fB+0hLXUh3IMgcIlJlyYZ04/OxmMW/o13MhuqeBjEnCN0M
	OBlaZ+w0APdIP9tBcWDJsWp4Uz4pPLww8uUmBc8CQwn8e2THYNAjdDfl
X-Gm-Gg: ASbGncvV66NBv65o8CgYomKa5k/q29CkWmFCh8HoXDUhX2FfC63hM4kNNHL5tt6x3ge
	TBa0KYPWplLRz8L73ig/npcfw/K3hvuHwnFfBDpWuJPVfrink8bc91upK0kFhpG5vptV9ozpPVe
	JyS93Cx7cHib0zZzHHYLybIdAJNCCUN8tPt7SbIauuxZVmuxFE8YKwX1pxWl6gV5aRehJa/GMvy
	BBPpje483YNruGb4eGlz47tg4fxA5roJocx+H3O3OtLn0QjThwjUrt2S3krS/G3wSJ8UtUv3nYp
	bKOsVfcgYTmbXE4JDPRbmzH1fTuIHrAKSvmVzFRWihjnjP0jA48hwwrVDBXl/4viCntHE4Dw23+
	pVF+oiNyfAUtvSxZ/97MjGtcIBEmm+8xPxkrhaTubi09P/lczo4dvSQmpuOL2HD9YFc1m8vVtuq
	LwrrWtULM+q7mepo6crxupxPNR+QSCbrp3B1X1fUQiZi6pfcy2eRMk
X-Google-Smtp-Source: AGHT+IHs89hKTsl9/f/m+plS3Ev8/2NixvjRvxCPx92Pgo3FWsBpoEKCKAbX01MgtOEvv1xzIjE2Cw==
X-Received: by 2002:a17:90b:4b8b:b0:335:28ee:eebe with SMTP id 98e67ed59e1d1-339c279e977mr2022144a91.30.1759465938258;
        Thu, 02 Oct 2025 21:32:18 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:17 -0700 (PDT)
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
Subject: [PATCH v3 2/8] net/handshake: Define handshake_sk_destruct_req
Date: Fri,  3 Oct 2025 14:31:33 +1000
Message-ID: <20251003043140.1341958-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003043140.1341958-1-alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251002_213218_935037_1051F880 
X-CRM114-Status: GOOD (  10.82  )
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
---
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


