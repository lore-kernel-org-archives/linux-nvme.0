Return-Path: <SRS0=T5EX=YT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2589CA9EB9
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Oct 2019 13:19:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F2921D7F
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Oct 2019 13:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D12K6IY1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEplbGKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F2921D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TsD07OpqOXAx7HDIL5vEiXq4mMl3Z2d/OHu0BRJhq2M=; b=D12K6IY1/W6bAR
	WJYuLqtfLmNCEptnpJXmIkXXxRbCtda4+6x46j8m+7ioJOEd4G8TR2BMrNLW2t7K6K8W06P2yCPqG
	AMpBNcf/lu0R5HVUIXP9DEWS/iZJdCdFcnmI3qmWReh8UjfnVn/54A88YXSky6VamZfETsBe71Jew
	DBJ1/kd8Qdror6cT56uceb4lpuWcEYA+42gmClPLPT0p3404zOPS5KXPtqF7LF225AV7RmE2MaxZG
	cUxtl4XoHPY3j/+27LUGCk/SyPog1X6cIsBTYxz21XwYvwH6ZIRClkfQTehbDW1jDp0GgEPmA3c6I
	dRh3KHDEubeIT8h66bXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iOLyS-0008Dm-FT; Sat, 26 Oct 2019 13:19:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iOLyN-0008Cx-QA
 for linux-nvme@lists.infradead.org; Sat, 26 Oct 2019 13:19:18 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CF401222C9;
 Sat, 26 Oct 2019 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572095955;
 bh=J02sUj+m/UPBOLsmviY3nnf45uUHrYc2ULlOdHBWVlI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dEplbGKybTebsDeLiGalxBAkO0CoSkzyGEDbm8jJrpb1zl4wirZW+tpV/lEl08LgB
 3EjY3lOqKl784dpdzEWW9801ZZXs56pOsp0CpSC7O+WKQb/J7AZ24IiiL4kR5+aqvt
 KoqzhX4pemOM27niBlr7mj7UIubDrOezoIzryAuk=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 04/59] nvme: fix possible deadlock when
 nvme_update_formats fails
Date: Sat, 26 Oct 2019 09:18:15 -0400
Message-Id: <20191026131910.3435-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131910.3435-1-sashal@kernel.org>
References: <20191026131910.3435-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191026_061915_882405_4126B04B 
X-CRM114-Status: GOOD (  11.05  )
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
Cc: Sasha Levin <sashal@kernel.org>, Judy Brock <judy.brock@samsung.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 6abff1b9f7b8884a46b7bd80b49e7af0b5625aeb ]

nvme_update_formats may fail to revalidate the namespace and
attempt to remove the namespace. This may lead to a deadlock
as nvme_ns_remove will attempt to acquire the subsystem lock
which is already acquired by the passthru command with effects.

Move the invalid namepsace removal to after the passthru command
releases the subsystem lock.

Reported-by: Judy Brock <judy.brock@samsung.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ae0b01059fc6d..ddd5c72a565ad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1201,8 +1201,6 @@ static void nvme_update_formats(struct nvme_ctrl *ctrl)
 		if (ns->disk && nvme_revalidate_disk(ns->disk))
 			nvme_set_queue_dying(ns);
 	up_read(&ctrl->namespaces_rwsem);
-
-	nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
 }
 
 static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
@@ -1218,6 +1216,7 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 		nvme_unfreeze(ctrl);
 		nvme_mpath_unfreeze(ctrl->subsys);
 		mutex_unlock(&ctrl->subsys->lock);
+		nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
 		mutex_unlock(&ctrl->scan_lock);
 	}
 	if (effects & NVME_CMD_EFFECTS_CCC)
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
