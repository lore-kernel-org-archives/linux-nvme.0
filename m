Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEBACD4F54
	for <linux-nvme@archiver.kernel.org>; Sat, 30 May 2026 08:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jXf2bvYSAAZt0TsC/x8Kx2Varq1y3DRbvmQC9bTnigo=; b=BqgT37W/muSbiflGX2+ledcbCq
	DxGFOpm4V4eVLqEtRJfkRFjc9F51nKDQbWagvldW5H+9c9QvBCY4lmku0lBG0Sp1nuD7YZFU0+96J
	F26pnvKYlWkpj5/t2ckVH79TYFPimZ7zEGIBAI2+6bRFiFLeXO+Wsowxn7ZVztmfawdLPLMXvIggO
	0ZUFwex6nKWeQckNmyN7PY2364e/bz7QG1IvO/48U3uVPlPooKPUpfMX7fXN5OIKJ/dICHHQXh+tE
	F/rLPgFk2BIM6Aycl+T9/SZcrBscZkMIUb8XShzJDB8mloYpOZ0CHsvpdxcsSWImL9r1jW3VgoCsT
	ZZFlgWTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTEmf-00000008XCA-15Ro;
	Sat, 30 May 2026 08:11:05 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTEmc-00000008XBm-45Gi
	for linux-nvme@lists.infradead.org;
	Sat, 30 May 2026 08:11:04 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-c8279604464so17553927a12.1
        for <linux-nvme@lists.infradead.org>; Sat, 30 May 2026 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780128661; x=1780733461; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jXf2bvYSAAZt0TsC/x8Kx2Varq1y3DRbvmQC9bTnigo=;
        b=SvJfFmqwzmEU3/cVsa21XZhxLOA/PYyvYTs+/+ANpM+D0lnfJ9IZ1D+6ov5Qk1ER7z
         ssojtxSpKHoNOxcM81YUbHnYiUC/o7LImqdhekiJLRox80OAcsYcuDVVykDaOxHdxxWh
         6KxImzJwoOKCldWFomRA7bHv3PmluP6kW5wHG9SjvKKXuzpurnGhANWcyN1yhPIgYFy5
         C25xjIK02+62UCo+tL5n2ztPRDpXcoqdx5gDOUHQ19ZqXvJmi9H0mYHtXWmeul9JtI9W
         gbkbqFN9RFxWhFe+xEFM4mxfn6N7Lf6YRS6vlvq3bJ+E+QMIomzP7T0x8oSOwQc1iKCa
         zVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780128661; x=1780733461;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXf2bvYSAAZt0TsC/x8Kx2Varq1y3DRbvmQC9bTnigo=;
        b=kIGJUHLsFFJNdfSNzyhr/lESHYmzl0av5c05W+l1v/cLk1BDhIfoZhKkbfNmUgTMH+
         eMuWFjzYNUiFq/kIinErkKUIPoPv5Tfa/4BZ6uWVKQc6NYioMhiSRA1pmCNshryVJd7t
         zUKW5XUIMtQ6awFoOrXeP6vATmgc42VHvPMbeanKprfW3aLNTRiKUG4o52YSAI2XMEMF
         TbXoMvrNYu8ukKs7vJjTNaBZ5xnecmXyC048moy9qst/BfTcm6RJSR1+5ghr9a8SVH6D
         7oxQXkhdp288R2r1hFJTAAyUytjzPsYSbIKz8WFgmcFsNj/cPGyixj8NZYGKxw+SvEs9
         t89w==
X-Forwarded-Encrypted: i=1; AFNElJ8rgR/x9TaHuw/g2PewV0xHW2j6Bn71Kh0ywgQ1WlAbEnd+8ZGoQq13qdYmVrhYgjqfIaG7O3Bd/Q8Q@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+bTSH3L5WV/nAGSF6Dk4JMdilIfZz9hX5vSFz1O9DBBV//hzf
	/XSvOTwahc6YwLDTmukpW7WeGNM1ezXTkrR7M6ZqfnYdjs5X0t2Squ2ucPVkxRZw2Mo/BWmaoj5
	RWzRviw==
X-Received: from pfblc6.prod.google.com ([2002:a05:6a00:4f46:b0:835:4c30:5576])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:ce44:b0:3b4:dd7:6304
 with SMTP id adf61e73a8af0-3b427fb6867mr2860302637.8.1780128660802; Sat, 30
 May 2026 01:11:00 -0700 (PDT)
Date: Sat, 30 May 2026 08:10:57 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260530081059.428303-1-kuniyu@google.com>
Subject: [PATCH] nvme-tcp: Use WQ_PERCPU explicitly if wq_unbound is false.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: Marco Crivellari <marco.crivellari@suse.com>, Tejun Heo <tj@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, linux-nvme@lists.infradead.org, 
	syzbot+d078cba4418e65f61984@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260530_011103_047972_6A28906E 
X-CRM114-Status: GOOD (  10.98  )
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

Since commit 21c05ca88a54 ("workqueue: Add warnings and ensure
one among WQ_PERCPU or WQ_UNBOUND is present"), we must explicitly
set WQ_PERCPU or WQ_UNBOUND when creating workqueue.

nvme_tcp_init_module() sets WQ_UNBOUND when the module param
wq_unbound is set, but otherwise, WQ_PERCPU is missing, triggering
the warning below:

  workqueue: nvme_tcp_wq is using neither WQ_PERCPU or WQ_UNBOUND. Setting WQ_PERCPU.
  WARNING: kernel/workqueue.c:5856 at __alloc_workqueue+0x1d02/0x2070 kernel/workqueue.c:5855, CPU#0: swapper/0/1

Let's set WQ_PERCPU if wq_unbound is false.

Reported-by: syzbot+d078cba4418e65f61984@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a1a9a86.323e8352.141b09.0001.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/nvme/host/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 22be0e0eee07..fcf54cc38c3c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -3046,6 +3046,8 @@ static int __init nvme_tcp_init_module(void)
 
 	if (wq_unbound)
 		wq_flags |= WQ_UNBOUND;
+	else
+		wq_flags |= WQ_PERCPU;
 
 	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq", wq_flags, 0);
 	if (!nvme_tcp_wq)
-- 
2.54.0.823.g6e5bcc1fc9-goog


