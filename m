Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68264C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 27 May 2022 08:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oq/vZ7XghI1mZ4NQj5jbB50AvR+Ej+9P8dEWe+23+pU=; b=cUAzyQRtyhDP4uGgw4osrl51EN
	4txwbCJUuUx4fnVD+6Ezuc2A4yXOryCrkQDbY2xCxEtqviW9AoqvsPUhTBDiuGamHsVvDqgqKbSfG
	5z9TnehR7Wp+/V4+0LzS/7rXiijixEfNvOKPD8KvG+BR6MUys/T6gBTxnOH3ukoM0rnfoZJGSrbnQ
	pBtqQjXzQpMzow1a313/HcGeSXKWO0+cc9aoK1Y/FnALV+X/RcwPH3br1dwVQLTLWJiaIPB2ucneO
	Bxd3EXImMKC9vga+QZpoZuiwpNTtZAQMVxH3Zrf0/iAYfZn2xAU117mttYGEC7j6ymx978RD/9LmL
	LrXdWsgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuUyE-00GwRc-L1; Fri, 27 May 2022 08:05:18 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuUyB-00GwP6-Dc
	for linux-nvme@lists.infradead.org; Fri, 27 May 2022 08:05:17 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 4940221A95;
	Fri, 27 May 2022 08:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1653638713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oq/vZ7XghI1mZ4NQj5jbB50AvR+Ej+9P8dEWe+23+pU=;
	b=HhqWXhaUlLFwhGBhs/sb4E8uNbOLm6Qi0E8pkMt23219hE+Mb4pHazGn0c4ZGa+yXI8XZq
	/tHklzzCSn5NS+1ixRHusgv4EnMv1OLmjUUu3RF2fnWYB3a9Z/hI6Vd7AC3QQCszx4h/p+
	F8aWth+OB/t4v6M4v0lGID23HoiIGa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1653638713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oq/vZ7XghI1mZ4NQj5jbB50AvR+Ej+9P8dEWe+23+pU=;
	b=gRilCD0I2ZqcXOE2iRSwAWbjbk52rnRDQNYj2UbHM3PEo1aoyvKMNWN2lcywzlzhr0bwGH
	hjiLzMWnA28UXfDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 3B9AE2C145;
	Fri, 27 May 2022 08:05:13 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 2FFD0519471C; Fri, 27 May 2022 10:05:13 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 3/9] nvme-fabrics: decode 'authentication required' connect error
Date: Fri, 27 May 2022 10:04:51 +0200
Message-Id: <20220527080457.90855-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220527080457.90855-1-hare@suse.de>
References: <20220527080457.90855-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220527_010515_728486_1C2A7F4E 
X-CRM114-Status: UNSURE (   8.67  )
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

The 'connect' command might fail with NVME_SC_AUTH_REQUIRED, so we
should be decoding this error, too.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/nvme/host/fabrics.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ee79a6d639b4..953e3076aab1 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -331,6 +331,10 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 		dev_err(ctrl->device,
 			"Connect command failed: host path error\n");
 		break;
+	case NVME_SC_AUTH_REQUIRED:
+		dev_err(ctrl->device,
+			"Connect command failed: authentication required\n");
+		break;
 	default:
 		dev_err(ctrl->device,
 			"Connect command failed, error wo/DNR bit: %d\n",
-- 
2.29.2


