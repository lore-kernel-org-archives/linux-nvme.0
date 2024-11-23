Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C454CE6ADFA
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Nov 2024 13:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YrPDMuw1dFwbu0Tqru5tfNRebp4Qh9dYF1NLTgw6QP8=; b=lH9bd8/ifUcgbsKW+Q91q5kMr3
	0ZAGM1gdmywnGnurjKRuBq7lIf8WrfgV1K43zoFtJRHLezcjm2zy3Bupb5kHVDyvL+3a2G8acu+po
	dT9FEqrWKOvkL3pf5129CariImGNKNH3b2zicU0kyyIRITT2biX3sSaCqhJcYyOuQljj78jTPzpza
	dYZSol/TQmxrbinj0+a9lOeDDw512GJ6g9ybn5ATgbzeAD0HdMObHZcI+givpwB4rcI6omVxw2WCa
	0/dd/VGnkR2nNp/SydkR5livcqzdcW7J8ygJmxvZ9mexfvU8tVBdTmS+G9g9g+LgVTq2UekeXyt8h
	/5+YspDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEpmC-00000004LtJ-29Lq;
	Sat, 23 Nov 2024 13:02:16 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEpm9-00000004Ls7-3HOD
	for linux-nvme@lists.infradead.org;
	Sat, 23 Nov 2024 13:02:14 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-7ea9739647bso2423340a12.0
        for <linux-nvme@lists.infradead.org>; Sat, 23 Nov 2024 05:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732366933; x=1732971733; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrPDMuw1dFwbu0Tqru5tfNRebp4Qh9dYF1NLTgw6QP8=;
        b=CGZK5h1VP9CzJ4OFS/jUw70S18GEqcTxg/+/zPW+U/7XG9RUfLPQ0aH8XLpehjeqr4
         h5uUL/IDq0HFoZCMOZ/N7HcTC6nmrq8Yy/PMoaJdS/rtysSVfLqNJk//2iFhGJ+W9uHF
         3x/l4JB8Ow8xG/5C7jR0aM8qq/C3Vwtfbm8LD5ZVixulg2PIqWNwcG5tcSrd1rxMT/R7
         DsM0pVr+XiFvtIiaHXTUxUI7P6gkk8s0VzkxOB0+gn+PSibwUOO1fRUUYoB0vIX64ZdG
         U2EnUYdLkewL5SzX+efEHqDWauhfrL/tqy/lFcRwpzkZhrHVTv/lluj3R3zGi21wjL+n
         jDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732366933; x=1732971733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrPDMuw1dFwbu0Tqru5tfNRebp4Qh9dYF1NLTgw6QP8=;
        b=XkBgv6tmsGs7MfIoleOKUN5jtcgMCu2UNF+0gzvU2RAZ+GJs97pYo1np0MCJ0cFQE1
         5N71MK/QZpM/XgvNzyPdqzt/o/N2elS928KhKn/O8/TXNtAZ5aJdsoSgNB1nroZzOqWg
         OtEe8lb/gpbFupsuWbDEmEy5FI7vYrvy/xALANubcWOhvNcuQ6ZX4JgSFdrHkLwhdFrp
         JDdt+EDAUOI4UBpHQyO4TlMU0Co3kjmBx/YNfsrStYOI/VUufqEuPIBho12BOXDoddwp
         Q4zCiO/YnO/mIEHVFjWhlGf4MVuXBYjkkv+xh3K7QQJIfxHTqEbOpqsig38li5w2HReb
         tmtA==
X-Gm-Message-State: AOJu0YwmmMhLhy1iFLRiIVSgtBTRXzHpPFaJrec7kMyqADqA6Duv/f3l
	Q0FOyeM87Vf7AFHcSE9LCc1vYwZWEEOmAEKZtFro3rIqdmLje5HG
X-Gm-Gg: ASbGnctP1R6MUu0BBdvXREd7g5TY4AskPHBxFXpX4+jOPLy7tOk/KF/XlLfLie7NFOd
	0qXySRaHgNNJM+P/JIF6P4SXACjZ4h+XfJSlHZdvOJSdcOAVdRQkBYrjIi4GOS2yWHWC9WZVrVN
	PxVt+WiYMNZlRAyAOj9rYboKjiNdI1F/e6sVB4pYma1fIxTlSo4AMKyyRhmI8X+4WQLHcbl7kIb
	UtCQldqKxqyOyzN+egOzkxUYMGzohHgzmE0MjfDj16aNwR9AsMUAuPsMAKO+w==
X-Google-Smtp-Source: AGHT+IF3F2H3QEfzAXCRlL8SxURAgWq5rQ5oSRPQa9KvX3WmUGVygxsmZiZORju1Kw53XHpLHT07Kw==
X-Received: by 2002:a17:90b:4c8e:b0:2ea:3aeb:ecca with SMTP id 98e67ed59e1d1-2eb0e8847b1mr7505522a91.31.1732366932509;
        Sat, 23 Nov 2024 05:02:12 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cff8fe8sm3295226a91.14.2024.11.23.05.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 05:02:11 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] nvme-tcp: no need to quiesec admin_q in nvme_tcp_teardown_io_queues()
Date: Sat, 23 Nov 2024 21:37:38 +0800
Message-Id: <e7c1d7b531cef5fdd2764719e4ca824477579083.1732368538.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732368538.git.chunguang.xu@shopee.com>
References: <cover.1732368538.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241123_050213_818816_894A5C54 
X-CRM114-Status: UNSURE (   9.87  )
X-CRM114-Notice: Please train this message.
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

From: "Chunguang.xu" <chunguang.xu@shopee.com>

As we quiesec admin_q in nvme_tcp_teardown_admin_queue(), so we should no
need to quiesec it in nvme_tcp_reaardown_io_queues(), make things simple.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3e416af2659f..47d8f10b1f75 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2178,7 +2178,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->queue_count <= 1)
 		return;
-	nvme_quiesce_admin_queue(ctrl);
 	nvme_quiesce_io_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-- 
2.25.1


