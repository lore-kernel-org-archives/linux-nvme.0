Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF29C47094
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 16:16:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA366143F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 16:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA366143F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nCdSI69lMdxOGYTGVkG1qXuiJXClS5l/A3JMS+EwG6M=; b=3EogO+/GYTIq/V
	6AWpCUo+8fgP6oYH2srP5K2FYUoMaFdM+dgOhARab+p9batLL3Sv2lLHRE4fnQNZM10B+GboaVaRl
	8ClaQ9gvfp9Cs7uXNDJ1GVEutkaO9a9CRmRr7w0/c1WKeOtHJWFZ/59vehR3fSt07v/CZONen5Vz7
	ObKo0hfpR1yBEmJKmkr9Kxdi+mWdNihM3atlQnhiojr7xacGLf/HDWGqILa2R96xNgn2LjrXxvKW2
	973E52iklFBlCM4G1kevuqHSpZ6u+VKD6t+6cNwUh268JHVUMVrukKwpWrSPVs2bUCDq6CmWUPeyb
	uI7u9P1SD0Y5Qan553aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqHvD-004QU4-Lu; Mon, 07 Jun 2021 16:16:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqHsu-004Owt-BD
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 16:13:56 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5090361417;
 Mon,  7 Jun 2021 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623082432;
 bh=x1MZ4T89cpK8WojkI5GTgel4Y/xWbJa32tpk/siI8tI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CjfQvFH9sa1aAavj2lXbshNGm+djsQzOlGiMHk7kSpZ5RPIYn88zsneVTiqriGPv9
 zC+6lQ78OtTHRsB/cDkbcUj3pnON+u6ziTCIINdQQH8q7Ju7T8DbKkxzYIEjlPNDIQ
 48gMeNWcLjyGCE4diewV0ZTvCcmO5GenB7A1bsskFHrvd/IKQ6DnqJ6vsqRa+7yOg4
 HDOmTYM9ISxk2bsIoVZIwPRfrzmBe8Dw/AcQ/iyvW1LAaSZrRt415cDKg5Fav7Ir3d
 /hzepQLVaHcRpsm66gJF5R2YhTGBih+uwF1QsUc0u8DyWSRehw7oXRBu7c+J3ErTHC
 yhFvvppxcmvHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 26/39] nvme-loop: reset queue count to 1 in
 nvme_loop_destroy_io_queues()
Date: Mon,  7 Jun 2021 12:13:05 -0400
Message-Id: <20210607161318.3583636-26-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607161318.3583636-1-sashal@kernel.org>
References: <20210607161318.3583636-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_091352_441354_F0FA548F 
X-CRM114-Status: GOOD (  10.11  )
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

[ Upstream commit a6c144f3d2e230f2b3ac5ed8c51e0f0391556197 ]

The queue count is increased in nvme_loop_init_io_queues(), so we
need to reset it to 1 at the end of nvme_loop_destroy_io_queues().
Otherwise the function is not re-entrant safe, and crash will happen
during concurrent reset and remove calls.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index b869b686e962..1d3185c82596 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -287,6 +287,7 @@ static void nvme_loop_destroy_io_queues(struct nvme_loop_ctrl *ctrl)
 		clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[i].flags);
 		nvmet_sq_destroy(&ctrl->queues[i].nvme_sq);
 	}
+	ctrl->ctrl.queue_count = 1;
 }
 
 static int nvme_loop_init_io_queues(struct nvme_loop_ctrl *ctrl)
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
