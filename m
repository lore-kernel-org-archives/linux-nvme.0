Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81637CD4851
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 10:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y0x0i+gcegzHfZ4KyqltqDvyEBGkthH8obOAct/iNNc=; b=MByvlc9BG9FMKMa23sf7Gea5xI
	K7lxOP0QT6rK7ZchHm4LXVlURsQJpnIg0k52eCEIWyG/iZgGQYObUQtqsOmjoPavyWoK3rVJTFOTI
	XK9afHeuUW3Qb/5iECjWUJMnqiDdNonQUpi3PLl1J72P34FC+5/LOFXUka8buzk4sMpqe5P72N2SF
	nOXNtfnrVZPdt9F4H8Ko+2RO8N5RxiwF2uKjMlbLvYB4QBt+k9UMlJnYb49DuppjTSao79se6fywn
	EfLOTVFLYk5mAXCl8xXi1R9qErHOkbQ/EDCVjC6spBGFJIyiVnVH5mmCq5k/7Vt0Hcf4EjzPlirSA
	LyNxIsDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMkMZ-0000000GQrx-2hia;
	Tue, 12 May 2026 10:29:19 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMkMX-0000000GQrA-1s9s
	for linux-nvme@lists.infradead.org;
	Tue, 12 May 2026 10:29:18 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2ba4efedbeaso38096605ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 12 May 2026 03:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778581756; x=1779186556; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y0x0i+gcegzHfZ4KyqltqDvyEBGkthH8obOAct/iNNc=;
        b=KxYwfc+ZKhQRw0chzP1CBfOipAq2CI7+xba/ESSFuSdZFFvwcShzRvvhbzoGFG6p28
         QNRVgbTijRFRKGvnWB89YSIaprnGQeeZt5fds7bOuCcC8DXZzQ72qCnzfbYyqPY3dZKV
         6HdEfZrTdTbKZu3FSQ6ijaf0LEV9hPCwf3V++hEhaTLYP15mHhy16fIPxLRTc4Ad7APe
         hQVm4gaSUFs+q515GWArdtrsS7ecs2z3y+upGx2CEvhjhXMldvQlPIiIfJQ8IMhtq8K7
         WhvCNO3dzfHqg9HYGGhQY2+JyOMB7T77baNvNReR098EjokrWLQ/IIrk4XuuMZAD+0MB
         5EKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778581756; x=1779186556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0x0i+gcegzHfZ4KyqltqDvyEBGkthH8obOAct/iNNc=;
        b=RkCvJ6nMS3N1M6XIQIeINHKZhfAGsY7aKnow8+P8ifGzVODdQRWXhN+7t/wxvMraNm
         qpereJwuFHu2/iu8o0xq0scz38VLzCWV6+1AL0caOw2uOGDb4L5jR0oOmLuYUWxU+B0n
         XW9lCqup/M56AcrCK10+vYOMbP8IUELs7WHy5aJS8vS0/E4l67PLbiYkvS/MLvfJ5bR2
         nT5oWgg9cE211x9pT4fzmpuTnGO1bprvJ/ReNDyaOqWjrryABx/W+dDeey9bOpKCnQLr
         em8IB0GU4+5OVFbbZMLzd18trBl7cemYMM0xEvQDwdeJl6vspGfjwYaprpnkLF+za21F
         eUwg==
X-Gm-Message-State: AOJu0YzoR0RHOE2LNHFtmQMnJUqroBfEIkvh6FHdAZOCJldz3UZzTkcY
	AgPRZj3rEJBaZVWveyodWbbCKKCjrQTxOpNdLCQiqtiZCkmv0LVcJ9bO
X-Gm-Gg: Acq92OFe9JGHwOBAKr3hx0c5lFQzPcuc2u0WigVhgOZcGJL0fjUyZQyG8B6aCg+x8TW
	p5Zl5OoknnusKPLb6oe/3s/dKZAQPbyplbb6r+Ba55choGasL9utS1A0PYbICmJyGPkaVKv2uSp
	wSTrPDqt7LLVwUXvjyKktEMyaZklRjIaHhUDCC3v9Pl3YH2qG8wExXvoYKu4PYC8DTlErCviNeX
	eACQIp2BWCq6l26kIV9t82iTer/+4ZWs4uWc3CaimFmc2g1l8zwDDvf++EZRWbJl3O+isxrWlOd
	s+wDglpNWdpYRE9aGB31rpStITycrW2YXNENoYUBUFrWO/KGmUvil6XcpFVhLj7c7T9gfmUebR1
	jCCE90OmubBlzdMxyQJBtT6sB9wJ+qc2HpuMHNI5lYlLR4Fhd0x/n4iDJs8MRTtYqFi9CBQjm1v
	ziCMnY4lplfJm55MMUz0Aw91ObpJSfqmjCaigPzMs=
X-Received: by 2002:a17:902:cec8:b0:2b4:63c8:ce18 with SMTP id d9443c01a7336-2ba794bb379mr309763995ad.12.1778581755727;
        Tue, 12 May 2026 03:29:15 -0700 (PDT)
Received: from zenbook ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e3571dsm129849905ad.42.2026.05.12.03.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:29:15 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Damien Le'Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH] nvme/tcp: release socket on sock_alloc_file() failure
Date: Tue, 12 May 2026 20:28:32 +1000
Message-ID: <20260512102831.3593121-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_032917_488924_F54A79C2 
X-CRM114-Status: GOOD (  11.25  )
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

If sock_alloc_file() fails after a sock_create_kern() in
nvme_tcp_alloc_queue(), the socket is not released.

Add sock_release() to release the socket if sock_alloc_file() fails.

Fixes: e40d4eb84089eae1 ("nvme-tcp: allocate socket file")
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/nvme/host/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8e5421d2e8b9..f4b9d8acc7b1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1820,6 +1820,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
 	if (IS_ERR(sock_file)) {
 		ret = PTR_ERR(sock_file);
+		sock_release(queue->sock);
+		queue->sock = NULL;
 		goto err_destroy_mutex;
 	}
 
-- 
2.54.0


