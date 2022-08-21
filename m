Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3966FC00140
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Aug 2022 08:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/gfG0D0sc+UcgGbztGLxhfSt4r6r4+glvAaliHc//C4=; b=fk0BNXQFifh7YXXUxbaIHVBywX
	q2R+NN2RI+Wx61UFieXtUNDmRpi0rGHslzIcYK5Wa6rrxVftcdVOGSYCG0bBx8/29w1X8w5YA6J2Z
	HR1Fy5APYMe/e6Bq0ZhG94sOsnPzqYRv7bwSOWlpzjgScd0SpxJmNHLn5rKZl8Xm3A+cb28ftxn+o
	6p6rFfsRDPSQ6q1jyn9v86e/jiSYGXIh7yWr4vsaCXnkU3VelxWnl+aiCSRLA7ovybL+0fSsSgdAE
	qz6zdmhRoNLxGARZVIRAkbREYgYW9QoVsKu+asoNC/lrJdu8dv2U4oXHKH+Xy966bYoYLdCBFAI4d
	H1/XfnIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPgd3-008NDu-30; Sun, 21 Aug 2022 08:48:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPgcx-008NA6-1a
	for linux-nvme@lists.infradead.org; Sun, 21 Aug 2022 08:48:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661071694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gfG0D0sc+UcgGbztGLxhfSt4r6r4+glvAaliHc//C4=;
	b=L7Ng0mqEc6g7xaN0VHt83ymqi2iVnydTStPan028Pg3oI4DVptyiDdjO2KdGtGLkr6CMHD
	3ZxpxoZPEVONg/D1yC9zqdzjFodD1QfcPl1jdTR/10KAIcIDD1VCCv6PApMM6karo++b2f
	jlgCj5kS+sFLxmmlDZkraDYRUdtQk50=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-t4QZYZ7IOiKeTuDEHtZOyw-1; Sun, 21 Aug 2022 04:48:09 -0400
X-MC-Unique: t4QZYZ7IOiKeTuDEHtZOyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAD5F29AB435;
	Sun, 21 Aug 2022 08:48:08 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 540CE909FE;
	Sun, 21 Aug 2022 08:48:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] nvme-pci: don't wait freeze during resetting
Date: Sun, 21 Aug 2022 16:47:54 +0800
Message-Id: <20220821084754.340585-3-ming.lei@redhat.com>
In-Reply-To: <20220821084754.340585-1-ming.lei@redhat.com>
References: <20220821084754.340585-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220821_014815_232985_36FBC74F 
X-CRM114-Status: GOOD (  11.58  )
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

First it isn't necessary to call nvme_wait_freeze in nvme_reset_work().
If tagset isn't allocated, there can't be any inflight IOs; otherwise
blk_mq_update_nr_hw_queues can freeze & wait queues.

Second, since commit bdd6316094e0 ("block: Allow unfreezing of a queue
while requests are in progress"), it is fine to unfreeze queue without
draining inflight IOs.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3a1c37f32f30..91b2903fcc24 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2910,7 +2910,6 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_free_tagset(dev);
 	} else {
 		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
 		if (!dev->ctrl.tagset)
 			nvme_pci_alloc_tag_set(dev);
 		else
-- 
2.31.1


