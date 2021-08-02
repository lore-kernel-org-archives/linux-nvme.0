Return-Path: <SRS0=aESL=MZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220BDC4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 11:27:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E954260F36
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 11:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E954260F36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R5qldSoOk0x5WG4hPi4KDmYhhAFiZFckkyCcNAX1Qaw=; b=IAmsx7ZdHPR8e8
	7/hyh//VN3LPe563H3kWUrlgmYO977zdKrZ6ON6ldRxhwaZ+fPXQpqmcIP+b64/EF6+2eycQ6kqOE
	m0DclKh5Rp2lcVS0eFqzTODe9MI/OflLEM2ENM38VNmMnXhCdyoQJAA56eSXmTkxdstRPiJomGeTi
	yvQYCHTuUaBEyG0EiBGWmgMFCANbEqwKDzgMbV52QKiHroVDSYk+P+gHDphQ/dcPeCZcwRXDwZLsj
	40Tg468lXBXEBwHM08ezQoGTuxu//u4YZ3Ue+YvxBZlbrXOf5vxmRyjbihLQYb1HlhdIqg5cg4iY7
	l6yYfCT9y17MWnoaOOlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAW6T-00FvpM-Bs; Mon, 02 Aug 2021 11:27:29 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAW6B-00FvfJ-6s
 for linux-nvme@lists.infradead.org; Mon, 02 Aug 2021 11:27:13 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 1542F21EED;
 Mon,  2 Aug 2021 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627903628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuFuvhKlUfFYXf6FmlE9wh0koABi63V3tWPF92dXgDs=;
 b=T+MCcYPZkMEz3giv6QkqVZ1zrxfHWKkAC2gT3JhJf7eVaG2+2yvvod+t/C5LZxwiO/NBtS
 YuUXvL/fXmi/4a/D2O2/5QXWnJpyMF0iuoVSjmt0UHaKxeklDfGUpIll2CU6wDxcfgDCTo
 iVUhQtOw+W90Vbu0/PAU7ZOKaiQX7P8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627903628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuFuvhKlUfFYXf6FmlE9wh0koABi63V3tWPF92dXgDs=;
 b=IF7WxU6P2YZflUcw3M5+xTBNQ5tqbzJJZma9sxSxUo/Ry/G4P3Na54uVIgiZP8sXs2PYD8
 kCXgGf0+VMdcZ/BA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 00E2CA3BC8;
 Mon,  2 Aug 2021 11:27:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id EC323518C0B0; Mon,  2 Aug 2021 13:27:07 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, James Smart <jsmart2021@gmail.com>,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
Date: Mon,  2 Aug 2021 13:26:56 +0200
Message-Id: <20210802112658.75875-7-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210802112658.75875-1-dwagner@suse.de>
References: <20210802112658.75875-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210802_042711_458844_B679F301 
X-CRM114-Status: GOOD (  13.62  )
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

commit fe35ec58f0d3 ("block: update hctx map when use multiple maps")
exposed an issue where we may hang trying to wait for queue freeze
during I/O. We call blk_mq_update_nr_hw_queues which may attempt to freeze
the queue. However we never started queue freeze when starting the
reset, which means that we have inflight pending requests that entered the
queue that we will not complete once the queue is quiesced.

So start a freeze before we quiesce the queue, and unfreeze the queue
after we successfully connected the I/O queues (the unfreeze is already
present in the code). blk_mq_update_nr_hw_queues will be called only
after we are sure that the queue was already frozen.

This follows to how the pci driver handles resets.

This patch added logic introduced in commit 9f98772ba307 "nvme-rdma: fix
controller reset hang during traffic".

Signed-off-by: James Smart <jsmart2021@gmail.com>
CC: Sagi Grimberg <sagi@grimberg.me>
[dwagner: call nvme_unfreeze() unconditionally in
          nvme_fc_recreate_io_queues() to match the nvme_start_freeze()]
Tested-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 133b87db4f1d..b292af0fd655 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2486,6 +2486,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * (but with error status).
 	 */
 	if (ctrl->ctrl.queue_count > 1) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
@@ -2966,8 +2967,8 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 			return -ENODEV;
 		}
 		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
-		nvme_unfreeze(&ctrl->ctrl);
 	}
+	nvme_unfreeze(&ctrl->ctrl);
 
 	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
 	if (ret)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
