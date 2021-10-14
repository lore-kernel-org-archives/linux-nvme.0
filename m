Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE77FC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 08:19:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877A960E96
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 08:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 877A960E96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l2LFQq71dqWB0MJ8/20HA9VFLVcxA/IdZ6Nqm+rYqvg=; b=kbnEO8xWluCa77yqQWksI3sICJ
	8oOCtINZR9TPwj8HHfauCGR2LAlVNqE25YB6+x2MArZdEZbsEWXayLUr04gIPECsoStUaqms5EYrJ
	YGj5M99y7aUqsnaKPXcm9CXA980h9jwY/L2YdwpjFw+UQdgBHbfBi3/DDPILd0rd/LIaHZc72TOnX
	a2TFiCdtPvS0Jfzd29wb30t7mFZh74qy5F8NGRZpDiBcBjGWE76Muedze/gbJUq0cq/xdml/Inkbl
	b1gWCobgvGS5AQ3kbceKU9q1XsSVMnHPvtr77qiqRCK8LDpzMEXHU893BOyAusVf939pAgd5Bmj0L
	x+2DnlvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mavx0-0029Mr-8U; Thu, 14 Oct 2021 08:18:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mavwN-00299p-T5
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 08:18:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634199495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2LFQq71dqWB0MJ8/20HA9VFLVcxA/IdZ6Nqm+rYqvg=;
 b=BFE2xS0Fb1OZa3ViHRE+rJcSvGUOzrmggFhNivcJ+qilJ1DH3W3DvSUOyDcmEwwP6eeWtu
 bb8XVgJbJLBPcgzrvlf8Kl3HvBv4/0r4JrsduF7mN/wyw2dZKAAUwrpT0c3Oivx9yAoCFl
 RB46jdA5+b+VdwPhma8Fn4tIGUCMMyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-fn7xKnZ2PDinhBM-1ZhhJA-1; Thu, 14 Oct 2021 04:18:11 -0400
X-MC-Unique: fn7xKnZ2PDinhBM-1ZhhJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E884101F002;
 Thu, 14 Oct 2021 08:18:10 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 114305DA60;
 Thu, 14 Oct 2021 08:18:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai3@huawei.com>,
 Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 5/6] nvme: loop: clear NVME_CTRL_ADMIN_Q_STOPPED after
 admin queue is reallocated
Date: Thu, 14 Oct 2021 16:17:09 +0800
Message-Id: <20211014081710.1871747-6-ming.lei@redhat.com>
In-Reply-To: <20211014081710.1871747-1-ming.lei@redhat.com>
References: <20211014081710.1871747-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_011816_062065_3B01A9D4 
X-CRM114-Status: GOOD (  14.88  )
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

The nvme-loop's admin queue may be freed and reallocated, and we have to
reset the flag of NVME_CTRL_ADMIN_Q_STOPPED so that the flag can match
with the quiesce state of the admin queue.

nvme-loop is the only driver to reallocate request queue, and not see
such usage in other nvme drivers.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/target/loop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 440e1544033b..eb1094254c82 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -384,6 +384,8 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 		error = PTR_ERR(ctrl->ctrl.admin_q);
 		goto out_cleanup_fabrics_q;
 	}
+	/* reset stopped state for the fresh admin queue */
+	clear_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->ctrl.flags);
 
 	error = nvmf_connect_admin_queue(&ctrl->ctrl);
 	if (error)
-- 
2.31.1


