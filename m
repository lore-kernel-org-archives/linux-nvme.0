Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4E0C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 11:24:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC6C613A6
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 11:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4BC6C613A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z8KD1GeQ3NImo174e5/0AT077cJM1Tt0+tTUgvMmoCA=; b=uxQcD4iWgzps9h
	WhoVTKjfynbUMHvvzHjGRahJgpqJhqWZAkSF5ypPbLckUFhoawks4GgPj1MczRuxQsqT/PIcS0idY
	wWIuMVi0Pzf8xLPMNxY6boqaCvtaxV7I1+tozCPAXvqjZs159fTnCV3W/m4SfovVU73AnEF0gEzpk
	f44lFXfgrjyPrvSNhiIXEgN61rat25LaUskDG+LsNlI1gV4utF2Uit2SC9Jt18L41F40xbUG5+tL5
	ZCil+D4lDnyJeDmz70nHK9Mlzzyg/PovOyzNNThk0FOhbiLQhjZZQXfkg7gJM+0MMa1nRyKZ+5EWA
	guEz6Gd7XBE57C9mCFBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mI83c-00GYra-4l; Mon, 23 Aug 2021 11:24:00 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mI83W-00GYoe-AK
 for linux-nvme@lists.infradead.org; Mon, 23 Aug 2021 11:23:58 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id EFE1321F5C;
 Mon, 23 Aug 2021 11:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629717832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EayIZPvEx8NBX6gVMYZJJQtq+PDoTIWp/jqWnTRrcoI=;
 b=oRNFq04/+fpitigIPbdiK59exX9c56+BEa8yZNZEXW3Bepbz+MMmxvLcBkbmwN2BfUrjzK
 m7SNRUJefhW2s1AZattSrlP9jgkXiuN3LhG92j+ByhQoeYfu+MbbuCYPlvFVeDA6DszuLn
 yGMAMNlJGrJfc+Nvuk7C/zM/P4R+bbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629717832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EayIZPvEx8NBX6gVMYZJJQtq+PDoTIWp/jqWnTRrcoI=;
 b=tcWvOCqER0uNdYm3BipT7jlGUb5GAnKqoXJIaCXd6EukIj6/aiYxobw3YuPu8xdFO9nMep
 wbaFbKvOD39/6TBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 37286A3BC1;
 Mon, 23 Aug 2021 11:23:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 2257F518D88F; Mon, 23 Aug 2021 13:23:52 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 James Smart <jsmart2021@gmail.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 3/3] nvme-fc: Remove freeze/unfreeze around
 update_nr_hw_queues
Date: Mon, 23 Aug 2021 13:23:51 +0200
Message-Id: <20210823112351.82899-4-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210823112351.82899-1-dwagner@suse.de>
References: <20210823112351.82899-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210823_042354_557637_3EA8E4AF 
X-CRM114-Status: GOOD (  10.88  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: James Smart <jsmart2021@gmail.com>

Remove the freeze/unfreeze around changes to the number of hardware
queues. Study and retest has indicated there are no ios that can be
active at this point so there is nothing to freeze.

This patch primarily reverts 883837ed0f1f "nvme-fc: wait for queues to
freeze before calling update_hr_hw_queues". It's not an exact revert as
it leaves the adjusting of hw queues only if the count changes.

Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 48aaa753be44..b71d0c2d4d31 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2957,9 +2957,7 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 		dev_info(ctrl->ctrl.device,
 			"reconnect: revising io queue count from %d to %d\n",
 			prior_ioq_cnt, nr_io_queues);
-		nvme_wait_freeze(&ctrl->ctrl);
 		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
-		nvme_unfreeze(&ctrl->ctrl);
 	}
 
 	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
