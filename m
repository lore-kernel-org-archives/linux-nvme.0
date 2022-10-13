Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CE2C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jlfuvXWu5SeTxVzVxrBULOJJVXhL5e/8NFuwjavM7A0=; b=egqwR4EKgXYSA/0haeiOIVFaHM
	DQlAnReiDxsQMwWBmQsYULGJdztEN/J6iKawwM7vk3uGJbNNJJmyb0GSLoZU1LsepUffeB+8hplQK
	x0LoiLU88PFZOa1LmwY0Nv8d8WYJYiBXX0kG8llx6Vs1Y5lOSwbJ+ohelH0gpMPTt6+LLRZwGg0dq
	R8w3MK5qwecPc523kyPwVGANJ12jNpiN4sBLz6ms9WnLLkXyrM62mQ7tQ4nF9VrwOE+D7JH4LU/1V
	B8c8kHOulovYfJLyBroR0wRqHvdaGYpHotWbhvrnShcB7vtdPGBZL9tXBjB2V2lw7XhC1QLsOEVbQ
	qOcuyJ5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oilvN-009n0X-12; Thu, 13 Oct 2022 00:18:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oilvJ-009myO-Nx
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 00:18:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5225C61684;
	Thu, 13 Oct 2022 00:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A029EC43141;
	Thu, 13 Oct 2022 00:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665620284;
	bh=5qt8H4mypo9d3J9EVjpniftXE2g7dQ0BL2h2ZP4cgy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l8Ay+NfbXlOGvPtzEXzHRS2yCaKx5YR7ewDRDwybGXaxPaAYRJtYCmlmcNaBvyY4l
	 So5pnjdK12IhrrKT5xaatG11GUaFtOwGJecy6ANX0/8v5fHHa4UU2Rc0scP9BQxdju
	 fkWfH2eh9xVpcPu+uNMQqivVT1qR/NEBlMWSt3ADGtQFJjfz9A6PmaYx+t98mi1dgH
	 1BpXdo+v8xA7eUeWbEYD/aRfP1LB44pZNQDH2WcpS+jkGduwSAXMpSlc+47f2tgZo4
	 mSsZGo2nIyXkVoVUqeb/IPJ+RrK23dfoCZdKYTf29C428TWOXmcdt7WA3aWpVhISCe
	 2KvxC23lGMieQ==
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
Subject: [PATCH AUTOSEL 6.0 53/67] nvme: copy firmware_rev on each init
Date: Wed, 12 Oct 2022 20:15:34 -0400
Message-Id: <20221013001554.1892206-53-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013001554.1892206-1-sashal@kernel.org>
References: <20221013001554.1892206-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_171805_837598_CE8608BF 
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
index 7991d28e6a6a..59e4b188fc71 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2889,7 +2889,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	nvme_init_subnqn(subsys, ctrl, id);
 	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
-	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
 	subsys->vendor_id = le16_to_cpu(id->vid);
 	subsys->cmic = id->cmic;
 
@@ -3108,6 +3107,8 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 				ctrl->quirks |= core_quirks[i].quirks;
 		}
 	}
+	memcpy(ctrl->subsys->firmware_rev, id->fr,
+	       sizeof(ctrl->subsys->firmware_rev));
 
 	if (force_apst && (ctrl->quirks & NVME_QUIRK_NO_DEEPEST_PS)) {
 		dev_warn(ctrl->device, "forcibly allowing all power states due to nvme_core.force_apst -- use at your own risk\n");
-- 
2.35.1


