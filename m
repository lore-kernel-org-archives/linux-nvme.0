Return-Path: <SRS0=pSM9=LQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25B5C4743C
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 00:28:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904AB611C1
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 00:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904AB611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1aPDvhy4HqnBsFiFKdmt2jg0d+vk/D1kmCTiLWlIBxc=; b=STBu1JJfWQ768d
	DVs4Gw/Xoh4BkHBSt6UleBCY0FCAnt7oWobeeky3gS3KG/kphY9Tn5N6UP6Zqsly2ZXtgQrvUcCLS
	EPQdl4fBahKT5qG+WqsfT8hbzBZzcuVyRF9sa8K892iJTT2LmUlcrW7GQvOEc7wfG6rIabKFKiyp4
	sThilbgjVqANlppEZQsqVNE0Vn8KixXpj1PQzh5Y4da4X7h5x+0PSAJ0yaBAJ3kQzZVnYopypRxTe
	/Fx6KtPEbamlzS2bz4OIJFvtpmaO+0dT4iYP8tpRuKM9alqRPIg3isUAAAIW2EuzOwOoPBxq8SEVL
	raWo4bHPfK1sAGHWwcnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvUHD-005D78-Ds; Tue, 22 Jun 2021 00:28:27 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvUH1-005D5q-IL
 for linux-nvme@lists.infradead.org; Tue, 22 Jun 2021 00:28:16 +0000
Received: by mail-pj1-x1029.google.com with SMTP id
 bb10-20020a17090b008ab029016eef083425so622530pjb.5
 for <linux-nvme@lists.infradead.org>; Mon, 21 Jun 2021 17:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cz2d4Ujdtgkjv0Jx9kWjdzkrRxQi8sbq06d3GehCdIs=;
 b=Nvrw0U8rRll2mtltIvlhp6A/LJi/hYkRvPtpJFWioDlPRl4s3rNsK38qEyE8spin9e
 7QTRjJnm6YT0rwE/jZu62BOkheMGQ0Y7US5s9yNV6qm85EuYsCmZC7U58gc+VY2/EZOx
 kV/0b3lCJTfnFBTrCu8bSIOd9GpC1MiyatKXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cz2d4Ujdtgkjv0Jx9kWjdzkrRxQi8sbq06d3GehCdIs=;
 b=fyF7jCf09ePYDIXOVrzBOvHNbw9QsXGvkJkBPNF+dnvULuNan65r8NpYu/8zJBrByX
 e4Pa+MqD7UidKzZNfQYiaIfbTtecceLfL21uNEGiQWzrY+jJcu3sIvlRmsSjRjYzquN/
 ro4dLd17ABCdO9bN83T+Oqa2weHDSZqYEZapwCbvTXVlYcE95Zh4BKKfAWPN9A9n4FGa
 Imqm9l1y09x/mKYjmI3fT7Qjh1lS9NqhcJ1KRIP+XU4bTiEHLa0guEhrTaaiKMf6iTXn
 OErf3hcX7ityIGac+jkGueq5mjl3TQeRdpfzqkM170wPDKoRIY4Sw+0FTZfGrRZud4ut
 KJmg==
X-Gm-Message-State: AOAM530oAfuU6df30yr6RIq6hOhMKdp4hv+JUYFt/a/TGbrLBWkbiqE4
 c0QOfPXzBgoPXFc3TmYab4Tx8ncVCxqc4ldFg0d9Y6G8IJT1folnb3RjEWQL6RQ/xbP1BOactF1
 +XwHv7lCYYfjgRhRUanj0AOiqzi3k7C7FOVUpvRi/jhgZTOEsy1lEHA3eqlrG08cUFDQNRtuBXU
 5cmsUCKTI=
X-Google-Smtp-Source: ABdhPJye9reLfi2H8tstk6kITRX9++gZi/DL2nKO6JUbqbdqoOe+3BS1qkx7WR12haemmPce8HJSPw==
X-Received: by 2002:a17:90a:20c:: with SMTP id c12mr896761pjc.7.1624321694376; 
 Mon, 21 Jun 2021 17:28:14 -0700 (PDT)
Received: from yoga.purestorage.com ([192.30.189.3])
 by smtp.googlemail.com with ESMTPSA id i6sm19714156pgg.50.2021.06.21.17.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 17:28:14 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-nvme@lists.infradead.org
Cc: yzhong@purestorage.com, ashishk@purestorage.com,
 Casey Chen <cachen@purestorage.com>
Subject: [PATCH 2/2] nvme-pci: Fix UAF introduced by nvme_dev_remove_admin()
Date: Mon, 21 Jun 2021 17:27:10 -0700
Message-Id: <20210622002710.26591-3-cachen@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210622002710.26591-1-cachen@purestorage.com>
References: <20210622002710.26591-1-cachen@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210621_172815_646180_8EE3FD75 
X-CRM114-Status: GOOD (  11.32  )
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

upstream_status: upstream
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5abc4c3be454..49ef2027bcb0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3023,7 +3023,6 @@ static void nvme_remove(struct pci_dev *pdev)
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
