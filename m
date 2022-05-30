Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FE0C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 May 2022 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CIKiyw9eMx+Zup4Q6tcuiABmJ8rOHpBsZrlY3LDMfMc=; b=MsVQdI/0bYOqqE9kNI+pw4GO/w
	iR/+ZImYgodi6lNHGYFcr+opvtWshLpfU8Tgp5Dhl94ULoaL+b6VJZjh3qXf6/e3evtbdqEqi3gFj
	ILHPEWhsyBPPJ8FOuPkjT1G+TQ4juoqjQv+THVVZLNpOI7ME5O8wKpN443btV582yYwQJtOlh5/Gq
	+dxSWL5sI+OAc/hl8qPYdy7FBeuEb4Q44ARDw/Trp5U7R3StU6tc3t2uhSyMtQuaUuZYScq9ECFa5
	UeEbM75jamGrOIBwBHq1UVIwDqdJT6CGXboW8DpXt9rX0IHz0SkKakAJtp/i4DAufTllhrN2qcPFc
	r7R5eLsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvfmm-006u81-O9; Mon, 30 May 2022 13:50:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvfZn-006mAq-AZ
	for linux-nvme@lists.infradead.org; Mon, 30 May 2022 13:36:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7621560FB3;
	Mon, 30 May 2022 13:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A0FC3411C;
	Mon, 30 May 2022 13:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653917814;
	bh=FxjKdDBBySaV4aLPGsf0NuaXxjSFKK4NzD+yfD/c8BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lei/atOP0dKpw7KXKtsUU5xGjno/Vv7XQn8+mYU5b4qMSBJjGGej3LECwFda+2EKt
	 bs9SMZejBlKPCeIRpljil5/PsoqghdAACKfDGpraGStDwnc/CAGLHP1HAccD6Jf/23
	 D8qHKVfPy1HK0YTxeTF9jXN1YzBdmwL2y/6cNIDCX9c4IKTfRO0NEl1KgJ2cW33up6
	 8f+YIljmx5o93KVWJqFSqy6OB2NbQvImBfJsG7lZ12f1kjipFZmKiEMxEeVY/PO4mn
	 MwE6DAcrRBlmwN30gfxfGpGZRjBWRoKVT3CtA8h1T528Lz915HF/9s9aj5o/BSPBIE
	 puYV4pmIrKatQ==
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
Subject: [PATCH AUTOSEL 5.17 105/135] nvme-pci: fix a NULL pointer dereference in nvme_alloc_admin_tags
Date: Mon, 30 May 2022 09:31:03 -0400
Message-Id: <20220530133133.1931716-105-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530133133.1931716-1-sashal@kernel.org>
References: <20220530133133.1931716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220530_063655_686765_521C6EA1 
X-CRM114-Status: GOOD (  14.80  )
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
index 94a0b933b133..823fa48fbfb0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1772,6 +1772,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->ctrl.admin_q = blk_mq_init_queue(&dev->admin_tagset);
 		if (IS_ERR(dev->ctrl.admin_q)) {
 			blk_mq_free_tag_set(&dev->admin_tagset);
+			dev->ctrl.admin_q = NULL;
 			return -ENOMEM;
 		}
 		if (!blk_get_queue(dev->ctrl.admin_q)) {
-- 
2.35.1


