Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4E7C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 00:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bbQqD09h0kMDWH3J0zUV/OlX+1yLdEhK5ckTWLr8oks=; b=dlX4RkVzJsg6Hiq5yyMDXt1Azn
	8TZ4c14JIXUlBsPsCSA0Qf/VC1I+DWSoi5+AioVCyHlK1RT3LaZeS8UGpSSIt20SyRKtTmzaikQn2
	rI8ryqwL0lqTJjYmFP0tF5X2Oq1pn5kDTddnSBULBmGKkW8nC9PjxRWlY4zEc/LYjpVbHWU6pSL7o
	5HrtgbiG6P3tXhrk+fLb4AFwIBbF+g5fNsDIVviqHPxZw05h2p/WYUl7P1yssYZcsI3ZjzsGwMtlB
	1rRmfm0okVZqddynASuDVwKjF2/VUXy9lqf1ITw578phbTV9j6ThBzHk0dfkF+wxwkzoLROYB8TCx
	rjEdLjpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oimKs-009zRJ-FJ; Thu, 13 Oct 2022 00:44:30 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oim41-009rKD-8c
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 00:27:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C2B91616EF;
	Thu, 13 Oct 2022 00:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC137C433D6;
	Thu, 13 Oct 2022 00:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665620823;
	bh=QU5vmXNJ3Gr1SJU1WZy8eaBaS35TPYAliopPzIIp1pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYrXnZToejBP5QZ4ZXY0+UeR+bLy9NJ7uOlpZciag0MznXNmKzc+dkgjfV8GRbyaZ
	 jWHN+fockDM8gAcu+kqunhrGy/VyhVna1WbThTBmKB6tIv2IKjpoCIyCAtOc4YlR/k
	 511B6N3yNvqMp4F6FuNw8I4uvpH0b0Ee54BIhHMwfRHqCdtUTd8IMZFKdkxxhK1J6r
	 e5jpUrMBN87DXl5Lx64s3Db7oNpeW+mlxFiDo5IgwLw9PpjIftTa3iBccoXJCNwY9Q
	 Dqgx3gqKmLDoBDZMaBcYXKhnKn4B9NJ7wFWTT1LpCqtp+ROEiDAAnMIMh3B+12CG0+
	 snxmTxVTl4j0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jeff Lien <jeff.lien@wdc.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Chao Leng <lengchao@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 16/19] nvme: copy firmware_rev on each init
Date: Wed, 12 Oct 2022 20:26:15 -0400
Message-Id: <20221013002623.1895576-16-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013002623.1895576-1-sashal@kernel.org>
References: <20221013002623.1895576-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_172705_426021_1B32BB01 
X-CRM114-Status: GOOD (  12.49  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit a8eb6c1ba48bddea82e8d74cbe6e119f006be97d ]

The firmware revision can change on after a reset so copy the most
recent info each time instead of just the first time, otherwise the
sysfs firmware_rev entry may contain stale data.

Reported-by: Jeff Lien <jeff.lien@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Chao Leng <lengchao@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 582c3b190418..986912e680d8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2320,7 +2320,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	nvme_init_subnqn(subsys, ctrl, id);
 	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
-	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
 	subsys->vendor_id = le16_to_cpu(id->vid);
 	subsys->cmic = id->cmic;
 
@@ -2481,6 +2480,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 				ctrl->quirks |= core_quirks[i].quirks;
 		}
 	}
+	memcpy(ctrl->subsys->firmware_rev, id->fr,
+	       sizeof(ctrl->subsys->firmware_rev));
 
 	if (force_apst && (ctrl->quirks & NVME_QUIRK_NO_DEEPEST_PS)) {
 		dev_warn(ctrl->device, "forcibly allowing all power states due to nvme_core.force_apst -- use at your own risk\n");
-- 
2.35.1


