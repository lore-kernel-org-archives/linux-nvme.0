Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898ECC001DF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 14:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+sWng06Wo/Nny2+CyT7CWRumH+vjAEiunGWEQTjIgPY=; b=yurXkxJBYQaKCimTlK6SejYqm8
	RNoMSHUoSQ4F/1OWIuGLn1tEvcrPoa/ZdHXKHslVu0lYjXKNmW3w7FLn4tWtfclt59ou0fCNxmuhn
	EOsHGO3Te7fl4VO8ebfMA7IfD3OMMspIQ53RfD/S75PRkfeV7qNCY50oh2G0d3xqszWjCOngPnW2v
	YPFw7XGe+z3wSflmegseV9VGKebkIivMhTO4sGPfX0+peoRcBUJ+JD1AL91ZFVijgbCe0AKfpeIgI
	/qUV6vh35EKgravOZx8yUX6qvN8087OD9/lX8PtmnCrno6EzaoAoAda4e0jFgy64RtPyfKHYG3xI3
	pTi5Oa4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtqS3-002UNh-34;
	Fri, 20 Oct 2023 14:26:11 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtqRw-002UKh-1b
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 14:26:08 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 5F7C81F86B;
	Fri, 20 Oct 2023 14:26:02 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 285072C8A9;
	Fri, 20 Oct 2023 14:26:02 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 567A551EC193; Fri, 20 Oct 2023 16:26:02 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/4] nvme-loop: quiesce admin queue on failure
Date: Fri, 20 Oct 2023 16:25:59 +0200
Message-Id: <20231020142600.47246-4-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231020142600.47246-1-hare@suse.de>
References: <20231020142600.47246-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.49 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.20)[suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(0.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[5];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-0.00)[24.93%]
X-Rspamd-Queue-Id: 5F7C81F86B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_072604_707392_5DCCE0A1 
X-CRM114-Status: UNSURE (   9.76  )
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

We are calling nvme_unquiesce_admin_queue() in
nvme_loop_configure_admin_queue(), but don't call
nvme_quiesce_admin_queue() on failure.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/loop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 48d5df054cd0..e1b8ead94575 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -379,10 +379,12 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 	error = nvme_init_ctrl_finish(&ctrl->ctrl, false);
 	if (error)
-		goto out_cleanup_tagset;
+		goto out_quiesce_tagset;
 
 	return 0;
 
+out_quiesce_tagset:
+	nvme_quiesce_admin_queue(&ctrl->ctrl);
 out_cleanup_tagset:
 	clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
 	nvme_remove_admin_tag_set(&ctrl->ctrl);
-- 
2.35.3


