Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E395C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 06:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i93gdwdJwTXNOfXoya/7WJAYlNF1iMYcRcaL8nz1gpg=; b=vDLIeSFuOFlsQLz9Ve6mvekvd1
	mbHEQaF0bxX5LPChhtzVekGzqVoVrMrbqz1sRuVeS2vONEHKIQ+2o7UBU/0LxKwJBcFo8LFKni4M2
	NL52UUVWrI5eyTli9POj3o0E1K48mk58LJIZufAzHp2UaznNidCK3NuosjbY183gkuLxTI2p+azx+
	8RBuj4IKmiCHY1o72VMz2cx6FXeD15K00uAlj8g0YU+yOAum8reU4cPcxL6DT1C3gDwnqj6djWw8n
	uDS4J+enSQtr9+BaZL66SCeYWGiIjC5Kvj3V9lPIYYDx48zFfPML0zgfxzGr6GdzPmg9WEy8Q9Oru
	j+D2Edkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQTr-00EEjS-Fn; Wed, 28 Sep 2022 06:23:39 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQTk-00EEhw-SA
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 06:23:34 +0000
Received: by mail-wm1-f45.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so1765971wmr.1
        for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 23:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=i93gdwdJwTXNOfXoya/7WJAYlNF1iMYcRcaL8nz1gpg=;
        b=h1rKAMylRokVZMHtv/XaJ0rpw9MOX3edRJGwkKXhD0dtDzZMCVAx0Pvgixzp38P5zN
         50nZyiyDn283zQJ1fIvKWnYpoXaorqR5hQJgEs+gnz4y2V/OTXq3oaPcRrqJTuA+cpus
         QxeSwGx6Xl6+dvjx4UGfSlDzG0i0iqTnXVJ/j3JcQaIO+3lzGTPOr45rAONdZtIcEgQH
         S1HhzpYJs7pB0/bjcCvHhMdQJAYy8ymXlzeLifZK5vDu8X0IvxT0mjcIvrtl9S2u3jm5
         j72dEmitxfeh6IAsP0T0gqWxsPhSwmgXi9eA/Xn7GLgCgNVHgxCoKCodTq/h73LRm6G1
         b6Zg==
X-Gm-Message-State: ACrzQf16ZYQ/9skjv0uobKB3vYFk59TlvCurrWbuq5J21FIo3aMO0rF6
	s/BPqzYZV+wwAOyB4vFYJtUkIUu93DY=
X-Google-Smtp-Source: AMsMyM54xT+fbBc7sDBwThw8ju4kOI+DN7kOQUKChWp66D9BK0DEB32rxLVVgiszsu0sOjqUyOcs0g==
X-Received: by 2002:a7b:cd14:0:b0:3b4:8680:79a7 with SMTP id f20-20020a7bcd14000000b003b4868079a7mr5585580wmj.28.1664346210621;
        Tue, 27 Sep 2022 23:23:30 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f13-20020a056000128d00b0022afcc11f65sm3411557wrx.47.2022.09.27.23.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 23:23:29 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Jonathan Nicklin <jnicklin@blockbridge.com>
Subject: [PATCH 2/2] nvme-rdma: fix possible hang caused during ctrl deletion
Date: Wed, 28 Sep 2022 09:23:26 +0300
Message-Id: <20220928062326.45119-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928062326.45119-1-sagi@grimberg.me>
References: <20220928062326.45119-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_232332_925356_E4FADB40 
X-CRM114-Status: GOOD (  16.92  )
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

When we delete a controller, we execute the following:
1. nvme_stop_ctrl() - stop some work elements that may be
        inflight or scheduled (specifically also .stop_ctrl
        which cancels ctrl error recovery work)
2. nvme_remove_namespaces() - which first flushes scan_work
        to avoid competing ns addition/removal
3. continue to teardown the controller

However, if err_work was scheduled to run in (1), it is designed to
cancel any inflight I/O, particularly I/O that is originating from ns
scan_work in (2), but because it is cancelled in .stop_ctrl(), we can
prevent forward progress of (2) as ns scanning is blocking on I/O
(that will never be cancelled).

The race is:
1. transport layer error observed -> err_work is scheduled
2. scan_work executes, discovers ns, generate I/O to it
3. nvme_ctop_ctrl() -> .stop_ctrl() -> cancel_work_sync(err_work)
   - err_work never executed
4. nvme_remove_namespaces() -> flush_work(scan_work)
--> deadlock, because scan_work is blocked on I/O that was supposed
to be cancelled by err_work, but was cancelled before executing.

Fix this by flushing err_work instead of cancelling it, to force it
to execute and cancel all inflight I/O.

Fixes: b435ecea2a4d ("nvme: Add .stop_ctrl to nvme ctrl ops")
Fixes: f6c8e432cb04 ("nvme: flush namespace scanning work just before
removing namespaces")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3100643be299..8e52d2362fa1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1049,7 +1049,7 @@ static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	cancel_work_sync(&ctrl->err_work);
+	flush_work(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->reconnect_work);
 }
 
-- 
2.34.1


