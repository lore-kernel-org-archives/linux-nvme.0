Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAF8C47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 16:35:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB2461E44
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 16:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB2461E44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v2PL6Gi6lWsjQa2loBQxOEWEo8O5jZKnhJUCZsmO+30=; b=5A/Yseo8hhmlf8
	fZ9NSA+QRCrP/rGHctrBM1GU2MGe3886A56CbN2mnSIZC0FHlEAkgoAkPupUVdeCnj3sIG6A1Dwpl
	vADY9VH4Cll0dF2yeObXsRzX80OD9N0bsfjTt8bZnoF2lCnZzaIGMSo8sDqr2Jw0D1L5HIOmVu4r+
	DZ/VfkByLi/LoKow71wRUy7VkwB1Ph9Tjggt9gwXinQlE8CgVpWqoAT8ZmX0FYwhKBh1nF6UFSiKX
	S6ltkngbEFNoiIxQE+d95sDL2mc5tYl1+PW5ex9h6jKt2+mZVz5FJTStxI19wczSvecY5Lr76U/Gi
	ZpAp817fwEYXzcVa1wbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqIE0-004Xwd-QC; Mon, 07 Jun 2021 16:35:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqHuY-004Q7P-Oa
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 16:15:36 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1C7D6192E;
 Mon,  7 Jun 2021 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623082534;
 bh=+AUXDUczjuSawvCTHOIWXEs386Lj8FbWpVxfUswMffo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YKwlZryFkmnOKRRTJkMnysvXLs1vwsIP8FR05HoGvUGINg7T6VUvgLvTuJ7Ec/Uup
 WPy6kTRyuD1KRx9W8gwJMp2G0IFMJJYo7PUJYpJ3CkLaLQ7twcB2OnPA4UYVxeuPko
 reOmR4U9zHvD1C8iv70cWTo+74frbHoJWIm9vPWy+7RgFfrptjdPBCfzM7eBivcjI3
 4aSu22/B89WFgasNSPJcnWlmg9sq2JiEXdr/Zc+Hb2KmY2H9Fsx6bFoIvSC1q5lYuW
 T9Hs7j4oPD15jsUV8+VhX5r/071I1nPYG1ZxyVtAGq2W7DYr2JGEDqbzdAfW4+PgoN
 w1N6uvVTv9t2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 12/18] nvme-loop: clear NVME_LOOP_Q_LIVE when
 nvme_loop_configure_admin_queue() fails
Date: Mon,  7 Jun 2021 12:15:10 -0400
Message-Id: <20210607161517.3584577-12-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607161517.3584577-1-sashal@kernel.org>
References: <20210607161517.3584577-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_091534_858305_CE013AC6 
X-CRM114-Status: UNSURE (   8.66  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 1c5f8e882a05de5c011e8c3fbeceb0d1c590eb53 ]

When the call to nvme_enable_ctrl() in nvme_loop_configure_admin_queue()
fails the NVME_LOOP_Q_LIVE flag is not cleared.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 5f33c3a9469b..963d8de932d1 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -430,6 +430,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	return 0;
 
 out_cleanup_queue:
+	clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
 	blk_cleanup_queue(ctrl->ctrl.admin_q);
 out_free_tagset:
 	blk_mq_free_tag_set(&ctrl->admin_tag_set);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
