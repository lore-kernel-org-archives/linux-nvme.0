Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9C3C2BC11
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 13:04:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF34B2222B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 13:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dFG1G2fU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3XrHdKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF34B2222B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2w9ccypr4CrfWWOamAWVOUfDTG5e317HBnzCfO8ai+Y=; b=dFG1G2fUCKwOjTddpPWMYLk3b
	GVJ+siDu3tUOJInZSxd14dsLHl3tMW3MPH2Wo1xCwzzt20Xz+7/CdT/pXEfv6WzUy0ThIWDgSO3A1
	/KmNBDquyme5QEz3B0G1XLDt0eJz+2PTnubbiOrsEU0sTCl5dY6Dii4PT0ubZ9wM7hoXEdVxt0LXw
	8rp7hUYUNVJ4B7ZS7CZkIgzDFB2HTkh025NQ3fyxfuPJMcDOKo7tVExKa+BP+UoBXx60jBQle1EF/
	KLSgm7v5buMPOpcPI0pWsNlmCIKdDkYdKnFNFbUKmGuW/Qw/sMVAfu6W7JmO7t4ahNsGhD1RosLZ2
	oOLnmqb2w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHo9j-0002lD-NG; Mon, 14 Sep 2020 13:04:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHo9g-0002kF-Jp
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 13:04:25 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3AB8E2220D;
 Mon, 14 Sep 2020 13:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600088664;
 bh=9HscjCgciwipmMzEmC04n7HE2tru8sD4dggZwWpiqAo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F3XrHdKBcfSPSCheyp8/BAQEozUmxpL5pGq1w3CLOdwHVpoOKFGm0fxLnhMpPvXNV
 p2EEWyJi0JhoWnpHmaaN0hNVKScAHdEQ0AgQYkyNbTlwhWMDPdRdzlMjSxgkqK78Qe
 yE1NWQq9Em2gATysF5ix6mBlbMOyqJDcykEisUWM=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 21/29] nvme-tcp: cancel async events before
 freeing event struct
Date: Mon, 14 Sep 2020 09:03:50 -0400
Message-Id: <20200914130358.1804194-21-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914130358.1804194-1-sashal@kernel.org>
References: <20200914130358.1804194-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_090424_718189_0E7423B9 
X-CRM114-Status: GOOD (  14.76  )
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

[ Upstream commit ceb1e0874dba5cbfc4e0b4145796a4bfb3716e6a ]

Cancel async event work in case async event has been queued up, and
nvme_tcp_submit_async_event() runs after event has been freed.

Signed-off-by: David Milburn <dmilburn@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a6d2e3330a584..e17f71e69f6ec 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1566,6 +1566,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 static void nvme_tcp_free_admin_queue(struct nvme_ctrl *ctrl)
 {
 	if (to_tcp_ctrl(ctrl)->async_req.pdu) {
+		cancel_work_sync(&ctrl->async_event_work);
 		nvme_tcp_free_async_req(to_tcp_ctrl(ctrl));
 		to_tcp_ctrl(ctrl)->async_req.pdu = NULL;
 	}
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
