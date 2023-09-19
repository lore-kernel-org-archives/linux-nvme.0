Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D59CD3432
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Sep 2023 03:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xSjnYJ6kacZY7UCZLdel3UJ+ItlAuPMrAohzlcPsg08=; b=Qvy7h45LR7iKrVJkvT3jyo9s2B
	Oz3Rel7dcfqxjZUPbxRBPweYdQEw9QhebI+vpYtlqGBVObsNFqAiGEnkjIARN+rDJjvVhtS8ApNtJ
	novi8bGg9WTaLAHTxuzTIDcimc3qG3Wo+A+fEIIOgDS76Lmrhd3Pbjnx04osn2ysqFRHg5F33dREG
	kTmtUxyv1CRSXuJNCE+MJRgnA2d/5Yk0PAL1te7JzZnxPWL/uFx+AnPfYRG0Y5iFlq13j5gyhULsF
	ukTGdyWMrfMrCXJZWE1gvJM1ZuOZdygAOxCmRl+cFm9HdtTgNLPgPCdtlymsiABdCi+KcVnzZ77wG
	y1S766WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiROb-00Go0H-1t;
	Tue, 19 Sep 2023 03:27:29 +0000
Received: from m12.mail.163.com ([220.181.12.215])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiROY-00Gnzp-1n
	for linux-nvme@lists.infradead.org;
	Tue, 19 Sep 2023 03:27:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:Reply-To:MIME-Version;
	bh=xSjnYJ6kacZY7UCZLdel3UJ+ItlAuPMrAohzlcPsg08=; b=UFxUY6tZ4d52P
	CsUT+pL3PPmJeKgcGP6c0u1APPPLIv7DgYNbQsD4gyzX0Kmnz5A/gqe3vdCmfkaX
	aqccK/p+BbGD/GumOmAZFWmNRzDq6C+NASiknZpvJwY2Z8KiAISpN8CDVGKDMnbi
	yX4+d7b9lAPidvhz0FX64GemA18nAY=
Received: from localhost.localdomain (unknown [183.192.130.204])
	by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wB3Lij7FAllZePxCQ--.10947S3;
	Tue, 19 Sep 2023 11:26:55 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: chaitanyak@nvidia.com
Cc: ping_gan@dell.com,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	jacky_gam_2001@163.com
Subject: [PATCH 0/4] nvmet: support polling queue task for bio request 
Date: Tue, 19 Sep 2023 11:25:39 +0800
Message-ID: <cover.1694592708.git.jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230919032539.71629-1-jacky_gam_2001@163.com>
References: <28949e52-7db7-4227-6bbd-cb8b627b390f@nvidia.com>
 <20230919032539.71629-1-jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3Lij7FAllZePxCQ--.10947S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWDWr45ur1xZrykKry8Xwb_yoWfKFX_Cr
	10vr9rKFW8uF1DtFW7Cr1UXFZFka1Fvr92gFs0qr45Kr9rury5Jrn2vF9xAw4xAw48Zrn8
	GryUGr4FkrWUWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiyCJPUUUUU==
X-Originating-IP: [183.192.130.204]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiWB-vKWNftq5OugABsQ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_202727_069495_6A203F94 
X-CRM114-Status: UNSURE (   8.79  )
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
Reply-To: chaitanyak@nvidia.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
Message-ID: <20230919032539.IcekBybwGIM7oUgJIA859dJsj-8ODXhxVmJz1k7LsP4@z>

Since nvme target currently does not support to submit bio to a polling
queue, the bio's completion relies on system interrupt. But when there
is high workload in system and the competition is very high, so it makes
sense to add polling queue task to submit bio to disk's polling queue
and poll the completion queue of disk. 

Ping Gan (4):
  nvmet: Add nvme target polling queue task parameters
  nvmet: Add polling queue task for nvme target
  nvmet: support bio polling queue request
  nvme-core: Get lowlevel disk for target polling queue task

 drivers/nvme/host/multipath.c              |  20 +
 drivers/nvme/target/Makefile               |   2 +-
 drivers/nvme/target/core.c                 |  55 +-
 drivers/nvme/target/io-cmd-bdev.c          | 243 ++++++++-
 drivers/nvme/target/nvmet.h                |  13 +
 drivers/nvme/target/polling-queue-thread.c | 594 +++++++++++++++++++++
 6 files changed, 895 insertions(+), 32 deletions(-)
 create mode 100644 drivers/nvme/target/polling-queue-thread.c

-- 
2.26.2


