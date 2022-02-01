Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF6CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 12:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bQYmoZ+SIoC9afaE+8yhiS1Sg6j8BlnBOctrqQUnrys=; b=w1rQ37nymTeUndzHwQ7YnEQkxu
	dGHCQbClbex1C92LZxagowAVDNXDUfQBs5tJ83CLF1drZaVgpDHGU2fLG1mEkJaq0YwThycg7wrdq
	qT1ygiSkvIMBLtBBRWABaA6aSIH8EnlnKGUeyn15VUKMu+X6qinPferxOiUB6KvizRIy+cdyhhFRS
	76lOcbVUmyVeFFw5eJxfyqkFXot9DDjH0hVoA8v4Qnz+RPmfk4ojS4LII476DdqiPrqv4+2l5h7+O
	XjzlLzulnI3OwSL3u2T2+D5r2hwNUocjvxzRpqXOCY9+T3ttAGtsdg/fV5WjHPbx7IEe3/G9V//Sz
	mYHwWO3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEsgB-00C7gJ-44; Tue, 01 Feb 2022 12:54:39 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEsfz-00C7e7-E0
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 12:54:28 +0000
Received: by mail-wm1-f51.google.com with SMTP id m26so6380504wms.0
 for <linux-nvme@lists.infradead.org>; Tue, 01 Feb 2022 04:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bQYmoZ+SIoC9afaE+8yhiS1Sg6j8BlnBOctrqQUnrys=;
 b=nRvRRCDuymrVIcuhdWfIrU0iCNETTfbmmJmugYvpWIIlazjkY0mZPA3FsKdg/ks5Xg
 ATnOP464nwayL2qb42NTlupAhK+Y6AaOWC1luAlvkO/pqcXeLmVHC+1axjXjhvkeCxRk
 6SYemXxV+K81djKPDtEc0OcpZ7FACg49ulXzZt0GuBjQ4IvTCw94PvmbYlaBZIK5hLpk
 odSzbbQkzaxp5RvculoZ+pttVvZZltHbQlO0igZPnYMn2FzIe9iUw/DxZ0iyqZpe6b6c
 Aqo1GD2hhO8MmAnooy9WwhstE5rqo0O/pIkqjusMAVRhryupd7qnzafep7mHBeasSRSe
 8q1w==
X-Gm-Message-State: AOAM5308yqN9NKMT0S6RV2p1Y07fJmuUmX843Hu3KzS2W7ilgfOCqZXd
 jAqJKmheQsnghAvFeEJWvSguH5Sx/O8=
X-Google-Smtp-Source: ABdhPJzcwjZOEM+r2jzqNb4rnh/qRuLKpTJZlPVmmr27F44pejUFPAT7v3Br1gL/yZ2bLKClW/eeMg==
X-Received: by 2002:a05:600c:20d3:: with SMTP id
 y19mr1679569wmm.1.1643720064935; 
 Tue, 01 Feb 2022 04:54:24 -0800 (PST)
Received: from localhost.localdomain (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id x4sm14993878wrp.13.2022.02.01.04.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Feb 2022 04:54:24 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chris Leech <cleech@redhat.com>
Subject: [PATCH v2 1/3] nvme: fix a possible use-after-free in controller
 reset during load
Date: Tue,  1 Feb 2022 14:54:19 +0200
Message-Id: <20220201125421.177942-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220201125421.177942-1-sagi@grimberg.me>
References: <20220201125421.177942-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_045427_491394_2FB01AB6 
X-CRM114-Status: GOOD (  16.41  )
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

Unlike .queue_rq, in .submit_async_event drivers may not check the ctrl
readiness for AER submission. This may lead to a use-after-free
condition that was observed with nvme-tcp.

The race condition may happen in the following scenario:
1. driver executes its reset_ctrl_work
2. -> nvme_stop_ctrl - flushes ctrl async_event_work
3. ctrl sends AEN which is received by the host, which in turn
   schedules AEN handling
4. teardown admin queue (which releases the queue socket)
5. AEN processed, submits another AER, calling the driver to submit
6. driver attempts to send the cmd
==> use-after-free

In order to fix that, add ctrl state check to validate the ctrl
is actually able to accept the AER submission.

This addresses the above race in controller resets because the driver
during teardown should:
1. change ctrl state to RESETTING
2. flush async_event_work (as well as other async work elements)

So after 1,2, any other AER command will find the
ctrl state to be RESETTING and bail out without submitting the AER.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd18861f77c0..c11cd3a814fd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4251,6 +4251,8 @@ static void nvme_async_event_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, async_event_work);
 
 	nvme_aen_uevent(ctrl);
+	if (ctrl->state != NVME_CTRL_LIVE)
+		return;
 	ctrl->ops->submit_async_event(ctrl);
 }
 
-- 
2.30.2


