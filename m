Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8141C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 09:21:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9980460F25
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 09:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9980460F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zwsmm3jf17ATIqukl0bBegvIatOIMpL5LUWSmDmSlmA=; b=agqU6u52HVawjB
	AbSPQaCCJGYrO4QtUIrasbfJs485QnfQ8IVxV8t6uGw3TO6riB1AuXATPk4+bEu542X3MFZPutuM+
	rg9nMQDGoBH9ZW6IFqLnSanLM8JyCpgKPJAC1MjQEzz21vGNCaxjx8M9TIHNYfRCld9MCDRG7rV9z
	cW1LPzO/snomK0pukrS0tRYAn68Gd0e8lXxXySQoQdnZexWbs/nvXNnGQbY3lz0YWX7XaWAfw6x7v
	TFlVveD+BeIgIE0QgPcDPkD1VJb954kycI7M+f3Dur0BfFRTr1287P08DZ8OeTwQ1CU907yTp31F/
	CIN54plE6ch8Eh6qqMrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ4cc-004yof-Ll; Tue, 14 Sep 2021 09:20:58 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ4br-004yXF-FX
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 09:20:16 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A5127200E4;
 Tue, 14 Sep 2021 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631611209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpRcKizLVtNPGJx/gg+Q96tVErFITSxqit8PA8OfLM0=;
 b=UzQTR1Qg7KZtMSidqZo1l9+2DT1RT2Jwzz/ATXhsL98q7cuYvphTn2d2UCjWCeXcjIEF/M
 7SmYs9KU8QVPz7WHvFdHcUFCd4kZQ1d7SOAta1tuDe5v+0OeJUN+o1VUunjsyiqi9msm4k
 7N3iww/bLDdr/fztCO6YpLleIbW9D28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631611209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpRcKizLVtNPGJx/gg+Q96tVErFITSxqit8PA8OfLM0=;
 b=ck+2B+2OA+6rNZrsXvIKh082XDcvrETbzFoey9+LwqPBKgs6Lz/dG3Usc0D8ArhYXFLK9i
 v2A0RCzXS4mqTNAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 9EDC8A3BF2;
 Tue, 14 Sep 2021 09:20:09 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 8E982518E62D; Tue, 14 Sep 2021 11:20:09 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Ming Lei <ming.lei@redhat.com>, Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 James Smart <jsmart2021@gmail.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v7 3/3] nvme-fc: Remove freeze/unfreeze around
 update_nr_hw_queues
Date: Tue, 14 Sep 2021 11:20:08 +0200
Message-Id: <20210914092008.40370-4-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210914092008.40370-1-dwagner@suse.de>
References: <20210914092008.40370-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_022011_877148_745A9399 
X-CRM114-Status: GOOD (  10.76  )
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

nvme-fc is draining the queues in the shutdown and error recovery path
in __nvme_fc_abort_outstanding_ios.

This patch primarily reverts 88e837ed0f1f "nvme-fc: wait for queues to
freeze before calling update_hr_hw_queues". It's not an exact revert as
it leaves the adjusting of hw queues only if the count changes.

Signed-off-by: James Smart <jsmart2021@gmail.com>
[dwagner: added explanation why no IO is pending]
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6ebe68396712..aa14ad963d91 100644
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
