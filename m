Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC62C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 30 May 2022 13:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SKGMcXRlhx1sbQBa6dL60VF1kPSEZc9HWBm6v06zlkU=; b=wRDl6RC9KWsw4yqHiZW2Hb3e3q
	/eDwn3onCkbRwhoxdnn5k7Ea8Vv825J+TltMOCrLZvezxf5DpG3gyds4xvzKmh1bF4RdOE1OunwsH
	RfdED30MslhJvcaGYDIk07nC9Gevmc3eSFksC7PTrEiTkILqM/Xmfk28NVgfJj8QAQrWHu0euHmnc
	2Kbsix1DRLeQcvSeZOdx2axHDm/6H5Qz/THWAI1y2NOdogjg6kCdLmS2jF22Jxz8z9dAGFij7SOxK
	dB1wiEI0uTZZKQN04eXb6YywysCmHpBy7jIzkDM8Qw8E2X4qGvK38WKGxrgcxD6jK5PGJvneLIhol
	512NPuqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvfXC-006kqX-LU; Mon, 30 May 2022 13:34:14 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvfTI-006iV9-EV
	for linux-nvme@lists.infradead.org; Mon, 30 May 2022 13:30:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id ECD5FB80DB0;
	Mon, 30 May 2022 13:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79291C3411A;
	Mon, 30 May 2022 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653917409;
	bh=WsqAai+5P7tpwyoVY6INpxmZB/LvH/u5uW4sHM5kfLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VSfMVjgrpxdwmmvueWj+h53xCVPnIfjDRq+QyeatTAjd9kdpEm62ChPzCDf0xqGC0
	 IbK4EOVBvdfTjdwFMfWMkO/v4hTgAHqwb+RILEuiX5NI0Z3TMWx2GN2+IDAxmxRn/I
	 F6GW2XkAfJUPu+qpNG68z0vyu9TZcfjZ9HGrHZ4w6MQreyqiz+662RrA/wzz3nkFxs
	 TzOSzfKJcZrLCUWm/VamRYo7MsrEPtI1rW6kmPRi3yt7sXyXJVVtq4Q7HhNql2etwv
	 Kx0bXCW8L3QgPSBThv2iKLfLJI3lXwHZYi8SXeGpI7PTdAeG+m2garoMuT6SaxB3pd
	 OojCp5tp+9FVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Smith, Kyle Miller (Nimble Kernel)" <kyles@hpe.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.18 126/159] nvme-pci: fix a NULL pointer dereference in nvme_alloc_admin_tags
Date: Mon, 30 May 2022 09:23:51 -0400
Message-Id: <20220530132425.1929512-126-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530132425.1929512-1-sashal@kernel.org>
References: <20220530132425.1929512-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220530_063012_789276_691402ED 
X-CRM114-Status: GOOD (  14.72  )
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

From: "Smith, Kyle Miller (Nimble Kernel)" <kyles@hpe.com>

[ Upstream commit da42761181627e9bdc37d18368b827948a583929 ]

In nvme_alloc_admin_tags, the admin_q can be set to an error (typically
-ENOMEM) if the blk_mq_init_queue call fails to set up the queue, which
is checked immediately after the call. However, when we return the error
message up the stack, to nvme_reset_work the error takes us to
nvme_remove_dead_ctrl()
  nvme_dev_disable()
   nvme_suspend_queue(&dev->queues[0]).

Here, we only check that the admin_q is non-NULL, rather than not
an error or NULL, and begin quiescing a queue that never existed, leading
to bad / NULL pointer dereference.

Signed-off-by: Kyle Smith <kyles@hpe.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aacf1c0d5a5..17aeb7d5c485 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1775,6 +1775,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->ctrl.admin_q = blk_mq_init_queue(&dev->admin_tagset);
 		if (IS_ERR(dev->ctrl.admin_q)) {
 			blk_mq_free_tag_set(&dev->admin_tagset);
+			dev->ctrl.admin_q = NULL;
 			return -ENOMEM;
 		}
 		if (!blk_get_queue(dev->ctrl.admin_q)) {
-- 
2.35.1


