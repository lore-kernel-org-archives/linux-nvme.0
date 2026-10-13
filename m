Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC55CC6B03
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 02:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nyPLhLnF9T9518o2UneCzRtJlrrg/wdkORxySMDG/Jc=; b=Fw7Qo+QVjKhHreOuT3H/ecpMF3
	RrbUbZHD9vIP1b7vYn9ph5ntHFsxLqCz51zFNRw7HikmpfanZtQUlNf6pZhtW8hSFck+nG4bbKbcT
	qEffQcVPBjsgUpnlsK2FmzIJryaZ5qhjJbyihqkIIY6Saq0fKdSJ7NpIuZdAmImBuT47rMjt1FdL9
	nHMkrihPx1zZrcOh2Hq3Am9AzGv8Mu5ai024i5YaXN4G35Ge0l+MapnOGraqOXB/cabNXjS4Vr9oV
	akh3JH6Jid/OxIUu3jJGV4y4citGtdd2Oit8GV3MxZUNtlDiynOf0rxLhx9wDrxuG2FU+EmEDlaOw
	/BkjpSWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGS8z-0000000BmbB-421Q;
	Tue, 13 Oct 2026 02:21:33 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGS8r-0000000BmSg-1IEM
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 02:21:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791858082; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nyPLhLnF9T9518o2UneCzRtJlrrg/wdkORxySMDG/Jc=;
	b=biJIhiC6qOPwVbtACuAa12uHYnfgDEEht8GwGvFpw45wM+h/mY7nj04E3oj/u0CQnHkMMl+WXTEp3lmuj8F7+jnLVAOYeA4W41Qrrsms0Ub8YSgCfQZBmnaF7l7Zifhh0MNLCMa0lnkHIn3zftY50CJe+hkYjRPaRmzL5AH0owo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XCk-8ff_1791858081;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XCk-8ff_1791858081 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 Oct 2026 10:21:21 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 06/11] nvmet: advertise the FDP capability
Date: Tue, 13 Oct 2026 10:21:04 +0800
Message-ID: <20261013022109.1507911-7-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261013022109.1507911-1-kanie@linux.alibaba.com>
References: <20261013022109.1507911-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_192125_505599_7E85140D 
X-CRM114-Status: UNSURE (   9.85  )
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


