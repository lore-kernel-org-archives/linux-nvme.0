Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF57AC43461
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 13:04:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DCE22246
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 13:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bLYXx+bs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPveibCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DCE22246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=U2ZdtYRbAUL2UTML+Xz4WSI3ihyCnM7eFYqB9sebeow=; b=bLYXx+bs2vW7ee1BS9IjIGXo2
	sBUXLYSZ0zTGdYBSQrwo3eSq6pMLEAeENPjTKjxItu/Y+mos3BKNcqUpTcLHiUOnQ/lctfJP/cykg
	kLcK5jeTiiuZG7RBQ+/95Z1PC1Z2zRDHvdxP74MANmPouu1ghFAibAZYBxjzdpYCrS7X6BEB9JDWp
	yYC2Fv3dXbyG2ZlslrwqjlBnrqVwpYWN/V5vVEyExPl7gpbcCG+Z+chxpRCZ85Jo4tqLCvqRAqJO1
	7x/ORRErAuNiCmqYoFwVM/GDj+VSKC7oDf0BkZBD2kNgH2xls4S0KvDRJIOdxq0b03cizaLlQ7ywi
	xIXx/IoMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHoA9-0002pi-W4; Mon, 14 Sep 2020 13:04:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHoA7-0002oo-F4
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 13:04:52 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C57B121973;
 Mon, 14 Sep 2020 13:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600088690;
 bh=C87FEcxOQvwbve5njzgtcQ3YGHj3Yux44IZWafvgDVk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FPveibCtGLl3xKhbztRtS06wXlr4S6P3ujvy9nkF+pjbqBZ7yQ/hqMuX156G8tH2/
 AY7pmtvmiuR3L5xCsCJN1M5ZKCZoWDadUleLvQJEufak/SaJpdXv7fkNyBpqONsqL3
 KkOcGradHBe5SBdRyjOxMAACYH19+pr4xxCpw8GE=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 13/22] nvme-fc: cancel async events before freeing
 event struct
Date: Mon, 14 Sep 2020 09:04:25 -0400
Message-Id: <20200914130434.1804478-13-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914130434.1804478-1-sashal@kernel.org>
References: <20200914130434.1804478-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_090451_560202_2E58D80A 
X-CRM114-Status: GOOD (  14.68  )
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
Cc: Sasha Levin <sashal@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, David Milburn <dmilburn@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: David Milburn <dmilburn@redhat.com>

[ Upstream commit e126e8210e950bb83414c4f57b3120ddb8450742 ]

Cancel async event work in case async event has been queued up, and
nvme_fc_submit_async_event() runs after event has been freed.

Signed-off-by: David Milburn <dmilburn@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index dce4d6782ceb1..dae050d1f814d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1820,6 +1820,7 @@ nvme_fc_term_aen_ops(struct nvme_fc_ctrl *ctrl)
 	struct nvme_fc_fcp_op *aen_op;
 	int i;
 
+	cancel_work_sync(&ctrl->ctrl.async_event_work);
 	aen_op = ctrl->aen_ops;
 	for (i = 0; i < NVME_NR_AEN_COMMANDS; i++, aen_op++) {
 		if (!aen_op->fcp_req.private)
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
