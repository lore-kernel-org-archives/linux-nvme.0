Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29036CCF2DD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 03:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nyPLhLnF9T9518o2UneCzRtJlrrg/wdkORxySMDG/Jc=; b=CKYZHv1YX1CPHAI3C5rMw/USxA
	8gft2yk7fCbpzP2/5RdFlb5IpnaZp8SSAp9wotGmZChrbDe7SX452+PnOHknaH04HCn8Z5L8brhMb
	y4CAw4NtrLwi2KaQozpIm+glSciqmHx9AB14+3D/rojFA7L3B/Pe8vMLVwI6lCyJv73r4U3SSJSL3
	fHqKeBBbzdnx4GPe7ks7Z5qA8Yyi4gL2rKOxxGpSxr41f2GVpy4lZ68nsS7C7282uaajdfe3+n8G/
	nH+s7/BX/QpO6I7R4BoyrXmFZ9R/Tveuwvydv4/FxS5HZq3jUrxF2CuIg8+P5KaQ0UVwi9Ju4X6yl
	tYf1SNrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeB3-00000006Xjh-3CUa;
	Mon, 19 Oct 2026 03:36:45 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeAv-00000006Xci-2eYH
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 03:36:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792380995; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nyPLhLnF9T9518o2UneCzRtJlrrg/wdkORxySMDG/Jc=;
	b=Er67FbxcAe+7glMdbQ2+nNqPGSfjzsClrSd/YqTX4MbWgaZQjaFGOkxcBtAEAKvyHwYwdbnYLwBdATC2KCicSqGFkeFSKAbU45LE4POYYSCyuRp3fkdHKCf+kWJfptQcN+QFpNufA6bRd0jZcMYmCMCUPeTPx4SFY2EqVQILeRw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XD-YSCY_1792380994;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XD-YSCY_1792380994 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 11:36:35 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 06/11] nvmet: advertise the FDP capability
Date: Mon, 19 Oct 2026 11:36:19 +0800
Message-ID: <20261019033624.402337-7-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261019033624.402337-1-kanie@linux.alibaba.com>
References: <20261019033624.402337-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_203637_806480_E8C339A2 
X-CRM114-Status: GOOD (  10.48  )
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

Set the Flexible Data Placement Supported (FDPS) bit in the Identify
Controller ctratt field whenever at least one enabled namespace of
the subsystem bridges FDP.  Hosts use the FDPS bit to decide whether
to query the FDP feature and configuration for each namespace, so
without it the bridge stays invisible.  The FDP log pages are listed
in the Supported Log Pages log page by the patches that serve them.

Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/admin-cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index aad5abdb6ef96..b293ce418e2c3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -699,6 +699,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	ctratt = NVME_CTRL_ATTR_HID_128_BIT | NVME_CTRL_ATTR_TBKAS;
 	if (nvmet_is_pci_ctrl(ctrl))
 		ctratt |= NVME_CTRL_ATTR_RHII;
+	if (nvmet_fdp_subsys_configured(ctrl->subsys))
+		ctratt |= NVME_CTRL_ATTR_FDPS;
 	id->ctratt = cpu_to_le32(ctratt);
 
 	id->oacs = 0;
-- 
2.43.7


