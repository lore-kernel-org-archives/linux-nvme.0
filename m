Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267C3C53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 10:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9H/K5nW4Q9GCuFcrVaO7KUp3QJsG6PTeqRG58E18Hqo=; b=Dgi4X1DhUvgNfju++/YTmXrWyx
	p+cP6/nfNB3Cjclvmb4ngj8CgpUTKjrVpWOb/MK3PmTKb8atpY/P/U/mdkNtxFzI8ONUyL+2xHASg
	xyOrVmIusdAgwDDkaPq3NjdOIOpeRoGDgiJDL1mtjEElEjH6V1Wfafy/Svg5yn2FkCcYOKxJRbUty
	5RfiF34/MDk4JBUsiHaHp4qurKLjbw9Hn1LAJCW3Y8pgX+GfJHEL79X/UjcPUwh1GuiidCTdcGU3W
	i0BTvLU6sZMazOmc+JDLWAY4+0pIlJJmKgt7P+n34gnfkKk4BFdLj9qakmmT7uinZbjf4uJU+8plI
	fAWwpTzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp1zx-00000007fAs-0tTK;
	Wed, 29 Jul 2026 10:58:53 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp1zu-00000007f9w-1DzV
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 10:58:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785322728; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9H/K5nW4Q9GCuFcrVaO7KUp3QJsG6PTeqRG58E18Hqo=;
	b=niAt0WEyym5MTS23ZMUOlGUdJhs77xydkweHqzFmFoRU69WOfm7QIzG/DD7HpA+aZ0VHcTcrFbFsjnNPmciAHS7xUq9eGHzxG8a1Z+oNBOZ7TnERz3f7sFUuypED8mkcG0OUA1hiFycq2jFUQ12wxNYXbwT91wI4Q2VExU/7KKI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X820PAE_1785322726;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X820PAE_1785322726 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Jul 2026 18:58:47 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Jay Freyensee <james_p_freyensee@linux.intel.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] nvme-fc: unmap cmd_iu DMA on rsp_iu mapping failure in init_request
Date: Wed, 29 Jul 2026 18:58:46 +0800
Message-ID: <20260729105846.1401843-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_035850_639974_F803E59B 
X-CRM114-Status: GOOD (  11.02  )
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

__nvme_fc_init_request() maps cmd_iu and then rsp_iu for DMA. If the
rsp_iu mapping fails, the original code only recorded the error and fell
through: it left the already-mapped cmd_iu unmapped and still marked the
op as FCPOP_STATE_IDLE before returning. Since blk-mq does not call
.exit_request() when .init_request() fails, the cmd_iu mapping is leaked
for every op whose rsp_iu mapping fails.

Jump to an error path on rsp_iu mapping failure that unmaps cmd_iu and
returns the error without marking the op idle, so it stays in the
FCPOP_STATE_UNINIT state set by the initial memset().

Fixes: e399441de911 ("nvme-fabrics: Add host support for FC transport")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/fc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 04363b9c4489..40f9da2833ff 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2100,9 +2100,15 @@ __nvme_fc_init_request(struct nvme_fc_ctrl *ctrl,
 		dev_err(ctrl->dev,
 			"FCP Op failed - rspiu dma mapping failed.\n");
 		ret = -EFAULT;
+		goto out_unmap;
 	}
 
 	atomic_set(&op->state, FCPOP_STATE_IDLE);
+	return 0;
+
+out_unmap:
+	fc_dma_unmap_single(ctrl->lport->dev, op->fcp_req.cmddma,
+			sizeof(op->cmd_iu), DMA_TO_DEVICE);
 out_on_error:
 	return ret;
 }
-- 
2.43.7


