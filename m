Return-Path: <SRS0=KTc9=BF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5289C433E3
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 00:23:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BE8206D7
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 00:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eXbhDDKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BE8206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DaltqvaOrq9MlSTJ22Fz7zJWgGq3w9dzhWETMKRetFc=; b=eXbhDDKWqipsQPX4Ml9y8414A
	tcxXefZJ8Ke6lAnCAsG5/LPyx3aAcc/i1KIHwvK/lVi/EVsaWBlXX+UaPPSUZFaTtF7upDruL3RFf
	Wz62RBsrklj+BJRW5QhU6fV2yBpTL8Por8IGApMa/rLCjbcVYu9IT3F7f1+JgOmCj001axej7Bw1R
	viOMAgGJTkv0NRwPvglyP4VLYeJ3UbSGkI2Hks6fcNbqWU4xabkP9nObhRSrWqY26EPW4MO4I2HVN
	prMmZ9xR9D0W7IIgksEqwMWfiRkiB4Im3zx0VCLqNVLdkOb26PH1MFnq3gPJK901XYsDnPQ55/uZo
	L2F/EaQ3A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzURd-0007xb-Gr; Sun, 26 Jul 2020 00:23:13 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzURZ-0007w9-HS
 for linux-nvme@lists.infradead.org; Sun, 26 Jul 2020 00:23:10 +0000
Received: by mail-pj1-f67.google.com with SMTP id gc9so7215603pjb.2
 for <linux-nvme@lists.infradead.org>; Sat, 25 Jul 2020 17:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kzUvv4wu5ssPzXeGgDw5vla87R2Q2Tzs154QAybre/M=;
 b=E/G3hllOoce5ALDSKLb4ycMhXZjX3bc99+6yNSyh5ylXwK79cS4oQxtCSnIBZV+aWk
 80WG7OBKg/4+8w8wsdCsDYkIeP9oym0N7vQ9hyrkhDKoB+fpDi9ia0LO1asdABKtuYth
 W1RAuh6BcA9yGjxq7xKyWWPAA6gLdQ+MOAtJ7DFKd85tSOcusOjOdBriws4GzxuVJJo3
 NIWVNkOX8PhLx1L0lTAcWS4BJfDY2xvfOqC7E7x0hduqBTOz+ae2QQv8ljjE/Ovkmwpn
 77G7xN/rZhCAy1+vv3ahGXolhboc5AkVSJ/Svk2HTx8wYBA1/iz5JRGaYzAjtniwwlSW
 +vng==
X-Gm-Message-State: AOAM531rlzijFLjfZSVzhuvt28DQKPt8gy07onubF4k4ZdvfD5TXGztE
 hce0PuB76pF7RyvRLROZ1u0KWk7/
X-Google-Smtp-Source: ABdhPJxWwkAga5zev8d9iBVMpMFXDowL+DPZC5cPQP4ZuayCuRCNYPruAe2i4Gxr6EezIsi/LlOcFQ==
X-Received: by 2002:a17:90a:7441:: with SMTP id
 o1mr12401882pjk.71.1595722987816; 
 Sat, 25 Jul 2020 17:23:07 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:c428:8d39:30dd:38a5])
 by smtp.gmail.com with ESMTPSA id z62sm10185620pfb.47.2020.07.25.17.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2020 17:23:07 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 2/2] nvme: improve quiesce time for large amount of
 namespaces
Date: Sat, 25 Jul 2020 17:23:01 -0700
Message-Id: <20200726002301.145627-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200726002301.145627-1-sagi@grimberg.me>
References: <20200726002301.145627-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200725_202309_708315_5521179D 
X-CRM114-Status: GOOD (  10.49  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme currently will synchronize queue quiesce for each namespace at once.
This can slow down failover time (which first quiesce all ns queues) if we
have a large amount of namespaces. Instead, we want to use an async interface
and do the namespaces quiesce in parallel rather than serially.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c16bfdff2953..45f1559ee160 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4535,7 +4535,9 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_quiesce_queue(ns->queue);
+		blk_mq_quiesce_queue_async(ns->queue);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_mq_quiesce_queue_async_wait(ns->queue);
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
