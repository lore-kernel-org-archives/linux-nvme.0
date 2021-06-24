Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54225C49EA6
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 17:54:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC679613C7
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 17:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC679613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gTQGg+I9EteLmxhZWYiYU6T4OTF3LPFnrHtji4FlO1w=; b=lCV5eui6NvMUG/
	mgioSL98lYv4wwuT6BW6KUi6oGcwx/pMpAd5z/W3M/J+qYaMDRZqA3X9bAmgy8HbVPP8/a3lUVyVJ
	NveqOFn8ruSCac6WMxQOA3Tzpu2MeP6PMKRDor/7aDvVXIB3gGEANoMcnAcK6M8vgBz+q87KbhQF0
	+IXVxhZYf9LMdDiPJU2CCRIO66ovVLuBruSgPDWXy7DhMOX56mX6zeUIcCXdjxKif9YOytgLueAXm
	s4J9nP+UEOG9bcivZkh7JqONpr8fxObhUhMmUB9gRLDHJ+6Dq7LOVjzr5bzE1IcOlrpWR9DRNVnay
	Ul9xmHOnt1/IStYqeMTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwTYV-00FkkK-Iy; Thu, 24 Jun 2021 17:54:23 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwTCn-00FfDo-5k
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 17:31:59 +0000
Received: by mail-pf1-x42d.google.com with SMTP id g21so4086111pfc.11
 for <linux-nvme@lists.infradead.org>; Thu, 24 Jun 2021 10:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dNgLf/DCboNoR6dpC3wBL0ZKzO7kN3/jlOkp0r2Isx0=;
 b=g/bapTwD3DFcx/V+KY9aPsLT2t5oLfc0TdFLCk/MGYKl8H0S5MUAND6wjJJY8Mw7t9
 Bk+1bl3ebfqVfwk2APC9YlmuyjZPUELTgDeORr7IeJwLDU1pVns1+/OdWO9jJR7FdVaZ
 uTA1fcqdssqhPtRJkfcZprAGpKVqmHfrUIwKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dNgLf/DCboNoR6dpC3wBL0ZKzO7kN3/jlOkp0r2Isx0=;
 b=qv42EPQsmOIjTLSSA7WHEHD4FuJfabb6hVItp3zI/npw9lqYimRiGnfn/tu3HFxBva
 XHCfMWdNndVNEfgU8CSaFr8LLEIGttS/QP2thV4R1Q9pGIr1dTv6nHnZLewfUGEqlRJl
 xwI6laQ0N4toTGkmtQ0qvG9PehpTQSBAnIgWICYTZhqLA5vN6Izp87JpPL27OgbN/lXz
 SffP16np66LsTzA5D06MehVVaJewYqIHTiBD/ydzmZ9qh9IRSvxsnE+GG3VxVXt+niUc
 LwRv/Znm0VE1jNSN5RZF+zv76xFp+DMi+eDeqN3OkT3hG4BhCQi1Wakwu1vhMg2WMIAS
 J+9A==
X-Gm-Message-State: AOAM5316IIo8lUkiJpbsOiPrlElNkYnzb5xWNZwIIXimFEP4CTHkcXqv
 3ktR4ja/U/WYy22KEGtmSaTBS0UX9c6DrUnppOMR0zivzWgkhcSxmkm9+XwYkTZxVZhODsd7wIw
 RTHaINApGhjC3N/cqrOLHxhzQVr6rUKJwe/pLf93GiQtPVy55LKiXt5mqvdwtB3nebifPYZAYK3
 Qpcjg5OaA=
X-Google-Smtp-Source: ABdhPJw+IvHVEgn6N6BuYAX4UiyIii1ktEYEQsYVlZmAEtZQnIIoZCpdaS6W5KTT1FnnRGWm5h8F/Q==
X-Received: by 2002:a63:5153:: with SMTP id r19mr5750590pgl.56.1624555916064; 
 Thu, 24 Jun 2021 10:31:56 -0700 (PDT)
Received: from yoga.purestorage.com ([192.30.189.3])
 by smtp.googlemail.com with ESMTPSA id gg5sm8488537pjb.0.2021.06.24.10.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jun 2021 10:31:55 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-nvme@lists.infradead.org
Cc: yzhong@purestorage.com, ashishk@purestorage.com,
 Casey Chen <cachen@purestorage.com>
Subject: [PATCH 2/2] nvme-pci: Fix UAF introduced by nvme_dev_remove_admin()
Date: Thu, 24 Jun 2021 10:31:25 -0700
Message-Id: <20210624173125.20376-3-cachen@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210624173125.20376-1-cachen@purestorage.com>
References: <20210624173125.20376-1-cachen@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_103157_282566_3FC9F2EB 
X-CRM114-Status: GOOD (  11.06  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_dev_remove_admin() could free admin_q and admin_tagset while
they are being accessed by nvme_dev_disable(), which could come from
nvme_remove_dead_ctrl() by nvme_reset_work() during cleanup.

Commit cb4bfda62afa ("nvme-pci: fix hot removal during error handling") was
to avoid requests being stuck on a removed controller by killing admin queue.
But the later fix c8e9e9b7646e ("nvme-pci: unquiesce admin queue on shutdown"),
together with nvme_dev_disable(dev, true) right before nvme_dev_remove_admin()
could help dispatch requests and fail them early, so we don't need
nvme_dev_remove_admin() any more.

Fixes: cb4bfda62afa ("nvme-pci: fix hot removal during error handling")

Signed-off-by: Casey Chen <cachen@purestorage.com>
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 378ce9c060af..9e843d571617 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3045,7 +3045,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
 		nvme_dev_disable(dev, true);
-		nvme_dev_remove_admin(dev);
 	}
 
 	flush_work(&dev->ctrl.reset_work);
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
