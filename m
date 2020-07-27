Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CECC433E8
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 22:07:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34D62072E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 22:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ecMsyb2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34D62072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TyNl4RfPsT27Dj/lRvAvaj55N2IDRQasRi8TRhVnvws=; b=ecMsyb2kF2L7qV0he5JAcjJZG
	N0qIdpL/Rrrcvm0p9N6NYAO70piSfqaCXe5DvLdr0j0TztviOGvyGgS/2bLS0PPC4RvgizjxlZ5O5
	Ne56F1dthcctqViY/lNs8KEm+flwo1z/27sco8xFumzIgcC15zme2rXCqhFtut2I6uHk8EX60PvGP
	DK0/e6/IvopfZaaeqXAD65SAljwd31wM8gyGaA8AIrwRRNFh/CFos8DfCjKLbB+BCBBnzFmiTRt3p
	9GUBP/RedBLiH1ixwPP9az5m/SnPv1jj+nJutKm75HSwRM4LS+Ia1kHHp++i0cGMZRjSkMzgd7yLH
	B7wnYY6cA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0BHK-0005ZA-LJ; Mon, 27 Jul 2020 22:07:26 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0BHI-0005YM-4F
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 22:07:25 +0000
Received: by mail-pf1-f195.google.com with SMTP id u185so9860136pfu.1
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 15:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lGFmsfpmP1LvxqwpCX7vdhM/VjA4HywoeDLN1d97U/Y=;
 b=lYqErtU7SnQFFH2x1XrPbPN026KaBJWYkqDJD28Gh2Y2hgpmrmpe0lEK/BXVuNt/27
 ND3EAL+06vNIR6wHA8RgGUW8MwB5bBFJ/gz2Ccnt1l8aeR+EBCbrUGfe57o7kn3smJeo
 2BKxRZrW3kanTehZuEi3q/1w78eBGu3/shsQ88cUUERfEg7HHvQPVvJCl9QAHDiJMzlY
 nFMO6wYZCg9xc25hWsa0LVI/uPlNwM1Ji7kXpwcMytVCjatfjY1zmFu19VJVfcqLoQ1p
 IbkGK3zY1t3VrtPlKPUsADTWUGcJ0LPy2aN80T+bt1JxwMAL1ppC+vBqDK+Py8GVVov3
 93kQ==
X-Gm-Message-State: AOAM533D5KLU60V8j7A6sOwR1KlCFxNgYqIxJwwXaslTDRbLVZhHlkDD
 ScvsCF3xe7H2m8gzTGz536kV08Am
X-Google-Smtp-Source: ABdhPJzuDeMj0q/suaY9WEziGI3xiE+NvrLUxYpSNGDvlnh8u19J/jpAnrSeRuRwL4vxj8m9KDhP5A==
X-Received: by 2002:a63:515a:: with SMTP id r26mr23126086pgl.204.1595887642531; 
 Mon, 27 Jul 2020 15:07:22 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id s4sm2309519pfh.128.2020.07.27.15.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 15:07:21 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 2/2] nvme: improve quiesce time for large amount of
 namespaces
Date: Mon, 27 Jul 2020 15:07:17 -0700
Message-Id: <20200727220717.278116-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727220717.278116-1-sagi@grimberg.me>
References: <20200727220717.278116-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_180724_234559_F8CF6ED6 
X-CRM114-Status: GOOD (  13.14  )
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
Cc: linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
 Chao Leng <lengchao@huawei.com>
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
index 05aa568a60af..e8cc728dee46 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4561,7 +4561,9 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 
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
