Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A7606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 05:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UlmNo2tP;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f1XLAEuR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=cwgEBBj5LhsaX6pCYUsZy387nginafi1pmffopbOivg=; b=UlmNo2tPLWXNhrL1pgkzug6dmH
	+dt5o78YofsKm7tdtWebTsclqVXVYiNu6V7XXxRkEQ+CO9ef6mgQwlX+5UyamPJMx2NbpwpPrsmBl
	9Aq+ULzgYYhyFqlQyJb8p22vcYBIwUf8raxl8GhbetLOuYXTg1dKzo/llCdobhMKApyPqWPO4k1ZM
	lLV1MGH/QjyoNQNns0dstP7ugxyGfTgHB32HeQZyTb6OtmXf7kL/2wPm2cf1pnZJshDhCr74sBtru
	kWE8RWjBbexe6M4hSf+hopB8rhhszph+ft/qq3zynJVm2IMcJL3JCachHvv/SGQRc58KFs4GWvi5M
	T25HPk/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVinw-00000005aby-0AsU;
	Tue, 24 Nov 2026 05:10:56 +0000
Received: from mail-pg1-x546.google.com ([2607:f8b0:4864:20::546])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVinn-00000005aao-3kdV
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 05:10:49 +0000
Received: by mail-pg1-x546.google.com with SMTP id 41be03b00d2f7-cddf34086c8so2383470a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 21:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795497045; x=1796101845; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cwgEBBj5LhsaX6pCYUsZy387nginafi1pmffopbOivg=;
        b=f1XLAEuRnFxGodc8O0bmbtZceESVf3azuFnL3PdaeGlrYkUUo7sgsmf44nmjqvjLju
         yW8kIIvkauibOtIYI6ZT/9zfKBGQgOvQAbc16DmaIVN/nL8Rchskt7ZchqeH8tDu25tF
         /NJCSeKaAK5S+8ogmvakKdQXoDUTICvSLzI3HcS9KiDWxwgWQN4KUHm7X+UBKZn93gGA
         BXI/Uha8ErOBU2GsbwmocligVc7qReVQeqT5i9pnJMKeeh1pkQZ59lltmekx/l5/huBn
         2FBA9Daw0jiUX3wVMFXxiigNGl6f8B7u2K4D0gLP/6s/T+f/qaNK2aphak+neweTGmXN
         vV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795497045; x=1796101845;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cwgEBBj5LhsaX6pCYUsZy387nginafi1pmffopbOivg=;
        b=vSdF1oHEE47nDSiICPv+hp1R1Fapb7Q/9aU/P6b3o7fmWioedtNfckhmNHcbZZAw/d
         qgt4Luj23+xsc8VWwFnHQfEvRyQe9LOG1IANfCCTCHXQa7LfV8KT6gmLOtg2mSgmkWHT
         ppQj8PQ3M3N1vdNbo7a369Nielf+UQ8y8/0iYPl4y7Ce9n17UtKXO0P8SlzyxwIMn8At
         IknMrFkUKjCYXD3y+J0u1Hn2yz/RZHbHyZmLk9axT+cr1dk1YwRqt3/XNNjZfM0Jl09s
         xtTZk7I9J2/AC5KAQnKlcre/Jg5Ceu7rU4Hpr5oG/rlKRXb+y+fcdjLNmxIcmLAs3w7X
         UD/A==
X-Forwarded-Encrypted: i=1; AL+hErE9cuVJEbj2MUpR7JEphck3hg4I/y7q7pc6zL07i+LAUVsdZcWBs4+9wJvghRjk8G0fKfL+sK7AXWFC@lists.infradead.org
X-Gm-Message-State: APuU4Z/wFGznlQ0tZcVdfK9x/GvmWbJdEW7z91wehEvzmIonpX9wjiBx
	XADfIh8N1+KLs4cDS9lcvkJLKrGlSRP9b8b02KYmIAE9cz/UwRF3/R/XsiFcECPmSIh0dI1sBOW
	LE3zmSph5SZFBg888Gr8vDAANlfo1BA==
X-Received: from pjbbt12.prod.google.com ([2002:a17:90a:f00c:b0:3b0:ac19:f886])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2f8f:b0:3b0:ad59:7199 with SMTP id 98e67ed59e1d1-3b41c942629mr11575434a91.32.1795497045086;
 Mon, 23 Nov 2026 21:10:45 -0800 (PST)
Date: Tue, 24 Nov 2026 05:10:39 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124051041.3099796-1-zhenwenliang@google.com>
Subject: [PATCH v2 0/2] nvme-tcp: fix the R2T send/receive race
From: Zhenwen Liang <zhenwenliang@google.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: Shao Mingyin <shao.mingyin@zte.com.cn>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_211047_937112_AB99C003 
X-CRM114-Status: GOOD (  14.08  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


nvme_tcp_handle_r2t() sets up the next H2CData transfer while the send
path may still be finishing the previous R2T of the same request. On
stable kernels (with the "<" offset check) this leaves pdu_sent wrong
and the write stalls until the I/O timeout; since 347d50d92e25 on
v7.4-rc4 the host rejects the valid R2T and reconnects.

Patch 1/2 fixes a 32-bit overflow in the existing R2T length check.
Patch 2/2 moves the R2T setup to the send path.

Changes since v1, with the Sashiko review findings:
- 32-bit overflow in the length checks -> patch 1/2 (and the new check
  in 2/2 uses the same form).
- Use-after-completion on send error -> 2/2: the send error path no
  longer completes a request that the receive path has queued again;
  error recovery handles it.
- Race with a second R2T / torn read of the recorded R2T -> 2/2: one
  R2T at a time (NVME_TCP_REQ_R2T_BUSY), published with
  NVME_TCP_REQ_R2T_READY. The send path never sets up an R2T before
  the command PDU has been sent completely; if it finds a recorded R2T
  for a request whose command PDU has not been sent
  (NVME_TCP_REQ_CMD_SENT), it treats it as a protocol error.
Test results are in the notes of 2/2. I am open to a smaller approach
if that is preferred.

v1: https://lore.kernel.org/r/20261123225246.1653658-1-zhenwenliang@google.com

The problem was found with a Lean-based formal model of the code and
AI-assisted analysis. The patches and this text were written with AI
assistance and reviewed by a human.

Zhenwen Liang (2):
  nvme-tcp: avoid overflow in the R2T length check
  nvme-tcp: set up R2T data transfer in the send path

 drivers/nvme/host/tcp.c | 132 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 122 insertions(+), 10 deletions(-)


