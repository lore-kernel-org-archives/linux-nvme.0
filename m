Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E181C5DF81
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 15:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sTS3S21AVaGPg1KNZfUBi7GL9TMq/vAFdOnL6DwUes4=; b=feV3JszeOFNqWvu6Otdg2i6AL9
	1L3rdn+i/Qj5sFXCpr6xzqqSlxLVUUtGy+cjGQWh2kZzmtHkDzCtvTZ0kk7wYpdFHwQxbpeVG5tq4
	Uxetif9nDddg78kPUTLxPZaL6lZ9/Z/Vi5/fStslChnrigxvd6FWZHDKRLQ09WJfOPRSckrwQDzeP
	6OCna7/XDnyPwZ6C1ED3Q1t2C8lSgN4Rpo+R9qmMwxRcHGyHiIqYLzNTtGlwZoIDJfL9W2dy/DY96
	XlK/emCJh1VAIcHC1kOazUNXwkjnxEyN4IQjKjlBfE+dXBtlrOGoTq8nYlbwh8oScH4y67kKwblxx
	ImcaCepg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiav-0000000A7u6-0dBo;
	Wed, 19 Aug 2026 15:52:49 +0000
Received: from mail-m49198.qiye.163.com ([45.254.49.198])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiar-0000000A7si-1Sqx
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 15:52:47 +0000
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a95ff6dd;
	Wed, 19 Aug 2026 23:52:39 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v2 0/3] nvmet: avoid recursive configfs open
Date: Wed, 19 Aug 2026 23:52:25 +0800
Message-Id: <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01ab97e2903a1kunm38a93da01445a1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGR9NVkhMSUIaQklJTRoaGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TrOoaB0u/vLbkxcd9ooY+sYodz6ttLvfP206kDx8cLWSSNx8PVI2XRFPXlVdMotj6l702Ii/i/lYT04z6vblJybWkFwUjtRXUEvGomLf7937ysdjHK3MBTn56bOCS+Gg7IHg5ofaqi/++Y9ed3bUl0Rvr1RAIr7MdGWQtJHEpDE=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=sTS3S21AVaGPg1KNZfUBi7GL9TMq/vAFdOnL6DwUes4=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_085245_986502_31CDD362 
X-CRM114-Status: UNSURE (   6.44  )
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

This v2 moves the configfs path check into a shared helper so nvmet can
reject configfs-backed paths without string comparisons, then reuses it
from both nvmet open paths.

Runyu Xiao (3):
  fs: configfs: add helper to identify configfs paths
  nvmet: avoid recursive configfs open for file-backed namespaces
  nvmet: avoid recursive configfs open for passthru

 drivers/nvme/target/io-cmd-file.c | 20 +++++++++++++++++++-
 drivers/nvme/target/passthru.c    | 17 ++++++++++++++++-
 fs/configfs/mount.c               |  6 ++++++
 include/linux/configfs.h          |  2 ++
 4 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.34.1

