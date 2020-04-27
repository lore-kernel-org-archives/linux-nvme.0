Return-Path: <SRS0=LwVW=6L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE9AC55199
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 12:35:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 882A720575
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 12:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="THVr4QrV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xzq65Uim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882A720575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PmKxYeO4q5iZME4GiekylbBnRsi0kncUzrF4URPAuB8=; b=THVr4QrVyPVWO4
	pT1zs+pa2tewcONa/KyhGBBWdM4U4PVFOeqMWE9o8FvP0CEKIe34dqK8cVFQcJfhcTc17OxjVE7uA
	yY7GBPOpWqklfVAxhLFBUEAsDPO7KhaqWvF1waffxp/GPAxibF6ND+fvkh+151CCfd67kYkgVaqgZ
	vLqri2fRhpkx8GDohkOT1eyuWkphIPEXx3eMa22nDhgZ7g3+eddyfZ6BqbrVp0XN56MydjMQ670kO
	A7y7Krjjk84IA/PAbnOV6LurTIFfjJhZLz66P+5fclGWPNCdBPFgqQipoUO90ky2XMqS679W2CvtS
	/IvgMr00K57yV/2zEK9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jT2yP-0006lx-UY; Mon, 27 Apr 2020 12:34:57 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jT2yN-0006kW-4p
 for linux-nvme@lists.infradead.org; Mon, 27 Apr 2020 12:34:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587990894; x=1619526894;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VFhl5pd1bt6CpJr4PfxQxrl9uO26lhYUX26RETwc4cw=;
 b=Xzq65UimawuJ77zGzKMappairV8EVHBXhC7zkDikB7h1QMVfnUxP0ljb
 Uo1ijgNDBpcixQxAtW+JVThSBaj42Ic0+Zy6PfzpORrcXNYHTj0v2x7tF
 Eqfl34QcGPGIg69sHIHahY+aakjIsft4CH3UjYXabBWrMbp0qpls2qptB
 Hgu41Z2o8OZOaYJTnsGowVrigbepVj6z6l0tA8AoiD8aaI7gx2aDEY4k8
 GZ8P8Nr4IU3r1M9pLWtmZKOcVHcivwoA/bh7+niDOl6ukdaP59zSJKrEW
 RhWUCc3lAy84tbp422qh4DOLHMusoEbqZanmy5D9gTdJD49HwoKTpZmMt g==;
IronPort-SDR: HaoYwIFyc4OqVJjvqjhRzc8nUcGKUx3jOgtKS4OusPjXqAsPk5z+l0MDM7E4hrxu1p7UbUksos
 RFfnykPDwSlZlvAeGmnxmRZXeb6nwoU2ldmDo5PuUALkJJmPZjYhY6EvyXmR6+KomAPiGWj1mW
 B4pTmmF8e6gKbdianunRUwvTeLBvFekmMDby/CA1CSRJNnPyNrHvZy6lU872DLMLcSyIhHVkv6
 CXcx5ieWkpXLyzCSZKNuCt6rO0sLYDkrpoxfRVwi8QB4dtipt0gQ4MUu0iScgAuUrvDrcVi/EU
 KnU=
X-IronPort-AV: E=Sophos;i="5.73,324,1583164800"; d="scan'208";a="245018832"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 20:34:51 +0800
IronPort-SDR: +m6ajJH9rmnPEkcoE4do01VQL+ZvouqsIl9fvfW0G1SRwy8ucEtyQmNlFzC/M8Hu4Q5LZjCm29
 +VKQoW6vL+b1AQLqJa3Sw9iLcNNndUPaQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 05:25:32 -0700
IronPort-SDR: joVpwLHLD6k+JizYgH/iGyPlWfrkPSlUPtw35O+L9V3zdtYTZtit5oZ5/epw7Pjc43LN0IvG4Z
 Dz+PMn7H5Bzw==
WDCIronportException: Internal
Received: from th5m0yyf2.ad.shared (HELO localhost.hgst.com) ([10.86.56.126])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Apr 2020 05:34:46 -0700
From: Niklas Cassel <niklas.cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Igor Konopko <igor.j.konopko@intel.com>,
 =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] nvme: prevent double free in nvme_alloc_ns() error handling
Date: Mon, 27 Apr 2020 14:34:41 +0200
Message-Id: <20200427123443.520469-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200427_053455_196779_8E58BE51 
X-CRM114-Status: GOOD (  10.21  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <niklas.cassel@wdc.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When jumping to the out_put_disk label, we will call put_disk(), which will
trigger a call to disk_release(), which calls blk_put_queue().

Later in the cleanup code, we do blk_cleanup_queue(), which will also call
blk_put_queue().

Putting the queue twice is incorrect, and will generate a KASAN splat.

Set the disk->queue pointer to NULL, before calling put_disk(), so that the
first call to blk_put_queue() will not free the queue.

The second call to blk_put_queue() uses another pointer to the same queue,
so this call will still free the queue.

Fixes: 85136c010285 ("lightnvm: simplify geometry enumeration")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 91c1bd659947..f2adea96b04c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3642,6 +3642,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	return;
  out_put_disk:
+	/* prevent double queue cleanup */
+	ns->disk->queue = NULL;
 	put_disk(ns->disk);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
-- 
2.25.3


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
