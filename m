Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCC9C43460
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 20:09:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8AF61168
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 20:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8AF61168
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CgOZPNOIJtHJUBrr3oufHDqSvNtkN/yDT/q50RHy5oY=; b=Yz/hXuM7+aGvnRiBzRDrnyEBwQ
	FjEELAJL9jWQ73RFLKxYmGE8s13WdX4q3LM43UEelZLT0HdHYhIs4IP6ZLCmN/1HaYsYUFurKolZM
	dAmgyBa1O4D9c3bbkdG7F+ciB5nPQtZgMIexlN6V/URYXetY2Yz77oAeROhTX3GcpK3XB5FtkLKgG
	WFBDaS6QnDt8ct+qNDJrxt2CPvSLNYs8juvtw2ULsXvpRalG9QYjO59FrfKYVKpG6LzrHu6EtEJwy
	jYXZiMsOUK0CU8jBhRqqZgOwlLOxoScAZVD2cz8T55oEWUES7P1KkpjkRI75viZwvdnpV13+Nu+ja
	1/GavwhA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSQ65-00Dm9r-Tx; Fri, 02 Apr 2021 20:08:50 +0000
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSQ61-00Dm9H-Cd
 for linux-nvme@lists.infradead.org; Fri, 02 Apr 2021 20:08:47 +0000
Received: by mail-pl1-f169.google.com with SMTP id l1so2934320plg.12
 for <linux-nvme@lists.infradead.org>; Fri, 02 Apr 2021 13:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3dwpWREjo4Fa//x6Xdonleo7aiSQbfEpLvexm/DxwVg=;
 b=EaJkKyb5e+29T24B398f7AnlRoZx33tYr66vFww4+taVc4Qbt0nzkvf2A7NKXn54dI
 0Z56K4rQjdrs/2v09ORkgaKTuyp91cZR7haDrZ+7NaIppS1isFl5J72QKdqshM2VBMPW
 mO1NpU9aHKxuiCRgK21OCMcyt1iKMaMU9Wbj+Yqc+KKKUoBXzc6cUCyyp9SyLrc/MmKp
 uc2rZz1Kb0n1MheghEbqe+BNX+SjCEzYbs9eTABOrMcYDCT6uSpXydv0Noab2yVnPgcL
 vef8BhwkstALqntIepWtkovEw+NCanXA/TBwPjHxyTjakbn1zn8hSSHaGNLDwtaT+oYV
 NrqQ==
X-Gm-Message-State: AOAM533jbKSSpTglcB8tnKZo77KrktWFxoHCTh50r/+CQuG05CtWZygH
 nx0RpC054Rpw9db3uzr/bM0=
X-Google-Smtp-Source: ABdhPJx0rt4hE3P6WhMiDsGjg3hsS0NHcCJ545zVm8R9Y0kTVwN3dLQtLRuG8r0EEASq05pVRpg75w==
X-Received: by 2002:a17:902:ea0d:b029:e6:f01d:9db5 with SMTP id
 s13-20020a170902ea0db02900e6f01d9db5mr14031764plg.60.1617394123970; 
 Fri, 02 Apr 2021 13:08:43 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:de32:cc5:ecd7:105c])
 by smtp.gmail.com with ESMTPSA id n6sm5635854pfq.214.2021.04.02.13.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Apr 2021 13:08:43 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: <stable@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH stable/5.4..5.8] nvme-mpath: replace direct_make_request with
 generic_make_request
Date: Fri,  2 Apr 2021 13:08:41 -0700
Message-Id: <20210402200841.347696-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210402_210845_468215_94665DE9 
X-CRM114-Status: GOOD (  22.47  )
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

The below patches caused a regression in a multipath setup:
Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")

These patches on their own are correct because they fixed a controller reset
regression.

When we reset/teardown a controller, we must freeze and quiesce the namespaces
request queues to make sure that we safely stop inflight I/O submissions.
Freeze is mandatory because if our hctx map changed between reconnects,
blk_mq_update_nr_hw_queues will immediately attempt to freeze the queue, and
if it still has pending submissions (that are still quiesced) it will hang.
This is what the above patches fixed.

However, by freezing the namespaces request queues, and only unfreezing them
when we successfully reconnect, inflight submissions that are running
concurrently can now block grabbing the nshead srcu until either we successfully
reconnect or ctrl_loss_tmo expired (or the user explicitly disconnected).

This caused a deadlock [1] when a different controller (different path on the
same subsystem) became live (i.e. optimized/non-optimized). This is because
nvme_mpath_set_live needs to synchronize the nshead srcu before requeueing I/O
in order to make sure that current_path is visible to future (re)submisions.
However the srcu lock is taken by a blocked submission on a frozen request
queue, and we have a deadlock.

In recent kernels (v5.9+) direct_make_request was replaced by submit_bio_noacct
which does not have this issue because it bio_list will be active when
nvme-mpath calls submit_bio_noacct on the bottom device (because it was
populated when submit_bio was triggered on it.

Hence, we need to fix all the kernels that were before submit_bio_noacct was
introduced.

[1]:
Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
Call Trace:
 __schedule+0x293/0x730
 schedule+0x33/0xa0
 schedule_timeout+0x1d3/0x2f0
 wait_for_completion+0xba/0x140
 __synchronize_srcu.part.21+0x91/0xc0
 synchronize_srcu_expedited+0x27/0x30
 synchronize_srcu+0xce/0xe0
 nvme_mpath_set_live+0x64/0x130 [nvme_core]
 nvme_update_ns_ana_state+0x2c/0x30 [nvme_core]
 nvme_update_ana_state+0xcd/0xe0 [nvme_core]
 nvme_parse_ana_log+0xa1/0x180 [nvme_core]
 nvme_read_ana_log+0x76/0x100 [nvme_core]
 nvme_mpath_init+0x122/0x180 [nvme_core]
 nvme_init_identify+0x80e/0xe20 [nvme_core]
 nvme_tcp_setup_ctrl+0x359/0x660 [nvme_tcp]
 nvme_tcp_reconnect_ctrl_work+0x24/0x70 [nvme_tcp]

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Note: This patch does not exist in upstream, it is a pure
backport fix that was just now found. The reason for that is
that this specific issue exists on on kernels 5.4-5.8 as it
was fixed in 5.9, and the patches that caused this was only
backported to linux-5.4.y (which are correct as mentioned
in the patch description)

 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 041a755f936a..0d9d0bebe645 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -339,7 +339,7 @@ static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
 		trace_block_bio_remap(bio->bi_disk->queue, bio,
 				      disk_devt(ns->head->disk),
 				      bio->bi_iter.bi_sector);
-		ret = direct_make_request(bio);
+		ret = generic_make_request(bio);
 	} else if (nvme_available_path(head)) {
 		dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
 
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
