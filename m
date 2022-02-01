Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3666C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 12:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H6dFyOO49Ui+f7RUWksXFpkOOVwnIUDL/r7ujptZ/9c=; b=pQeGh7UktB88bkmc0cMQ/AM5zz
	hl2fA7Hony1ViPOwWDloGQTrd9RUA5bc3dJQfQjO+wKjP0h2suWpt12X/svMV96EBYqbiwuGXt2iO
	0Q+XsgV2wMgcV0rxOfxvRCBbHafvnLfIv89/sR/1ccVsjoC4BtwGRTJsSbboSrWbDZuBdUahotrI2
	kMDE/deYM/TZ1poKNCgzejrWnWgcBdXq5Sqr6dWHY7fnHqPmW//VuZqI05QsGHbuHJbfqaHn62pAZ
	MgeAwHydfXv+0hjEGG1tdVwbqa7YHS05HqjfcIKQJYOl0wCaUviZnD2+DNfJYl/Ve3bhxftcHbc8k
	TwufcFtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEsg1-00C7fH-JQ; Tue, 01 Feb 2022 12:54:29 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEsfy-00C7e6-O1
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 12:54:27 +0000
Received: by mail-wr1-f49.google.com with SMTP id e2so31925154wra.2
 for <linux-nvme@lists.infradead.org>; Tue, 01 Feb 2022 04:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H6dFyOO49Ui+f7RUWksXFpkOOVwnIUDL/r7ujptZ/9c=;
 b=heURQk/oRsbAWzBwct+oO2wsmZSgvNuZfaTAEo7lmAzvB9oVQ/VN78Du1tXyNR2xyg
 ikSGxUN0oZsCLiVj2R9Ry9MaR1ag77m6w6Q6dqL29ZNQAjlZbepA7ixPJdY75AX17vTW
 9EAS139/2CiGs8wnkk7vZ5YxAKurNyAcC3kDWJI07DpCDLo9FJ6wj+eVMdnGihf1PluE
 mI11PBpVoEMzM8ms90kxY65coTjjXJbgbCI8DnAso69ad+4A/eW/Txc1UdosIykMppwM
 zBP/b7nbBPxWjcjrD4DDLIj1wtGuQW16Ug9iLcrbQpOPAVtAhsIW3B/iGIYy7UFiyAdc
 1lKw==
X-Gm-Message-State: AOAM530t0//sejh/ghxUf6rlJV5BH606gLkhelX48GuCrCC44zE1tYYn
 upuxTbtYyhoqg3WTd4YyXxbBAF4WntU=
X-Google-Smtp-Source: ABdhPJzLXfnPoydXgACH6er6JKupvgvaKWo8DWpI9iu94tB+a7BiSWOjhpTNrLnQcnWed0LJ/CO1QQ==
X-Received: by 2002:a5d:4406:: with SMTP id z6mr21494663wrq.544.1643720063849; 
 Tue, 01 Feb 2022 04:54:23 -0800 (PST)
Received: from localhost.localdomain (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id x4sm14993878wrp.13.2022.02.01.04.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Feb 2022 04:54:23 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chris Leech <cleech@redhat.com>
Subject: [PATCH v2 0/3] nvme-[tcp|rdma] fix for possible use-after-free
Date: Tue,  1 Feb 2022 14:54:18 +0200
Message-Id: <20220201125421.177942-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_045426_822882_DEEED2F0 
X-CRM114-Status: GOOD (  13.02  )
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

A few use-after-free reports were seen in the wild with nvme-tcp when testing
ctrl reset and error recovery under load. Analysis shows that the exact same
use-after-free can happen with nvme-rdma as well. This patch series addresses
these issues for both.

Changes from v1:
- Move ctrl->state check from driver(s) .submit_async_event to core
  nvme_async_event_work (so need a single patch, not one per driver).
- omit queue state from the check - it is redundant, the ctrl state
  check is sufficient

Sagi Grimberg (3):
  nvme: fix a possible use-after-free in controller reset during load
  nvme-tcp: fix possible use-after-free in transport error_recovery work
  nvme-rdma: fix possible use-after-free in transport error_recovery
    work

 drivers/nvme/host/core.c | 2 ++
 drivers/nvme/host/rdma.c | 1 +
 drivers/nvme/host/tcp.c  | 1 +
 3 files changed, 4 insertions(+)

-- 
2.30.2


