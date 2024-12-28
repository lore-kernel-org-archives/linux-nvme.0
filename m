Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E4AE77188
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Dec 2024 18:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AENc4Z3ax7rwx0f6UlYvVrtWhnoX8l+2h80qRPNl/Jo=; b=jBtQvZf5aCoB/l7pxFrjNc5nNB
	kV4XrqJ+P+zM88vkFoGTno3e1+QzHjnwLIMicsPVnEVxi2XUD3gkNrIOx0LYlvausBe8j2mkreGST
	pYoVDMLocBrwRbxDwsGiUnFU4eqO8v69r99LFCKDp1ox8B8VPV6TrtzAxcih4t7yrNKtkU6lHNrkw
	6s+SFNlXso0gmxHI4Ggwvz+JyOO/lRhDzWtn2jBfDlE1jz6zG1Qr78iOL/q/dcFNQQbZQu3uSxrsi
	i9UAwZKD+XJ0S5UvotC7zl19a1gMldZQnUXEjRKt7VjHlQ+muucEnYGTNNHsYZBb8qPh+dkJYVwj1
	WGreC2cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tRbtB-00000002GFU-0GxC;
	Sat, 28 Dec 2024 18:50:17 +0000
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tRbt8-00000002GEM-3mEa
	for linux-nvme@lists.infradead.org;
	Sat, 28 Dec 2024 18:50:15 +0000
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-e5390ed85a1so8630367276.1
        for <linux-nvme@lists.infradead.org>; Sat, 28 Dec 2024 10:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735411814; x=1736016614; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AENc4Z3ax7rwx0f6UlYvVrtWhnoX8l+2h80qRPNl/Jo=;
        b=Sb+gPJodEVKtitzlkKV1SqkBd0qsOh3Cyo6rriMz5tS5hhjEFX9bUte0PcpYZbhURZ
         ymsCM4rBLqwZlpknaDk9KSVdIjxr78Cmm2j00o+pe/1kxdJk+utmqAF0hDfG3kKSONGp
         sHjuoW/7ecpzuvqBuf7I6Lx52pwpgCc1z0dfdsgLv5Y5C4F/lJnKaEtfQCt2frJSSvxi
         pWptkoC9MDBAPrXVCLXMktdV8tEDiGh6cwU8TOkyqv7lWh+mfABevoX/pC1xKJansDDz
         R4NDKrnFRDz2v3b09trxgpfUtDtx9gFuxrpapda9hyxvEth9ThfqpgqcOgdeoLN8nRYt
         zGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735411814; x=1736016614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AENc4Z3ax7rwx0f6UlYvVrtWhnoX8l+2h80qRPNl/Jo=;
        b=ho0GQUXBVBroj5T67UC7NNpYg/39oV1mPtp2QNhVhzoCjPDgBbkS25NP2FDX5MLaYW
         sppGpSYPc4mwm/R4PLa696f64VCkqJg6NbVg9jZc6m3LCQa1inWqwW0XaxhWGZBa7p9m
         XjwjvVVZpX4R3zoFzOKcv+OYGbnz9LJToyn4/QJ2ori847IxQz0eiPzEADFmfQEPt6vZ
         IPEuI20PXGmeQHrxfTdkpVaT6GCWW70pkBVXTUpyWpRawArQVUCWXtYD/fmuAQLFst/E
         PrChXf62mGE50AzvtuE35NwIg+T9yBTWKN4I0OVGoQ5Ib7QWsEsMsLTCP1+LNF+UPiv+
         Pjaw==
X-Gm-Message-State: AOJu0YwYxwjcn6WO6cwFjSk5tzASrY5OG8Wf6vtfyd/lqOXp7Q7hMPIS
	T+8N+s9zV+ENJ08IAje11olkaSLqptZR98dSuBikF2nYmHqADcOb8m4u3QuH
X-Gm-Gg: ASbGncvSJyrvAspPwE6LhbRe3UevldMbM5jNt9mUAhYFjLSOW3sY8j2C+opJVcHGS0L
	Eg1hLR1nPzm+01LWGAi784hGgHT/XJJM92/CLugxyZd+FEn/OFN1+9v8Dwpauipe1ZL/Gu807YJ
	OoQ/OGGe6wFMSLWqqAcmz/lqAGrt3hYa3MgN7Y9K6ADpxd+bzd7wVaRdqy8eGor5jTAlVe99JFa
	F2VzUGPu8HnckiIic0wb46KdPufq3FeoWJ4kYGFMgy/K1Mth/r7zyC0plyJuWiTYGlTNWGYoOJ4
	MvBdygFP9VsE0ooP
X-Google-Smtp-Source: AGHT+IG7gNQAzyDpww9VP81evosoCFfnUVTHMGuH++JEv5/DY1rdC5GzeEk1nuPACT/z7N1na4UEHw==
X-Received: by 2002:a05:690c:6188:b0:6ef:820c:a752 with SMTP id 00721157ae682-6f3f814565fmr201190567b3.20.1735411813799;
        Sat, 28 Dec 2024 10:50:13 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e7499b47sm47971617b3.64.2024.12.28.10.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 10:50:13 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 10/14] nvme-tcp: switch nvme_tcp_set_queue_io_cpu() to using cpumask_next_wrap()
Date: Sat, 28 Dec 2024 10:49:42 -0800
Message-ID: <20241228184949.31582-11-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241228184949.31582-1-yury.norov@gmail.com>
References: <20241228184949.31582-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241228_105014_947658_B64BF5B9 
X-CRM114-Status: GOOD (  12.13  )
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

Calling cpumask_next_wrap_old() with starting CPU == -1 effectively
is the same as request to find next CPU, wrapping around if needed.

cpumask_next_wrap() is the proper replacement for that.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 054904376c3c..088101c57f53 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1578,7 +1578,7 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	if (wq_unbound)
 		queue->io_cpu = WORK_CPU_UNBOUND;
 	else
-		queue->io_cpu = cpumask_next_wrap_old(n - 1, cpu_online_mask, -1, false);
+		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask);
 }
 
 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
-- 
2.43.0


