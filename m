Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF67C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 30 May 2022 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZQOYxT+g2z06l/6FpK6AgdGYPhETLZrpq4ILucXby3o=; b=bG3aOyDEjegU6cNCSjGVaZeZMW
	hGBQx8jbdFUjlwrlo9f616GCsVVbhiqpyMzrmVX72G0F+D4wufO36cdoAHsHInlv4ki7S+TRz7qwA
	SZ1g1wV9C1XLdE2qJmYFPwJyn2MXRMYefHxswsxTa6YLwJmo5gt5FlCj8oHSJiGBJRipi1qPUaBSX
	SfTqJ+893BZtbMizOlpfN8KL4VOsQbXeH8JtHF5U3DTGMEq3dnlLRnnAS98vZ/qxJTOq1v+1pBL09
	dDtn304Nf8EcxWpvghzhBYe6CIGfKGX5/W5LgeB06QbtDXMd0opDQuiWU5cWO9XuXULsLe513m3j2
	gm1fS5Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvgPk-007EAa-Gs; Mon, 30 May 2022 14:30:36 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvfpQ-006vuO-3K
	for linux-nvme@lists.infradead.org; Mon, 30 May 2022 13:53:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 8FFC0B80DE6;
	Mon, 30 May 2022 13:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5DFC3411C;
	Mon, 30 May 2022 13:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653918781;
	bh=BJubilEJWC04HBLlh+H4l4DtxiVXurshrA27j4U8eo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lt0CCEmuGGDGAPbwrMUHFcnAYvnnS/P2ShH9mKOAl+TQ3E89I5LdhyCD7QRBrBUzA
	 c5KYbZE0HtmcfyfjZ0UpwHmPVp3OSesuaKmPcW1LaAwsB63BDMS+3vITOGOy1J8xYF
	 UOtv9jrnCcoDwATvAPdEcETCWGKSQcmR0tgqoAt6lRrE8RA9nm0xy6SBsA7Ii8lPsE
	 i2knz6Fkdv8mQZQnSUcGpl9L7Yt/SQWGkH27PHHDZGQFa/HTEzINcaJtslXpBEbSSQ
	 Yvgyb0b98N6CKowsKE7W569xJhaI+DSFUADDvMtidO7bl4o3Wt+PekER54keZqEnpS
	 JKei2mRbKDO1w==
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
Subject: [PATCH AUTOSEL 4.9 19/24] nvme-pci: fix a NULL pointer dereference in nvme_alloc_admin_tags
Date: Mon, 30 May 2022 09:52:06 -0400
Message-Id: <20220530135211.1937674-19-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530135211.1937674-1-sashal@kernel.org>
References: <20220530135211.1937674-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220530_065304_399672_D074ECD7 
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
index c87f27d3ee31..e7b872592f36 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1203,6 +1203,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->ctrl.admin_q = blk_mq_init_queue(&dev->admin_tagset);
 		if (IS_ERR(dev->ctrl.admin_q)) {
 			blk_mq_free_tag_set(&dev->admin_tagset);
+			dev->ctrl.admin_q = NULL;
 			return -ENOMEM;
 		}
 		if (!blk_get_queue(dev->ctrl.admin_q)) {
-- 
2.35.1


