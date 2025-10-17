Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25061CCD184
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 04:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kAkZgFdLzvs8Exsdja0IC6onWedwrzXxt2HCf6MfZEs=; b=d6PpXnb7FejfTGZOnHNAYNVXGt
	LBDuMfDehZkYNJUwhuQVOfg7eQCsWYExxetHqt/LzAdthXBbHOjrkfBOpAIb5To/vvYgtdtpDhf2e
	Y212O/+1NciqCFGeBL8aNyW8b/B4K2G6IDqExFOZ94+jz9w5L/NoRZSI6rV9vb9+ZyakiXe+W+Q78
	LcKHH3zVJMs3ltCKd9uxAa3U/iBg2delIkT7MUd8oheJoam1Mfo0/bCENr59vB/JznehT2U3yFeGj
	XSbzXeMJZjwGWAOEvI3iBx9+Ctkx0M+bpr4zty0NMTGowvY8RybnDFPq98xvyOk/bEaWrNSxbZkod
	mraXEyHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c22-00000006WvC-3Ggh;
	Fri, 17 Oct 2025 04:25:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c22-00000006WuG-1Lad
	for linux-nvme@bombadil.infradead.org;
	Fri, 17 Oct 2025 04:25:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=kAkZgFdLzvs8Exsdja0IC6onWedwrzXxt2HCf6MfZEs=; b=Nu2K//AP7C+4ulCUEfn+AdUiUN
	TsgRHqeh41Qi8RDf768LBvp+BHr/nV/mLwwRz0vuPmt+jSckvVE0owvusqw7S0i9E8WlJDI5b9aSZ
	Rd3CqPUksNFXLJgQ+kXM65iiFEkGnyz7aaqxhJPrxht1SYLobels85RePLfN772ySLuBzb/rGVUgj
	iAbs+ki7ztE9f1w5G1xJ7j8yxKZRfHxbJedqRNL/aatuQHgVVKscpSjWrxe7I0QpEztL7zyCTYicT
	uc3/QrFbO8tXIQ147cFKCdgYEbhB7mWrHquB8AtdXGFNwXhsoGtI5AS3Lg4uJDLK88P6hnDPVGtZv
	glB4omnw==;
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c0X-00000007HbZ-2cUN
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 04:24:50 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-330b4739538so1352141a91.3
        for <linux-nvme@lists.infradead.org>; Thu, 16 Oct 2025 21:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675030; x=1761279830; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAkZgFdLzvs8Exsdja0IC6onWedwrzXxt2HCf6MfZEs=;
        b=MZJHkRjNr4zZ0drQ5BVZPWskIM0qEEI5wGTdncYB3ZdoZgH2hiIbXZm8TkFAw9r1Db
         EzazrfpTQr9m5J+0a2cEVq89jfuIrU2U1QZgDxPga+uSzTTsDoUaDcrp2oZZLvN/k+fI
         veojFzYfJSL30gnLf7LlJPVLvndRJgNd6q5SkJdES1KnrTCX3Ufir8hgDxP0X6i02dXL
         ZtngeLdgB944eoaeUCcFktJ47DloTv8mCGOeoIMNHZTsX0TFrE+zS482bEV1cZrSwajc
         ndoCHGRBqxhc16xZW6XIwdwLpywyf9e/BoT/YkLbvEhhqZ9B0ZaeqJ/7k23ZrknLLfQf
         F78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675030; x=1761279830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAkZgFdLzvs8Exsdja0IC6onWedwrzXxt2HCf6MfZEs=;
        b=clyS4mIYQ65O6i8MMnb2NOmXAUfomilawsqH98/k6x26nrgL20HOlx6Fy2bFytC+Hj
         ayGZlDCINZYdWAbK7eVCLI79PPHKv4xhWg4MCS79cf4wQeqx3JOurFthru1Xk9ERini+
         UAYNggRQRneMsGlhPNOX3OuqwJWrmeI7QgLgEOcZG9E7qw71T3jqPjSFfGQjK4zVLY5r
         zsQgjFXnrPfl0sa+TFdBWGnxRuIl6YSaja595RuZ1P5+hdv0muVaZDfceTAljfFBofKx
         BWCZQAI1IgincOTO/6mLHhsuKrPK8+F/d7ycWGDSrPfM5TOug55k4kZXRn97nGwje6QD
         +MzA==
X-Forwarded-Encrypted: i=1; AJvYcCVHeJoX5hKl7Gsg7sDaMPKegjUM75XWzi5uB1TrZ/mZZohEFVa8nRok9a6ROERDei25jTIQcZ65RrkR@lists.infradead.org
X-Gm-Message-State: AOJu0YzWdVJ4wovLun2vSjj3fV+czFGU5sjEpPefMN4rzA0vjzTKZl3h
	bfEvLFdgiP/wv1TtZbECrRc0NafGtj0PWlbf5rMyVdf5ULePG1W6VcjP
X-Gm-Gg: ASbGncu71PeUQ21LkK09UHpYMXKLAPcLInYRKai+zsztp/C0OcTjzzzctRqR7E7nrIJ
	FMfSHD/WoJWhR23gP8pRDvhLUsEi3AWE4+l2IfCKfZ/JTyL8FRWp8pTlsn2r76X6n7zCXOyhiHe
	GS0cASo36ipx1eDE6SyHvtIv2LRHqiRGsEtB3xzTvnqhFzQm47wWkNHycjZFRuLlvaCd3AdWoQd
	RxeZb6eWTOR2qIqXIpplEhbPHHnwnO4fc1B3HKTx9LTk1t74zjcUPuUVGsi+pnck2LvTB3hlMdZ
	JoSF7+MpvYOS0skx32u2wrJI8p9SFeAnwLszZ1ACPjq4V5rOGECxhcTr6RYjsoBtPG2jEDzlFnl
	7SB4C0wNLv1i27mtMh2nYYiZJwu8rhGNZx3xE9bA5dwUITHqLM+nW7qvYFrJGovkArrTMVcVZAS
	vm9X8xXxX7yqALseC269rkY1tI2xJumY2VqBcho1tm8b2JmlK06wSf/nLX1dVz4p9IJ1Y5PmpPd
	tGNf/o/keB9V4Kg17EG
X-Google-Smtp-Source: AGHT+IFfbNX2mTod+6zKsy5GzuQyZpJ35ah75bJLjAVf3giPURvKPzSrUXNdaNKl89D52wOXFUj7ww==
X-Received: by 2002:a17:90b:2ccc:b0:33b:c9b6:1cd with SMTP id 98e67ed59e1d1-33bcf8fa1fcmr2615932a91.19.1760675030324;
        Thu, 16 Oct 2025 21:23:50 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:23:49 -0700 (PDT)
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
Subject: [PATCH v4 3/7] net/handshake: Ensure the request is destructed on completion
Date: Fri, 17 Oct 2025 14:23:08 +1000
Message-ID: <20251017042312.1271322-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017042312.1271322-1-alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251017_052448_430120_53AC155F 
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

To avoid future handshake_req_hash_add() calls failing with EEXIST when
performing a KeyUpdate let's make sure the old request is destructed
as part of the completion.

Until now a handshake would only be destroyed on a failure or when a
sock is freed (via the sk_destruct function pointer).
handshake_complete() is only called on errors, not a successful
handshake so it doesn't remove the request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v4:
 - Improve description in commit message
v3:
 - New patch

 net/handshake/request.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 0d1c91c80478..194725a8aaca 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -311,6 +311,8 @@ void handshake_complete(struct handshake_req *req, unsigned int status,
 		/* Handshake request is no longer pending */
 		sock_put(sk);
 	}
+
+	handshake_sk_destruct_req(sk);
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
 
-- 
2.51.0


