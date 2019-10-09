Return-Path: <SRS0=7vxi=YC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2792DC47404
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 18:30:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F378620B7C
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 18:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fbQWzoep";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOLnLFa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F378620B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=093JSHa8Y7Io9HrSHNydxSs6rXNJhpgLPNed8fqT1JU=; b=fbQWzoepVMv0MI
	2LjxhlKY2fz2lTgYQC5hb1mc12hfkICv20/JKs0NfP0tKFToRiVyanLLUKE6kseqDLkAV7GzOunns
	CFcHQa2rovxUrOlzWCN57or8XPhFufKD0Yg69GflaTA3R8eBAkNfNAkN9spo2hbmNYYcsLpzfeyeG
	FVh4vW0k5l5PNRfC78qZm4Zwbfp/yA3qmXtkxlcEdj7dK8LJgtvphL0gDuvPMmMoDk9p128UU6g/L
	ADJthq65enwWtjXvAjca2joIRDBsLqXDfLk9vr5Dj/AuvxM/jJJ6N8UWsLFWsXAZ3sp/6CpPErWpR
	MN7UnnN7aDtdNaYZHo8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iIGjO-0006pD-31; Wed, 09 Oct 2019 18:30:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIFgt-0003xu-6d
 for linux-nvme@lists.infradead.org; Wed, 09 Oct 2019 17:24:02 +0000
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D3CF021D80;
 Wed,  9 Oct 2019 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570641838;
 bh=iezhzlRdqtRKrCvQN3UCRIlAx7UiuWRw/K0Y0zQsiyw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tOLnLFa8Cl5iUN2TYumhSnQqi2c9jspVTPBlnxUOPOLg0OyesX5zrLBaHTIJFfDMr
 9grLIHUjyiLO06Lr3XmqgXpr8dbRqdaDHDLmO1bCf5FpmZqMKjfWLVvFwV6xCMfTiT
 Sd9QMPUtQwc2hUhOxMiPAYGmtXiHb3wYj5U4ktGc=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 20/68] nvme: fix an error code in
 nvme_init_subsystem()
Date: Wed,  9 Oct 2019 13:04:59 -0400
Message-Id: <20191009170547.32204-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170547.32204-1-sashal@kernel.org>
References: <20191009170547.32204-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191009_102359_257660_AE9B96F2 
X-CRM114-Status: GOOD (  11.09  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit bc4f6e06a90ea016855fc67212b4d500145f0b8a ]

"ret" should be a negative error code here, but it's either success or
possibly uninitialized.

Fixes: 32fd90c40768 ("nvme: change locking for the per-subsystem controller list")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 28217cee5e762..ac2ac06d870b5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2513,8 +2513,9 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		list_add_tail(&subsys->entry, &nvme_subsystems);
 	}
 
-	if (sysfs_create_link(&subsys->dev.kobj, &ctrl->device->kobj,
-			dev_name(ctrl->device))) {
+	ret = sysfs_create_link(&subsys->dev.kobj, &ctrl->device->kobj,
+				dev_name(ctrl->device));
+	if (ret) {
 		dev_err(ctrl->device,
 			"failed to create sysfs link from subsystem.\n");
 		goto out_put_subsystem;
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
